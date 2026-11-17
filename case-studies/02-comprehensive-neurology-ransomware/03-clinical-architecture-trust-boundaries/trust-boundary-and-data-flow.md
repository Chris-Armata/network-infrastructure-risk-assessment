# Stage 3: Clinical Architecture, Trust Boundaries & Data-Flow Map
- **Baseline:** Flat subnet with `UFW ALLOW Anywhere` on `445/tcp` and Samba `guest ok = yes`.
- **Target Zero Trust (NIST SP 800-207):** UFW host PEP restricting `445/tcp` to `10.0.2.50` + Samba RBAC (`valid users = backup_admin`).
