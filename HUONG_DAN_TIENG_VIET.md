# 🇻🇳 Hướng Dẫn Sử Dụng - Kie.ai API Tester

## 📋 Bạn Cần Có

1. ✅ Node.js 18+ ([tải tại đây](https://nodejs.org/))
2. ✅ Flutter SDK ([tải tại đây](https://flutter.dev/))
3. ✅ Kie.ai API key ([lấy tại đây](https://kie.ai/))
4. ✅ iOS Simulator hoặc Android Emulator

## ⚡ Bắt Đầu Nhanh (Chạy Local)

### Bước 1: Cài Đặt Backend (2 phút)

```bash
# 1. Vào thư mục backend
cd backend

# 2. Cài đặt các thư viện
npm install

# 3. Tạo file .env từ mẫu
cp env.example .env

# 4. Mở file .env và thêm API key của bạn
# KIE_API_KEY=api_key_cua_ban
nano .env  # hoặc dùng bất kỳ editor nào

# 5. Chạy backend
npm run dev
```

✅ Backend đã chạy tại `http://localhost:3000`

### Bước 2: Cài Đặt Flutter App (2 phút)

```bash
# 1. Mở terminal mới, vào thư mục Flutter
cd flutter_app

# 2. Cài đặt các thư viện
flutter pub get

# 3. Chạy app
flutter run
```

✅ App sẽ mở trên simulator/emulator của bạn!

### Bước 3: Test API Đầu Tiên (1 phút)

1. Trong app, vào tab **Photo**
2. Nhấn vào card **"Nano Banana - Generate"** để mở rộng
3. Xem prompt mẫu (đã được điền sẵn)
4. Nhấn nút **"Test API"**
5. Đợi vài giây
6. Xem ảnh được tạo! 🎨

## 🎯 Nên Test Gì Trước

### API Nhanh (Phản hồi nhanh)

1. **Photo → Nano Banana → Generate**
   - Thời gian: ~5 giây
   - Mẫu hoạt động ngay
   - Hoàn hảo để test đầu tiên!

2. **Photo → Ideogram V3**
   - Thời gian: ~10 giây
   - Thử các style khác nhau

### API Trung Bình (Cần upload file)

3. **Photo → Nano Banana → Edit**
   - Thời gian: ~10 giây
   - Upload ảnh trước
   - Thử "làm cho nó màu sắc hơn"

### API Nâng Cao (Đợi lâu hơn)

4. **Video → Veo 3.1 → Generate**
   - Thời gian: 1-2 phút
   - Tạo video ngắn
   - Rất tuyệt! 🎥

5. **Audio → Suno V4 → Generate**
   - Thời gian: 1-2 phút
   - Tạo nhạc
   - Thử các thể loại khác nhau 🎵

## 🛠️ Sửa Lỗi Thường Gặp

### "Backend không kết nối được" ❌

**iOS Simulator**:
```dart
// Trong flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://localhost:3000';
```

**Android Emulator**:
```dart
// Trong flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://10.0.2.2:3000';
```

Sau đó restart lại Flutter app:
```bash
flutter run
```

### "API Key chưa được cấu hình" ❌

1. Kiểm tra file `.env` trong thư mục backend:
```bash
cat backend/.env
```

2. Nội dung phải có:
```
KIE_API_KEY=api_key_cua_ban
```

3. Nếu không đúng, sửa lại:
```bash
nano backend/.env
```

4. Restart backend:
```bash
# Trong thư mục backend
npm run dev
```

### Backend không chạy được ❌

```bash
# Đảm bảo bạn đang ở thư mục backend
cd backend

# Cài lại các thư viện
npm install

# Kiểm tra phiên bản Node (phải là 18+)
node --version

# Thử chạy lại
npm run dev
```

## 📱 Test Trên Điện Thoại Thật

### Tìm Địa Chỉ IP Của Máy Tính

**Mac/Linux**:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
# Tìm dòng có dạng: 192.168.1.XXX
```

**Windows**:
```bash
ipconfig
# Tìm IPv4 Address: 192.168.1.XXX
```

### Cập Nhật Config Flutter

```dart
// Trong flutter_app/lib/config/api_config.dart
static const String baseUrl = 'http://192.168.1.XXX:3000';
// Thay XXX bằng IP thực của bạn
```

### Chạy Trên Điện Thoại

```bash
# Kết nối điện thoại qua USB
flutter devices  # Nên thấy điện thoại của bạn
flutter run
```

## 🌐 Deploy Lên Production (Tùy Chọn)

Muốn deploy lên cloud? Xem [DEPLOYMENT.md](DEPLOYMENT.md) để biết hướng dẫn đầy đủ.

**Deploy Nhanh Lên Vercel**:

```bash
# Cài Vercel CLI
npm install -g vercel

# Deploy backend
cd backend
vercel

# Thêm API key
vercel env add KIE_API_KEY production

# Deploy lên production
vercel --prod
```

Sau đó cập nhật URL Vercel trong Flutter app!

## 💡 Tips Khi Test

### 1. Bắt Đầu Với API Đơn Giản
- Ảnh tạo nhanh nhất
- Video mất thời gian nhất
- Nhạc ở giữa

### 2. Dùng Prompt Mẫu
- Đã được điền sẵn cho mỗi API
- Đã test và hoạt động tốt
- Sửa đổi chúng để học

### 3. Kiểm Tra Thông Báo Lỗi
- App hiển thị lỗi chi tiết
- Stack trace để debug
- Log backend cũng hữu ích

### 4. Theo Dõi Credits
- Mỗi lần gọi API tốn credits
- Kiểm tra số dư tại https://kie.ai/
- Đừng spam nút test 😅

### 5. Tips Upload File
- Max 10MB cho ảnh
- Max 100MB cho video
- Định dạng: JPG, PNG, WEBP, MP4, MOV

## 📖 Tài Liệu Chi Tiết

- **Tài liệu đầy đủ**: [README.md](README.md)
- **Hướng dẫn Backend**: [backend/README.md](backend/README.md)
- **Hướng dẫn Flutter**: [flutter_app/README.md](flutter_app/README.md)
- **Hướng dẫn Deploy**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **Docs Kie.ai**: https://docs.kie.ai/

## 🎯 Tính Năng Chính

### 🎥 Video APIs (11 APIs)
- Veo 3.1: Tạo và mở rộng video
- Runway: Chuyển ảnh thành video
- Sora 2: AI tạo video từ text
- Hailuo, Kling, Wan, Luma: Các model khác
- Xóa watermark

### 🎵 Audio APIs (3 APIs)
- Suno V4: Tạo nhạc từ mô tả
- Extend: Kéo dài bản nhạc
- Get Details: Lấy thông tin track

### 🖼️ Image APIs (9 APIs)
- Nano Banana: Tạo và chỉnh sửa ảnh
- 4O Image: Chỉnh sửa bằng AI
- Flux Kontext: Tạo ảnh theo ngữ cảnh
- Ideogram: Tạo logo và character
- Qwen: Chỉnh sửa nâng cao

## 🏗️ Cấu Trúc Dự Án

```
xkie/
├── backend/              # Backend Node.js
│   ├── api/             # Các endpoint API
│   ├── utils/           # Utilities
│   └── index.js         # Server chính
│
└── flutter_app/         # App Flutter
    └── lib/
        ├── screens/     # 3 màn hình chính
        ├── widgets/     # UI components
        ├── services/    # API service
        └── models/      # Data models
```

## 🆘 Cần Trợ Giúp?

### Xem Log Backend

```bash
# Trong terminal backend, bạn sẽ thấy:
📤 Calling Kie.ai: /v1/image/nano-banana/generate
📦 Data: { "prompt": "...", ... }
✅ Response: 200
```

### Xem Log Flutter

```bash
# Chạy với logging chi tiết
flutter run -v
```

### Vẫn Gặp Vấn Đề?

1. Kiểm tra tất cả environment variables đã được set
2. Verify API key đúng tại https://kie.ai/
3. Thử restart cả backend và Flutter app
4. Xem thông báo lỗi trong UI của app

## 🎉 Thành Công!

Bạn đã sẵn sàng test tất cả API của Kie.ai!

**Bước tiếp theo**:
1. Thử tất cả Video APIs
2. Tạo nhạc với Suno
3. Chỉnh sửa ảnh bằng AI
4. Vui vẻ thử nghiệm! 🚀

## 📞 Liên Hệ Hỗ Trợ

- **Kie.ai Support**: support@kie.ai
- **Docs**: https://docs.kie.ai/
- **Website**: https://kie.ai/

---

**Chúc Bạn Test Vui Vẻ! 🎨🎥🎵**

Made with ❤️ in Vietnam

