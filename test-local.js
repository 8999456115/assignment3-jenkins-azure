const express = require('express');
const request = require('supertest');

// Create a simple Express app to test the function locally
const app = express();
app.use(express.json());

// Mock the Azure Function
app.use('/api/HttpExample', (req, res) => {
    const name = req.query.name || (req.body && req.body.name);
    const responseMessage = name
        ? `Hello, ${name}. This HTTP triggered function executed successfully.`
        : "Hello, World! This HTTP triggered function executed successfully.";
    
    res.status(200).send(responseMessage);
});

// Test the function
async function testFunction() {
    console.log('Testing Azure Function locally...\n');

    // Test 1: Basic GET request
    console.log('Test 1: Basic GET request');
    const response1 = await request(app).get('/api/HttpExample');
    console.log(`Status: ${response1.status}`);
    console.log(`Response: ${response1.text}\n`);

    // Test 2: GET request with name parameter
    console.log('Test 2: GET request with name parameter');
    const response2 = await request(app).get('/api/HttpExample?name=John');
    console.log(`Status: ${response2.status}`);
    console.log(`Response: ${response2.text}\n`);

    // Test 3: POST request with JSON body
    console.log('Test 3: POST request with JSON body');
    const response3 = await request(app).post('/api/HttpExample').send({ name: 'Jane' });
    console.log(`Status: ${response3.status}`);
    console.log(`Response: ${response3.text}\n`);

    console.log('Local testing completed!');
}

// Run the test if this file is executed directly
if (require.main === module) {
    testFunction().catch(console.error);
}

module.exports = { app }; 