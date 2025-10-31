const express = require('express');
const router = express.Router();
const kieClient = require('../../utils/kieClient');

// Veo 3.1 - Generate
router.post('/veo/generate', async (req, res) => {
  try {
    const { prompt, duration = '5' } = req.body;
    
    const result = await kieClient.post('/v1/video/veo/generate', {
      prompt,
      duration: parseInt(duration)
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Veo 3.1 - Extend
router.post('/veo/extend', async (req, res) => {
  try {
    const { video_id, prompt } = req.body;
    
    const result = await kieClient.post('/v1/video/veo/extend', {
      video_id,
      prompt
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Veo 3.1 - Get Details
router.post('/veo/details', async (req, res) => {
  try {
    const { video_id } = req.body;
    
    const result = await kieClient.get(`/v1/video/veo/${video_id}`);
    res.json(result);
  } catch (error) {
    res.json({
      success: false,
      error: error.message,
      stackTrace: error.stack
    });
  }
});

// Runway Gen-3
router.post('/runway', async (req, res) => {
  try {
    const { prompt, image_url, duration = '5' } = req.body;
    
    const result = await kieClient.post('/v1/video/runway', {
      prompt,
      image_url,
      duration: parseInt(duration)
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Runway Aleph
router.post('/runway-aleph', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.post('/v1/video/runway-aleph', {
      prompt,
      video_url: image_url // Reusing image_url field for video
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Sora 2 - Text to Video
router.post('/sora/text', async (req, res) => {
  try {
    const { prompt, duration = '5' } = req.body;
    
    const result = await kieClient.post('/v1/video/sora/text', {
      prompt,
      duration: parseInt(duration)
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Sora 2 - Image to Video
router.post('/sora/image', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.post('/v1/video/sora/image', {
      prompt,
      image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Hailuo 2.3 - Text to Video
router.post('/hailuo/text', async (req, res) => {
  try {
    const { prompt } = req.body;
    
    const result = await kieClient.post('/v1/video/hailuo/text', {
      prompt
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Hailuo 2.3 - Image to Video
router.post('/hailuo/image', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.post('/v1/video/hailuo/image', {
      prompt,
      image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Kling
router.post('/kling', async (req, res) => {
  try {
    const { prompt, version = '2.1' } = req.body;
    
    const result = await kieClient.post('/v1/video/kling', {
      prompt,
      version
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Wan Video
router.post('/wan', async (req, res) => {
  try {
    const { prompt, version = '2.2' } = req.body;
    
    const result = await kieClient.post('/v1/video/wan', {
      prompt,
      version
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Luma
router.post('/luma', async (req, res) => {
  try {
    const { prompt } = req.body;
    
    const result = await kieClient.post('/v1/video/luma', {
      prompt
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

// Sora 2 Watermark Remove
router.post('/sora/watermark-remove', async (req, res) => {
  try {
    const { video_id, image_url } = req.body;
    
    const result = await kieClient.post('/v1/video/sora/watermark-remove', {
      video_id,
      video_url: image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'video',
          url: result.data.video_url || result.data.url,
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

