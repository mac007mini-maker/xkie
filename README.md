# Kie.ai API Tester App

A Flutter application with Node.js backend to test all Kie.ai API features including video generation, music creation, and image processing.

## 🏗️ Architecture

- **Frontend**: Flutter app (UI only) with 3 main tabs: Video, Audio, Photo
- **Backend**: Node.js + Express deployed on Vercel
- **API**: All Kie.ai API calls handled by backend to protect API key

## 📁 Project Structure

```
xkie/
├── flutter_app/           # Flutter mobile app
│   ├── lib/
│   │   ├── main.dart
│   │   ├── config/       # API configuration
│   │   ├── screens/      # Video, Audio, Photo screens
│   │   ├── widgets/      # Reusable UI components
│   │   ├── services/     # API service layer
│   │   ├── models/       # Data models
│   │   └── utils/        # Sample data & utilities
│   └── pubspec.yaml
│
└── backend/              # Node.js backend
    ├── api/
    │   ├── video/       # Video API endpoints
    │   ├── audio/       # Audio API endpoints
    │   ├── photo/       # Photo API endpoints
    │   ├── upload/      # File upload
    │   └── common/      # Account & credits
    ├── utils/
    │   └── kieClient.js # Kie.ai API client
    ├── index.js         # Express server
    ├── package.json
    └── vercel.json      # Vercel deployment config
```

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ (for backend)
- Flutter SDK 3.0+ (for mobile app)
- Kie.ai API key (get from https://kie.ai/)

### Backend Setup

1. **Navigate to backend directory**:
```bash
cd backend
```

2. **Install dependencies**:
```bash
npm install
```

3. **Configure API key**:
```bash
cp env.example .env
# Edit .env and add your Kie.ai API key
```

4. **Run backend locally**:
```bash
npm run dev
```

Backend will run on `http://localhost:3000`

### Flutter App Setup

1. **Navigate to Flutter directory**:
```bash
cd flutter_app
```

2. **Install dependencies**:
```bash
flutter pub get
```

3. **Configure backend URL** (edit `lib/config/api_config.dart`):
```dart
static const String baseUrl = 'http://localhost:3000'; // For local testing
// OR
static const String baseUrl = 'https://your-backend.vercel.app'; // For production
```

4. **Run the app**:
```bash
flutter run
```

## 🌐 Deploy Backend to Vercel

### Option 1: Vercel CLI

1. **Install Vercel CLI**:
```bash
npm install -g vercel
```

2. **Login to Vercel**:
```bash
vercel login
```

3. **Deploy from backend directory**:
```bash
cd backend
vercel
```

4. **Add API key as environment variable**:
```bash
vercel env add KIE_API_KEY
# Enter your Kie.ai API key when prompted
```

5. **Redeploy with environment variable**:
```bash
vercel --prod
```

### Option 2: Vercel Dashboard

1. Go to [vercel.com](https://vercel.com)
2. Click "Add New Project"
3. Import your Git repository
4. Set Root Directory to `backend`
5. Add environment variable:
   - Name: `KIE_API_KEY`
   - Value: Your Kie.ai API key
6. Deploy

### After Deployment

1. Copy your Vercel deployment URL (e.g., `https://your-app.vercel.app`)
2. Update Flutter app's `lib/config/api_config.dart`:
```dart
static const String baseUrl = 'https://your-app.vercel.app';
```
3. Rebuild Flutter app

## 📱 Features

### Video Generation (11 APIs)
- **Veo 3.1**: Generate, Extend, Get Details
- **Runway Gen-3**: Image to Video
- **Runway Aleph**: Video to Video (Style Transfer)
- **Sora 2**: Text/Image to Video
- **Hailuo 2.3**: Text/Image to Video
- **Kling 2.1/2.5**: Text to Video
- **Wan 2.2/2.5**: Text to Video
- **Luma**: Video Generation
- **Sora Watermark Remove**: Remove watermarks

### Audio Generation (3 APIs)
- **Suno V4**: Generate Music, Extend Track, Get Details

### Image Generation (9 APIs)
- **Nano Banana**: Generate & Edit images
- **4O Image**: Generate & Edit images
- **Flux Kontext**: Generate & Edit images
- **Ideogram V3**: Advanced generation
- **Ideogram Character**: Character-focused generation
- **Qwen**: Image editing

### File Upload
- Supports JPEG, PNG, WEBP, MP4, MOV
- Max file size: 100MB
- Automatic upload to Kie.ai

## 🔧 Configuration

### Backend Environment Variables

Create a `.env` file in the backend directory:

```env
KIE_API_KEY=your_kie_api_key_here
```

For production (Vercel), add this in the Vercel dashboard under Settings → Environment Variables.

### Flutter Configuration

Edit `flutter_app/lib/config/api_config.dart`:

```dart
class ApiConfig {
  // Change this to your backend URL
  static const String baseUrl = 'http://localhost:3000'; // Local
  // static const String baseUrl = 'https://your-backend.vercel.app'; // Production
}
```

## 🐛 Debug Mode

The app is configured with debug mode enabled:

- **Flutter**: `debugShowCheckedModeBanner: true` in main.dart
- **Backend**: Detailed error logging with stack traces
- **Error Display**: Full error messages and stack traces shown in UI

## 🧪 Testing

### Test Video API
1. Open app → Video tab
2. Select a model (e.g., "Veo 3.1 - Generate")
3. Review pre-filled sample prompt
4. Adjust parameters if needed
5. Tap "Test API"
6. View video result or error details

### Test Audio API
1. Open app → Audio tab
2. Select "Suno V4 - Generate Music"
3. Review pre-filled prompt
4. Adjust duration and instrumental settings
5. Tap "Test API"
6. Wait 1-2 minutes for generation
7. Play audio result

### Test Photo API
1. Open app → Photo tab
2. Select a model (e.g., "Nano Banana - Generate")
3. Review pre-filled prompt
4. Adjust output format and size
5. Tap "Test API"
6. View image result

### Test File Upload
1. Select an API that requires file upload (has "Upload File" button)
2. Tap "Upload File"
3. Select image/video from device
4. Wait for upload confirmation
5. Add editing instructions
6. Tap "Test API"

## 📖 API Documentation

All backend endpoints follow this pattern:

### Request Format
```json
POST /api/{category}/{model}/{action}
Content-Type: application/json

{
  "prompt": "Description of what to generate",
  "parameter1": "value1",
  "parameter2": "value2"
}
```

### Response Format (Success)
```json
{
  "success": true,
  "data": {
    "type": "image|video|audio",
    "url": "https://...",
    "metadata": { ... }
  }
}
```

### Response Format (Error)
```json
{
  "success": false,
  "error": "Error message",
  "stackTrace": "Full stack trace (debug mode)",
  "details": { ... }
}
```

## 🔗 Useful Links

- [Kie.ai Official Website](https://kie.ai/)
- [Kie.ai API Documentation](https://docs.kie.ai/)
- [Kie.ai API Market](https://kie.ai/market)
- [Kie.ai API Updates](https://kie.ai/api-updates)

## 💡 Tips

1. **Save API Key**: Store your Kie.ai API key securely
2. **Monitor Credits**: Check your credit balance regularly
3. **Sample Prompts**: Use provided samples for quick testing
4. **File Sizes**: Keep files under 10MB for faster uploads
5. **Generation Time**: Video and music may take 1-3 minutes
6. **Error Messages**: Read error details for debugging

## 🛠️ Troubleshooting

### Backend Issues

**"API Key not configured"**
- Check if `.env` file exists in backend directory
- Verify `KIE_API_KEY` is set correctly
- For Vercel, check environment variables in dashboard

**"Cannot connect to Kie.ai"**
- Check your internet connection
- Verify API key is valid
- Check Kie.ai service status

### Flutter Issues

**"Cannot connect to backend"**
- Verify backend is running (`npm run dev`)
- Check `baseUrl` in `api_config.dart` is correct
- For iOS simulator, use `http://localhost:3000`
- For Android emulator, use `http://10.0.2.2:3000`

**"File upload failed"**
- Check file size (max 100MB)
- Verify file format is supported
- Check backend logs for details

## 📝 Notes

- This is a testing app, not production-ready
- No authentication required (for testing only)
- API calls consume Kie.ai credits
- All processing happens on backend
- Flutter app is UI only (no API keys in app)

## 🤝 Support

For issues with:
- **Kie.ai API**: support@kie.ai
- **This app**: Check error messages and logs

## 📄 License

This is a testing/development tool. Use at your own discretion.

---

Built with ❤️ for testing Kie.ai APIs

