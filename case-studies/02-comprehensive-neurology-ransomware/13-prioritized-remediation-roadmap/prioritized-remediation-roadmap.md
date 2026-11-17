# Stage 9: Prioritized Remediation Roadmap
1. Disable SMB guest access (`map to guest = never`, `valid users = backup_admin`).
2. Enforce UFW source-IP micro-segmentation (`10.0.2.50` -> `445/tcp`) and `chmod 0770`.
