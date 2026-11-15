# Stage 9.5 — Healthcare Imaging Zero Trust & Cyber-Resilience Snapshot
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Scope Disclaimer:** *This is an evidence-backed scoped readiness snapshot aligned with NIST SP 800-207 and the CISA Zero Trust Maturity Model; it does not constitute a formal maturity certification or regulatory compliance attestation.*

---

## 1. Pillar-by-Pillar Readiness Assessment
| Zero Trust Pillar | Baseline State (Observed) | Post-UFW PEP State | Evidence / Information Gap | Realistic Next Maturity Step |
| :--- | :--- | :--- | :--- | :--- |
| **Network & Environment** | **Traditional / Flat:** Single `10.0.2.0/24` subnet; `ALLOW IN Anywhere` on `8042` & `4242` | **Initial Micro-Segmentation:** Host PEP (`UFW`) restricts `8042` to `10.0.2.30` and `4242` to `10.0.2.20` | `E-001`, `E-004` | Enforce Layer-2/3 VLAN separation on core switches between modalities, PACS, and office endpoints |
| **Identity & Access** | **Traditional:** `AuthenticationEnabled: false` on Orthanc REST API; standard SSH baseline | **Unchanged at App Layer:** Network-gated by IP, but Orthanc user auth still disabled | `E-003`, `E-006` | Enable Orthanc RBAC user accounts and Ed25519 key-only SSH via MFA jump host |
| **Devices** | **Traditional:** No device-certificate posture verification before PACS connection | **IP-Bound Allowlist:** Only `10.0.2.20` and `10.0.2.30` permitted by IP | `E-004` | Pair static DHCP/ARP inspection with DICOM AE-title allowlisting and mTLS client certificates |
| **Applications & Workloads** | **Traditional:** Wildcard `0.0.0.0` listeners without TLS (`SslEnabled: false`) | **Perimeter-Protected:** Direct unauthorized socket access blocked by UFW | `E-002`, `E-003` | Bind Orthanc HTTP to `127.0.0.1:8042` behind an Nginx TLS 1.3 reverse proxy |
| **Data** | **Traditional:** Cleartext ePHI in transit; unverified offline backup immutability | **Access-Restricted:** Lateral ePHI enumeration blocked | `E-003`, `E-005` | Encrypt ePHI in transit (TLS 1.3) and isolate pull-based immutable PACS backups |
