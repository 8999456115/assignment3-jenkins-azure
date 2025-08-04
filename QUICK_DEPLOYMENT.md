# 🚀 Quick Deployment Guide - Get Final 2 Screenshots

## 📸 **You Have: 3/5 Screenshots ✅**
- ✅ `npm test` - Tests passing
- ✅ `node demo.js` - Function working
- ✅ `dir` - Project structure

## 🎯 **You Need: 2/5 Screenshots**
- 📸 Jenkins Pipeline Success
- 📸 Azure Function Live

## ⚡ **Quick Deployment Steps (15 minutes)**

### **Step 1: Create Azure Resources (5 min)**

1. **Open Command Prompt as Administrator**
2. **Login to Azure:**
   ```bash
   az login
   ```

3. **Create Resource Group:**
   ```bash
   az group create --name "assignment3-rg" --location "eastus"
   ```

4. **Create Storage Account:**
   ```bash
   az storage account create --name "assignment3storage12345" --location "eastus" --resource-group "assignment3-rg" --sku Standard_LRS
   ```

5. **Create Function App:**
   ```bash
   az functionapp create --resource-group "assignment3-rg" --consumption-plan-location "eastus" --runtime node --runtime-version 18 --functions-version 4 --name "your-student-id-function" --storage-account "assignment3storage12345"
   ```

6. **Create Service Principal:**
   ```bash
   az ad sp create-for-rbac --name "jenkins-assignment3" --role contributor --scopes /subscriptions/$(az account show --query id -o tsv)
   ```

7. **Save the output** - You'll need these values:
   - `appId` (Client ID)
   - `password` (Client Secret)
   - `tenant` (Tenant ID)
   - `subscriptionId`

### **Step 2: Update Jenkinsfile (2 min)**

Edit your `Jenkinsfile` and change these lines:
```groovy
FUNCTION_APP_NAME = 'your-student-id-function'  // Your actual function app name
RESOURCE_GROUP = 'assignment3-rg'               // Your resource group name
```

### **Step 3: Push to GitHub (3 min)**

1. **Create GitHub Repository:**
   - Go to GitHub.com
   - Create new repository: `assignment3-jenkins-azure`
   - Make it public

2. **Push your code:**
   ```bash
   git add .
   git commit -m "Assignment 3: Complete Jenkins CI/CD Pipeline"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/assignment3-jenkins-azure.git
   git push -u origin main
   ```

### **Step 4: Configure Jenkins (5 min)**

1. **Install Jenkins Plugins:**
   - Go to Jenkins > Manage Jenkins > Manage Plugins
   - Install: GitHub Plugin, Azure CLI Plugin, Pipeline Plugin, Credentials Plugin

2. **Add Azure Credentials:**
   - Go to Jenkins > Manage Jenkins > Manage Credentials
   - Add credentials for each:
     - `AZURE_CLIENT_ID` (Secret text) - Use the appId from Step 1
     - `AZURE_CLIENT_SECRET` (Secret text) - Use the password from Step 1
     - `AZURE_TENANT_ID` (Secret text) - Use the tenant from Step 1
     - `AZURE_SUBSCRIPTION_ID` (Secret text) - Use the subscriptionId from Step 1

3. **Create Pipeline Job:**
   - Create new Pipeline job
   - Configure to pull from your GitHub repository
   - Set pipeline script from SCM
   - Point to your GitHub repository

## 📸 **Get Your Final Screenshots**

### **Screenshot 4: Jenkins Pipeline Success**
1. **Trigger the pipeline** (push to GitHub or click "Build Now")
2. **Wait for completion** (all stages should be green)
3. **Take screenshot** of Jenkins dashboard showing success

### **Screenshot 5: Azure Function Live**
1. **Get your function URL:** `https://your-student-id-function.azurewebsites.net/api/HttpExample`
2. **Open in browser**
3. **Take screenshot** showing the response: "Hello, World! This HTTP triggered function executed successfully."

## 🎉 **Complete Submission Package**

After deployment, you'll have:
- ✅ **5/5 Screenshots** - Complete demonstration
- ✅ **GitHub Repository URL** - `https://github.com/YOUR_USERNAME/assignment3-jenkins-azure`
- ✅ **Jenkins Pipeline URL** - `http://your-jenkins-url/job/your-pipeline-name/`
- ✅ **Azure Function URL** - `https://your-student-id-function.azurewebsites.net/api/HttpExample`

## 🚀 **Ready to Submit!**

Your assignment will demonstrate:
- ✅ **Technical Excellence:** Clean code, proper testing
- ✅ **DevOps Understanding:** CI/CD pipeline implementation
- ✅ **Cloud Integration:** Azure Functions deployment
- ✅ **Professional Quality:** Complete documentation

**You're almost there! Just 15 minutes to get those final 2 screenshots! 🎯** 