const axios = require('axios');

const KIE_API_BASE = 'https://api.kie.ai';
const CREATE_TASK_ENDPOINT = '/api/v1/jobs/createTask';

class KieClient {
  constructor() {
    this.apiKey = process.env.KIE_API_KEY;
    if (!this.apiKey) {
      console.warn('⚠️ WARNING: KIE_API_KEY not set in environment variables');
    }
  }

  getHeaders() {
    return {
      'Authorization': `Bearer ${this.apiKey}`,
      'Content-Type': 'application/json'
    };
  }

  async createTask(model, input, callBackUrl = null) {
    try {
      console.log(`📤 Creating Kie.ai task for model: ${model}`);
      console.log('📦 Input:', JSON.stringify(input, null, 2));

      const payload = {
        model,
        input
      };

      if (callBackUrl) {
        payload.callBackUrl = callBackUrl;
      }

      const response = await axios.post(
        `${KIE_API_BASE}${CREATE_TASK_ENDPOINT}`,
        payload,
        { headers: this.getHeaders() }
      );

      console.log('✅ Response:', response.status, response.data);
      return {
        success: true,
        data: response.data
      };
    } catch (error) {
      console.error('❌ Error calling Kie.ai:', error.response?.data || error.message);
      return {
        success: false,
        error: error.response?.data?.message || error.message,
        statusCode: error.response?.status,
        details: error.response?.data
      };
    }
  }

  async createTaskWithPolling(model, input, maxWaitTime = 60000) {
    try {
      // Step 1: Create task
      const taskResult = await this.createTask(model, input);
      if (!taskResult.success) {
        return taskResult;
      }

      const taskId = taskResult.data.data?.taskId;
      if (!taskId) {
        return {
          success: false,
          error: 'No taskId returned from Kie.ai'
        };
      }

      console.log(`⏳ Polling for task completion: ${taskId}`);

      // Step 2: Poll for results
      const startTime = Date.now();
      const pollInterval = 3000; // 3 seconds

      while (Date.now() - startTime < maxWaitTime) {
        await new Promise(resolve => setTimeout(resolve, pollInterval));

        try {
          // Try different possible endpoints
          const endpoints = [
            `/api/v1/jobs/${taskId}`,
            `/api/v1/jobs/status/${taskId}`,
            `/api/v1/tasks/${taskId}`,
            `/v1/jobs/${taskId}`
          ];

          for (const endpoint of endpoints) {
            try {
              const statusResponse = await axios.get(
                `${KIE_API_BASE}${endpoint}`,
                { headers: this.getHeaders() }
              );

              console.log(`✅ Status check successful on ${endpoint}:`, statusResponse.data);
              
              // Check if task is completed
              const data = statusResponse.data;
              if (data.data?.state === 'success' && data.data?.resultJson) {
                const resultJson = JSON.parse(data.data.resultJson);
                return {
                  success: true,
                  data: {
                    taskId,
                    resultUrls: resultJson.resultUrls || [],
                    metadata: data.data
                  }
                };
              } else if (data.data?.state === 'fail') {
                return {
                  success: false,
                  error: data.data.failMsg || 'Task failed',
                  taskId
                };
              }
              
              // Task still processing, continue polling
              console.log(`⏳ Task ${taskId} still processing...`);
              break; // Found working endpoint, no need to try others
              
            } catch (endpointError) {
              // Try next endpoint
              continue;
            }
          }
        } catch (pollError) {
          console.log(`⏳ Polling attempt failed, retrying...`);
        }
      }

      // Timeout reached
      return {
        success: false,
        error: 'Task timeout - please check task status manually',
        taskId
      };

    } catch (error) {
      console.error('❌ Error in createTaskWithPolling:', error);
      return {
        success: false,
        error: error.message,
        stackTrace: error.stack
      };
    }
  }

  async post(endpoint, data) {
    try {
      console.log(`📤 Calling Kie.ai: ${endpoint}`);
      console.log('📦 Data:', JSON.stringify(data, null, 2));

      const response = await axios.post(
        `${KIE_API_BASE}${endpoint}`,
        data,
        { headers: this.getHeaders() }
      );

      console.log('✅ Response:', response.status);
      return {
        success: true,
        data: response.data
      };
    } catch (error) {
      console.error('❌ Error calling Kie.ai:', error.response?.data || error.message);
      return {
        success: false,
        error: error.response?.data?.message || error.message,
        statusCode: error.response?.status,
        details: error.response?.data
      };
    }
  }

  async get(endpoint) {
    try {
      console.log(`📤 Getting from Kie.ai: ${endpoint}`);

      const response = await axios.get(
        `${KIE_API_BASE}${endpoint}`,
        { headers: this.getHeaders() }
      );

      console.log('✅ Response:', response.status);
      return {
        success: true,
        data: response.data
      };
    } catch (error) {
      console.error('❌ Error calling Kie.ai:', error.response?.data || error.message);
      return {
        success: false,
        error: error.response?.data?.message || error.message,
        statusCode: error.response?.status,
        details: error.response?.data
      };
    }
  }

  async uploadFile(fileBuffer, filename) {
    try {
      const FormData = require('form-data');
      const form = new FormData();
      form.append('file', fileBuffer, filename);

      const response = await axios.post(
        `${KIE_API_BASE}/upload`,
        form,
        {
          headers: {
            ...this.getHeaders(),
            ...form.getHeaders()
          }
        }
      );

      return {
        success: true,
        data: response.data
      };
    } catch (error) {
      return {
        success: false,
        error: error.response?.data?.message || error.message
      };
    }
  }
}

module.exports = new KieClient();

