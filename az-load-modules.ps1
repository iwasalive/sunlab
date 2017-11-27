$modules = "Azure", "AzureRM"

function Test-Modules {
    foreach( $module in $modules ) {
        if( Get-Module -ListAvailable $module ) {
            importModule $module
        } else {
            Write-Host "$module not installed"
            installModule $module
        }
    }
}

function importModule($module) {
    try {
        if( Get-Module $module ) {
            Import-Module $module
        }
        Write-Host "$module imported `n" -ForegroundColor Green
        
    }
    catch {
        write-host "Failed to import: $module" -ForegroundColor Green
    }
}

function installModule($module) {
    try {
        Install-Module $module -confirm:$false -AllowClobber
        write-host "Installed module: $module" -ForegroundColor Green
        importModule $module
    }
    catch {
        Write-host "Failed to install: $module"
    }
}

Test-Modules