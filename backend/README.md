# Kie.ai Backend API

Node.js + Express backend for Kie.ai API testing app.

## 🚀 Quick Start

### Local Development

1. **Install dependencies**:
```bash
npm install
```

2. **Configure environment**:
```bash
cp env.example .env
```

Edit `.env` and add your Kie.ai API key:
```env
KIE_API_KEY=your_actual_api_key_here
```

3. **Start server**:
```bash
npm run dev
```

Server will start on `http://localhost:3000`

## 📡 API Endpoints

### Video APIs

| Endpoint | Description |
|----------|-------------|
| `POST /api/video/veo/generate` | Veo 3.1 video generation |
| `POST /api/video/veo/extend` | Extend Veo video |
| `POST /api/video/veo/details` | Get Veo video details |
| `POST /api/video/runway` | Runway image to video |
| `POST /api/video/runway-aleph` | Runway video to video |
| `POST /api/video/sora/text` | Sora text to video |
| `POST /api/video/sora/image` | Sora image to video |
| `POST /api/video/sora/watermark-remove` | Remove Sora watermark |
| `POST /api/video/hailuo/text` | Hailuo text to video |
| `POST /api/video/hailuo/image` | Hailuo image to video |
| `POST /api/video/kling` | Kling video generation |
| `POST /api/video/wan` | Wan video generation |
| `POST /api/video/luma` | Luma video generation |

### Audio APIs

| Endpoint | Description |
|----------|-------------|
| `POST /api/audio/suno/generate` | Generate music with Suno |
| `POST /api/audio/suno/extend` | Extend Suno track |
| `POST /api/audio/suno/details` | Get track details |

### Photo APIs

| Endpoint | Description |
|----------|-------------|
| `POST /api/photo/nano-banana/generate` | Generate image |
| `POST /api/photo/nano-banana/edit` | Edit image |
| `POST /api/photo/4o-image/generate` | 4O generate image |
| `POST /api/photo/4o-image/edit` | 4O edit image |
| `POST /api/photo/flux-kontext/generate` | Flux generate |
| `POST /api/photo/flux-kontext/edit` | Flux edit |
| `POST /api/photo/ideogram/v3` | Ideogram V3 |
| `POST /api/photo/ideogram/character` | Ideogram Character |
| `POST /api/photo/qwen/edit` | Qwen edit |

### Utility APIs

| Endpoint | Description |
|----------|-------------|
| `POST /api/upload` | Upload file |
| `GET /api/common/account` | Get account info |
| `GET /api/common/credits` | Get credit balance |

## 🌐 Deploy to Vercel

### Method 1: Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel

# Add environment variable
vercel env add KIE_API_KEY

# Deploy to production
vercel --prod
```

### Method 2: Vercel Dashboard

1. Go to https://vercel.com/new
2. Import your Git repository
3. Set Root Directory: `backend`
4. Add environment variable:
   - Name: `KIE_API_KEY`
   - Value: Your Kie.ai API key
5. Click "Deploy"

### After Deployment

Your API will be available at: `https://your-project.vercel.app`

Update Flutter app's `api_config.dart` with this URL.

## 🔧 Environment Variables

### Local Development (.env)

```env
KIE_API_KEY=your_kie_api_key_here
```

### Production (Vercel)

Add in Vercel Dashboard:
- Settings → Environment Variables
- Name: `KIE_API_KEY`
- Value: Your API key
- Scope: Production, Preview, Development

## 📝 Example Requests

### Generate Video (Veo 3.1)

```bash
curl -X POST http://localhost:3000/api/video/veo/generate \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "A serene underwater scene",
    "duration": "5"
  }'
```

### Generate Music (Suno)

```bash
curl -X POST http://localhost:3000/api/audio/suno/generate \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Upbeat electronic dance music",
    "duration": "30",
    "instrumental": "false"
  }'
```

### Generate Image (Nano Banana)

```bash
curl -X POST http://localhost:3000/api/photo/nano-banana/generate \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "A wise old owl on a tree branch",
    "output_format": "png",
    "image_size": "1:1"
  }'
```

### Upload File

```bash
curl -X POST http://localhost:3000/api/upload \
  -F "file=@/path/to/image.jpg"
```

## 🔍 Response Format

### Success Response

```json
{
  "success": true,
  "data": {
    "type": "image",
    "url": "https://cdn.kie.ai/...",
    "metadata": {
      "id": "xxx",
      "status": "completed",
      ...
    }
  }
}
```

### Error Response

```json
{
  "success": false,
  "error": "Error message",
  "statusCode": 400,
  "details": { ... }
}
```

## 🐛 Debugging

### Enable Detailed Logging

The backend logs all requests and responses:

```
[2024-10-31T12:00:00.000Z] POST /api/video/veo/generate
📤 Calling Kie.ai: /v1/video/veo/generate
📦 Data: { "prompt": "...", "duration": 5 }
✅ Response: 200
```

### Check Logs

Local development:
```bash
npm run dev
# Logs appear in terminal
```

Vercel deployment:
```bash
vercel logs
# Or check in Vercel dashboard
```

## 📦 Dependencies

- **express**: Web framework
- **cors**: Enable CORS for Flutter app
- **axios**: HTTP client for Kie.ai API
- **dotenv**: Environment variable management
- **multer**: File upload handling
- **form-data**: Multipart form data

## 🛠️ Development

### Project Structure

```
backend/
├── api/
│   ├── video/index.js      # Video endpoints
│   ├── audio/index.js      # Audio endpoints
│   ├── photo/index.js      # Photo endpoints
│   ├── upload/index.js     # File upload
│   └── common/index.js     # Account/credits
├── utils/
│   └── kieClient.js        # Kie.ai API client
├── index.js                # Main server
├── package.json
├── vercel.json             # Vercel config
└── .env                    # Environment variables
```

### Adding New Endpoint

1. Edit appropriate route file in `api/`
2. Add route handler:

```javascript
router.post('/new-endpoint', async (req, res) => {
  try {
    const { param1, param2 } = req.body;
    
    const result = await kieClient.post('/v1/api/path', {
      param1,
      param2
    });

    if (result.success) {
      res.json({
        success: true,
        data: {
          type: 'image|video|audio',
          url: result.data.url,
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
```

3. Test locally
4. Update Flutter app to use new endpoint

## 🔐 Security Notes

- API key is stored server-side only
- Never expose API key in Flutter app
- CORS is enabled for all origins (development only)
- For production, restrict CORS to your app's domain

## 📄 License

Development/Testing tool - Use at your own discretion

