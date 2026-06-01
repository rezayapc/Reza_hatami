#!/bin/bash

# V2Ray Configuration Builder
# این اسکریپت به صورت تعاملی کنفیگ‌های شما را ایجاد می‌کند

echo "🔧 V2Ray Configuration Builder"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# دریافت اطلاعات سرور
read -p "📍 IP سرور شما: " SERVER_IP
read -p "🌐 دومین سرور (مثال: example.com): " DOMAIN
read -p "🔐 UUID (Enter برای تولید خودکار): " UUID

# اگر UUID خالی بود، تولید کن
if [ -z "$UUID" ]; then
    UUID=$(python3 -c "import uuid; print(uuid.uuid4())" 2>/dev/null || uuidgen)
    echo "✅ UUID تولید شد: $UUID"
fi

# ایجاد client config
cat > client-config-custom.json << EOF
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": false
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vless",
      "settings": {
        "vnext": [
          {
            "address": "$SERVER_IP",
            "port": 1080,
            "users": [
              {
                "id": "$UUID",
                "flow": "xtls-rprx-vision",
                "encryption": "none",
                "level": 0
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "serverName": "$DOMAIN",
          "allowInsecure": false
        }
      },
      "mux": {
        "enabled": true,
        "concurrency": 8
      }
    }
  ]
}
EOF

echo ""
echo "✅ کنفیگ ایجاد شد: client-config-custom.json"
echo ""
echo "📋 خلاصه تنظیمات:"
echo "━━━━━━━━━━━━━━━━━"
echo "🔹 Server IP: $SERVER_IP"
echo "🔹 Domain: $DOMAIN"
echo "🔹 Port: 1080"
echo "🔹 Protocol: VLESS"
echo "🔹 UUID: $UUID"
echo ""
echo "✅ فایل آماده برای اندروید است!"