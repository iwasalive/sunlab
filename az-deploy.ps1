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
            -Tag @{ DateCreated = get-date; Env = "Test" }
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
        [Parameter(mandatory)] [String] $TemplateFile,
        [Parameter(mandatory)] [String] $TemplateParamFile,
        [Parameter(mandatory)] [String] $Version
    )
    try {
        New-AzureRmResourceGroupDeployment `
            -ResourceGroupName $ResourceGroup `
            -TemplateFile $TemplateFile `
            -TemplateParameterFile $TemplateParamFile 
            # -TemplateVersion $Version 

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
        [Parameter(mandatory)] [String] $TemplateFile,
        [Parameter(mandatory)] [String] $TemplateParamFile,
        [Parameter(mandatory)] [String] $Version
    )

    createResourceGroup -name $ResourceGroup -Location $location

    deployTemplate `
        -ResourceGroup $ResourceGroup `
        -TemplateFile $TemplateFile `
        -TemplateParamFile $TemplateParamFile `
        -Version $Version
}





# Get-AzureRmResource |
#     Where-Object ResourceGroupName -eq myResourceGroup |
#     Select-Object Name, Location, ResourceType

# Remove-AzureRmVM -Name myWindowsVM -ResourceGroupName myResourceGroup
