# Create resource group 
function createResourceGroup {
    [CmdletBinding()]
    Param (
        [Parameter(mandatory)] [String] $name,
        [String] $location = "East US"
    )
    try {
        New-AzureRmResourceGroup `
            -Name $name `
            -Location $location `
            -Tag @{ DateCreated = get-date; Env = "Test" } `
            -Confirm:$false -Force
    }
    catch {
        Write-Host "Failed to create resource group $name" -ForegroundColor Red -BackgroundColor Yellow

        $ErrorMessage = $_.Exception.Message

        Write-Host "$ErrorMessage" -ForegroundColor Red -BackgroundColor Yellow
    }
}

function deployTemplate {
    [CmdletBinding()]
    Param (
        [Parameter(mandatory)] [String] $ResourceGroup,
        [Parameter(mandatory)] [String] $TemplateUri,
        [Parameter(mandatory)] [String] $TemplateParamFile,
        [Parameter(mandatory)] [switch] $Test
    )
    try {

        $AzureParams = @{ 
            ResourceGroupName = $ResourceGroup
            TemplateFile = $TemplateUri
            TemplateParameterFile = $TemplateParamFile 
        }

        If ($Test) {
            Test-AzureRmResourceGroupDeployment @AzureParams 
        }
        Else {
            New-AzureRmResourceGroupDeployment @AzurParams
        }

        Write-Host "Deployed successful" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to deploy template `n" -ForegroundColor Red

        $ErrorMessage = $_.Exception.Message

        Write-Host "$ErrorMessage `n" -ForegroundColor Red -BackgroundColor Yellow
    }
}


function createLab() {
    [CmdletBinding()]
    Param (
        [Parameter(mandatory)] [String] $ResourceGroup,
        [Parameter(mandatory)] [String] $Location,
        [Parameter(mandatory)] [String] $TemplateUri,
        [Parameter(mandatory)] [String] $TemplateParamFile,
        [Parameter(mandatory)] [String] $Version,
        [Parameter(mandatory)] [Switch] $Test
    )

    createResourceGroup -name $ResourceGroup -Location $location

    $DeployParams = @{
        ResourceGroup = $ResourceGroup
        TemplateUri = $TemplateUri
        TemplateParamFile = $TemplateParamFile
        Test = $Test
    }

    deployTemplate @DeployParams
}





# Get-AzureRmResource |
#     Where-Object ResourceGroupName -eq myResourceGroup |
#     Select-Object Name, Location, ResourceType

# Remove-AzureRmVM -Name myWindowsVM -ResourceGroupName myResourceGroup
