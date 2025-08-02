const request = require('supertest');
const { app } = require('../test-server');

describe('Azure Function Tests', () => {
    // Test Case 1: Basic HTTP response with "Hello, World!"
    it('should return 200 status code and Hello World message', async () => {
        const response = await request(app)
            .get('/api/HttpExample')
            .expect(200);
        
        expect(response.text).toContain('Hello, World!');
        expect(response.text).toContain('This HTTP triggered function executed successfully');
    });

    // Test Case 2: Response code verification
    it('should return correct response structure', async () => {
        const response = await request(app)
            .get('/api/HttpExample')
            .expect(200);
        
        expect(response.status).toBe(200);
        expect(response.headers['content-type']).toContain('text/html');
    });

    // Test Case 3: Edge case handling with query parameter
    it('should handle name parameter correctly', async () => {
        const testName = 'John';
        const response = await request(app)
            .get(`/api/HttpExample?name=${testName}`)
            .expect(200);
        
        expect(response.text).toContain(`Hello, ${testName}`);
        expect(response.text).toContain('This HTTP triggered function executed successfully');
    });

    // Test Case 4: POST request handling
    it('should handle POST requests with body parameter', async () => {
        const testName = 'Jane';
        const response = await request(app)
            .post('/api/HttpExample')
            .send({ name: testName })
            .expect(200);
        
        expect(response.text).toContain(`Hello, ${testName}`);
    });

    // Test Case 5: Empty name parameter handling
    it('should handle empty name parameter gracefully', async () => {
        const response = await request(app)
            .get('/api/HttpExample?name=')
            .expect(200);
        
        expect(response.text).toContain('Hello, World!');
    });
}); 