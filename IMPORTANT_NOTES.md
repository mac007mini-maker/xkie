# ⚠️ Important Notes & Things to Know

## 🔴 Critical - Must Do Before Running

### 1. Add Your Kie.ai API Key

**Backend needs your API key to work!**

```bash
cd backend
cp env.example .env
# Edit .env file and add your actual API key
```

The `.env` file should look like:
```env
KIE_API_KEY=your_actual_api_key_here
```

**Where to get API key:**
- Go to https://kie.ai/
- Sign up / Log in
- Go to Settings or API section
- Copy your API key

### 2. Backend URL Configuration

**Flutter app needs to know where backend is!**

Edit `flutter_app/lib/config/api_config.dart`:

```dart
// For iOS Simulator
static const String baseUrl = 'http://localhost:3000';

// For Android Emulator (special IP)
static const String baseUrl = 'http://10.0.2.2:3000';

// For production (after deploying to Vercel)
static const String baseUrl = 'https://your-backend.vercel.app';
```

### 3. Install Dependencies

**Backend:**
```bash
cd backend
npm install
```

**Flutter:**
```bash
cd flutter_app
flutter pub get
```

## 🟡 Important to Understand

### API Calls Cost Credits

Every API test consumes Kie.ai credits!

- ✅ Images: Low cost (~0.1-0.5 credits)
- ⚠️ Audio: Medium cost (~1-5 credits)
- 🔴 Videos: High cost (~5-20 credits)

**Recommendation:**
- Start with image APIs (cheapest)
- Monitor your credit balance at https://kie.ai/
- Don't spam the test button!

### Response Times Vary

Different APIs take different times:

| Type | Typical Time |
|------|-------------|
| Images | 5-15 seconds |
| Audio/Music | 1-2 minutes |
| Videos | 1-3 minutes |

**Be patient!** The loading indicator will show progress.

### This is a Testing App

- ✅ For testing and development
- ✅ No login required
- ❌ NOT production-ready
- ❌ No rate limiting
- ❌ No data persistence (results disappear when closed)

## 🟢 Good to Know

### Debug Mode is Enabled

**What this means:**
- Full error messages shown in app
- Stack traces displayed
- Backend logs all requests
- Debug banner visible in app

**Why it's good:**
- Easy to troubleshoot problems
- Learn from error messages
- Understand API responses

**To disable debug mode (later):**
Edit `flutter_app/lib/main.dart`:
```dart
debugShowCheckedModeBanner: false,
```

### File Upload Limitations

| Type | Max Size | Formats |
|------|----------|---------|
| Images | 10MB | JPG, PNG, WEBP |
| Videos | 100MB | MP4, MOV |

**Upload process:**
1. Select file in app
2. File uploads to Kie.ai
3. Returns URL
4. URL used in API call

### Sample Prompts Included

All APIs have pre-filled sample prompts from Kie.ai documentation:

- **Video prompts** - Epic scenes, nature, actions
- **Audio prompts** - Music descriptions with BPM, style
- **Image prompts** - Detailed scenes, characters, styles

**You can modify them!** They're just examples.

## 🔵 Platform Differences

### iOS Simulator
```dart
static const String baseUrl = 'http://localhost:3000';
```
✅ Works out of the box

### Android Emulator
```dart
static const String baseUrl = 'http://10.0.2.2:3000';
```
⚠️ Must use `10.0.2.2` (maps to host's localhost)

### Physical Device
```dart
static const String baseUrl = 'http://192.168.1.XXX:3000';
```
⚠️ Must use computer's IP address
⚠️ Device and computer must be on same WiFi

## 🟣 Backend Architecture

### Why Backend is Separate

**Security reasons:**
- API key stays on server
- Never exposed in Flutter app
- Can't be extracted from APK/IPA

**Flexibility:**
- Change backend URL without rebuilding app
- Update API logic without app changes
- Deploy backend independently

### Backend Endpoints Structure

All endpoints follow this pattern:
```
POST /api/{category}/{model}/{action}
```

Examples:
- `/api/video/veo/generate`
- `/api/audio/suno/generate`
- `/api/photo/nano-banana/edit`

## 🔧 Configuration Files

### Files You Might Need to Edit

1. **backend/.env** - Add your API key
2. **flutter_app/lib/config/api_config.dart** - Backend URL
3. **backend/vercel.json** - Vercel settings (if deploying)

### Files You Probably Won't Edit

- All other files are ready to use
- Only change if you want to customize features

## 🌐 Deployment Notes

### Vercel Free Tier Limits

- ✅ 100GB bandwidth/month
- ✅ 100GB-hours compute
- ✅ Unlimited requests (with fair use)
- ✅ 1000 serverless functions/day

**This is enough for:**
- Personal testing
- Small team usage
- Development projects

**Not enough for:**
- High-traffic production apps
- Public-facing services
- Heavy concurrent usage

### Production Checklist

Before deploying to production:
- [ ] Add real API key to Vercel env vars
- [ ] Update Flutter baseUrl to production URL
- [ ] Test all APIs in production
- [ ] Monitor credit usage
- [ ] Set up error alerts (optional)

## 💰 Cost Considerations

### Kie.ai Credits

- You pay for credits at https://kie.ai/
- Different APIs cost different amounts
- Monitor usage in Kie.ai dashboard

### Vercel Hosting

- Free tier is usually enough
- Backend is serverless (no idle cost)
- Only charged when APIs are called

### Flutter App

- Free to build and distribute
- No hosting cost (runs on device)

## 🚨 Common Mistakes to Avoid

### 1. Forgetting to Start Backend

```bash
# Terminal 1: Backend MUST be running
cd backend
npm run dev
```

### 2. Wrong Backend URL

iOS Simulator: `localhost:3000`
Android Emulator: `10.0.2.2:3000`
Physical Device: `192.168.1.XXX:3000`

### 3. API Key Not Set

Check `backend/.env` exists and has your key!

### 4. Spamming Test Button

- Each click costs credits
- Wait for response before clicking again
- Use loading indicator to know when done

### 5. Not Checking Error Messages

- App shows detailed errors
- Read them to understand issues
- Backend logs also helpful

## 📱 App Behavior

### Results Don't Save

- Results disappear when you close app
- This is by design (testing app)
- To save results: Take screenshots
- Future feature: Add persistence

### No Login Required

- Pure testing tool
- No user accounts
- No authentication
- Anyone with app can test (if they have backend URL)

### Debug Info Shows

- Error messages with stack traces
- Request/response data
- Backend logs in terminal
- This helps with testing/debugging

## 🔍 Troubleshooting Tips

### Backend Issues

**Check if running:**
```bash
curl http://localhost:3000
# Should return JSON with success: true
```

**Check logs:**
Backend terminal shows all requests:
```
[timestamp] POST /api/photo/nano-banana/generate
📤 Calling Kie.ai: /v1/image/nano-banana/generate
✅ Response: 200
```

**Check API key:**
```bash
cat backend/.env
# Should show your actual API key
```

### Flutter Issues

**Check backend URL:**
Look in `lib/config/api_config.dart`

**Check logs:**
```bash
flutter run -v
```

**Clean and rebuild:**
```bash
flutter clean
flutter pub get
flutter run
```

### API Issues

**"Invalid API key":**
- Check API key in backend/.env
- Verify key is correct at https://kie.ai/
- Restart backend after changing .env

**"Insufficient credits":**
- Buy more credits at https://kie.ai/
- Check balance in Kie.ai dashboard

**"Request timeout":**
- Some APIs take 1-3 minutes
- Wait for loading indicator
- Check internet connection

## 📚 Learning Resources

### Understand the Code

- All code has comments
- Read README files
- Check sample_data.dart for examples
- Backend code is simple and clear

### Kie.ai Documentation

- Official docs: https://docs.kie.ai/
- API reference: https://kie.ai/market
- Updates: https://kie.ai/api-updates

### Flutter Learning

- Flutter docs: https://flutter.dev/docs
- Dart docs: https://dart.dev/guides

### Node.js Learning

- Express docs: https://expressjs.com/
- Node.js docs: https://nodejs.org/docs

## 🎯 Best Practices

### Testing APIs

1. Start with image APIs (fast & cheap)
2. Use sample prompts first
3. Modify prompts to learn
4. Try different parameters
5. Read error messages
6. Monitor credit usage

### Development

1. Always start backend before Flutter
2. Check logs when debugging
3. Use sample data as reference
4. Test one API at a time
5. Save successful prompts

### Deployment

1. Test everything locally first
2. Deploy backend before building app
3. Update Flutter config with production URL
4. Test in production before distributing
5. Monitor Vercel logs after deployment

## ✅ Sanity Checklist

Before you start testing:

- [ ] Node.js 18+ installed
- [ ] Flutter SDK installed
- [ ] Kie.ai API key obtained
- [ ] Backend `.env` file created with API key
- [ ] Backend dependencies installed (`npm install`)
- [ ] Flutter dependencies installed (`flutter pub get`)
- [ ] Backend running (`npm run dev`)
- [ ] Flutter baseUrl configured correctly
- [ ] Simulator/Emulator running
- [ ] Internet connection working

## 🎉 You're Ready!

If you've read this far, you're well-prepared to use the app!

**Quick Start:**
1. Follow QUICKSTART.md
2. Test Nano Banana Generate first
3. Explore other APIs
4. Have fun! 🚀

**Need Help:**
- Check error messages in app
- Read documentation files
- Check backend logs
- Review this file again

---

**Remember:** This is a testing tool - have fun and learn! 🎨🎥🎵

