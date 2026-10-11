#!/usr/bin/env bash
# 💥 One-command production deploy for WhatsApp Proxy POWER FORK
# Run as root on a fresh VPS

set -euo pipefail

REPO_DIR="/opt/whatsapp-proxy"
COMPOSE_FILE="docker-compose.prod.yml"
SERVICE_FILE="whatsapp-proxy.service"

echo "========================================"
echo "  WhatsApp Proxy POWER DEPLOY"
echo "========================================"

# 1. Install Docker if missing
if ! command -v docker &>/dev/null; then
  echo "[+] Installing Docker..."
  curl -fsSL https://get.docker.com | sh
  systemctl enable --now docker
fi

# 2. Clone or update the POWER FORK
if [ -d "$REPO_DIR" ]; then
  echo "[+] Updating existing repo..."
  cd "$REPO_DIR"
  git pull origin main
else
  echo "[+] Cloning POWER FORK..."
  git clone https://github.com/appycody58-byte/proxy.git "$REPO_DIR"
fi

cd "$REPO_DIR/proxy/ops"

# 3. Install systemd service
echo "[+] Installing systemd service..."
cp -f "$SERVICE_FILE" /etc/systemd/system/
# Fix WorkingDirectory path inside the unit
sed -i "s|WorkingDirectory=.*|WorkingDirectory=$REPO_DIR/proxy/ops|" /etc/systemd/system/$SERVICE_FILE

systemctl daemon-reload
systemctl enable whatsapp-proxy.service
systemctl start whatsapp-proxy.service

echo ""
echo "========================================"
echo "  DEPLOY COMPLETE"
echo "========================================"
echo "Status:   systemctl status whatsapp-proxy"
echo "Logs:     docker logs -f whatsapp_proxy"
echo "Stats:    http://YOUR_PUBLIC_IP:8199"
echo "Metrics:  http://YOUR_PUBLIC_IP:8199/metrics"
echo ""
echo "Open these ports in your firewall / security group:"
echo "  80, 443, 5222, 8199, 8080, 8443, 8222, 587, 7777"
echo "========================================"
