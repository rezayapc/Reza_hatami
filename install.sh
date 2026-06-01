#!/bin/bash

# V2Ray Installation Script for Linux
# VLESS Protocol - Port 1080

set -e

echo "🚀 شروع نصب V2Ray..."

# بررسی دسترسی root
if [[ $EUID -ne 0 ]]; then
   echo "❌ این اسکریپت نیاز به دسترسی root دارد"
   exit 1
fi

# به‌روزرسانی سیستم
echo "📦 به‌روزرسانی پکیج‌ها..."
apt-get update -qq
apt-get install -y curl wget unzip >/dev/null 2>&1

# نصب V2Ray
echo "⬇️  دانلود V2Ray..."
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

# ایجاد پوشه لازم
mkdir -p /etc/v2ray
mkdir -p /var/log/v2ray
chmod 755 /var/log/v2ray

# کپی کردن کنفیگ
echo "📝 نصب کنفیگ..."
cp server-config.json /etc/v2ray/config.json

# تولید سرتیفیکت خودامضا (اختیاری)
echo "🔐 تولید سرتیفیکت..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/v2ray/key.pem \
  -out /etc/v2ray/cert.pem \
  -subj "/C=IR/ST=Tehran/L=Tehran/O=V2Ray/CN=example.com" 2>/dev/null

# فعال‌سازی سرویس
echo "✅ فعال‌سازی V2Ray..."
systemctl enable v2ray
systemctl restart v2ray

echo ""
echo "✅ نصب تکمیل شد!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 وضعیت:"
systemctl status v2ray --no-pager
echo ""
echo "📝 فایل کنفیگ: /etc/v2ray/config.json"
echo "📋 لاگ‌ها: /var/log/v2ray/"
echo ""
echo "🔧 نکات مهم:"
echo "1. IP سرور را در client-config.json تغییر دهید"
echo "2. یک دومین DNS اختصاص دهید"
echo "3. از firewall استفاده کنید (پورت 1080 را باز کنید)"