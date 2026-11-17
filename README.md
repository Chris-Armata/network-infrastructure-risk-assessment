# Network Infrastructure Risk Assessment

[![Live Portfolio Showcase](https://img.shields.io/badge/Live_Showcase-GitHub_Pages-38bdf8?style=for-the-badge&logo=github)](https://chris-armata.github.io/network-infrastructure-risk-assessment/)
[![Framework](https://img.shields.io/badge/Framework-NIST_SP_800--207-34d399?style=for-the-badge)](#operating-methodology)
[![Case Study 01](https://img.shields.io/badge/Case_Study_01-Video_Walkthrough_(11:08)-0f172a?style=for-the-badge)](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-1.html)
[![Case Study 02](https://img.shields.io/badge/Case_Study_02-Video_Walkthrough_(02:25)-0f172a?style=for-the-badge)](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-2.html)

A practical healthcare and critical-infrastructure cyber risk assessment operating playbook, laboratory, and portfolio of empirical, evidence-backed case studies.

> **Interactive Video Showcase:** Launch the ad-free, chapter-indexed walkthroughs directly at **[chris-armata.github.io/network-infrastructure-risk-assessment](https://chris-armata.github.io/network-infrastructure-risk-assessment/)**.

---

## Operating Methodology

Every assessment in this repository follows a reproducible, three-phase validation lifecycle mapped to a **21-stage governance and evidence playbook**:

1. **Phase 1 — Baseline & Empirical Exposure:** Enumerate active services, inspect application authentication posture, and capture raw terminal proof (`E-001`–`E-003`) of unauthenticated network reachability.
2. **Phase 2 — Architecture & Threat Modeling:** Map lateral movement paths across flat network segments and design explicit Policy Enforcement Point (PEP) boundaries aligned with **NIST SP 800-207 (Zero Trust Architecture)** and the **HIPAA Security Rule**.
3. **Phase 3 — Control Engineering & Post-Remediation Verification:** Deploy host/network micro-segmentation and RBAC controls, then re-execute baseline probes from unauthorized perspectives to verify silent packet drops and access denials (`E-004`–`E-006`).

---

## Case Study Index

### Case Study 01: Healthcare PACS (Orthanc) Security & NIST SP 800-207 Zero Trust Remediation
- **Live Walkthrough:** [Watch 11:08 Technical Video & Chapter Breakdown](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-1.html)
- **Full 21-Stage Assessment Artifacts:** [`case-studies/01-northeast-radiology/`](case-studies/01-northeast-radiology/)
- **Target Workload:** Orthanc Medical Imaging Server (PACS) hosting Protected Health Information (PHI)
- **Protocols Assessed:** DICOM (`TCP 4242`) and Orthanc REST API / Web Explorer (`TCP 8042`)

#### Lab Topology & Zero Trust Policy Matrix

| Node / Role | IPv4 Address | Permitted Port / Protocol | Enforcement Posture |
| :--- | :--- | :--- | :--- |
| **Orthanc PACS Server** (`AST-01`) | `10.0.2.15` | `8042/tcp` (HTTP), `4242/tcp` (DICOM) | Host-based UFW default-deny inbound |
| **Imaging Modality** (Authorized Client) | `10.0.2.20` | `4242/tcp` (`ALLOW IN`) | Explicit source-IP allowlist for DICOM ingestion |
| **Clinical Admin Workstation** (Authorized Client) | `10.0.2.30` | `8042/tcp` (`ALLOW IN`) | Explicit source-IP allowlist for PACS administration |
| **Unauthorized Lateral Hosts** | Any other subnet host | None (`DROP` / Timeout) | Blocked at host perimeter; zero service banner leakage |

#### Baseline vs. Post-Remediation Evidence

| Control Dimension | Phase 1: Baseline State | Phase 3: Zero Trust State |
| :--- | :--- | :--- |
| **Application Posture** | `AuthenticationEnabled: false`, `RemoteAccessAllowed: true` | Isolated behind explicit host perimeter allowlists |
| **Firewall Policy (UFW)** | `ALLOW IN Anywhere` on `8042/tcp` and `4242/tcp` | Source-restricted to `10.0.2.30` (`:8042`) and `10.0.2.20` (`:4242`) |
| **HTTP API Probe (`curl -i`)** | `HTTP/1.1 200 OK` from any local host | Connection timed out / dropped for unauthorized clients |
| **DICOM Probe (`nc -zv`)** | `Connection to 10.0.2.15 4242 port [tcp/*] succeeded!` | Connection timed out / dropped for unauthorized clients |

---

### Case Study 02: Comprehensive Neurology, P.C. — Ransomware Blast Radius Containment & Zero Trust Remediation
- **Live Walkthrough:** [Watch 02:25 Technical Video & Chapter Breakdown](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-2.html)
- **Full 21-Stage Assessment Artifacts:** [`case-studies/02-comprehensive-neurology-ransomware/`](case-studies/02-comprehensive-neurology-ransomware/README.md)
- **Raw Evidence & Automation:** [`05-evidence-register/`](case-studies/02-comprehensive-neurology-ransomware/05-evidence-register/) | [`remediate_smb_zerotrust.sh`](case-studies/02-comprehensive-neurology-ransomware/18-remediation-scripts/remediate_smb_zerotrust.sh) | [`SHA-256 Manifest`](case-studies/02-comprehensive-neurology-ransomware/21-evidence-hash-manifest.txt)
- **Regulatory Benchmark:** April 2025 HHS OCR HIPAA Resolution Agreement ($25,000 Settlement / ~6,800 Patient ePHI Records)
- **Protocols Assessed:** SMB / CIFS (`TCP 445`) & OpenSSH (`TCP 22`)

#### Lab Topology & Zero Trust Policy Matrix

| Node / Role | IPv4 Address | Permitted Port / Protocol | Enforcement Posture |
| :--- | :--- | :--- | :--- |
| **Clinical Backup Server** (`AST-02`) | `10.0.2.15` | `445/tcp` (SMB3), `22/tcp` (SSH) | UFW default-deny inbound + Samba RBAC (`valid users = backup_admin`) |
| **Backup Orchestrator** (`ADMIN-01`) | `10.0.2.50` | `445/tcp`, `22/tcp` (`ALLOW IN`) | Exclusive source-IP allowlist for scheduled clinical backup sync |
| **Front-Desk Workstation** (`ENDPT-01`) | `10.0.2.25` | None (`[UFW BLOCK]` / Timeout) | Assumed-breach vantage point; blocked at perimeter and Samba layer |

#### Baseline vs. Post-Remediation Evidence

| Control Dimension | Phase 1: Baseline State | Phase 3: Zero Trust State |
| :--- | :--- | :--- |
| **Samba & Storage ACLs** | `guest ok = Yes`, `map to guest = Bad User`, `0777` perms | `map to guest = Never`, `SMB3_11`, `valid users = backup_admin`, `0750` perms |
| **Firewall Policy (UFW)** | `ALLOW IN Anywhere` on `139/tcp`, `445/tcp`, `22/tcp` | `139/tcp` closed; `445/tcp` and `22/tcp` restricted to `10.0.2.50` |
| **Unauthenticated SMB Write** | `smbclient //10.0.2.15/ClinicBackups -N` uploaded `payload.txt` | Local loopback rejected (`NT_STATUS_ACCESS_DENIED`) |
| **Lateral Subnet Probe** | Full read/write access to EHR & billing backup archives | Dropped at host firewall (`[UFW BLOCK]` / `NT_STATUS_IO_TIMEOUT`) |

---

## Repository Structure

```text
network-infrastructure-risk-assessment/
├── README.md                                          # Operating playbook, lab topology & case study index
├── index.html                                         # GitHub Pages portfolio hub
├── case-study-1.html                                  # Case Study 01 interactive video player & chapters
├── case_study_1_web.mp4                               # Case Study 01 1080p walkthrough (11:08)
├── case-study-2.html                                  # Case Study 02 interactive video player & chapters
├── case_study_2_web.mp4                               # Case Study 02 1080p walkthrough (02:25)
└── case-studies/
    ├── 01-northeast-radiology/                        # 21-stage PACS / DICOM risk assessment & E-001..E-006
    └── 02-comprehensive-neurology-ransomware/         # 21-stage Ransomware / SMB assessment, scripts & E-001..E-006
```
