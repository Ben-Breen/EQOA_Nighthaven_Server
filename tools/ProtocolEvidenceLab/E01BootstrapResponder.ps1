# E01-U02: independently authored gzip/XML and Changes candidates. Acceptance UNKNOWN. Lab only.
[CmdletBinding()]
param(
    [string]$RunDirectory,
    [string]$StopPath,
    [string]$ReportPath,
    [string]$ReadyPath,
    [switch]$LibraryOnly
)
$ErrorActionPreference='Stop'

function Assert-E01ListenerRawPath {
    param([string]$Path,[string]$Root,[switch]$Existing)
    $full=[IO.Path]::GetFullPath($Path)
    $prefix=[IO.Path]::GetFullPath($Root).TrimEnd('\')+'\'
    if($full-ne$prefix.TrimEnd('\')-and-not$full.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){throw 'Listener artifact is outside its approved run directory.'}
    $cursor=$full
    while($cursor){
        if(Test-Path -LiteralPath $cursor){if((Get-Item -LiteralPath $cursor -Force).Attributes-band[IO.FileAttributes]::ReparsePoint){throw 'Listener artifact path contains a reparse point.'}}
        $cursor=[IO.Path]::GetDirectoryName($cursor)
    }
    if($Existing){
        $item=Get-Item -LiteralPath $full -Force -ErrorAction Stop
        if(-not($item.Attributes-band[IO.FileAttributes]::Encrypted)){throw 'Listener evidence must already be EFS encrypted.'}
        $operator=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value
        foreach($ace in (Get-Acl -LiteralPath $full).Access){
            if($ace.AccessControlType-ne'Allow'-or$ace.IdentityReference.Translate([Security.Principal.SecurityIdentifier]).Value-notin@($operator,'S-1-5-18')){throw 'Listener evidence ACL permits another account.'}
        }
    }
    return $full
}

function Write-E01ListenerJson {
    param([string]$Path,$Value,[string]$Root)
    $full=Assert-E01ListenerRawPath -Path $Path -Root $Root
    $temporary=$full+'.'+[Guid]::NewGuid().ToString('N')+'.tmp'
    [IO.File]::WriteAllText($temporary,($Value|ConvertTo-Json -Depth 10),[Text.UTF8Encoding]::new($false))
    $null=Assert-E01ListenerRawPath -Path $temporary -Root $Root -Existing
    [IO.File]::Move($temporary,$full,$true)
}

function Assert-E01ListenerDistinctArtifacts {
    param([string[]]$Paths)
    $seen=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach($path in $Paths){if(-not$seen.Add([IO.Path]::GetFullPath($path))){throw 'Listener control/report/payload paths must be distinct.'}}
}

function Close-E01ListenerResources {
    param($File,$Client,$Listener)
    $closed=[ordered]@{file_closed=$false;client_closed=$false;listener_closed=$false;cleanup_errors=@()}
    try{if($null-ne$File){$File.Dispose()};$closed.file_closed=$true}catch{$closed.cleanup_errors+=('File close: '+$_.Exception.Message)}
    try{if($null-ne$Client){$Client.Dispose()};$closed.client_closed=$true}catch{$closed.cleanup_errors+=('Client close: '+$_.Exception.Message)}
    try{if($null-ne$Listener){$Listener.Stop()};$closed.listener_closed=$true}catch{$closed.cleanup_errors+=('Listener close: '+$_.Exception.Message)}
    return $closed
}

function Get-E01Crc32 {
    param([byte[]]$Bytes)
    [uint32]$crc=[uint32]::MaxValue
    foreach($b in $Bytes){$crc=$crc-bxor[uint32]$b;for($bit=0;$bit-lt8;$bit++){if($crc-band1){$crc=($crc-shr1)-bxor[uint32]3988292384}else{$crc=$crc-shr1}}}
    return [uint32]($crc-bxor[uint32]::MaxValue)
}

function Get-E01BootstrapCatalog {
    # Independent candidate, not a copy/replay of the reference manifest or file entries.
    # Empty Distribution and selected version values are hypotheses, not validated minima.
    $changes=[Text.Encoding]::ASCII.GetBytes("Nighthaven laboratory bootstrap.`r`n")
    $crc=(Get-E01Crc32 $changes).ToString([Globalization.CultureInfo]::InvariantCulture)
    $xml="<?xml version=`"1.0`" encoding=`"UTF-8`"?>`n<VerantPatcher Version=`"1`"><Product Version=`"36`"><Distribution Name=`"Nighthaven`" UseCRC=`"True`"/><Changes Version=`"0`" CRC=`"$crc`" Server=`"198.18.0.1`" Port=`"7000`" RemotePath=`"/patch/eqoa/Changes.txt`"/></Product></VerantPatcher>`n"
    $plain=[Text.UTF8Encoding]::new($false).GetBytes($xml)
    $memory=[IO.MemoryStream]::new()
    try{$gzip=[IO.Compression.GZipStream]::new($memory,[IO.Compression.CompressionLevel]::Optimal,$true);try{$gzip.Write($plain,0,$plain.Length)}finally{$gzip.Dispose()};$compressed=$memory.ToArray()}finally{$memory.Dispose()}
    $entries=@(
        @{name='Nighthaven-empty-distribution-v1';path='/patch/eqoa/eqoa-frontierslive-update.xml.gz';content_type='application/x-gzip';body=$compressed},
        @{name='Nighthaven-changes-v1';path='/patch/eqoa/Changes.txt';content_type='text/plain';body=$changes}
    )
    foreach($e in $entries){
        $head=[Text.Encoding]::ASCII.GetBytes("HTTP/1.1 200 OK`r`nContent-Length: $($e.body.Length)`r`nContent-Type: $($e.content_type)`r`nConnection: close`r`n`r`n")
        $wire=[byte[]]::new($head.Length+$e.body.Length);[Array]::Copy($head,0,$wire,0,$head.Length);[Array]::Copy($e.body,0,$wire,$head.Length,$e.body.Length)
        [pscustomobject]@{name=$e.name;path=$e.path;content_type=$e.content_type;body=$e.body;response=$wire;response_bytes=$wire.Length;response_sha256=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($wire)).ToLowerInvariant()}
    }
}

function Get-E01BootstrapResponse {
    param([Parameter(Mandatory)][byte[]]$RequestBytes)
    # Only exact known GET shapes. No absolute URLs, POST, queries, extra headers or credentials.
    $catalog=@(Get-E01BootstrapCatalog)
    foreach($e in $catalog){
        $hosts=if($e.path-eq'/patch/eqoa/eqoa-frontierslive-update.xml.gz'){@('patch.everquestonlineadventures.com')}else{@('198.18.0.1','198.18.0.1:7000','patch.everquestonlineadventures.com')}
        foreach($hostValue in $hosts){
            $expected=[Text.Encoding]::ASCII.GetBytes("GET $($e.path) HTTP/1.1`r`nHost: $hostValue`r`n`r`n")
            if([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($RequestBytes))-ceq[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($expected))){return $e}
        }
    }
    throw 'Request is outside the two approved bootstrap GET shapes; no response sent.'
}

function Receive-E01InitialBytes {
    # Dependency-free bounded receiver. Tests may supply a loopback socket/clock/sink.
    param(
        [Parameter(Mandatory)][Net.Sockets.TcpClient]$Client,
        [Parameter(Mandatory)][IO.Stream]$Sink,
        [Parameter(Mandatory)][string]$StopPath,
        [int]$MaximumBytes=65536,
        [double]$MaximumSeconds=20,
        [double]$IdleSeconds=3,
        [switch]$StopAtHeaderEnd
    )
    if($MaximumBytes-le0-or$MaximumBytes-gt65536-or$MaximumSeconds-le0-or$MaximumSeconds-gt20-or$IdleSeconds-le0-or$IdleSeconds-gt3){throw 'Receiver bounds exceed the reviewed limits.'}
    $stream=$Client.GetStream();$stream.ReadTimeout=500
    $buffer=[byte[]]::new(8192);$count=0
    $watch=[Diagnostics.Stopwatch]::StartNew();$lastData=$null;$reason='MAXIMUM_SECONDS';$headerMatch=0;$headerComplete=$false
    while($watch.Elapsed.TotalSeconds-lt$MaximumSeconds){
        if([IO.File]::Exists($StopPath)){$reason='OPERATOR_STOP';break}
        if($stream.DataAvailable){
            $limit=[Math]::Min($buffer.Length,$MaximumBytes-$count)
            $received=$stream.Read($buffer,0,$limit)
            if($received-eq0){$reason='PEER_CLOSED';break}
            $Sink.Write($buffer,0,$received);$count+=$received;$lastData=$watch.Elapsed.TotalSeconds
            if($StopAtHeaderEnd){
                foreach($index in 0..($received-1)){
                    $expected=@(13,10,13,10)[$headerMatch]
                    if($buffer[$index]-eq$expected){$headerMatch++}elseif($buffer[$index]-eq13){$headerMatch=1}else{$headerMatch=0}
                    if($headerMatch-eq4){$headerComplete=$true;break}
                }
                if($headerComplete){$reason='HTTP_HEADER_END';break}
            }
            if($count-ge$MaximumBytes){$reason='MAXIMUM_BYTES';break}
        }elseif($Client.Client.Poll(0,[Net.Sockets.SelectMode]::SelectRead)-and$Client.Client.Available-eq0){$reason='PEER_CLOSED';break}
        if($null-ne$lastData-and($watch.Elapsed.TotalSeconds-$lastData)-ge$IdleSeconds){$reason='IDLE_AFTER_DATA';break}
        Start-Sleep -Milliseconds 25
    }
    $Sink.Flush()
    [pscustomobject]@{bytes_received=$count;stop_reason=$reason;elapsed_seconds=$watch.Elapsed.TotalSeconds;application_bytes_sent=0;header_complete=$headerComplete}
}

function Invoke-E01Listener {
    param([string]$RunDirectory,[string]$StopPath,[string]$ReportPath,[string]$ReadyPath)
    $listener=$null;$client=$null;$file=$null;$validated=$false;$root=$null
    $result=[ordered]@{experiment='E01-U02';utc=[DateTime]::UtcNow.ToString('o');result='FAILED';stopped=$false;listener_closed=$false;client_closed=$false;file_closed=$false;application_bytes_sent=0;bytes_received=0;bind_address='198.18.0.1';port=7000;error=$null;exchanges=@();cleanup_errors=@()}
    try{
        if([string]::IsNullOrWhiteSpace($RunDirectory)-or[string]::IsNullOrWhiteSpace($StopPath)-or[string]::IsNullOrWhiteSpace($ReportPath)-or[string]::IsNullOrWhiteSpace($ReadyPath)){throw 'All four explicit listener artifact paths are required.'}
        $root=Assert-E01ListenerRawPath -Path $RunDirectory -Root $RunDirectory -Existing
        $artifactPaths=@($StopPath,$ReportPath,$ReadyPath)
        foreach($n in 1..4){$artifactPaths+=@(Join-Path $root "listener-$n-request.bin");$artifactPaths+=@(Join-Path $root "listener-$n-response.bin")}
        Assert-E01ListenerDistinctArtifacts $artifactPaths
        foreach($path in @($StopPath,$ReportPath,$ReadyPath)){$null=Assert-E01ListenerRawPath -Path $path -Root $root;if(Test-Path -LiteralPath $path){throw 'Stale listener control artifact.'}}
        foreach($i in 1..4){foreach($suffix in @('request.bin','response.bin')){$p=Join-Path $root "listener-$i-$suffix";if(Test-Path -LiteralPath $p){throw 'Stale listener payload artifact.'}}}
        $validated=$true
        $listener=[Net.Sockets.TcpListener]::new([Net.IPAddress]::Parse('198.18.0.1'),7000);$listener.Server.ExclusiveAddressUse=$true;$listener.Start(1)
        $bound=[Net.IPEndPoint]$listener.LocalEndpoint;if($bound.Address.ToString()-ne'198.18.0.1'-or$bound.Port-ne7000){throw 'Unexpected listener binding.'}
        $process=[Diagnostics.Process]::GetCurrentProcess()
        Write-E01ListenerJson -Path $ReadyPath -Root $root -Value ([ordered]@{ready=$true;pid=$process.Id;process_start_utc=$process.StartTime.ToUniversalTime().ToString('o');bind_address='198.18.0.1';port=7000;utc=[DateTime]::UtcNow.ToString('o');maximum_connections=4;maximum_bytes_per_request=65536;maximum_lifetime_seconds=300;application_bytes_sent=0})
        $watch=[Diagnostics.Stopwatch]::StartNew();$stopping=$false
        foreach($index in 1..4){
            while(-not$listener.Pending()){
                if([IO.File]::Exists($StopPath)){$result.stop_reason='OPERATOR_STOP';$stopping=$true;break}
                if($watch.Elapsed.TotalSeconds-ge300){$result.stop_reason='LISTENER_DEADLINE';$stopping=$true;break}
                Start-Sleep -Milliseconds 50
            }
            if($stopping){break}
            $client=$listener.AcceptTcpClient();$remote=[Net.IPEndPoint]$client.Client.RemoteEndPoint
            if($remote.Address.ToString()-ne'198.18.0.2'){throw 'Connection was not from the approved guest; no application bytes read.'}
            $entry=[ordered]@{index=$index;remote_address='198.18.0.2';accepted_utc=[DateTime]::UtcNow.ToString('o');response_write_attempted=$false;response_write_complete=$false}
            $result.exchanges+=,$entry
            $payload=Join-Path $root "listener-$index-request.bin";$responseFile=Join-Path $root "listener-$index-response.bin"
            $file=[IO.File]::Open($payload,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::Read);$null=Assert-E01ListenerRawPath -Path $payload -Root $root -Existing
            try{$remaining=[Math]::Min(20,300-$watch.Elapsed.TotalSeconds);if($remaining-le0){throw 'Listener lifetime expired.'};$received=Receive-E01InitialBytes -Client $client -Sink $file -StopPath $StopPath -StopAtHeaderEnd -MaximumSeconds $remaining}finally{$file.Dispose();$file=$null}
            $request=[IO.File]::ReadAllBytes($payload);$result.bytes_received+=$request.Length
            $entry.request_file=[IO.Path]::GetFileName($payload);$entry.request_bytes=$request.Length;$entry.request_sha256=(Get-FileHash $payload).Hash.ToLowerInvariant()
            if(-not$received.header_complete){throw 'Request header incomplete; no response sent.'}
            $candidate=Get-E01BootstrapResponse $request
            if($index-eq1-and$candidate.name-cne'Nighthaven-empty-distribution-v1'){throw 'First request is not the approved updater GET.'}
            if([IO.File]::Exists($StopPath)){throw 'Operator stopped before response.'}
            [IO.File]::WriteAllBytes($responseFile,$candidate.response);$null=Assert-E01ListenerRawPath -Path $responseFile -Root $root -Existing
            $entry.response_file=[IO.Path]::GetFileName($responseFile);$entry.response_name=$candidate.name;$entry.response_bytes=$candidate.response_bytes;$entry.response_sha256=(Get-FileHash $responseFile).Hash.ToLowerInvariant()
            if($entry.response_sha256-cne$candidate.response_sha256){throw 'Response artifact differs from generated catalog.'}
            $network=$client.GetStream();$network.WriteTimeout=1000;$entry.response_write_attempted=$true
            $sentBefore=$result.application_bytes_sent;$result.application_bytes_sent=$null
            $network.Write($candidate.response,0,$candidate.response.Length);$network.Flush()
            $result.application_bytes_sent=$sentBefore+$candidate.response.Length;$entry.response_write_complete=$true;$entry.sent_utc=[DateTime]::UtcNow.ToString('o')
            $client.Dispose();$client=$null
        }
        $result.result=if($result.exchanges.Count){'CAPTURED'}else{'NO_CLIENT'}
        if(-not$result.Contains('stop_reason')){$result.stop_reason='MAXIMUM_CONNECTIONS'}
    }catch{$result.result='FAILED';$result.error=$_.Exception.Message;$result.line=$_.InvocationInfo.ScriptLineNumber}
    finally{
        $closed=Close-E01ListenerResources -File $file -Client $client -Listener $listener
        foreach($name in @('file_closed','client_closed','listener_closed','cleanup_errors')){$result[$name]=$closed[$name]}
        $result.stopped=$true;if($result.cleanup_errors.Count){$result.result='FAILED'};$result.utc=[DateTime]::UtcNow.ToString('o')
        if($validated){Write-E01ListenerJson -Path $ReportPath -Root $root -Value $result}else{[Console]::Error.WriteLine(($result|ConvertTo-Json -Depth 8))}
    }
    if($result.result-eq'FAILED'){throw ('E01 bootstrap listener failed: '+$result.error)}
}

if(-not$LibraryOnly){Invoke-E01Listener -RunDirectory $RunDirectory -StopPath $StopPath -ReportPath $ReportPath -ReadyPath $ReadyPath}
