const express = require('express');
const router = express.Router();
const kieClient = require('../../utils/kieClient');

// Nano Banana - Generate
router.post('/nano-banana/generate', async (req, res) => {
  try {
    const { prompt, output_format = 'png', image_size = '1:1' } = req.body;
    
    const result = await kieClient.createTask('google/nano-banana', {
      prompt,
      output_format,
      image_size
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Nano Banana - Edit
router.post('/nano-banana/edit', async (req, res) => {
  try {
    const { prompt, image_url, output_format = 'png' } = req.body;
    
    const result = await kieClient.createTask('google/nano-banana-edit', {
      prompt,
      image_urls: [image_url],
      output_format
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// 4O Image - Generate
router.post('/4o-image/generate', async (req, res) => {
  try {
    const { prompt, image_size = '1:1' } = req.body;
    
    const result = await kieClient.createTask('openai/4o-image', {
      prompt,
      image_size
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// 4O Image - Edit
router.post('/4o-image/edit', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.createTask('openai/4o-image-edit', {
      prompt,
      image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Flux Kontext - Generate
router.post('/flux-kontext/generate', async (req, res) => {
  try {
    const { prompt, image_size = '1:1' } = req.body;
    
    const result = await kieClient.createTask('flux/kontext', {
      prompt,
      image_size
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Flux Kontext - Edit
router.post('/flux-kontext/edit', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.createTask('flux/kontext-edit', {
      prompt,
      image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Ideogram V3
router.post('/ideogram/v3', async (req, res) => {
  try {
    const { prompt, style = 'auto' } = req.body;
    
    const result = await kieClient.createTask('ideogram/v3', {
      prompt,
      style
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Ideogram Character
router.post('/ideogram/character', async (req, res) => {
  try {
    const { prompt, style = 'cartoon' } = req.body;
    
    const result = await kieClient.createTask('ideogram/character', {
      prompt,
      style
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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

// Qwen Image Edit
router.post('/qwen/edit', async (req, res) => {
  try {
    const { prompt, image_url } = req.body;
    
    const result = await kieClient.createTask('qwen/image-edit', {
      prompt,
      image_url
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image',
          url: result.data.image_url || result.data.url || result.data.result,
          taskId: result.data.taskId || result.data.id,
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
