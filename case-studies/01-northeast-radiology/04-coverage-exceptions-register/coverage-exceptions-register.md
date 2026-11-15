# Stage 2 — Coverage & Exceptions Register
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Governing Rule:** Every in-scope IP and imaging component is explicitly accounted for as assessed, passive-only, excluded, or inaccessible.

---

## 1. Playbook Coverage Summary
| Coverage Category | Count | Details / Notes |
| :--- | :--- | :--- |
| **In-scope IP addresses** | `4` named roles (`10.0.2.0/24` boundary) | `10.0.2.15`, `10.0.2.20`, `10.0.2.30`, plus `10.0.2.x` assessor vantage point |
| **Discovered live hosts** | `3` confirmed | `AST-01` (`10.0.2.15`), `AST-02` (`10.0.2.20`), `AST-03` (`10.0.2.30`) |
| **Imaging modalities** | `1` | `AST-02` (`10.0.2.20` — Diagnostic CT/MRI Modality) |
| **PACS/RIS/VNA components** | `1` | `AST-01` (`10.0.2.15` — Orthanc PACS Server) |
| **Imaging workstations** | `1` | `AST-03` (`10.0.2.30` — Clinical Admin / Radiologist Workstation) |
| **Network/security devices** | `1` | Host-based Policy Enforcement Point (`UFW` / `iptables` on `AST-01`) |
| **Vendor remote-access systems** | `1` documented path | Remote PACS/modality support path evaluated via config/architecture review |
| **Hosts assessed** | `2` | `AST-01` (active service + config), `AST-03` (trust-path validation) |
| **Hosts inaccessible** | `0` | All approved targets reachable within testing window |
| **Passive-only medical devices** | `1` | `AST-02` (`10.0.2.20`) — evaluated via firewall/DICOM relationship review only |
| **Excluded clinical assets** | `1` (`AST-02` active scan excluded) | Excluded from Nmap/active probing per Stage 1 ROE to prevent clinical modality disruption |
| **Unidentified devices** | `0` | No rogue or unidentified listeners detected on approved target |

---

## 2. Explicit Clinical Safety Exception Log
* **Asset:** `AST-02` (`10.0.2.20` — Diagnostic CT/MRI Modality)
* **Exception Type:** Excluded from active port scanning (`Nmap`) and vulnerability probing.
* **Clinical Rationale:** Legacy/embedded DICOM protocol stacks on imaging modalities can lock up or drop active study queues when subjected to malformed TCP probes. Risk posture for `AST-02` is established solely through `AST-01` firewall rules, DICOM AE-title configuration review, and network architecture analysis.
