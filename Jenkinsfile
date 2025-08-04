pipeline {
    agent any
    
    environment {
        // Azure Function App Configuration
        FUNCTION_APP_NAME = 'lab4-function-sahil'
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
                        powershell -Command "Get-ChildItem -Path . -Exclude 'node_modules','tests','test-server.js','*.test.js','.git','Jenkinsfile' | Compress-Archive -DestinationPath function.zip -Force"
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
                        REM Login to Azure using Service Principal
                        az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%
                        
                        REM Set subscription
                        az account set --subscription %AZURE_SUBSCRIPTION_ID%
                        
                        REM Deploy the function app
                        az functionapp deployment source config-zip --resource-group %RESOURCE_GROUP% --name %FUNCTION_APP_NAME% --src function.zip
                        
                        echo Deployment completed successfully!
                    '''
                }
            }
            post {
                success {
                    echo 'Deployment successful!'
                    echo "Function URL: https://%FUNCTION_APP_NAME%.azurewebsites.net/api/HttpExample"
                }
                failure {
                    echo 'Deployment failed!'
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