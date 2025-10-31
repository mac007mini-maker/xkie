require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));

// Debug middleware
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// Import routes
const videoRoutes = require('./api/video');
const audioRoutes = require('./api/audio');
const photoRoutes = require('./api/photo');
const uploadRoutes = require('./api/upload');
const commonRoutes = require('./api/common');

// Use routes
app.use('/api/video', videoRoutes);
app.use('/api/audio', audioRoutes);
app.use('/api/photo', photoRoutes);
app.use('/api/upload', uploadRoutes);
app.use('/api/common', commonRoutes);

// Health check
app.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'Kie.ai Backend API',
    version: '1.0.0',
    endpoints: {
      video: '/api/video/*',
      audio: '/api/audio/*',
      photo: '/api/photo/*',
      upload: '/api/upload',
      common: '/api/common/*'
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({
    success: false,
    error: err.message,
    stackTrace: process.env.NODE_ENV === 'development' ? err.stack : undefined
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: 'Endpoint not found',
    path: req.path
  });
});

// Export for Vercel serverless
module.exports = app;

// Only start server when running locally (not on Vercel)
if (!process.env.VERCEL) {
  app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
    console.log(`📍 API available at http://localhost:${PORT}`);
    console.log(`🔑 API Key configured: ${process.env.KIE_API_KEY ? 'Yes' : 'No'}`);
  });
}

