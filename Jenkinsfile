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
                        REM Check if Azure CLI is available
                        where az >nul 2>&1
                        if %errorlevel% neq 0 (
                            echo Azure CLI not found, installing...
                            REM Download and install Azure CLI
                            powershell -Command "Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile azure-cli-installer.msi"
                            msiexec /i azure-cli-installer.msi /quiet /norestart
                            echo Azure CLI installation completed
                        ) else (
                            echo Azure CLI found
                        )
                        
                        REM Login to Azure using Service Principal
                        echo Logging into Azure...
                        az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%
                        
                        REM Set subscription
                        echo Setting subscription...
                        az account set --subscription %AZURE_SUBSCRIPTION_ID%
                        
                        REM Check if Function App exists, if not create it
                        echo Checking if Function App exists...
                        az functionapp show --name %FUNCTION_APP_NAME% --resource-group %RESOURCE_GROUP% >nul 2>&1
                        if %errorlevel% neq 0 (
                            echo Function App does not exist, creating...
                            REM Create storage account if needed
                            az storage account create --name %FUNCTION_APP_NAME%storage --resource-group %RESOURCE_GROUP% --location canadacentral --sku Standard_LRS
                            
                            REM Create Function App
                            az functionapp create --resource-group %RESOURCE_GROUP% --consumption-plan-location canadacentral --runtime node --runtime-version 18 --functions-version 4 --name %FUNCTION_APP_NAME% --storage-account %FUNCTION_APP_NAME%storage
                            echo Function App created successfully
                        ) else (
                            echo Function App already exists
                        )
                        
                        REM Deploy the function app
                        echo Deploying function app...
                        az functionapp deployment source config-zip --resource-group %RESOURCE_GROUP% --name %FUNCTION_APP_NAME% --src function.zip
                        
                        echo Deployment completed successfully!
                        echo Function URL: https://%FUNCTION_APP_NAME%.azurewebsites.net/api/HttpExample
                    '''
                }
            }
            post {
                success {
                    echo 'Deployment successful!'
                    echo "Function URL: https://%FUNCTION_APP_NAME%.azurewebsites.net/api/HttpExample"
                    echo "Function App: %FUNCTION_APP_NAME%"
                    echo "Resource Group: %RESOURCE_GROUP%"
                }
                failure {
                    echo 'Deployment failed!'
                    echo 'Check Azure credentials and permissions'
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