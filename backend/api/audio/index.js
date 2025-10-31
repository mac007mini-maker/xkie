const express = require('express');
const router = express.Router();
const kieClient = require('../../utils/kieClient');

// Suno V4 - Generate Music
router.post('/suno/generate', async (req, res) => {
  try {
    const { prompt, duration = '30', instrumental = 'false' } = req.body;
    
    const result = await kieClient.post('/v1/audio/suno/generate', {
      prompt,
      duration: parseInt(duration),
      instrumental: instrumental === 'true'
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'audio',
          url: result.data.audio_url || result.data.url,
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

// Suno V4 - Extend Music
router.post('/suno/extend', async (req, res) => {
  try {
    const { audio_id, continuation_prompt, duration = '30' } = req.body;
    
    const result = await kieClient.post('/v1/audio/suno/extend', {
      audio_id,
      continuation_prompt,
      duration: parseInt(duration)
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'audio',
          url: result.data.audio_url || result.data.url,
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

// Suno V4 - Get Details
router.post('/suno/details', async (req, res) => {
  try {
    const { audio_id } = req.body;
    
    const result = await kieClient.get(`/v1/audio/suno/${audio_id}`);
    res.json(result);
  } catch (error) {
    res.json({
      success: false,
      error: error.message,
      stackTrace: error.stack
    });
  }
});

module.exports = router;

