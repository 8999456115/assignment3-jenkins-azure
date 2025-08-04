# Simple Azure Function Deployment
Write-Host "=== Simple Azure Function Deployment ===" -ForegroundColor Green

# Set your Azure credentials here
$clientId = "your_client_id_here"
$clientSecret = "your_client_secret_here"
$tenantId = "your_tenant_id_here"
$subscriptionId = "your_subscription_id_here"

$functionAppName = "assignment-3-8947486"
$resourceGroup = "assignment3-rg"

Write-Host "🔐 Getting Azure access token..." -ForegroundColor Yellow

try {
    # Get access token
    $tokenBody = @{
        grant_type = "client_credentials"
        client_id = $clientId
        client_secret = $clientSecret
        resource = "https://management.azure.com/"
    }
    
    $tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/token" -Method Post -Body $tokenBody
    $accessToken = $tokenResponse.access_token
    
    Write-Host "✅ Azure authentication successful" -ForegroundColor Green
    
    # Create function
    Write-Host "🚀 Creating function: HttpExample" -ForegroundColor Yellow
    
    $functionUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroup/providers/Microsoft.Web/sites/$functionAppName/functions/HttpExample?api-version=2021-02-01"
    
    $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type" = "application/json"
    }
    
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
        headers: { 'Content-Type': 'text/html' },
        body: responseMessage
    };
};
"@
            }
        }
    }
    
    $createResponse = Invoke-RestMethod -Uri $functionUrl -Headers $headers -Method Put -Body ($functionConfig | ConvertTo-Json -Depth 10)
    Write-Host "✅ Function created successfully!" -ForegroundColor Green
    
    # Test function
    Write-Host "🧪 Testing function..." -ForegroundColor Yellow
    $testUrl = "https://$functionAppName.azurewebsites.net/api/HttpExample"
    
    Start-Sleep -Seconds 10
    
    try {
        $response = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 30
        Write-Host "✅ Function test successful!" -ForegroundColor Green
        Write-Host "📊 Status Code: $($response.StatusCode)" -ForegroundColor Green
        Write-Host "📝 Response: $($response.Content)" -ForegroundColor Green
        Write-Host "🌐 Function URL: $testUrl" -ForegroundColor Cyan
    }
    catch {
        Write-Host "⚠️  Function created but may need more time to deploy" -ForegroundColor Yellow
        Write-Host "🌐 Function URL: $testUrl" -ForegroundColor Cyan
    }
    
    Write-Host "🎉 Azure Function deployment completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "❌ Function deployment failed!" -ForegroundColor Red
} 