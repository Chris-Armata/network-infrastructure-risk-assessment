# Stage 15: Clinical System Lifecycle & Hardening Snapshot
* **Ubuntu 24.04.1 LTS:** UFW allowlist restricted to `10.0.2.50` (`22/tcp`, `445/tcp`), `ufw logging medium` (`E-004`).
* **Samba `4.19.5`:** `SMB3_11`, `valid users = backup_admin`, `0750` mount, `testparm -s` validated (`E-005`).
* **OpenSSH `9.6p1`:** Key-based auth only, `PermitRootLogin no`, `AllowUsers assessor backup_admin` (`E-006`).
