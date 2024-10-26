function Make-Settings{
	param(
		[string]$settingsPath,
		[string]$settingsFile,
		[hashtable]$defaultSettings
	)

	if (-not (Test-Path -PathType Container $settingsPath)) {
	    # Create the folder structure
	    New-Item -ItemType Directory -Path $settingsPath
	    Write-Host "Created folder structure: $settingsPath"
	}
	if (-not (Test-Path $settingsFile)) {
	    # Create the file if it doesn't exist
	    New-Item -Path $settingsFile -ItemType File
	    $defaultSettings | ConvertTo-Json -Depth 100 | Set-Content -Path $settingsFile
	    $settings = Get-Content $settingsFile -ErrorAction Stop | Out-String | ConvertFrom-Json
	    Write-Host "Created new file and added initial text content"
	}
}

function Get-Settings{
	param(
		[string]$settingsFile
	)
	$settings = Get-Content $settingsFile -ErrorAction Stop | Out-String | ConvertFrom-Json
	return $settings
}

function Save-Settings{
	param(
		[hashtable]$settings
		[string]$settingsFile
	)
    $settings | ConvertTo-Json -Depth 100 | Set-Content -Path $settingsFile
}