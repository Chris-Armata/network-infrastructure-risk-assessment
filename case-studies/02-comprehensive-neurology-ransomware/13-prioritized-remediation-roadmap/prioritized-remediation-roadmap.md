# Stage 13: Prioritized Remediation Roadmap
* **P1 (Completed — `E-004`, `E-005`):** Enforced Samba RBAC (`valid users = backup_admin`), `0750` storage permissions, and UFW source-IP micro-segmentation (`10.0.2.50` only) via `18-remediation-scripts/remediate_smb_zerotrust.sh`.
* **P2 (Recommended):** Configure scheduled off-site immutable WORM backup replication from `ADMIN-01`.
