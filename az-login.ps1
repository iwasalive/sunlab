function Login {
    # Credentials 
    $subscriptionId = "4d936221-abbd-45f7-9619-35ec924f52bd"
    $tenantId = "8d5197e9-41d3-4db0-97a6-8bd4dc2d9a15"
    $appId = "cfeab20f-b113-45e4-a097-6d64015ebed8"
    $appSecret = "ilsWRSwH6GM6MTeN0IWbtV345K8CEPYC7gAMULdMW/c="
    
    $SecurePassword = $appSecret  | ConvertTo-SecureString -AsPlainText -Force
    $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $appId, $SecurePassword
    
    # Login to Azure Portal
    Login-AzureRmAccount -Credential $cred -TenantId $tenantId -SubscriptionId $subscriptionId -ServicePrincipal
    
    # Test
    Get-AzureRmSubscription
    
    Write-Host "Logged in succeeded `n" -ForegroundColor Green
}


if ([string]::IsNullOrEmpty($(Get-AzureRmContext).Account)) {
    Login
} else {
    write-host "Already logged in `n" -ForegroundColor Green
}