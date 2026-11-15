# Executive Healthcare Imaging Cyber Risk Report
**Engagement:** Case Study 01 — Northeast Radiology (NERAD) Imaging Infrastructure Risk Assessment  
**Prepared By:** Chris Armata, Lead Healthcare Infrastructure Risk Assessor  
**Assessment Date:** November 15, 2026 | **Playbook Baseline:** 2026 Healthcare Imaging Operating Playbook  

---

## 1. Mandatory Fixed-Scope & Non-Exploitation Statement
> *"This engagement identifies, validates, and risk-ranks cybersecurity weaknesses within the agreed healthcare-imaging scope. Unless explicitly stated in a separate Statement of Work, it does not constitute a penetration test, exploitation exercise, clinical safety assessment, regulatory audit, certification, medical-device conformity assessment, or legal opinion. No assessment activity authorizes modification of a medical device or clinical workflow."*

---

## 2. Executive Summary & Clinical Context
Northeast Radiology (NERAD) operates an outpatient diagnostic imaging environment centered on an **Orthanc PACS Server (`AST-01`, `10.0.2.15`)** receiving DICOM studies (`TCP 4242`) from diagnostic imaging modalities (`AST-02`, `10.0.2.20`) and serving clinical viewing workflows (`TCP 8042`) to radiologist/administrative workstations (`AST-03`, `10.0.2.30`). Modeled on the real-world NERAD security incident ($350,000 HHS OCR settlement affecting 298,532 patients' radiology records), this assessment evaluated network exposure, segmentation boundaries, clinical workflow dependencies, and third-party access governance.

### Overall Risk Posture
* **Baseline Posture (Critical Risk):** The PACS server operated with unauthenticated web/API access (`AuthenticationEnabled: false`), unencrypted DICOM and HTTP transport (`SslEnabled: false`), and blanket host firewall rules (`ALLOW IN Anywhere`) across a flat `10.0.2.0/24` subnet. Any compromised general office endpoint (`AST-04`) could enumerate, download, alter, or delete patient radiology studies without credentials.
* **Post-Containment Posture (Low Network Residual Risk):** Immediate enforcement of host-based **Policy Enforcement Point (PEP)** micro-segmentation via UFW (`NIST SP 800-207`) eliminated unauthorized lateral reachability (`F-001`, `F-002`), reducing immediate breach exposure while preserving uninterrupted modality-to-PACS clinical flow.

### Risk Distribution Summary
| Inherent Risk Level | Count | Finding IDs | Residual Risk (Post-Phase 1 PEP) |
| :--- | :--- | :--- | :--- |
| **Critical** | `1` | `F-001` (Unauthenticated PACS REST API / Web Explorer) | **Low** (Network-isolated; app auth scheduled) |
| **High** | `3` | `F-002` (Unrestricted DICOM), `F-003` (Cleartext Transport), `F-004` (SPOF & Backup Isolation) | `1` **Low**, `1` **Medium**, `1` **High** |
| **Medium-High** | `1` | `F-005` (Unsegmented SSH & Vendor Remote Access) | **Medium** |

---

## 3. Top Three Priorities & Clinical Consequences
1. **Unauthenticated PACS Web/API Exposure (`F-001` — Inherent: Critical | Residual: Low):** Direct exposure of patient demographics and diagnostic studies to any flat-subnet host threatens mass ePHI disclosure and study deletion.
2. **Unrestricted DICOM Ingestion (`F-002` — Inherent: High | Residual: Low):** Lack of source-IP and calling AE-title restrictions allows rogue devices to inject corrupted DICOM objects into clinical reading queues, creating patient-safety and misdiagnosis hazards.
3. **Single-Host PACS SPOF & Unverified Offline Recovery (`F-004` — Inherent: High | Residual: High):** Lack of verified immutable/offline backup restoration risks prolonged outpatient radiology shutdowns and repeat patient radiation exposure if active studies are lost.

---

## 4. Remediation Roadmap Overview
* **Phase 1 (Days 1–7 — Immediate Containment):** Enforce host PEP source-IP allowlists (`8042/tcp` → `10.0.2.30`; `4242/tcp` → `10.0.2.20`) [Completed] and restrict SSH (`22/tcp`) to jump-host IPs with key-only authentication.
* **Phase 2 (Days 8–30 — Scheduled Maintenance Window):** Enable Orthanc user authentication (`AuthenticationEnabled: true`), enforce DICOM AE-title allowlists, and deploy an Nginx TLS 1.3 reverse proxy.
* **Phase 3 (Days 31–90 — Architecture & Resilience):** Implement core switch VLAN segmentation, ticket-gated JIT vendor remote access, and pull-based immutable backups with a verified sandbox restore drill.

---

## 5. Methodology, Coverage & Explicit Limitations Statement
* **Assessment Window & Environment:** November 15, 2026 (`01:15–02:15 UTC`) within approved NERAD lab boundary (`10.0.2.0/24`).
* **Tooling & Versions:** Nmap `7.94SVN` (`-sT -Pn -T2 -sV`), Linux `ss` (iproute2), `ufw`, `systemctl`, `grep`, and `sha256sum`.
* **Coverage Summary:** `2` hosts actively/configurationally assessed (`AST-01`, `AST-03`); `1` clinical modality (`AST-02`, `10.0.2.20`) explicitly **excluded from active scanning** and evaluated passively via firewall/architecture review to protect clinical safety.
* **Explicit Limitations & Data Handling:** No exploitation, password spraying, firmware modification, or clinical image downloading occurred. Zero patient-identifiable DICOM image payloads were retained. All evidence files are protected via `SHA256` hashes in `21-evidence-hash-manifest.txt` for a 90-day client retention window.
