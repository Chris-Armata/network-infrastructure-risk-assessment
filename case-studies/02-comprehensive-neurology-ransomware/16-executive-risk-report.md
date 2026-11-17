# Stage 10: Executive Risk Report — Comprehensive Neurology, P.C.
An assumed-breach assessment demonstrated that a compromised workstation on a flat network could encrypt `ClinicBackups` via unauthenticated SMB guest access. Enforcing Samba RBAC (`valid users = backup_admin`) and UFW micro-segmentation (`445/tcp` restricted to `10.0.2.50`) eliminated lateral ransomware propagation.
