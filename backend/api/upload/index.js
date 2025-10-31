const express = require('express');
const router = express.Router();
const multer = require('multer');
const kieClient = require('../../utils/kieClient');

// Configure multer for file uploads
const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 100 * 1024 * 1024 // 100MB
  }
});

// File Upload
router.post('/', upload.single('file'), async (req, res) => {
  try {
    if (!req.file) {
      return res.json({
        success: false,
        error: 'No file uploaded'
      });
    }

    console.log(`📁 Uploading file: ${req.file.originalname}, Size: ${req.file.size} bytes`);

    const result = await kieClient.uploadFile(req.file.buffer, req.file.originalname);

    if (result.success) {
      res.json({
        success: true,
        data: {
          url: result.data.url || result.data.file_url,
          filename: req.file.originalname,
          size: req.file.size,
          metadata: result.data
        }
      });
    } else {
      res.json(result);
    }
  } catch (error) {
    res.json({
      success: false,
      error: error.message,
      stackTrace: error.stack
    });
  }
});

module.exports = router;

