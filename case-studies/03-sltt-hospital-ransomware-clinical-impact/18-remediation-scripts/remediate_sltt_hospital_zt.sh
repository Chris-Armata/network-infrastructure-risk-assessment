#!/usr/bin/env bash
set -euo pipefail

echo "[*] Capturing pre-remediation UFW baseline..."
sudo ufw status verbose > /tmp/ufw_before_cs3.txt

echo "[*] Provisioning dedicated Tier-0 service principal (tier0_admin)..."
id tier0_admin &>/dev/null || sudo useradd -r -M -s /usr/sbin/nologin tier0_admin
printf 'Tier0ZeroTrust!\nTier0ZeroTrust!\n' | sudo smbpasswd -a -s tier0_admin >/dev/null
sudo smbpasswd -e tier0_admin >/dev/null

echo "[*] Hardening SYSVOL filesystem permissions (0750) and Samba RBAC (SMB3_11)..."
sudo rm -f /tmp/gpo_leak.ps1
sudo chown -R tier0_admin:tier0_admin /srv/samba/SYSVOL
sudo chmod -R 0750 /srv/samba/SYSVOL

cat << 'SMB' | sudo tee /etc/samba/smb.conf >/dev/null
[global]
    workgroup = SLTTHOSPITAL
    server role = standalone server
    map to guest = Never
    restrict anonymous = 2
    usershare allow guests = No
    min protocol = SMB3_11
    server signing = mandatory

[SYSVOL]
    path = /srv/samba/SYSVOL
    comment = Restricted Tier-0 Domain Controller SYSVOL (PAW-01 Only)
    browseable = No
    guest ok = No
    read only = No
    valid users = tier0_admin
    create mask = 0640
    directory mask = 0750
SMB
testparm -s >/dev/null
sudo systemctl restart smbd

echo "[*] Switching DC-01 to LDAPS (636/tcp) & enabling Clinical Break-Glass Contingency Mode..."
echo "SLTT_MODE=hardened" | sudo tee /etc/default/sltt-clinical >/dev/null
sudo systemctl restart sltt-clinical
sleep 1

echo "[*] Enforcing NIST SP 800-207 Zero Trust UFW Micro-Segmentation..."
sudo ufw --force reset >/dev/null
sudo ufw logging medium >/dev/null
sudo ufw default deny incoming >/dev/null
sudo ufw default allow outgoing >/dev/null

# Tier-0 Admin & Identity Ports: Exclusively PAW-01 (10.0.2.50)
sudo ufw allow from 10.0.2.50 to any port 22 proto tcp >/dev/null
sudo ufw allow from 10.0.2.50 to any port 636 proto tcp >/dev/null
sudo ufw allow from 10.0.2.50 to any port 445 proto tcp >/dev/null

# Tier-1 Clinical Service Ports: Exclusively Authorized Clinical Floor (10.0.2.30)
sudo ufw allow from 10.0.2.30 to any port 8443 proto tcp >/dev/null
sudo ufw allow from 10.0.2.30 to any port 8444 proto tcp >/dev/null
sudo ufw allow from 10.0.2.30 to any port 8445 proto tcp >/dev/null

sudo ufw --force enable >/dev/null
echo "[+] SLTT Hospital Zero Trust Tiering & Clinical Break-Glass Remediation Complete!"
