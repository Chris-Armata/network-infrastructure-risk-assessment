# Stage 14: NIST SP 800-207 Zero Trust Cyber Resilience Snapshot
* **No Implicit Subnet Trust (`E-004`, `E-005`):** `10.0.2.25` dropped at UFW (`[UFW BLOCK]`).
* **Explicit Identity & Least Privilege (`E-005`, `E-006`):** `map to guest = Never`, `valid users = backup_admin`, `0750` permissions.
* **Mandatory Integrity (`E-005`):** `min protocol = SMB3_11`, `server signing = mandatory`.
