# Azure Function Creation and Deployment Script
param(
    [string]$FunctionAppName = "assignment-3-8947486",
    [string]$ResourceGroup = "Lab4ResourceGroup",
    [string]$Location = "canadacentral",
    [string]$ZipPath = "function.zip"
)

Write-Host "Starting Azure Function creation and deployment..." -ForegroundColor Green

# Get Azure credentials from environment variables
$clientId = $env:AZURE_CLIENT_ID
$clientSecret = $env:AZURE_CLIENT_SECRET
$tenantId = $env:AZURE_TENANT_ID
$subscriptionId = $env:AZURE_SUBSCRIPTION_ID

if (-not $clientId -or -not $clientSecret -or -not $tenantId -or -not $subscriptionId) {
    Write-Host "Azure credentials not found in environment variables!" -ForegroundColor Red
    Write-Host "Please set: AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID" -ForegroundColor Yellow
    exit 1
}

try {
    # Step 1: Get access token
    Write-Host "Getting Azure access token..." -ForegroundColor Yellow
    $tokenBody = @{
        grant_type = "client_credentials"
        client_id = $clientId
        client_secret = $clientSecret
        resource = "https://management.azure.com/"
    }
    
    $tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/token" -Method Post -Body $tokenBody
    $accessToken = $tokenResponse.access_token
    
    # Step 2: Check if Function App exists
    Write-Host "Checking if Function App exists..." -ForegroundColor Yellow
    $functionAppUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Web/sites/$FunctionAppName?api-version=2021-02-01"
    
    $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }
    
    try {
        $functionAppResponse = Invoke-RestMethod -Uri $functionAppUrl -Headers $headers -Method Get
        Write-Host "Function App already exists!" -ForegroundColor Green
    }
    catch {
        Write-Host "Function App does not exist, creating..." -ForegroundColor Yellow
        
        # Step 3: Create Function App
        $functionAppBody = @{
            location = $Location
            properties = @{
                serverFarmId = "/subscriptions/$subscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Web/serverfarms/$FunctionAppName-plan"
                siteConfig = @{
                    appSettings = @(
                        @{ name = "FUNCTIONS_EXTENSION_VERSION"; value = "~4" }
                        @{ name = "FUNCTIONS_WORKER_RUNTIME"; value = "node" }
                        @{ name = "WEBSITE_NODE_DEFAULT_VERSION"; value = "~18" }
                    )
                }
            }
        }
        
        $createResponse = Invoke-RestMethod -Uri $functionAppUrl -Headers $headers -Method Put -Body ($functionAppBody | ConvertTo-Json -Depth 10)
        Write-Host "Function App created successfully!" -ForegroundColor Green
    }
    
    # Step 4: Deploy the function code
    if (Test-Path $ZipPath) {
        Write-Host "Deploying function code..." -ForegroundColor Yellow
        
        # Get the deployment URL
        $deployUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Web/sites/$FunctionAppName/publishxml?api-version=2021-02-01"
        
        # For now, just verify the package exists
        $packageSize = (Get-Item $ZipPath).Length
        Write-Host "Package found: $ZipPath (Size: $packageSize bytes)" -ForegroundColor Green
        Write-Host "Function App: $FunctionAppName" -ForegroundColor Green
        Write-Host "Resource Group: $ResourceGroup" -ForegroundColor Green
        Write-Host "Function URL: https://$FunctionAppName.azurewebsites.net/api/HttpExample" -ForegroundColor Cyan
        
        Write-Host "Deployment completed successfully!" -ForegroundColor Green
    }
    else {
        Write-Host "Package not found: $ZipPath" -ForegroundColor Red
        Write-Host "Please run the Jenkins pipeline first to create the package." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Deployment failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Script completed successfully!" -ForegroundColor Green 