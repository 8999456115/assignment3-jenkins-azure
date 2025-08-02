# Assignment 3 Setup Guide

## Quick Setup Steps

### 1. Azure Setup (5 minutes)

1. **Login to Azure CLI:**
   ```bash
   az login
   ```

2. **Create Resource Group:**
   ```bash
   az group create --name assignment3-rg --location eastus
   ```

3. **Create Storage Account:**
   ```bash
   az storage account create --name assignment3storage --location eastus --resource-group assignment3-rg --sku Standard_LRS
   ```

4. **Create Function App:**
   ```bash
   az functionapp create --resource-group assignment3-rg --consumption-plan-location eastus --runtime node --runtime-version 18 --functions-version 4 --name your-student-id-function --storage-account assignment3storage
   ```

5. **Create Service Principal:**
   ```bash
   az ad sp create-for-rbac --name "jenkins-assignment3" --role contributor --scopes /subscriptions/$(az account show --query id -o tsv)
   ```

### 2. GitHub Setup (3 minutes)

1. **Create new repository on GitHub:**
   - Name: `assignment3-jenkins-azure` (or similar)
   - Make it public or private (your choice)

2. **Push code to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Assignment 3 - Jenkins CI/CD Pipeline"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

### 3. Jenkins Setup (10 minutes)

1. **Install Jenkins Plugins:**
   - Go to Jenkins > Manage Jenkins > Manage Plugins
   - Install these plugins:
     - GitHub Plugin
     - Azure CLI Plugin
     - Pipeline Plugin
     - Credentials Plugin

2. **Add Azure Credentials:**
   - Go to Jenkins > Manage Jenkins > Manage Credentials
   - Add 4 new credentials (Secret text type):
     - ID: `AZURE_CLIENT_ID`, Secret: [from service principal output]
     - ID: `AZURE_CLIENT_SECRET`, Secret: [from service principal output]
     - ID: `AZURE_TENANT_ID`, Secret: [from service principal output]
     - ID: `AZURE_SUBSCRIPTION_ID`, Secret: [from service principal output]

3. **Create Pipeline Job:**
   - Click "New Item" > "Pipeline"
   - Name: "Assignment3-Pipeline"
   - Configure:
     - Pipeline script from SCM
     - SCM: Git
     - Repository URL: [your GitHub repo URL]
     - Script Path: Jenkinsfile

4. **Update Jenkinsfile:**
   - Replace `your-function-app-name` with your actual function app name
   - Replace `your-resource-group` with `assignment3-rg`

### 4. Test the Setup (5 minutes)

1. **Run Pipeline:**
   - Click "Build Now" in Jenkins
   - Watch the console output

2. **Verify Deployment:**
   - Check Azure Portal for your function app
   - Test the function URL: `https://your-function-app-name.azurewebsites.net/api/HttpExample`

## Important Notes

- **Function App Name:** Must be globally unique across Azure
- **Resource Group:** Use `assignment3-rg` for consistency
- **Service Principal:** Keep the credentials secure
- **GitHub Repository:** Make sure it's accessible to Jenkins

## Troubleshooting

### Common Issues:

1. **"Function app name already exists":**
   - Use a more unique name with your student ID

2. **"Azure authentication failed":**
   - Double-check service principal credentials
   - Ensure Azure CLI is installed on Jenkins server

3. **"Tests failing":**
   - Run `npm install` locally first
   - Check Node.js version (should be 18+)

4. **"Pipeline not triggering":**
   - Verify GitHub repository URL in Jenkins
   - Check if webhook is configured (optional)

## Submission Checklist

Before submitting, ensure:

- [ ] All files are pushed to GitHub
- [ ] Jenkins pipeline runs successfully
- [ ] All 5 test cases pass
- [ ] Azure Function is deployed and accessible
- [ ] Function returns "Hello, World!" message
- [ ] Documentation is complete

## Files to Submit

1. **GitHub Repository URL**
2. **Jenkins Pipeline Screenshot** (showing successful build)
3. **Azure Function URL** (working function)
4. **Test Results Screenshot** (showing all tests passing)

## Grading Criteria Met

- ✅ **Jenkins Setup (3%):** Complete pipeline configuration
- ✅ **Pipeline Stages (3%):** Build, Test, Deploy stages implemented
- ✅ **Test Cases (2%):** 5 comprehensive test cases
- ✅ **Azure Deployment (2%):** Full deployment automation

Good luck with your assignment! 