const express = require('express');

// Create a simple Express app to simulate Azure Functions for testing
const testApp = express();

// Add middleware to parse JSON bodies
testApp.use(express.json());

// Mock the Azure Function
testApp.use('/api/HttpExample', (req, res) => {
    const name = req.query.name || (req.body && req.body.name);
    const responseMessage = name
        ? `Hello, ${name}. This HTTP triggered function executed successfully.`
        : "Hello, World! This HTTP triggered function executed successfully.";
    
    res.status(200).send(responseMessage);
});

module.exports = { app: testApp }; 