# Network Infrastructure Risk Assessment

[![Live Portfolio Showcase](https://img.shields.io/badge/Live_Showcase-GitHub_Pages-38bdf8?style=for-the-badge&logo=github)](https://chris-armata.github.io/network-infrastructure-risk-assessment/)
[![Framework](https://img.shields.io/badge/Framework-NIST_SP_800--207-34d399?style=for-the-badge)](#operating-methodology)
[![Case Study 01](https://img.shields.io/badge/Case_Study_01-Video_Walkthrough_(11:08)-0f172a?style=for-the-badge)](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-1.html)

A practical network and infrastructure cyber risk assessment operating playbook, laboratory, and portfolio of evidence-based case studies.

> **Interactive Video Showcase:** Launch the ad-free, chapter-indexed walkthroughs directly at **[chris-armata.github.io/network-infrastructure-risk-assessment](https://chris-armata.github.io/network-infrastructure-risk-assessment/)**.

---

## Operating Methodology

Every assessment in this repository follows a reproducible, three-phase validation lifecycle:

1. **Phase 1 — Baseline & Empirical Exposure:** Enumerate active services, inspect application authentication posture, and capture verifiable proof of unauthenticated network reachability.
2. **Phase 2 — Architecture & Threat Modeling:** Map lateral movement paths across flat network segments and design explicit Policy Enforcement Point (PEP) boundaries aligned with **NIST SP 800-207 (Zero Trust Architecture)**.
3. **Phase 3 — Control Engineering & Post-Remediation Verification:** Implement host/network micro-segmentation controls and re-execute baseline probes from unauthorized perspectives to confirm silent packet drops and connection timeouts.

---

## Case Study Index

### Case Study 01: Healthcare PACS (Orthanc) Security & NIST SP 800-207 Zero Trust Remediation
* **Live Walkthrough:** [Watch 11:08 Technical Video & Chapter Breakdown](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-1.html)
* **Target Workload:** Orthanc Medical Imaging Server (PACS) hosting Protected Health Information (PHI)
* **Protocols Assessed:** DICOM (`TCP 4242`) and Orthanc REST API / Web Explorer (`TCP 8042`)

#### Lab Topology & Zero Trust Policy Matrix

| Node / Role | IPv4 Address | Permitted Port / Protocol | Enforcement Posture |
| :--- | :--- | :--- | :--- |
| **Orthanc PACS Server** (Target PEP) | `10.0.2.15` | `8042/tcp` (HTTP), `4242/tcp` (DICOM) | Host-based UFW default-deny inbound |
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

## Repository Structure

```text
network-infrastructure-risk-assessment/
├── README.md               # Operating playbook, lab topology & case study index
├── index.html              # GitHub Pages portfolio landing page
├── case-study-1.html       # Interactive Case Study 01 video player & chapter timeline
└── case_study_1_web.mp4    # Web-optimized 1080p walkthrough recording (11:08)
```
