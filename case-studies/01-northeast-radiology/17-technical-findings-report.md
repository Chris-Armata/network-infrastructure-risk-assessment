# Technical Findings & Evidence Verification Report
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Target Environment:** `AST-01` (`10.0.2.15`, Ubuntu 24.04 / Orthanc PACS), `AST-02` (`10.0.2.20` Modality), `AST-03` (`10.0.2.30` Clinical Workstation)  

---

## 1. Technical Assessment Summary
This technical report substantiates Findings `F-001` through `F-005` using hashed primary artifacts (`E-001` through `E-006`) and establishes reproducible validation commands for hospital engineering teams.

### Key Empirical Evidence Highlights
* **Service & Protocol Discovery (`E-001`):** Low-rate TCP connect scan (`nmap -sT -Pn -T2 -sV -p 22,4242,8042 10.0.2.15`) confirmed three active listeners: `22/tcp` (`OpenSSH 9.6p1`), `4242/tcp` (DICOM listener, mislabeled `vrml-multi-use?` by default Nmap signatures), and `8042/tcp` (Orthanc Web Explorer, confirmed via HTTP `Location: app/explorer.html` response header).
* **Socket & Application Posture (`E-002`, `E-003`):** `ss -tulpn` confirmed wildcard interface bindings (`0.0.0.0` / `*`), while `/etc/orthanc/orthanc.json` confirmed `"AuthenticationEnabled": false`, `"RemoteAccessAllowed": true`, and `"SslEnabled": false`.
* **Host PEP Remediation State (`E-004`):** `sudo ufw status verbose` confirmed active default-deny inbound posture (`deny (incoming)`) with explicit source-restricted allowlists permitting `8042/tcp` only from `10.0.2.30` and `4242/tcp` only from `10.0.2.20`.
* **Resilience & SSH Governance (`E-005`, `E-006`):** `systemctl is-active orthanc` confirmed single-instance production operation, and `sshd_config` / `sshd_config.d` inspection confirmed default OpenSSH directives requiring explicit jump-host IP filtering and `PasswordAuthentication no`.

---

## 2. Finding-to-Evidence Traceability Matrix
| Finding ID | Title | Primary Evidence | SHA256 Reference (First 16 Chars) | Technical Remediation Standard |
| :--- | :--- | :--- | :--- | :--- |
| `F-001` | Unauthenticated PACS REST API & Web Explorer (`8042/tcp`) | `E-001`, `E-002`, `E-003`, `E-004` | `d96a0729...`, `c9a90446...`, `5b83bf74...`, `ecbcb30e...` | NIST SP 800-207; NIST SP 1800-24 (Access Control) |
| `F-002` | Unrestricted DICOM Association Listener (`4242/tcp`) | `E-001`, `E-002`, `E-003`, `E-004` | `d96a0729...`, `c9a90446...`, `5b83bf74...`, `ecbcb30e...` | DICOM PS3.15 Security Profiles; NIST SP 800-207 |
| `F-003` | Cleartext HTTP & DICOM Transport (`SslEnabled: false`) | `E-003` | `5b83bf747a0d4f28...` | NIST SP 800-53 `SC-8` (Transmission Confidentiality) |
| `F-004` | Single-Host PACS SPOF & Unverified Backup Isolation | `E-005` | `0ec6c6274381d90e...` | NIST CSF 2.0 `RC.RP-01`; HIPAA `§ 164.308(a)(7)` |
| `F-005` | Unsegmented SSH Management & Vendor Remote Access | `E-001`, `E-004`, `E-006` | `d96a0729...`, `ecbcb30e...`, `eaf5c08f...` | NIST SP 800-53 `AC-17` (Remote Access) |

---

## 3. Detailed Technical Remediation Specifications
For complete finding records, clinical constraints, and exact validation commands, refer to `10-finding-records/finding-records.md` and `20-remediation-validation-report/remediation-validation-report.md`.
