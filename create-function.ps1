# Create Azure Function Script
param(
    [string]$FunctionAppName = "assignment-3-8947486",
    [string]$ResourceGroup = "assignment3-rg",
    [string]$FunctionName = "HttpExample"
)

Write-Host "Creating Azure Function..." -ForegroundColor Green

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
    
    # Step 2: Create the function
    Write-Host "Creating function: $FunctionName" -ForegroundColor Yellow
    $functionUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$ResourceGroup/providers/Microsoft.Web/sites/$FunctionAppName/functions/$FunctionName?api-version=2021-02-01"
    
    $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }
    
    # Function configuration
    $functionConfig = @{
        properties = @{
            config = @{
                bindings = @(
                    @{
                        authLevel = "anonymous"
                        type = "httpTrigger"
                        direction = "in"
                        name = "req"
                        methods = @("get", "post")
                        route = "HttpExample"
                    },
                    @{
                        type = "http"
                        direction = "out"
                        name = "res"
                    }
                )
            }
            files = @{
                "index.js" = @"
module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const name = (req.query.name || (req.body && req.body.name));
    const responseMessage = name
        ? "Hello, " + name + ". This HTTP triggered function executed successfully."
        : "Hello, World! This HTTP triggered function executed successfully.";

    context.res = {
        status: 200,
        headers: {
            'Content-Type': 'text/html'
        },
        body: responseMessage
    };
};
"@
            }
        }
    }
    
    # Create the function
    $createResponse = Invoke-RestMethod -Uri $functionUrl -Headers $headers -Method Put -Body ($functionConfig | ConvertTo-Json -Depth 10)
    Write-Host "Function created successfully!" -ForegroundColor Green
    
    # Step 3: Test the function
    Write-Host "Testing function..." -ForegroundColor Yellow
    $testUrl = "https://$FunctionAppName.azurewebsites.net/api/HttpExample"
    
    try {
        $response = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 30
        Write-Host "Function test successful!" -ForegroundColor Green
        Write-Host "Status Code: $($response.StatusCode)" -ForegroundColor Green
        Write-Host "Response: $($response.Content)" -ForegroundColor Green
        Write-Host "Function URL: $testUrl" -ForegroundColor Cyan
    }
    catch {
        Write-Host "Function created but may need time to deploy" -ForegroundColor Yellow
        Write-Host "Function URL: $testUrl" -ForegroundColor Cyan
    }
    
    Write-Host "Azure Function deployment completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Function creation failed!" -ForegroundColor Red
    exit 1
} 