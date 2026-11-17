# Stage 17: Technical Findings & Remediation Verification Report
1. **Baseline Exploitation (`E-001`–`E-003`):** `smbclient //10.0.2.15/ClinicBackups -N -c 'put /tmp/payload.txt payload.txt; ls'` succeeded anonymously.
2. **Hardening (`18-remediation-scripts/remediate_smb_zerotrust.sh`):** Locked Samba to `SMB3_11` + `valid users = backup_admin`, set `/srv/samba/ClinicBackups` to `0750`, and restricted UFW `445/tcp` and `22/tcp` to `10.0.2.50`.
3. **Verification (`E-004`–`E-006`):** Local anonymous login returned `NT_STATUS_ACCESS_DENIED`; lateral probe from `10.0.2.25` logged `[UFW BLOCK]` (`NT_STATUS_IO_TIMEOUT`); authenticated sync from `10.0.2.50` succeeded.
