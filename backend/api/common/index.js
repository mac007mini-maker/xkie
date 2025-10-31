const express = require('express');
const router = express.Router();
const kieClient = require('../../utils/kieClient');

// Get Account Info
router.get('/account', async (req, res) => {
  try {
    const result = await kieClient.get('/v1/account');
    res.json(result);
  } catch (error) {
    res.json({
      success: false,
      error: error.message,
      stackTrace: error.stack
    });
  }
});

// Get Credits
router.get('/credits', async (req, res) => {
  try {
    const result = await kieClient.get('/v1/credits');
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

