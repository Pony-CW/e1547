# All AI
# Extract the lower bound Flutter version from pubspec.yaml

param (
    [string]$PubspecPath = ".\pubspec.yaml"
)

# Read the content of pubspec.yaml
$content = Get-Content $PubspecPath

# Find lines under the "environment:" section
$inEnvironment = $false
$flutterLine = $null

foreach ($line in $content) {
    $trim = $line.Trim()
    
    # Check for the "environment:" section
    if ($trim -eq "environment:") {
        $inEnvironment = $true
        continue
    }

    # Exit the environment section when a non-indented line appears
    if ($inEnvironment -and -not ($line.StartsWith(" "))) {
        $inEnvironment = $false
    }

    # Look for the "flutter:" line inside environment
    if ($inEnvironment -and $trim.StartsWith("flutter:")) {
        $flutterLine = $trim
        break
    }
}

# Fail if no flutter line found
if (-not $flutterLine) {
    Write-Error "No valid 'flutter:' entry found under 'environment:' in pubspec.yaml"
    exit 1
}

# Extract the version string
# Remove "flutter:" prefix and any quotes
$versionString = $flutterLine -replace '^flutter:\s*["'']?', '' -replace '["'']$', ''

# Split by version range symbols (<, >, =, space)
$tokens = $versionString -split '[<>= ]+'

# Take the first non-empty token as the lower bound version
$flutterVersion = $tokens | Where-Object { $_ -ne "" } | Select-Object -First 1

# Fail if no valid version is found
if (-not $flutterVersion) {
    Write-Error "No valid flutter version found in 'flutter:' entry."
    exit 1
}

# Output the Flutter version
Write-Output $flutterVersion