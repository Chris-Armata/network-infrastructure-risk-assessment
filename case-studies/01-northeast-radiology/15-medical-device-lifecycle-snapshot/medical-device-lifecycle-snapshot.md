# Stage 9.6 — Medical-Device Cybersecurity Lifecycle Snapshot
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Reference:** FDA Medical-Device Cybersecurity Lifecycle Guidance (Shared HDO / Manufacturer Responsibility)

---

## 1. Imaging Ecosystem Lifecycle Classification
| Asset ID | System / Device | Classification | Lifecycle & Patch Constraint | Required Hospital Action |
| :--- | :--- | :--- | :--- | :--- |
| `AST-02` (`10.0.2.20`) | Diagnostic CT/MRI Modality (`NERAD_CT01`) | **Compensating-Control-Required / Constrained** | Embedded OEM clinical operating system; arbitrary OS patching or endpoint agent installation is prohibited without manufacturer validation | Maintain strict network isolation (`AST-01:4242` egress only), block all general LAN inbound connections, and coordinate vendor-approved security updates during scheduled OEM maintenance |
| `AST-01` (`10.0.2.15`) | Orthanc PACS Server (Ubuntu 24.04) | **Supported (HDO-Managed Infrastructure)** | Standard Linux server and open-source PACS software maintained by hospital IT; supports direct configuration hardening | Execute immediate host PEP restrictions, enable Orthanc authentication, deploy TLS 1.3 reverse proxy, and apply standard OS security updates |
| `AST-03` (`10.0.2.30`) | Clinical Admin / Radiologist Workstation | **Supported (HDO-Managed Endpoint)** | Managed clinical workstation | Restrict network path exclusively to PACS viewer port, enforce EDR/patch baselines, and require individual clinician credentials |
