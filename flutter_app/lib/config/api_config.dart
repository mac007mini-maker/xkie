class ApiConfig {
  // Change this URL to your deployed backend URL
  // For local testing: 'http://localhost:3000'
  // For production: 'https://your-backend.vercel.app'
  static const String baseUrl = 'http://localhost:3000';
  
  // API endpoints
  static const String videoEndpoint = '/api/video';
  static const String audioEndpoint = '/api/audio';
  static const String photoEndpoint = '/api/photo';
  static const String uploadEndpoint = '/api/upload';
  static const String commonEndpoint = '/api/common';
}

