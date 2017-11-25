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
createLab `
    -ResourceGroup "TestLab1" `
    -Location "East US" `
    -TemplateFile "C:\Users\Administrator\Dropbox\projects\deloitte\Suncore\Dev\scripts\template\sunlab.json" `
    -TemplateParamFile "C:\Users\Administrator\Dropbox\projects\deloitte\Suncore\Dev\scripts\template\sunlab-params.json" `
    -Version "1.0"