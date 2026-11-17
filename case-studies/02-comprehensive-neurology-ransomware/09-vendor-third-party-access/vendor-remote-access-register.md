# Stage 09: Administrative & Third-Party Remote Access Register
* **`SSH (22/tcp)`:** Restricted via UFW to `10.0.2.50`; `PermitRootLogin no`, `PasswordAuthentication no`, `AllowUsers assessor backup_admin` (`E-004`, `E-006`).
* **`SMB3 (445/tcp)`:** Restricted via UFW to `10.0.2.50`; `map to guest = Never`, `valid users = backup_admin`, `server signing = mandatory` (`E-004`, `E-005`, `E-006`).
