# Module Setup
# Add Azure commands to shell 
# Install-Module AzureRM -Force
. .\az-load-modules.ps1

# Login 
. .\az-login.ps1

# Create Resource group 
. .\az-deploy.ps1

# Configure deployment

# Ideally we'd call this script through an API and take the equry parameters from the call to fill in the arguements of the createLab call 
function Create-Lab {
    [CmdletBinding()]
    Param (
        [Parameter(mandatory)] [String] $ResourceGroup,
        [Parameter(mandatory)] [String] $EnvPrefixName,
        [Parameter(mandatory)] [String] $Username,
        [Parameter(mandatory)] [Security.SecureString] $Password,
        [Parameter(mandatory)] [String] $Version,
        # [Parameter()] [String] $TemplateParamUri,
        [Switch] $Test
    )

    if($Test) {
        $Test = $true
    }

    $LabSettings = @{
        ResourceGroup = $ResourceGroup
        Location = "East US" 
        TemplateUri = "https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/iis-2vm-sql-1vm/azuredeploy.json"
        Version = $Version
        EnvPrefixName = $EnvPrefixName
        Username = $Username
        Password = $Password
        Test =  $Test
    }

    createLab @LabSettings
}

# Initiate lab creation
# [String] $ResourceGroup: Azure Resource Group name used to isolate environment
# [String] $EnvPrefixName: 2-5 Character limit
# [String] $Username: Local account username
# [String] $Password: Local account password
# [String] $Version: Deployment version 
# [Flag] $Test: Tests if deployment template validates. Remove -Test flag if want to deploy
Create-Lab