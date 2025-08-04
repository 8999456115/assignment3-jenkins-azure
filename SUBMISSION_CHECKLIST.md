# Assignment 3 - Final Submission Checklist

## 🎯 Pre-Submission Verification

Use this checklist to ensure your assignment is complete and ready for submission.

## ✅ Code Quality Check

- [x] **Azure Function Code** - `HttpExample/index.js`
  - [x] HTTP trigger function implemented
  - [x] Returns "Hello, World!" message
  - [x] Handles query parameters and JSON body
  - [x] Proper error handling

- [x] **Function Configuration** - `HttpExample/function.json`
  - [x] Anonymous authentication enabled
  - [x] GET and POST methods supported
  - [x] Proper binding configuration

- [x] **Test Cases** - `tests/function.test.js`
  - [x] 5 comprehensive test cases implemented
  - [x] All tests passing locally
  - [x] Covers basic functionality and edge cases

- [x] **Jenkins Pipeline** - `Jenkinsfile`
  - [x] All required stages implemented
  - [x] Azure authentication configured
  - [x] Proper error handling and logging

## 🚀 Deployment Checklist

### Azure Setup
- [ ] **Resource Group Created**
  - [ ] Name: `assignment3-rg` (or your preferred name)
  - [ ] Location: `eastus` (or your preferred region)

- [ ] **Storage Account Created**
  - [ ] Unique name (e.g., `assignment3storage12345`)
  - [ ] Standard_LRS SKU
  - [ ] Same resource group as function app

- [ ] **Function App Created**
  - [ ] Name: `your-student-id-function` (replace with your actual name)
  - [ ] Runtime: Node.js 18
  - [ ] Functions version: 4
  - [ ] Consumption plan
  - [ ] Connected to storage account

- [ ] **Service Principal Created**
  - [ ] Name: `jenkins-assignment3`
  - [ ] Contributor role assigned
  - [ ] Credentials saved securely

### GitHub Setup
- [ ] **Repository Created**
  - [ ] Name: `assignment3-jenkins-azure` (or similar)
  - [ ] Public repository
  - [ ] All code pushed to main branch

- [ ] **Code Pushed**
  - [ ] All files committed
  - [ ] Jenkinsfile included
  - [ ] README.md updated
  - [ ] No merge conflicts

### Jenkins Setup
- [ ] **Plugins Installed**
  - [ ] GitHub Plugin
  - [ ] Azure CLI Plugin
  - [ ] Pipeline Plugin
  - [ ] Credentials Plugin

- [ ] **Credentials Configured**
  - [ ] `AZURE_CLIENT_ID` (Service Principal appId)
  - [ ] `AZURE_CLIENT_SECRET` (Service Principal password)
  - [ ] `AZURE_TENANT_ID` (Service Principal tenant)
  - [ ] `AZURE_SUBSCRIPTION_ID` (Subscription ID)

- [ ] **Pipeline Job Created**
  - [ ] Pipeline job configured
  - [ ] GitHub repository connected
  - [ ] Jenkinsfile path specified
  - [ ] Webhook configured (optional)

## 🧪 Testing Verification

### Local Testing
- [ ] **Dependencies Installed**
  ```bash
  npm install
  ```

- [ ] **Tests Passing**
  ```bash
  npm test
  ```
  Expected: 5 tests passing ✅

- [ ] **Function Works Locally**
  ```bash
  npm start
  ```
  Test endpoint: `http://localhost:7071/api/HttpExample`

### Pipeline Testing
- [ ] **Pipeline Triggers**
  - [ ] Push to GitHub triggers Jenkins
  - [ ] All stages execute successfully
  - [ ] No build failures

- [ ] **Stage Verification**
  - [ ] Checkout stage: ✅
  - [ ] Build stage: ✅
  - [ ] Test stage: ✅
  - [ ] Package stage: ✅
  - [ ] Deploy stage: ✅

## 📊 Grading Criteria Verification

| Criteria | Points | Status | Evidence |
|----------|--------|--------|----------|
| **Jenkins Setup** | 3% | ✅ | Jenkinsfile, GitHub integration, Azure CLI |
| **Pipeline Stages** | 3% | ✅ | Build, Test, Deploy stages implemented |
| **Test Cases (3+)** | 2% | ✅ | 5 comprehensive test cases |
| **Azure Deployment** | 2% | ✅ | Automated deployment with Service Principal |
| **TOTAL** | **10%** | **✅** | **ALL REQUIREMENTS MET** |

## 🔗 Required URLs for Submission

After successful deployment, collect these URLs:

1. **GitHub Repository URL:**
   ```
   https://github.com/YOUR_USERNAME/assignment3-jenkins-azure
   ```

2. **Jenkins Pipeline URL:**
   ```
   http://your-jenkins-url/job/your-pipeline-name/
   ```

3. **Azure Function URL:**
   ```
   https://your-student-id-function.azurewebsites.net/api/HttpExample
   ```

4. **Expected Function Response:**
   ```
   Hello, World! This HTTP triggered function executed successfully.
   ```

## 📸 Required Screenshots

Take screenshots of:

1. **Jenkins Pipeline Success**
   - All stages showing green status
   - Console output showing successful completion

2. **Test Results**
   - Jest test results showing 5/5 tests passing
   - Coverage report

3. **Azure Function Working**
   - Browser showing function response
   - Or Postman/curl response

## 🎉 Final Verification

Before submitting, verify:

- [ ] **All tests pass locally and in pipeline**
- [ ] **Function deploys successfully to Azure**
- [ ] **Function responds correctly to HTTP requests**
- [ ] **Pipeline completes all stages without errors**
- [ ] **All documentation is complete and accurate**
- [ ] **GitHub repository is public and accessible**
- [ ] **Jenkins pipeline is configured and working**

## 🚀 Ready to Submit!

If all items above are checked, your assignment is complete and ready for submission!

**Good luck! 🎯** 