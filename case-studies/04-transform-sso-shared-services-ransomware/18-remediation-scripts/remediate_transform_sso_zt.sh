#!/usr/bin/env bash
set -euo pipefail
ufw --force reset > /dev/null
ufw default deny incoming > /dev/null
ufw default allow outgoing > /dev/null
ufw allow from 10.0.2.50 to any port 2222 proto tcp comment "Approved Admin Safe Only" > /dev/null
ufw allow from 10.0.2.50 to any port 8443 proto tcp comment "Approved Medical Hub Only" > /dev/null
ufw --force enable > /dev/null
ufw status verbose
