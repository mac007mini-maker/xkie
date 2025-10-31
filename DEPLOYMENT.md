# Deployment Guide - Kie.ai Tester App

Complete guide to deploy your Kie.ai testing app to production.

## 📋 Prerequisites

- Kie.ai API key (from https://kie.ai/)
- Vercel account (free tier is fine)
- Flutter development environment
- Git repository (optional but recommended)

## 🌐 Part 1: Deploy Backend to Vercel

### Step 1: Prepare Backend

1. Navigate to backend directory:
```bash
cd backend
```

2. Verify all files are ready:
```bash
ls -la
# Should see: index.js, package.json, vercel.json, api/, utils/
```

3. Test locally first:
```bash
npm install
cp env.example .env
# Edit .env and add your KIE_API_KEY
npm run dev
# Test: curl http://localhost:3000
```

### Step 2: Deploy via Vercel CLI

**Option A: Using Vercel CLI (Recommended)**

1. Install Vercel CLI:
```bash
npm install -g vercel
```

2. Login to Vercel:
```bash
vercel login
```

3. Deploy (from backend directory):
```bash
vercel
```

4. Follow prompts:
   - Set up and deploy? **Y**
   - Which scope? Choose your account
   - Link to existing project? **N**
   - Project name? **kie-ai-backend** (or your choice)
   - In which directory is your code? **./** (current directory)
   - Want to override settings? **N**

5. Add environment variable:
```bash
vercel env add KIE_API_KEY production
# Paste your Kie.ai API key when prompted
```

6. Deploy to production:
```bash
vercel --prod
```

7. Note your deployment URL:
```
✅ Production: https://kie-ai-backend-xxx.vercel.app
```

**Option B: Using Vercel Dashboard**

1. Go to https://vercel.com/new

2. Click "Import Project"

3. Import from Git:
   - Connect your Git provider (GitHub, GitLab, Bitbucket)
   - Select your repository
   - Click "Import"

4. Configure project:
   - **Framework Preset**: Other
   - **Root Directory**: `backend`
   - **Build Command**: (leave empty)
   - **Output Directory**: (leave empty)
   - **Install Command**: `npm install`

5. Add environment variable:
   - Click "Environment Variables"
   - Name: `KIE_API_KEY`
   - Value: Your Kie.ai API key
   - Check all environments (Production, Preview, Development)

6. Click "Deploy"

7. Wait for deployment to complete (1-2 minutes)

8. Copy your deployment URL:
```
https://your-project-name.vercel.app
```

### Step 3: Test Backend Deployment

1. Test health check:
```bash
curl https://your-project-name.vercel.app
```

Expected response:
```json
{
  "success": true,
  "message": "Kie.ai Backend API",
  "version": "1.0.0",
  "endpoints": { ... }
}
```

2. Test an API endpoint:
```bash
curl -X POST https://your-project-name.vercel.app/api/photo/nano-banana/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "A cute cat", "output_format": "png", "image_size": "1:1"}'
```

### Step 4: Monitor & Manage

**View Logs**:
```bash
vercel logs
```

Or in Vercel dashboard: Project → Deployments → Click deployment → Logs

**Update Environment Variable**:
```bash
vercel env rm KIE_API_KEY production
vercel env add KIE_API_KEY production
```

**Redeploy**:
```bash
vercel --prod
```

## 📱 Part 2: Configure Flutter App

### Step 1: Update Backend URL

1. Open Flutter project:
```bash
cd flutter_app
```

2. Edit `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // PRODUCTION: Use your Vercel deployment URL
  static const String baseUrl = 'https://your-project-name.vercel.app';
  
  // For local development, uncomment this:
  // static const String baseUrl = 'http://localhost:3000';
  
  // ... rest of the file
}
```

3. Save the file

### Step 2: Test Connection

1. Run app on simulator/emulator:
```bash
flutter run
```

2. Test an API:
   - Open any tab (Video/Audio/Photo)
   - Expand an API card
   - Tap "Test API"
   - Verify it connects to production backend

### Step 3: Build Release Version

**For Android**:

1. Build APK:
```bash
flutter build apk --release
```

2. APK location:
```
build/app/outputs/flutter-apk/app-release.apk
```

3. Install on device:
```bash
flutter install
```

Or build App Bundle (for Google Play):
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**For iOS**:

1. Build:
```bash
flutter build ios --release
```

2. Open in Xcode:
```bash
open ios/Runner.xcworkspace
```

3. In Xcode:
   - Select "Runner" in project navigator
   - Select "Signing & Capabilities"
   - Choose your development team
   - Select "Product" → "Archive"
   - Distribute to App Store or AdHoc

## 🔐 Security Best Practices

### Backend Security

1. **Never commit .env file**:
```bash
# Verify .gitignore includes .env
cat backend/.gitignore | grep .env
```

2. **Rotate API keys regularly**:
```bash
# Update in Vercel
vercel env rm KIE_API_KEY production
vercel env add KIE_API_KEY production
```

3. **Monitor usage**:
   - Check Vercel dashboard for bandwidth
   - Monitor Kie.ai credits usage
   - Set up alerts for unusual activity

### Flutter App Security

1. **No API keys in code**: ✅ Already implemented (keys on backend)

2. **HTTPS only**: ✅ Vercel provides HTTPS by default

3. **Validate inputs**: Add validation before sending to backend

## 📊 Monitoring & Maintenance

### Vercel Monitoring

1. **View analytics**:
   - Go to Vercel dashboard
   - Select project
   - Click "Analytics" tab

2. **Check function logs**:
   - Dashboard → Project → Logs
   - Filter by status code, time range

3. **Monitor costs**:
   - Dashboard → Settings → Usage
   - Free tier limits: 100GB bandwidth/month

### Kie.ai Usage

1. **Check credits**:
   - Visit https://kie.ai/account
   - Monitor credit balance
   - Set up low balance alerts

2. **Review API usage**:
   - Check which APIs consume most credits
   - Optimize usage patterns

## 🔄 Update & Redeploy

### Update Backend Code

1. Make changes to backend code

2. Test locally:
```bash
cd backend
npm run dev
# Test your changes
```

3. Deploy:
```bash
vercel --prod
```

4. Verify deployment:
```bash
curl https://your-project-name.vercel.app
```

### Update Flutter App

1. Make changes to Flutter code

2. Test locally:
```bash
cd flutter_app
flutter run
```

3. Build and distribute:
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🐛 Troubleshooting Deployment

### Vercel Deployment Fails

**Error: "Build failed"**
```bash
# Check package.json has correct Node version
"engines": {
  "node": ">=18.x"
}
```

**Error: "Function timeout"**
- Increase function timeout in vercel.json:
```json
{
  "functions": {
    "api/**/*.js": {
      "maxDuration": 60
    }
  }
}
```

**Error: "Environment variable not set"**
```bash
# Verify environment variable
vercel env ls
# Should show KIE_API_KEY

# Add if missing
vercel env add KIE_API_KEY production
```

### Flutter Build Issues

**Android build fails**:
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build apk --release
```

**iOS build fails**:
- Update CocoaPods: `pod repo update`
- Clean: `flutter clean`
- Remove Pods: `cd ios && rm -rf Pods Podfile.lock`
- Reinstall: `pod install`

### Connection Issues

**"Cannot connect to backend"**:

1. Verify URL in `api_config.dart`
2. Test backend directly: `curl https://your-backend.vercel.app`
3. Check CORS is enabled (it is by default)
4. Verify device has internet connection

**"API Key invalid"**:

1. Check environment variable:
```bash
vercel env ls
```

2. Verify API key is correct:
   - Login to Kie.ai
   - Check API key in settings
   - Update if needed

## 💰 Cost Optimization

### Vercel Free Tier Limits

- ✅ 100GB bandwidth/month
- ✅ 100GB-hours compute time
- ✅ Unlimited API requests
- ✅ 1000 serverless function invocations/day

### Kie.ai Credit Usage

- Monitor credit consumption per API
- Use lower-cost APIs when possible
- Implement caching if needed (future enhancement)

## 📝 Deployment Checklist

### Before Deployment

- [ ] Test all APIs locally
- [ ] Verify environment variables are set
- [ ] Update backend URL in Flutter app
- [ ] Test Flutter app with production backend
- [ ] Review security settings

### After Deployment

- [ ] Test health check endpoint
- [ ] Test at least one API from each category
- [ ] Verify error handling works
- [ ] Check Vercel logs for errors
- [ ] Monitor credit usage on Kie.ai
- [ ] Document deployment URL
- [ ] Share app with testers

## 🎉 Success!

Your Kie.ai testing app is now deployed and ready to use!

**Backend**: https://your-project-name.vercel.app
**Flutter App**: Installed on device or in app store

---

Need help? Check the main README.md or backend/README.md for more details.

