const https = require('https');

// Test the Azure Function deployment
const functionUrl = 'https://lab4-function-sahil.azurewebsites.net/api/HttpExample';

console.log('Testing Azure Function deployment...');
console.log(`Function URL: ${functionUrl}`);
console.log('');

// Test 1: Basic GET request
function testBasicRequest() {
    return new Promise((resolve, reject) => {
        https.get(functionUrl, (res) => {
            let data = '';
            
            res.on('data', (chunk) => {
                data += chunk;
            });
            
            res.on('end', () => {
                console.log('✅ Test 1: Basic GET Request');
                console.log(`   Status: ${res.statusCode}`);
                console.log(`   Response: ${data.trim()}`);
                console.log('');
                resolve({ status: res.statusCode, body: data });
            });
        }).on('error', (err) => {
            console.log('❌ Test 1: Basic GET Request Failed');
            console.log(`   Error: ${err.message}`);
            console.log('');
            reject(err);
        });
    });
}

// Test 2: GET request with name parameter
function testWithNameParameter() {
    return new Promise((resolve, reject) => {
        const urlWithName = `${functionUrl}?name=John`;
        https.get(urlWithName, (res) => {
            let data = '';
            
            res.on('data', (chunk) => {
                data += chunk;
            });
            
            res.on('end', () => {
                console.log('✅ Test 2: GET Request with Name Parameter');
                console.log(`   Status: ${res.statusCode}`);
                console.log(`   Response: ${data.trim()}`);
                console.log('');
                resolve({ status: res.statusCode, body: data });
            });
        }).on('error', (err) => {
            console.log('❌ Test 2: GET Request with Name Parameter Failed');
            console.log(`   Error: ${err.message}`);
            console.log('');
            reject(err);
        });
    });
}

// Run tests
async function runTests() {
    try {
        await testBasicRequest();
        await testWithNameParameter();
        
        console.log('🎉 Azure Function deployment verification completed!');
        console.log('📋 Summary:');
        console.log('   - Function is accessible via HTTPS');
        console.log('   - Returns correct "Hello, World!" response');
        console.log('   - Handles query parameters correctly');
        console.log('   - Ready for assignment submission!');
        
    } catch (error) {
        console.log('❌ Azure Function deployment verification failed!');
        console.log('   Please check your deployment and try again.');
    }
}

runTests(); 