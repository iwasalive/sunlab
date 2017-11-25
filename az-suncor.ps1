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
    -TemplateUri "https://raw.githubusercontent.com/simkessy/sunlab/master/templates/sunlab.json" `
    -TemplateParamFile "https://github.com/simkessy/sunlab/raw/master/templates/sunlab-params.json" `
    -Version "1.0"