# Nice to see you! It's always good to check the contents of a script before running it ;-)

# check if any .Net SDKs are installed
try { 
	Write-Host "Checking available .Net SDKs..."
	$dotnetSdks = (dotnet --list-sdks)
	Write-Host "Installed .Net SDKs: $dotnetSdks"
}
catch {
	Write-Host "No .NET SDK is installed. Please go to the opened page and install the latest LTS version from there. Afterwards close this window and run the script again in a new Powershell instance."
	Start-Process "https://dotnet.microsoft.com/en-us/download"
	Pause
	Exit
}

# check if project folder already exists, prompt for overwrite
if (Test-Path "./CodingTask") { 
	$delete = Read-Host "Project folder already exists. Delete folder and recreate project? [y|n]"
	if ($delete.ToLower() -eq 'y') {
		Write-Host "Deleting project folder..."
		Remove-Item -LiteralPath "./CodingTask" -Force -Recurse
	}
 else {
		Write-Host "Project folder already exists. Exiting."
		Pause
		Exit
	}
}

# create project folder
Write-Host "Creating project folder..."
New-Item -Path "./" -Name "CodingTask" -ItemType "directory" | Out-Null
Set-Location -Path "./CodingTask"

# create project
Write-Host "Creating project..."
dotnet new sln | Out-Null
dotnet new classlib -o CodingTask | Out-Null
dotnet new xunit -o CodingTask.Tests | Out-Null
dotnet add CodingTask.Tests reference CodingTask | Out-Null
dotnet sln add CodingTask | Out-Null
dotnet sln add CodingTask.Tests | Out-Null

# open project folder
Write-Host "Opening project folder..."
Set-Location -Path "../"
Invoke-Item "./CodingTask"

Write-Host "Done."
Pause
