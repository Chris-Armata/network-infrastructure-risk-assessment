#!/usr/bin/env bash
set -euo pipefail
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak.$(date +%F_%H%M%S)
cat << 'CONF' | sudo tee /etc/samba/smb.conf > /dev/null
[global]
   map to guest = never
   server min protocol = SMB3
[ClinicRecords]
   path = /srv/cn_lab/clinic_records
   read only = no
   valid users = backup_admin
[ClinicBackups]
   path = /srv/cn_lab/clinic_backups
   read only = no
   valid users = backup_admin
CONF
sudo chmod -R 0770 /srv/cn_lab
sudo ufw delete allow 445/tcp 2>/dev/null || true
sudo ufw allow from 10.0.2.50 to any port 445 proto tcp
sudo systemctl restart smbd
