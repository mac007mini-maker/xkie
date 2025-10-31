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

