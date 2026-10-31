# Offline/loopback only. No TAP bind, guest, capture, firewall or adapter changes.
$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'E01BootstrapResponder.ps1') -LibraryOnly
$passed=0
function Check([bool]$Value,[string]$Name){if(-not$Value){throw $Name};$script:passed++;Write-Output ('PASS '+$Name)}
function Deny([byte[]]$Bytes){try{$null=Get-E01BootstrapResponse $Bytes}catch{return $true};return $false}
Check ((Get-E01Crc32 ([Text.Encoding]::ASCII.GetBytes('123456789')))-eq[uint32]3421780262) 'CRC32 independent standard vector'
$catalog=@(Get-E01BootstrapCatalog);$again=@(Get-E01BootstrapCatalog)
Check ($catalog.Count-eq2-and$catalog[0].response_sha256-ceq$again[0].response_sha256) 'Two deterministic independent responses'
Check ($catalog[0].response_sha256-ceq'fc3dd9c20882f8d74e99d622ae83d37f37da89f7da03b1eae184a0b9f79efd05'-and$catalog[1].response_sha256-ceq'1b13bd2e084f64910817bdb7bcab9e0dc40ffbf7e1fd664b69ba4857fc03ec07') 'Exact response catalog pins'
$stream=[IO.MemoryStream]::new($catalog[0].body,$false);$gzip=[IO.Compression.GZipStream]::new($stream,[IO.Compression.CompressionMode]::Decompress);$reader=[IO.StreamReader]::new($gzip,[Text.Encoding]::UTF8)
try{$xml=[xml]$reader.ReadToEnd()}finally{$reader.Dispose();$gzip.Dispose();$stream.Dispose()}
Check ($xml.DocumentElement.Name-ceq'VerantPatcher'-and$xml.SelectNodes('//File').Count-eq0) 'Gzip contains XML and zero file/download/deletion entries'
$c=$xml.SelectSingleNode('/VerantPatcher/Product/Changes')
Check ($c.Server-ceq'198.18.0.1'-and$c.Port-ceq'7000'-and$c.RemotePath-ceq'/patch/eqoa/Changes.txt'-and$c.CRC-ceq(Get-E01Crc32 $catalog[1].body).ToString()) 'Manifest endpoint and independently calculated Changes checksum'
foreach($e in $catalog){
 $head=[Text.Encoding]::ASCII.GetString($e.response,0,$e.response.Length-$e.body.Length)
 Check ($head.StartsWith("HTTP/1.1 200 OK`r`n")-and$head.Contains("Content-Length: $($e.body.Length)`r`n")-and$head.EndsWith("`r`n`r`n")) ('Correct Content-Length and CRLF framing: '+$e.name)
}
$request=[Text.Encoding]::ASCII.GetBytes("GET /patch/eqoa/eqoa-frontierslive-update.xml.gz HTTP/1.1`r`nHost: patch.everquestonlineadventures.com`r`n`r`n")
Check ((Get-E01BootstrapResponse $request).name-ceq'Nighthaven-empty-distribution-v1') 'Known initial client request selects authored manifest'
foreach($hostValue in @('198.18.0.1','198.18.0.1:7000','patch.everquestonlineadventures.com')){
 $b=[Text.Encoding]::ASCII.GetBytes("GET /patch/eqoa/Changes.txt HTTP/1.1`r`nHost: $hostValue`r`n`r`n")
 Check ((Get-E01BootstrapResponse $b).name-ceq'Nighthaven-changes-v1') ('Approved Changes Host: '+$hostValue)
}
foreach($bad in @("GET / HTTP/1.1`r`nHost: 198.18.0.1`r`n`r`n","POST /patch/eqoa/Changes.txt HTTP/1.1`r`nHost: 198.18.0.1`r`n`r`n","GET /patch/eqoa/Changes.txt?x=1 HTTP/1.1`r`nHost: 198.18.0.1`r`n`r`n","GET /patch/eqoa/Changes.txt HTTP/1.1`r`nHost: other.example`r`n`r`n","GET /patch/eqoa/Changes.txt HTTP/1.1`r`nHost: 198.18.0.1`r`nAuthorization: no`r`n`r`n",'GET /patch/eqoa/Changes.txt')){
 Check (Deny ([Text.Encoding]::ASCII.GetBytes($bad))) 'Unapproved path/method/query/host/header/partial request refused'
}
$listener=[Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback,0);$client=$null;$server=$null;$sink=[IO.MemoryStream]::new()
try{
 $listener.Start(1);$client=[Net.Sockets.TcpClient]::new();$client.Connect([Net.IPAddress]::Loopback,([Net.IPEndPoint]$listener.LocalEndpoint).Port);$server=$listener.AcceptTcpClient();$network=$client.GetStream()
 # Segmented writes exercise receiving a complete request through real TCP.
 $network.Write($request,0,37);$network.Write($request,37,$request.Length-37)
 $received=Receive-E01InitialBytes -Client $server -Sink $sink -StopPath (Join-Path $PSScriptRoot ('absent-u02-'+[Guid]::NewGuid().ToString('N'))) -StopAtHeaderEnd -MaximumSeconds 1
 Check ($received.header_complete-and$received.bytes_received-eq104) 'Loopback fragmented request completion'
 $reply=Get-E01BootstrapResponse $sink.ToArray();$server.GetStream().Write($reply.response,0,$reply.response.Length);$server.Dispose();$server=$null
 $client.GetStream().ReadTimeout=1000;$all=[IO.MemoryStream]::new();$buffer=[byte[]]::new(64)
 try{while(($n=$client.GetStream().Read($buffer,0,$buffer.Length))-gt0){$all.Write($buffer,0,$n)};Check ([Convert]::ToHexString($all.ToArray())-ceq[Convert]::ToHexString($catalog[0].response)) 'Exact manifest response and EOF over loopback'}finally{$all.Dispose()}
}finally{if($server){$server.Dispose()};if($client){$client.Dispose()};$listener.Stop();$sink.Dispose()}
Write-Output "RESULT $passed bootstrap checks passed; no TAP, firewall, capture or guest action."
