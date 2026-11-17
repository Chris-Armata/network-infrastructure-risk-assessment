# Case Study 02: Comprehensive Neurology, P.C. — Ransomware Blast Radius Containment & Zero Trust Micro-Segmentation

## Engagement Context & Regulatory Trigger
Modeled on the **April 2025 U.S. Department of Health and Human Services (HHS) Office for Civil Rights (OCR) $25,000 HIPAA Security Rule resolution agreement with Comprehensive Neurology, P.C.** (New York), following a ransomware breach that encrypted clinic systems and compromised the ePHI of ~6,800 patients due to an incomplete enterprise Risk Analysis (`45 CFR § 164.308(a)(1)(ii)(A)`).

## Lab Topology & Trust Boundaries
| Host ID | Hostname | IP Address | Role | Trust Zone |
| :--- | :--- | :--- | :--- | :--- |
| `AST-02` | `ast02.compneuro.local` | `10.0.2.15` | Samba EHR & Billing Backup Server (`ClinicBackups`) | Restricted Clinical Data Tier |
| `ADMIN-01` | `backup-admin.compneuro.local` | `10.0.2.50` | Authorized Backup Orchestrator & Admin Workstation | Privileged Management Tier |
| `ENDPT-01` | `front-desk-01.compneuro.local` | `10.0.2.25` | Front-Desk Reception Workstation (Assumed Breach) | Untrusted User Access Tier |

## Three-Act Empirical Methodology
1. **Act 1 — Assumed Breach (`E-001`–`E-003`):** Enumerated `139/tcp` and `445/tcp` on `10.0.2.15`, mapped `//10.0.2.15/ClinicBackups` anonymously, and wrote `payload.txt` directly beside clinical EHR backups without credentials.
2. **Act 2 — Defense-in-Depth Hardening (`18-remediation-scripts/remediate_smb_zerotrust.sh`):** Enforced Samba RBAC (`map to guest = Never`, `valid users = backup_admin`, `SMB3_11`, `0750` perms) and UFW source-IP micro-segmentation (`10.0.2.50` only).
3. **Act 3 — Containment Proof (`E-004`–`E-006`):** Verified `NT_STATUS_ACCESS_DENIED` on anonymous logins and `[UFW BLOCK]` (`NT_STATUS_IO_TIMEOUT`) for unauthorized subnet endpoints.
