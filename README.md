# Assignment 3: Jenkins CI/CD Pipeline for Azure Functions

This repository contains a complete CI/CD pipeline implementation using Jenkins to deploy a "Hello World" Azure Function to Azure Functions.

## Project Structure

```
├── HttpExample/
│   ├── function.json          # Azure Function configuration
│   └── index.js              # Main function code
├── tests/
│   └── function.test.js      # Test cases
├── package.json              # Node.js dependencies
├── host.json                 # Azure Functions host configuration
├── local.settings.json       # Local development settings
├── test-server.js           # Test server for unit tests
├── Jenkinsfile              # Jenkins pipeline definition
└── README.md                # This file
```

## Prerequisites

### 1. Azure Account Setup
- Azure subscription with access to Azure Functions
- Azure CLI installed and configured
- Service Principal created for Jenkins authentication

### 2. GitHub Repository
- Create a new GitHub repository
- Push this code to your repository
- Note the repository URL for Jenkins configuration

### 3. Jenkins Server Setup
- Jenkins server installed and running
- Required plugins installed:
  - GitHub Plugin
  - Azure CLI Plugin
  - Pipeline Plugin
  - Credentials Plugin

## Setup Instructions

### Step 1: Azure Function App Creation

1. **Create Azure Function App:**
   ```bash
   az group create --name your-resource-group --location eastus
   az storage account create --name yourstorageaccount --location eastus --resource-group your-resource-group --sku Standard_LRS
   az functionapp create --resource-group your-resource-group --consumption-plan-location eastus --runtime node --runtime-version 18 --functions-version 4 --name your-function-app-name --storage-account yourstorageaccount
   ```

2. **Note down the following values:**
   - Function App Name: `your-function-app-name`
   - Resource Group: `your-resource-group`

### Step 2: Azure Service Principal Setup

1. **Create Service Principal:**
   ```bash
   az ad sp create-for-rbac --name "jenkins-azure-deploy" --role contributor --scopes /subscriptions/your-subscription-id
   ```

2. **Note down the output values:**
   - `appId` (Client ID)
   - `password` (Client Secret)
   - `tenant` (Tenant ID)
   - `subscriptionId`

### Step 3: Jenkins Configuration

1. **Install Required Plugins:**
   - Go to Jenkins > Manage Jenkins > Manage Plugins
   - Install: GitHub Plugin, Azure CLI Plugin, Pipeline Plugin, Credentials Plugin

2. **Configure Azure Credentials:**
   - Go to Jenkins > Manage Jenkins > Manage Credentials
   - Add credentials for:
     - `AZURE_CLIENT_ID` (Secret text)
     - `AZURE_CLIENT_SECRET` (Secret text)
     - `AZURE_TENANT_ID` (Secret text)
     - `AZURE_SUBSCRIPTION_ID` (Secret text)

3. **Create Jenkins Pipeline:**
   - Create new Pipeline job
   - Configure to pull from your GitHub repository
   - Set pipeline script from SCM
   - Point to your GitHub repository

4. **Update Jenkinsfile:**
   - Replace `your-function-app-name` with your actual function app name
   - Replace `your-resource-group` with your actual resource group name

### Step 4: GitHub Repository Setup

1. **Create GitHub Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Azure Function with Jenkins CI/CD"
   git branch -M main
   git remote add origin https://github.com/yourusername/your-repo-name.git
   git push -u origin main
   ```

2. **Configure Webhook (Optional):**
   - Go to your GitHub repository settings
   - Add webhook to trigger Jenkins on push

## Test Cases

The project includes 5 comprehensive test cases:

1. **Basic HTTP Response Test:** Verifies 200 status and "Hello, World!" message
2. **Response Structure Test:** Checks response headers and content type
3. **Query Parameter Test:** Tests name parameter handling
4. **POST Request Test:** Verifies POST request with JSON body
5. **Edge Case Test:** Handles empty name parameter gracefully

## Pipeline Stages

### 1. Checkout Stage
- Pulls code from GitHub repository

### 2. Build Stage
- Installs Node.js dependencies
- Prepares the application for deployment

### 3. Test Stage
- Runs all test cases using Jest
- Ensures code quality and functionality

### 4. Package Stage
- Creates deployment package (function.zip)
- Excludes unnecessary files

### 5. Deploy Stage
- Authenticates with Azure using Service Principal
- Deploys function app to Azure Functions
- Provides deployment URL

## Running the Pipeline

1. **Manual Trigger:**
   - Go to Jenkins dashboard
   - Click on your pipeline job
   - Click "Build Now"

2. **Automatic Trigger:**
   - Push changes to GitHub repository
   - Pipeline will automatically trigger (if webhook configured)

## Verification

### 1. Jenkins Pipeline Success
- All stages should show green status
- Console output should show successful completion

### 2. Azure Function Deployment
- Function should be accessible at: `https://your-function-app-name.azurewebsites.net/api/HttpExample`
- Should return: "Hello, World! This HTTP triggered function executed successfully."

### 3. Test Results
- All 5 test cases should pass
- Test coverage includes basic functionality and edge cases

## Troubleshooting

### Common Issues:

1. **Azure Authentication Failed:**
   - Verify Service Principal credentials in Jenkins
   - Check Azure CLI installation on Jenkins server

2. **Function Deployment Failed:**
   - Verify Function App name and Resource Group
   - Check Azure subscription access

3. **Tests Failing:**
   - Ensure all dependencies are installed
   - Check Node.js version compatibility

4. **Pipeline Not Triggering:**
   - Verify GitHub webhook configuration
   - Check Jenkins GitHub plugin settings

## Submission Checklist

- [ ] GitHub Repository URL provided
- [ ] Jenkins Pipeline successfully configured
- [ ] All 3+ test cases passing
- [ ] Azure Function deployed and accessible
- [ ] Pipeline stages (Build, Test, Deploy) working
- [ ] Documentation complete

## Contact

For issues or questions regarding this assignment, please refer to the course materials or contact your instructor.
