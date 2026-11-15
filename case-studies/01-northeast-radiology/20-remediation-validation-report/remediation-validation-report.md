# Stage 14 — Remediation Validation Report
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Validation Scope:** Phase 1 Host Policy Enforcement Point (PEP) Micro-Segmentation (`AST-01`, `10.0.2.15`)  
**Evidence Reference:** `E-004-ufw-status-verbose.txt` (`SHA256: ecbcb30e9c25e0fbd6fa4ac811461c7d3620d6f35ecd5b75cb433679be2f9b27`) & Case Study 01 Walkthrough Recording

---

## 1. Before-and-After Control Verification
| Finding ID | Control Tested | Phase 1 Baseline Observation | Phase 3 Validation Test & Result | Validation Status |
| :--- | :--- | :--- | :--- | :--- |
| `F-001` | Host PEP restriction on Orthanc HTTP API (`8042/tcp`) | `ALLOW IN Anywhere`; `curl -i http://10.0.2.15:8042/system` returned `HTTP/1.1 200 OK` from unauthorized host `AST-04` | UFW restricted `8042/tcp` exclusively to `10.0.2.30` (`E-004`); unauthorized `curl` probe from `AST-04` silently dropped / timed out | **Reduced (Network-Layer Resolved; App Auth Pending Phase 2)** |
| `F-002` | Host PEP restriction on Orthanc DICOM port (`4242/tcp`) | `ALLOW IN Anywhere`; `nc -zv 10.0.2.15 4242` returned `succeeded!` from unauthorized host `AST-04` | UFW restricted `4242/tcp` exclusively to `10.0.2.20` (`E-004`); unauthorized `nc` probe from `AST-04` silently dropped / timed out | **Reduced (Network-Layer Resolved; AE-Title Whitelist Pending Phase 2)** |
| `F-003` | TLS 1.3 transport encryption (`443/tcp` reverse proxy) | `SslEnabled: false` (`E-003`) | Scheduled for Phase 2 maintenance window (`Days 8–30`) | **Not Resolved (Scheduled)** |
| `F-004` | Immutable/offline backup & sandbox restore drill | Single-host Orthanc storage (`E-005`); restore drill unverified | Scheduled for Phase 3 (`Days 31–90`) | **Not Resolved (Scheduled)** |
| `F-005` | SSH bastion IP allowlist & key-only enforcement (`22/tcp`) | Default OpenSSH baseline (`E-006`) | Scheduled for Phase 1 completion (`Days 1–7`) | **Not Resolved (Scheduled)** |
