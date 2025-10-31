# 🚀 Quick Start Guide - Kie.ai Tester App

Get up and running in 5 minutes!

## 📋 What You Need

1. ✅ Node.js 18+ installed ([download](https://nodejs.org/))
2. ✅ Flutter SDK installed ([download](https://flutter.dev/))
3. ✅ Kie.ai API key ([get here](https://kie.ai/))
4. ✅ iOS Simulator or Android Emulator

## ⚡ Super Quick Start (Local Development)

### Step 1: Setup Backend (2 minutes)

```bash
# 1. Go to backend folder
cd backend

# 2. Install dependencies
npm install

# 3. Create .env file
cp env.example .env

# 4. Edit .env and add your API key
# KIE_API_KEY=your_actual_api_key_here
nano .env  # or use any text editor

# 5. Start backend
npm run dev
```

✅ Backend running at `http://localhost:3000`

### Step 2: Setup Flutter App (2 minutes)

```bash
# 1. Open new terminal, go to Flutter folder
cd flutter_app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

✅ App should open in your simulator/emulator!

### Step 3: Test Your First API (1 minute)

1. In the app, go to **Photo** tab
2. Tap on **"Nano Banana - Generate"** card to expand
3. Review the sample prompt (already filled in)
4. Tap **"Test API"** button
5. Wait a few seconds
6. See your generated image! 🎨

## 🎯 What to Test First

### Easy APIs (Fast Response)

1. **Photo → Nano Banana → Generate**
   - Takes: ~5 seconds
   - Sample works out of the box
   - Perfect first test!

2. **Photo → Ideogram V3**
   - Takes: ~10 seconds
   - Try different styles

### Medium APIs (File Upload)

3. **Photo → Nano Banana → Edit**
   - Takes: ~10 seconds
   - Upload a photo first
   - Try "make it more colorful"

### Advanced APIs (Longer Wait)

4. **Video → Veo 3.1 → Generate**
   - Takes: 1-2 minutes
   - Creates short video
   - Very cool! 🎥

5. **Audio → Suno V4 → Generate**
   - Takes: 1-2 minutes
   - Creates music
   - Try different genres 🎵

## 🛠️ Common Issues & Quick Fixes

### "Backend not connected" ❌

**iOS Simulator**:
```dart
// In flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://localhost:3000';
```

**Android Emulator**:
```dart
// In flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://10.0.2.2:3000';
```

Then restart the Flutter app:
```bash
flutter run
```

### "API Key not configured" ❌

1. Check your `.env` file in backend folder:
```bash
cat backend/.env
```

2. Should show:
```
KIE_API_KEY=your_actual_key_here
```

3. If not, edit it:
```bash
nano backend/.env
```

4. Restart backend:
```bash
# In backend folder
npm run dev
```

### Backend won't start ❌

```bash
# Make sure you're in backend folder
cd backend

# Install dependencies again
npm install

# Check Node version (should be 18+)
node --version

# Try starting again
npm run dev
```

## 📱 Test on Physical Device

### Find Your Computer's IP Address

**Mac/Linux**:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
# Look for something like: 192.168.1.XXX
```

**Windows**:
```bash
ipconfig
# Look for IPv4 Address: 192.168.1.XXX
```

### Update Flutter Config

```dart
// In flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://192.168.1.XXX:3000';
// Replace XXX with your actual IP
```

### Run on Device

```bash
# Connect device via USB
flutter devices  # Should list your device
flutter run
```

## 🌐 Deploy to Production (Optional)

Want to deploy to the cloud? See [DEPLOYMENT.md](DEPLOYMENT.md) for full guide.

**Quick Deploy to Vercel**:

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy backend
cd backend
vercel

# Add API key
vercel env add KIE_API_KEY production

# Deploy to production
vercel --prod
```

Then update Flutter app with your Vercel URL!

## 💡 Tips for Testing

### 1. Start with Simple APIs
- Photos generate fastest
- Videos take longest
- Music is in between

### 2. Use Sample Prompts
- Already filled in for each API
- Proven to work well
- Modify them to learn

### 3. Check Error Messages
- App shows detailed errors
- Stack traces for debugging
- Backend logs help too

### 4. Monitor Your Credits
- Each API call costs credits
- Check balance at https://kie.ai/
- Don't spam the test button 😅

### 5. File Upload Tips
- Max 10MB for images
- Max 100MB for videos
- Formats: JPG, PNG, WEBP, MP4, MOV

## 📖 Learn More

- **Full Documentation**: [README.md](README.md)
- **Backend Guide**: [backend/README.md](backend/README.md)
- **Flutter Guide**: [flutter_app/README.md](flutter_app/README.md)
- **Deployment**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **Kie.ai Docs**: https://docs.kie.ai/

## 🎉 Success!

You're now ready to test all Kie.ai APIs! 

**Next Steps**:
1. Try all the Video APIs
2. Generate some music with Suno
3. Edit images with AI
4. Have fun experimenting! 🚀

## 🆘 Need Help?

### Check Backend Logs

```bash
# In backend terminal, you'll see:
📤 Calling Kie.ai: /v1/image/nano-banana/generate
📦 Data: { "prompt": "...", ... }
✅ Response: 200
```

### Check Flutter Logs

```bash
# Run with verbose logging
flutter run -v
```

### Still Stuck?

1. Check all environment variables are set
2. Verify API key is correct at https://kie.ai/
3. Try restarting both backend and Flutter app
4. Check error messages in the app UI

---

**Happy Testing! 🎨🎥🎵**

