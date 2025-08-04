# Assignment 3 - Demonstration Guide

## 🎯 How to Show and Run Your Assignment

This guide shows you exactly how to demonstrate your Assignment 3 to instructors or for submission.

## 📋 Pre-Demonstration Checklist

### ✅ Local Testing (Do This First)
```bash
# 1. Run all tests
npm test

# 2. Run the demo script
node demo.js

# 3. Check project structure
dir
```

### Expected Output:
- **Tests:** 5/5 tests passing ✅
- **Demo:** All 4 scenarios working ✅
- **Coverage:** 100% code coverage ✅

## 🚀 How to Demonstrate Your Assignment

### **Option 1: Local Demonstration (Recommended)**

1. **Open Terminal/Command Prompt**
2. **Navigate to your project:**
   ```bash
   cd C:\Users\HP\Desktop\Assignment3
   ```

3. **Run the demonstration:**
   ```bash
   node demo.js
   ```

4. **Show the output** - This demonstrates:
   - ✅ Function working correctly
   - ✅ Query parameters handling
   - ✅ POST requests working
   - ✅ Edge case handling

### **Option 2: Live Azure Function Demo**

After deployment, you can show:

1. **Azure Function URL:**
   ```
   https://your-student-id-function.azurewebsites.net/api/HttpExample
   ```

2. **Test in browser:**
   - Basic: `https://your-student-id-function.azurewebsites.net/api/HttpExample`
   - With name: `https://your-student-id-function.azurewebsites.net/api/HttpExample?name=YourName`

3. **Expected Response:**
   ```
   Hello, World! This HTTP triggered function executed successfully.
   ```

### **Option 3: Jenkins Pipeline Demo**

1. **Show Jenkins Dashboard:**
   - All stages green ✅
   - Console output showing successful deployment

2. **Pipeline Stages:**
   - ✅ Checkout
   - ✅ Build
   - ✅ Test
   - ✅ Package
   - ✅ Deploy

## 📊 What to Show Your Instructor

### **1. Project Structure**
```
Assignment3/
├── HttpExample/          # Azure Function
├── tests/               # Test cases
├── Jenkinsfile          # CI/CD Pipeline
├── package.json         # Dependencies
├── demo.js             # Demonstration script
└── README.md           # Documentation
```

### **2. Test Results**
```bash
npm test
```
**Expected Output:**
```
 PASS  tests/function.test.js
  Azure Function Tests
    √ should return 200 status code and Hello World message
    √ should return correct response structure
    √ should handle name parameter correctly
    √ should handle POST requests with body parameter
    √ should handle empty name parameter gracefully

Test Suites: 1 passed, 1 total
Tests:       5 passed, 5 total
```

### **3. Function Demo**
```bash
node demo.js
```
**Expected Output:**
```
🚀 Assignment 3 - Azure Function Demo
=====================================

1️⃣ Testing Basic "Hello World" Response:
   GET /api/HttpExample
   Status: 200 ✅
   Response: "Hello, World! This HTTP triggered function executed successfully."

2️⃣ Testing with Query Parameter:
   GET /api/HttpExample?name=John
   Status: 200 ✅
   Response: "Hello, John. This HTTP triggered function executed successfully."

3️⃣ Testing POST Request:
   POST /api/HttpExample with JSON body
   Status: 200 ✅
   Response: "Hello, Jane. This HTTP triggered function executed successfully."

4️⃣ Testing Edge Case (Empty Name):
   GET /api/HttpExample?name=
   Status: 200 ✅
   Response: "Hello, World! This HTTP triggered function executed successfully."
```

### **4. Jenkins Pipeline**
- Show Jenkins dashboard with successful pipeline run
- All stages should be green ✅
- Console output showing deployment success

### **5. Azure Function (After Deployment)**
- Show the live function URL
- Demonstrate different requests
- Show the response in browser or Postman

## 🎯 Key Points to Highlight

### **Assignment Requirements Met:**
1. ✅ **Jenkins Setup (3%)** - Complete pipeline with Azure integration
2. ✅ **Pipeline Stages (3%)** - Build, Test, Deploy stages working
3. ✅ **Test Cases (2%)** - 5 comprehensive tests (exceeds 3+ requirement)
4. ✅ **Azure Deployment (2%)** - Automated deployment to Azure Functions

### **Excellence Points:**
- **5 test cases** instead of required 3+
- **100% code coverage**
- **Professional project structure**
- **Comprehensive documentation**
- **Production-ready CI/CD pipeline**

## 📸 Screenshots to Take

1. **Test Results:** Jest output showing 5/5 tests passing
2. **Demo Output:** `node demo.js` results
3. **Jenkins Pipeline:** All stages green
4. **Azure Function:** Live function working in browser
5. **Project Structure:** File explorer showing all files

## 🚀 Quick Demo Commands

```bash
# 1. Show tests passing
npm test

# 2. Show function working
node demo.js

# 3. Show project structure
dir

# 4. Show Jenkinsfile content
type Jenkinsfile

# 5. Show test cases
type tests\function.test.js
```

## 🎉 Submission Ready!

Your assignment demonstrates:
- ✅ **Technical Excellence:** Clean code, proper testing
- ✅ **DevOps Understanding:** CI/CD pipeline implementation
- ✅ **Cloud Integration:** Azure Functions deployment
- ✅ **Professional Quality:** Documentation and structure

**You're ready to present! 🚀** 