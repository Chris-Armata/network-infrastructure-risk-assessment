# Stage 05: Technical Evidence Register
| Evidence ID | File Path | Collection Command | Linked Findings |
| :--- | :--- | :--- | :--- |
| `E-001` | `network/E-001-nmap-smb-ast02.txt` | `nmap -sV -sC -p 22,139,445 10.0.2.15` | `F-01`, `F-03`, `F-04` |
| `E-002` | `infrastructure/E-002-smb-baseline-posture.txt` | `testparm -s` & `ls -ld /srv/samba/ClinicBackups` | `F-01`, `F-02` |
| `E-003` | `clinical-storage/E-003-unauth-smb-ransomware-drop.txt` | `smbclient -L //10.0.2.15 -N` & `put payload.txt` | `F-01`, `F-02` |
| `E-004` | `network/E-004-ufw-baseline-vs-hardened.txt` | `sudo ufw status verbose` (Before & After) | `F-03` |
| `E-005` | `resilience/E-005-post-remediation-smb-denial.txt` | `NT_STATUS_ACCESS_DENIED` & `[UFW BLOCK]` logs | Validation |
| `E-006` | `vendor-access/E-006-sshd-and-backup-service-posture.txt` | `sshd -T` & `backup_admin` share check | Validation |
