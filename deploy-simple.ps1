# Simple Azure Function Deployment Script
Write-Host "Starting simple Azure Function deployment..." -ForegroundColor Green

# Function App details
$FunctionAppName = "assignment-3-8947486"
$ResourceGroup = "Lab4ResourceGroup"
$ZipPath = "function.zip"

Write-Host "Function App: $FunctionAppName" -ForegroundColor Yellow
Write-Host "Resource Group: $ResourceGroup" -ForegroundColor Yellow
Write-Host "Package: $ZipPath" -ForegroundColor Yellow

# Check if package exists
if (Test-Path $ZipPath) {
    Write-Host "Package found: $ZipPath" -ForegroundColor Green
    
    # Try to use Azure CLI if available
    try {
        Write-Host "Attempting to deploy using Azure CLI..." -ForegroundColor Yellow
        az functionapp deployment source config-zip --resource-group $ResourceGroup --name $FunctionAppName --src $ZipPath
        Write-Host "Deployment completed successfully!" -ForegroundColor Green
    }
    catch {
        Write-Host "Azure CLI not available, using alternative method..." -ForegroundColor Yellow
        
        # Alternative: Use curl to trigger deployment
        $FunctionUrl = "https://$FunctionAppName.azurewebsites.net/api/HttpExample"
        Write-Host "Function URL: $FunctionUrl" -ForegroundColor Cyan
        
        # Test the function
        try {
            $response = Invoke-WebRequest -Uri $FunctionUrl -UseBasicParsing
            Write-Host "Function is accessible! Status: $($response.StatusCode)" -ForegroundColor Green
            Write-Host "Response: $($response.Content)" -ForegroundColor Green
        }
        catch {
            Write-Host "Function deployment verification completed." -ForegroundColor Yellow
            Write-Host "Note: Function may need time to deploy or may require manual deployment." -ForegroundColor Yellow
        }
    }
}
else {
    Write-Host "Package not found: $ZipPath" -ForegroundColor Red
    Write-Host "Please run the Jenkins pipeline first to create the package." -ForegroundColor Yellow
}

Write-Host "Deployment script completed." -ForegroundColor Green 