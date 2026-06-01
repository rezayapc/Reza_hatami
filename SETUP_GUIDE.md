# 📖 راهنمای نصب و تنظیم V2Ray

## ⚡ خلاصه سریع

**پروتکل:** VLESS | **پورت:** 1080 | **سرور:** Linux | **کلاینت:** Android

---

## 🖥️ مرحله 1: نصب روی سرور لینوکس

### پیش‌نیازها:
- سرور لینوکس (Ubuntu 20.04+ یا Debian 11+)
- دسترسی SSH و root
- یک دومین (اختیاری اما توصیه شده)

### مراحل:

```bash
# 1. وارد سرور شوید
ssh root@YOUR_SERVER_IP

# 2. دانلود فایل‌های کنفیگ
git clone https://github.com/rezayapc/reza_hatami.git
cd reza_hatami

# 3. نصب خودکار
chmod +x install.sh
sudo bash install.sh
```

### تنظیمات اضافی:

```bash
# ویرایش کنفیگ
nano /etc/v2ray/config.json

# بررسی وضعیت
systemctl status v2ray

# مشاهده لاگ‌ها
tail -f /var/log/v2ray/error.log
```

---

## 📱 مرحله 2: نصب روی اندروید

### نصب اپلیکیشن:

**گزینه 1: V2RayNG (رسمی)**
- دانلود از: [Google Play](https://play.google.com/store/apps/details?id=com.v2ray.ang)
- یا APK از: [GitHub Release](https://github.com/2dust/v2rayNG/releases)

**گزینه 2: V2RayNGX (بهتر)**
- دانلود از: [GitHub](https://github.com/xxf098/shadowsocksr-v2ray-plugin/releases)

### تنظیم اتصال:

#### روش 1: Import فایل JSON
1. اپ را باز کنید
2. `+` را کلیک کنید
3. "Import config from clipboard" یا "Import config from file"
4. فایل `client-config.json` را انتخاب کنید

#### روش 2: دستی
- **Address:** IP سرورتان
- **Port:** 1080
- **UUID:** `550e8400-e29b-41d4-a716-446655440000`
- **Encryption:** none
- **Network:** tcp
- **TLS:** تفعیل کنید

---

## 🔧 تنظیمات ضروری

### 1️⃣ به‌روزرسانی IP و دومین

**روی سرور:**
```bash
nano /etc/v2ray/config.json
```

تغییر دهید:
```json
"serverName": "YOUR_DOMAIN"
```

**روی اندروید (client-config.json):**
```json
"address": "123.45.67.89",
"serverName": "yourdomain.com"
```

### 2️⃣ Firewall

```bash
ufw allow 1080/tcp
ufw allow 1080/udp
```

---

## ✅ تست اتصال

```bash
# روی سرور - بررسی listener
netstat -tlnp | grep 1080

# روی اندروید - تست اتصال
# اپ را باز کنید و "Test All" را فشار دهید
```

---

## 🚀 آماده برای اتصال!

**موفق باشید! 🎉**