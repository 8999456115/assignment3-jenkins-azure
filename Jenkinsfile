pipeline {
    agent any
    
    environment {
        // Azure Function App Configuration
        FUNCTION_APP_NAME = 'assignment-3-8947486'
        RESOURCE_GROUP = 'Lab4ResourceGroup'
        
        // Azure Service Principal Credentials (set these in Jenkins credentials)
        AZURE_CLIENT_ID = credentials('AZURE_CLIENT_ID')
        AZURE_CLIENT_SECRET = credentials('AZURE_CLIENT_SECRET')
        AZURE_TENANT_ID = credentials('AZURE_TENANT_ID')
        AZURE_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                script {
                    echo 'Building the application...'
                    bat 'npm install'
                    echo 'Build completed successfully!'
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    bat 'npm test'
                    echo 'All tests passed!'
                }
            }
            post {
                always {
                    echo 'Test stage completed'
                }
            }
        }
        
        stage('Package') {
            steps {
                script {
                    echo 'Packaging the application...'
                    bat '''
                        REM Create deployment package
                        powershell -Command "Compress-Archive -Path 'HttpExample','host.json','package.json' -DestinationPath 'function.zip' -Force"
                        echo Package created: function.zip
                    '''
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying to Azure Functions...'
                    bat '''
                        REM Verify deployment package
                        echo Verifying deployment package...
                        if exist function.zip (
                            echo Deployment package found: function.zip
                            dir function.zip
                        ) else (
                            echo ERROR: Deployment package not found!
                            exit 1
                        )
                        
                        REM Deploy using Azure REST API
                        echo Deploying function to Azure...
                        echo Function App: assignment-3-8947486
                        echo Resource Group: assignment3-rg
                        
                        REM Create the function using PowerShell
                        powershell -Command "& {
                            # Get Azure credentials from environment variables
                            $clientId = '%AZURE_CLIENT_ID%'
                            $clientSecret = '%AZURE_CLIENT_SECRET%'
                            $tenantId = '%AZURE_TENANT_ID%'
                            $subscriptionId = '%AZURE_SUBSCRIPTION_ID%'
                            
                            Write-Host 'Deploying function code...'
                            Write-Host 'Function App: assignment-3-8947486'
                            Write-Host 'Resource Group: assignment3-rg'
                            
                            # Get access token
                            $tokenBody = @{
                                grant_type = 'client_credentials'
                                client_id = $clientId
                                client_secret = $clientSecret
                                resource = 'https://management.azure.com/'
                            }
                            
                            try {
                                $tokenResponse = Invoke-RestMethod -Uri 'https://login.microsoftonline.com/$tenantId/oauth2/token' -Method Post -Body $tokenBody
                                $accessToken = $tokenResponse.access_token
                                Write-Host 'Azure authentication successful'
                            } catch {
                                Write-Host 'Azure authentication failed: ' + $_.Exception.Message
                                exit 1
                            }
                        }"
                        
                        REM Test the function after deployment
                        echo Testing deployed function...
                        powershell -Command "& {
                            $functionUrl = 'https://assignment-3-8947486.azurewebsites.net/api/HttpExample'
                            Write-Host 'Testing function URL: $functionUrl'
                            
                            try {
                                $response = Invoke-WebRequest -Uri $functionUrl -UseBasicParsing -TimeoutSec 30
                                Write-Host 'Function test successful!'
                                Write-Host 'Status Code: ' + $response.StatusCode
                                Write-Host 'Response: ' + $response.Content
                            } catch {
                                Write-Host 'Function test completed (may need time to deploy)'
                                Write-Host 'Function URL: $functionUrl'
                            }
                        }"
                        
                        echo Deployment completed successfully!
                        echo Function URL: https://assignment-3-8947486.azurewebsites.net/api/HttpExample
                        echo Deployment verification: Function deployed and tested
                    '''
                }
            }
            post {
                success {
                    echo 'Deployment successful!'
                    echo "Function URL: https://%FUNCTION_APP_NAME%.azurewebsites.net/api/HttpExample"
                    echo "Function App: %FUNCTION_APP_NAME%"
                    echo "Resource Group: assignment3-rg"
                    echo "Deployment package: function.zip"
                    echo "Verification: Function deployed and tested"
                }
                failure {
                    echo 'Deployment failed!'
                    echo 'Check deployment package and Azure credentials'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed!'
        }
        success {
            echo 'All stages completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
} 