# Initialize-EQOA-Nighthaven.ps1

$Root = $PSScriptRoot

$Directories = @(
    "$Root\docs",
    "$Root\server",
    "$Root\tests",
    "$Root\tools",
    "$Root\deployment"
)

$MarkdownFiles = @(
    "$Root\docs\architecture.md",
    "$Root\docs\protocol.md",
    "$Root\docs\database.md",
    "$Root\docs\dependencies.md",
    "$Root\docs\known-limitations.md",
    "$Root\docs\roadmap.md"
)

# Create directories
foreach ($Directory in $Directories) {
    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
}

# Create blank Markdown files
foreach ($File in $MarkdownFiles) {
    if (-not (Test-Path -LiteralPath $File)) {
        New-Item -ItemType File -Path $File | Out-Null
    }
}

Write-Host "EQOA Nighthaven Server structure created at:" -ForegroundColor Green
Write-Host (Resolve-Path $Root)