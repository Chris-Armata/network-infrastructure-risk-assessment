# Case Study 02: Comprehensive Neurology, P.C. — Ransomware Blast Radius Containment

[![Live Video Walkthrough](https://img.shields.io/badge/Watch_Walkthrough-Interactive_Video-38bdf8?style=for-the-badge)](https://chris-armata.github.io/network-infrastructure-risk-assessment/case-study-2.html)
[![Playbook](https://img.shields.io/badge/Methodology-2026_Healthcare_Risk_Playbook-34d399?style=for-the-badge)](../../README.md)

Modeled after the April 2025 HHS OCR $25,000 ransomware enforcement action (6,800 patient ePHI records) and aligned with **HIPAA Security Rule (`45 CFR Part 164`)** and **NIST SP 800-207**.

## Self-Contained Assessment Artifact Chain

| Stage | Playbook Deliverable | Repository Path |
| :--- | :--- | :--- |
| **Stage 1** | Scope, Authorization & Clinical Safety ROE | [`01-scope-authorization-clinical-safety-roe/01-scope-authorization-clinical-safety-roe.md`](01-scope-authorization-clinical-safety-roe/01-scope-authorization-clinical-safety-roe.md) |
| **Stage 2** | Clinical Asset & Network Inventory | [`02-clinical-asset-network-inventory/clinical-asset-inventory.md`](02-clinical-asset-network-inventory/clinical-asset-inventory.md) |
| **Stage 2** | Coverage & Exceptions Register | [`04-coverage-exceptions-register/coverage-exceptions-register.md`](04-coverage-exceptions-register/coverage-exceptions-register.md) |
| **Stage 3** | Trust Boundaries & Data-Flow Map | [`03-clinical-architecture-trust-boundaries/trust-boundary-and-data-flow.md`](03-clinical-architecture-trust-boundaries/trust-boundary-and-data-flow.md) |
| **Stage 4** | Infrastructure & Lifecycle Gap List | [`06-infrastructure-vulnerability-lifecycle-assessment/infrastructure-lifecycle-gap-list.md`](06-infrastructure-vulnerability-lifecycle-assessment/infrastructure-lifecycle-gap-list.md) |
| **Stage 5** | Network Exposure & Blast-Radius Analysis | [`07-clinical-network-exposure/clinical-network-exposure-and-blast-radius.md`](07-clinical-network-exposure/clinical-network-exposure-and-blast-radius.md) |
| **Stage 6** | Workflow & Dependency Resilience | [`08-clinical-workflow-resilience/clinical-resilience-and-dependency-assessment.md`](08-clinical-workflow-resilience/clinical-resilience-and-dependency-assessment.md) |
| **Stage 7** | Vendor Remote Access Register | [`09-vendor-third-party-access/vendor-remote-access-register.md`](09-vendor-third-party-access/vendor-remote-access-register.md) |
| **Stage 8** | Master Evidence Register (`E-001`–`E-005`) | [`05-evidence-register/evidence-register.md`](05-evidence-register/evidence-register.md) |
| **Stage 8** | Finding Records (`F-001`–`F-003`) | [`10-finding-records/finding-records.md`](10-finding-records/finding-records.md) |
| **Stage 8** | Consolidated Risk Register | [`11-risk-register/risk-register.md`](11-risk-register/risk-register.md) |
| **Stage 8.5** | Business & Clinical Impact Analysis | [`12-business-clinical-impact-analysis/business-clinical-impact-analysis.md`](12-business-clinical-impact-analysis/business-clinical-impact-analysis.md) |
| **Stage 9** | Prioritized Remediation Roadmap | [`13-prioritized-remediation-roadmap/prioritized-remediation-roadmap.md`](13-prioritized-remediation-roadmap/prioritized-remediation-roadmap.md) |
| **Stage 9.5** | Zero Trust & Cyber-Resilience Snapshot | [`14-zero-trust-cyber-resilience-snapshot/zero-trust-cyber-resilience-snapshot.md`](14-zero-trust-cyber-resilience-snapshot/zero-trust-cyber-resilience-snapshot.md) |
| **Stage 9.6** | Clinical System Lifecycle Snapshot | [`15-clinical-system-lifecycle-snapshot/clinical-system-lifecycle-snapshot.md`](15-clinical-system-lifecycle-snapshot/clinical-system-lifecycle-snapshot.md) |
| **Stage 10** | Executive Risk Report | [`16-executive-risk-report.md`](16-executive-risk-report.md) |
| **Stage 10** | Technical Findings Report | [`17-technical-findings-report.md`](17-technical-findings-report.md) |
| **Control** | SMB RBAC & UFW Zero Trust Script | [`18-remediation-scripts/remediate_smb_zerotrust.sh`](18-remediation-scripts/remediate_smb_zerotrust.sh) |
| **Stage 11** | Assessment Closure | [`19-assessment-closure-acknowledgement.md`](19-assessment-closure-acknowledgement.md) |
| **Stage 14** | Remediation Validation Report | [`20-remediation-validation-report/remediation-validation-report.md`](20-remediation-validation-report/remediation-validation-report.md) |
| **Integrity** | SHA256 Evidence Hash Manifest | [`21-evidence-hash-manifest.txt`](21-evidence-hash-manifest.txt) |
