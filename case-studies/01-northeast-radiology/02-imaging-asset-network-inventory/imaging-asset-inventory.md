# Stage 2 — Healthcare Imaging Asset Inventory
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Assessment Subnet:** `10.0.2.0/24` (Flat Clinical & Administrative LAN)  
**Discovery Evidence:** `E-001-nmap-ast01.txt` (Approved low-rate Nmap `-T2` on `AST-01` only)

---

## 1. Crown-Jewel & Supporting Imaging Asset Register
| Asset ID | Hostname / Label | IPv4 | Role & Clinical Function | OS / Software Stack | Criticality | Assessment Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `AST-01` | `nerad-pacs-01` (`cyberriskassessment`) | `10.0.2.15` | **Orthanc PACS Server** — Central DICOM storage, query/retrieve (`C-FIND`/`C-MOVE`), and web viewer for radiology studies (ePHI) | Ubuntu 24.04 Linux (`OpenSSH 9.6p1`) / Orthanc PACS (`TCP 4242` DICOM, `TCP 8042` HTTP REST) | **Critical (Crown Jewel)** | **Assessed (Active + Config)** |
| `AST-02` | `nerad-ct-01` | `10.0.2.20` | **Diagnostic CT/MRI Modality** — Acquires patient scans and transmits DICOM objects to PACS (`AE_TITLE: NERAD_CT01`) | Proprietary Embedded Medical OS | **Critical (Life/Care)** | **Excluded from Active Scan (Passive/Rule Review Only)** |
| `AST-03` | `nerad-rad-ws01` | `10.0.2.30` | **Clinical Admin & Radiologist Workstation** — Reviews studies via Web Explorer and manages PACS queues | Managed Clinical Workstation | **High** | **Assessed (Path/Boundary)** |
| `AST-04` | `nerad-lan-client` | `10.0.2.x` | **General Office / Non-Imaging Endpoint** — Shares flat `10.0.2.0/24` broadcast domain with no clinical function | General Endpoint | **Low** | **Vantage Point (Lateral Exposure Check)** |
| `AST-05` | `nerad-bkp-01` | `10.0.2.40` (Logical) | **Local Archive / Backup Target** — Stores exported PACS database and DICOM file backups | Local Storage Target | **High** | **Documentation / Dependency Review** |

---

## 2. Key Stage 2 Observations
1. **Scanner Service Mislabeling (`E-001`):** Nmap reported `4242/tcp` as `vrml-multi-use?` and `8042/tcp` as `fs-agent?`, while raw HTTP response headers (`Location: app/explorer.html`) confirmed Orthanc Web Explorer—reinforcing why healthcare assessors must validate clinical protocols manually rather than relying on default scanner labels.
2. **Single Point of Failure (`AST-01`):** All diagnostic image storage (`TCP 4242`) and clinical viewing (`TCP 8042`) terminate on a single Orthanc host (`10.0.2.15`) with no secondary VNA failover.
3. **Co-Location of Medical & Non-Medical Hosts:** `AST-01` (PACS), `AST-02` (CT Modality), `AST-03` (Radiology Workstation), and `AST-04` (general office endpoints) reside in the same `10.0.2.0/24` Layer 2 domain without VLAN separation.
