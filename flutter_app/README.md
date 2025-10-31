# Kie.ai Flutter Tester App

Flutter mobile app for testing all Kie.ai API features.

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- iOS Simulator / Android Emulator / Physical device
- Backend API running (see backend/README.md)

### Installation

1. **Install dependencies**:
```bash
flutter pub get
```

2. **Configure backend URL** (edit `lib/config/api_config.dart`):

For local development:
```dart
static const String baseUrl = 'http://localhost:3000'; // iOS Simulator
// OR
static const String baseUrl = 'http://10.0.2.2:3000'; // Android Emulator
```

For production:
```dart
static const String baseUrl = 'https://your-backend.vercel.app';
```

3. **Run the app**:
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Or let Flutter choose
flutter run
```

## 📱 Features

### Three Main Sections

1. **Video Tab** - 11 video generation APIs
   - Veo 3.1 (Generate, Extend, Get Details)
   - Runway Gen-3 (Image to Video)
   - Runway Aleph (Video to Video)
   - Sora 2 (Text/Image to Video)
   - Hailuo 2.3
   - Kling 2.1/2.5
   - Wan 2.2/2.5
   - Luma
   - Sora Watermark Remove

2. **Audio Tab** - 3 audio generation APIs
   - Suno V4 (Generate, Extend, Get Details)

3. **Photo Tab** - 9 image generation APIs
   - Nano Banana (Generate & Edit)
   - 4O Image (Generate & Edit)
   - Flux Kontext (Generate & Edit)
   - Ideogram V3
   - Ideogram Character
   - Qwen Image Edit

### UI Components

- **API Test Card**: Expandable card for each API
- **File Upload**: Built-in file picker for image/video uploads
- **Media Display**: Image viewer, video player, audio player
- **Error Display**: Debug-friendly error messages with stack traces
- **Sample Prompts**: Pre-filled prompts from Kie.ai docs

## 🔧 Configuration

### Backend URL

Edit `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // Local development
  static const String baseUrl = 'http://localhost:3000'; // iOS
  // static const String baseUrl = 'http://10.0.2.2:3000'; // Android
  
  // Production
  // static const String baseUrl = 'https://your-backend.vercel.app';
}
```

### Platform-Specific URLs

**iOS Simulator**:
- Use `http://localhost:3000`

**Android Emulator**:
- Use `http://10.0.2.2:3000` (this maps to host's localhost)

**Physical Device**:
- Use your computer's IP address: `http://192.168.1.XXX:3000`
- Find IP: `ifconfig` (Mac/Linux) or `ipconfig` (Windows)

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  http: ^1.1.0              # HTTP requests
  image_picker: ^1.0.7       # Image selection
  video_player: ^2.8.1       # Video playback
  audioplayers: ^5.2.1       # Audio playback
  file_picker: ^6.1.1        # File selection
  path_provider: ^2.1.1      # File paths
```

## 🧪 Testing APIs

### Basic Flow

1. Open app
2. Select a tab (Video/Audio/Photo)
3. Tap on an API card to expand
4. Review the pre-filled sample prompt
5. Adjust parameters if needed
6. Tap "Test API"
7. View results or error messages

### Testing with File Upload

1. Select an API that requires files (e.g., "Nano Banana - Edit")
2. Tap "Upload File"
3. Select an image/video from your device
4. Wait for upload confirmation
5. Enter editing instructions
6. Tap "Test API"
7. View the edited result

### Testing Video Generation

1. Go to Video tab
2. Select "Veo 3.1 - Generate"
3. Review the sample prompt (or write your own)
4. Select duration (5 or 10 seconds)
5. Tap "Test API"
6. Wait 1-3 minutes for generation
7. Play the video result

### Testing Music Generation

1. Go to Audio tab
2. Select "Suno V4 - Generate Music"
3. Enter music description (genre, mood, tempo)
4. Select duration
5. Choose instrumental or with vocals
6. Tap "Test API"
7. Wait 1-2 minutes
8. Play the generated music

## 🐛 Debug Mode

The app runs in debug mode with:
- Debug banner enabled
- Full error messages displayed
- Stack traces shown in error cards
- Console logging for API calls

### View Console Logs

```bash
# Run with logging
flutter run -v

# Or check specific logs
flutter logs
```

## 🎨 Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/
│   └── api_config.dart         # Backend URL configuration
├── screens/
│   ├── home_screen.dart        # Main screen with tabs
│   ├── video_screen.dart       # Video APIs list
│   ├── audio_screen.dart       # Audio APIs list
│   └── photo_screen.dart       # Photo APIs list
├── widgets/
│   ├── api_test_card.dart      # Reusable API test UI
│   ├── media_result_display.dart  # Media player/viewer
│   ├── error_display.dart      # Error message display
│   └── loading_indicator.dart  # Loading spinner
├── services/
│   └── api_service.dart        # HTTP client
├── models/
│   └── api_models.dart         # Data models
└── utils/
    └── sample_data.dart        # Sample prompts
```

## 🛠️ Development

### Add New API

1. **Add to appropriate screen** (`video_screen.dart`, `audio_screen.dart`, or `photo_screen.dart`):

```dart
ApiTestCard(
  modelName: 'New API Name',
  description: 'Description of the API',
  endpoint: '/api/category/model-name',
  samplePrompt: 'Sample prompt text',
  requiresFileUpload: false, // true if needs file
  parameters: [
    ApiParameter(
      name: 'prompt',
      label: 'Prompt',
      type: 'text',
    ),
    ApiParameter(
      name: 'style',
      label: 'Style',
      type: 'dropdown',
      defaultValue: 'realistic',
      options: ['realistic', 'anime', 'cartoon'],
    ),
  ],
),
```

2. **Add sample prompt** in `utils/sample_data.dart`

3. **Ensure backend endpoint exists**

4. **Test the new API**

### Customize UI

The app uses Material Design 3. To change theme, edit `main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
),
```

## 📱 Platform Support

- ✅ iOS (Simulator & Device)
- ✅ Android (Emulator & Device)
- ⚠️ Web (Limited - file upload may not work)
- ❌ macOS, Windows, Linux (Not tested)

## 🔍 Troubleshooting

### "Cannot connect to backend"

**iOS Simulator**:
```dart
// Use localhost
static const String baseUrl = 'http://localhost:3000';
```

**Android Emulator**:
```dart
// Use 10.0.2.2 (maps to host's localhost)
static const String baseUrl = 'http://10.0.2.2:3000';
```

**Physical Device**:
```dart
// Use your computer's local IP
static const String baseUrl = 'http://192.168.1.XXX:3000';
```

### "File upload failed"

1. Check file size (max 100MB)
2. Verify file format (JPEG, PNG, WEBP, MP4, MOV)
3. Check backend logs for details
4. Ensure backend is running

### "Video won't play"

1. Check if video URL is valid
2. Ensure internet connection
3. Wait for video to fully load
4. Try different video format

### "Audio won't play"

1. Check audio URL is valid
2. Ensure device volume is up
3. Check app has audio permissions
4. Try restarting the app

### Build Issues

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## 📝 Notes

- This is a **testing app**, not production-ready
- No authentication required
- All API keys are stored on backend
- API calls consume Kie.ai credits
- Some APIs may take 1-3 minutes to respond

## 🚀 Building for Release

### iOS

```bash
flutter build ios --release
# Open ios/Runner.xcworkspace in Xcode
# Archive and distribute
```

### Android

```bash
flutter build apk --release
# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

Or build App Bundle:
```bash
flutter build appbundle --release
# AAB will be at: build/app/outputs/bundle/release/app-release.aab
```

## 📄 License

Testing/Development tool - Use at your own discretion

