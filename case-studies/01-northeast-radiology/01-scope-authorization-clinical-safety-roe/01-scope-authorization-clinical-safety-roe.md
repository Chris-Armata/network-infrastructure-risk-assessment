# Stage 1 — Scope, Authorization & Clinical Safety Rules of Engagement
**Engagement:** Case Study 01 — Northeast Radiology (NERAD) Imaging Infrastructure Risk Assessment  
**Assessment Classification:** Healthcare Imaging Network & Infrastructure Risk Assessment (Non-Destructive)  
**Trigger:** Clinical PACS perimeter exposure review & ePHI confidentiality/availability resilience check  

---

## 1. Mandatory Fixed-Scope & Non-Exploitation Statement
> *"This engagement identifies, validates, and risk-ranks cybersecurity weaknesses within the agreed healthcare-imaging scope. Unless explicitly stated in a separate Statement of Work, it does not constitute a penetration test, exploitation exercise, clinical safety assessment, regulatory audit, certification, medical-device conformity assessment, or legal opinion. No assessment activity authorizes modification of a medical device or clinical workflow."*

### Explicit Scope Exclusions
* Penetration testing, active exploitation, credential attacks, password spraying, or social engineering.
* Active vulnerability scanning, port sweeping, or fuzzing against clinical imaging modalities.
* Firmware flashing, OS patching, registry/file modification, or reconfiguration of medical devices during assessment.
* Copying, exporting, or viewing patient-identifiable DICOM images (ePHI) beyond minimal metadata required to prove exposure.

---

## 2. Named Contacts & Emergency-Stop Authority
| Role | Designated Representative | Responsibility |
| :--- | :--- | :--- |
| **Executive Scope Approver** | Director of Operations, Northeast Radiology (NERAD) | Approves assessment boundary, testing windows, and closure |
| **IT / Network & Security Lead** | Senior Systems & Network Administrator | Provides firewall/config exports and approves server checks |
| **Clinical / Biomedical Engineering** | Lead Clinical Imaging Engineer | Defines modality exclusions and holds **Emergency-Stop Authority** |
| **Lead Risk Assessor** | Chris Armata | Executes evidence collection, analysis, and reporting |

**Emergency-Stop Procedure:** The Clinical Imaging Engineer remains reachable throughout every active testing window. Any unexpected latency in DICOM image routing, PACS web responsiveness, or modality association triggers immediate cessation of all assessment commands and escalation within 5 minutes.

---

## 3. Approved Technical Boundary & Asset Classification
* **Site & Department:** NERAD Main Outpatient Diagnostic Imaging Center (Simulated Lab Subnet: `10.0.2.0/24`)
* **Approved Testing Window:** Maintenance / low-volume window (`22:00 – 02:00 Local`)

| Asset ID | System / Role | IPv4 Address | Assessment Classification | Permitted Methods |
| :--- | :--- | :--- | :--- | :--- |
| `AST-01` | Orthanc PACS Server (Linux Host) | `10.0.2.15` | **In-Scope (Active / Config Review)** | Low-rate Nmap (`-T2`), `orthanc.json` & `ufw` review |
| `AST-02` | Diagnostic Imaging Modality (CT/MRI Node) | `10.0.2.20` | **Passive-Only / Excluded from Active Scan** | Architecture & firewall rule review only; **no Nmap/active probes** |
| `AST-03` | Clinical Admin / Radiologist Workstation | `10.0.2.30` | **In-Scope (Boundary & Path Check)** | Trust-boundary & access-path verification |
| `AST-04` | General Subnet / Unauthorized Endpoint | `10.0.2.x` | **Assessor Vantage Point** | Low-rate reachability validation against `AST-01` only |

---

## 4. Data Handling & ePHI Minimization Rules
1. If live patient-identifiable DICOM studies are encountered on an unauthenticated endpoint, collection stops immediately at service/metadata verification (`/system` banner or TCP socket check) without downloading study payloads.
2. All collected configuration exports, command outputs, and network records are hashed (`SHA256`) at collection time and tracked in `05-evidence-register/`.
3. Baseline boundary frozen prior to Stage 2 discovery.
