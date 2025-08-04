# Azure Function Deployment Script
# Run this script to deploy your function app

param(
    [string]$ResourceGroup = "Lab4ResourceGroup",
    [string]$FunctionAppName = "lab4-function-sahil",
    [string]$ZipPath = "function.zip"
)

Write-Host "Starting Azure Function deployment..." -ForegroundColor Green

try {
    # Check if Azure PowerShell module is installed
    if (-not (Get-Module -ListAvailable -Name Az)) {
        Write-Host "Installing Azure PowerShell module..." -ForegroundColor Yellow
        Install-Module -Name Az -Force -AllowClobber -Scope CurrentUser
    }

    # Import Azure module
    Import-Module Az

    # Login using Service Principal (you'll need to set these as environment variables)
    $clientId = $env:AZURE_CLIENT_ID
    $clientSecret = $env:AZURE_CLIENT_SECRET
    $tenantId = $env:AZURE_TENANT_ID
    $subscriptionId = $env:AZURE_SUBSCRIPTION_ID

    if (-not $clientId -or -not $clientSecret -or -not $tenantId -or -not $subscriptionId) {
        Write-Host "Please set the following environment variables:" -ForegroundColor Red
        Write-Host "AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID" -ForegroundColor Red
        exit 1
    }

    # Create credential object
    $securePassword = ConvertTo-SecureString $clientSecret -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($clientId, $securePassword)

    # Connect to Azure
    Write-Host "Connecting to Azure..." -ForegroundColor Yellow
    Connect-AzAccount -ServicePrincipal -ApplicationId $clientId -Credential $credential -Tenant $tenantId

    # Set subscription
    Write-Host "Setting subscription..." -ForegroundColor Yellow
    Set-AzContext -SubscriptionId $subscriptionId

    # Deploy the function app
    Write-Host "Deploying function app..." -ForegroundColor Yellow
    Publish-AzWebApp -ResourceGroupName $ResourceGroup -Name $FunctionAppName -ArchivePath $ZipPath -Force

    Write-Host "Deployment completed successfully!" -ForegroundColor Green
    Write-Host "Function URL: https://$FunctionAppName.azurewebsites.net/api/HttpExample" -ForegroundColor Cyan

} catch {
    Write-Host "Deployment failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
} 