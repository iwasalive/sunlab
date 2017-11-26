#Add-AzureRMAccount -credential (get-credential)

# Get Azure Automation Account
$autoAccnt  = Get-AzureAutomationAccount -Name "Some name" -ResourceGroup "some group"

#  Import configuration script 
$autoAccnt | Import-AzureRmAutomationDscConfiguration -SourcePath "path maybe git?" -Published -Force
$autoAccnt | Get-AzureRmAutomationDscConfiguration -Name "some name"

# Compile configuration script
$job = $autoAccnt | Get-AzureRmAutomationDscConfiguration -Name "name" | Start-AzureRmAutomationDscCompilationJob

# Wait for finish
while (-not($job | Get-AzureRmAutomationDscCompilationJob).EndTime){Start-Sleep -Seconds 3}

# Show node configurations 
$autoAccnt | Get-AzureRmAutomationDscNodeConfiguration