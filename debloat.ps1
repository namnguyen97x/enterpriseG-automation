# Remove common pre-installed apps. Modify this list as needed.
$appsToRemove = @(
    'Microsoft.BingWeather',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.MicrosoftOfficeHub',
    'Microsoft.MicrosoftStickyNotes',
    'Microsoft.Windows.Photos',
    'Microsoft.WindowsSoundRecorder',
    'Microsoft.WindowsAlarms',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    'Microsoft.People',
    'Microsoft.SkypeApp',
    'Microsoft.YourPhone',
    'Microsoft.GetHelp',
    'Microsoft.Getstarted',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.Xbox.TCUI',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'Microsoft.GamingApp'
)
foreach ($app in $appsToRemove) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $app } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}
# Clean OneDrive (optional)
if (Get-Process OneDrive -ErrorAction SilentlyContinue) { Stop-Process -Name OneDrive -Force }
$onedrivePath = "$env:ProgramData\Microsoft OneDrive"
if (Test-Path $onedrivePath) { Remove-Item -Recurse -Force -Path $onedrivePath }
