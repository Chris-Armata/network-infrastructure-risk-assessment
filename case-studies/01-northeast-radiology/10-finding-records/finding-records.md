# Stage 8 — Structured Finding Records
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Standard:** Every significant finding maps technical weakness, exposure path, clinical consequence, existing controls, residual risk, and verification test.

---

## Finding `F-001`: Unauthenticated PACS REST API & Web Explorer Exposed Across Flat Clinic Subnet
| Field | Assessment Record |
| :--- | :--- |
| **Finding ID / Asset ID** | `F-001` / `AST-01` (`nerad-pacs-01`, `10.0.2.15`) |
| **Evidence ID(s)** | `E-001`, `E-002`, `E-003`, `E-004` |
| **Clinical Function** | Diagnostic radiology study viewing, querying, and PACS queue administration |
| **What is technically wrong?** | Orthanc REST API / Web Explorer (`8042/tcp`) bound to `0.0.0.0` with `AuthenticationEnabled: false` and `RemoteAccessAllowed: true`, paired with baseline `UFW ALLOW IN Anywhere` on `8042/tcp`. |
| **How could it be exploited or fail?** | Any compromised or unauthorized workstation on `10.0.2.0/24` (`AST-04`) can send unauthenticated HTTP requests (`GET /patients`, `GET /studies`, `DELETE /studies/{id}`) without credentials. |
| **What could be reached?** | Full patient demographic index, radiology reports, and downloadable DICOM studies on `AST-01`. |
| **Patient-care / operational event** | Mass ePHI breach (modeled on NERAD's 298,532-patient exposure) or deletion of active studies delaying patient diagnosis and treatment. |
| **Data affected** | ePHI (patient names, MRNs, birthdates, radiology images/studies) |
| **Existing control** | Host-based UFW firewall installed; subsequently configured as a source-IP Policy Enforcement Point (`10.0.2.30` only). |
| **Missing / ineffective control** | Application-layer user authentication (`AuthenticationEnabled: true` + RBAC) and VLAN segmentation between office hosts and PACS. |
| **Inherent Risk / Residual Risk** | **Critical** (Inherent) → **Low** (Residual after UFW PEP restriction; **Minimal** once Orthanc authentication is enabled) |
| **Recommended Action** | 1) Maintain UFW allowlist restricting `8042/tcp` to `10.0.2.30` (`AST-03`). 2) Enable `AuthenticationEnabled: true` with individual clinician/admin accounts during scheduled maintenance. |
| **Validation Test** | Execute `curl -i --max-time 5 http://10.0.2.15:8042/system` from unauthorized host `AST-04` (expect timeout/drop) and authenticated request from `AST-03` (expect `200 OK` only with valid credentials). |
| **Governance Metadata** | **Owner:** Senior Systems & Network Admin \| **Priority:** P1 (Immediate) \| **Vendor Dependency:** None (Orthanc config) \| **Clinical Safety Constraint:** Schedule Orthanc service restart during `22:00–02:00` maintenance window. |

---

## Finding `F-002`: Unrestricted DICOM Association Listener (`TCP 4242`) Without Source-IP or AE-Title Enforcement
| Field | Assessment Record |
| :--- | :--- |
| **Finding ID / Asset ID** | `F-002` / `AST-01` (`10.0.2.15`) & `AST-02` (`10.0.2.20` Modality boundary) |
| **Evidence ID(s)** | `E-001`, `E-002`, `E-003`, `E-004` |
| **Clinical Function** | Modality-to-PACS diagnostic image ingestion (`C-STORE`) and query/retrieve (`C-FIND`/`C-MOVE`) |
| **What is technically wrong?** | DICOM service on `4242/tcp` accepted TCP associations from `Anywhere` without source-IP filtering or strict calling AE-title validation. |
| **How could it be exploited or fail?** | Unauthorized host on `10.0.2.0/24` uses standard DICOM utilities (`findscu`/`storescu`) to enumerate patient studies or inject spoofed/corrupted images into clinical queues. |
| **Patient-care / operational event** | Misdiagnosis from injected/corrupted imaging studies or PACS storage exhaustion halting CT/MRI ingestion. |
| **Inherent Risk / Residual Risk** | **High** (Inherent) → **Low** (Residual after UFW `10.0.2.20` source-IP restriction) |
| **Recommended Action** | Enforce UFW restriction allowing `4242/tcp` exclusively from `10.0.2.20` (`AST-02`) and configure `DicomCheckCalledAet` / explicit `DicomModalities` whitelist in `orthanc.json`. |
| **Validation Test** | Run `nc -zv -w 5 10.0.2.15 4242` from `AST-04` (expect connection timeout) and verify normal `C-ECHO`/`C-STORE` from `AST-02` (`10.0.2.20`). |
| **Governance Metadata** | **Owner:** Lead Clinical Imaging Engineer & Network Admin \| **Priority:** P1 (Immediate) \| **Vendor Dependency:** Modality AE-title verification \| **Clinical Safety Constraint:** Do not alter `AST-02` modality software; enforce controls at `AST-01` perimeter. |

---

## Finding `F-003`: Cleartext HTTP & DICOM Network Transport (`SslEnabled: false`)
| Field | Assessment Record |
| :--- | :--- |
| **Finding ID / Asset ID** | `F-003` / `AST-01` (`10.0.2.15`) |
| **Evidence ID(s)** | `E-003` |
| **Clinical Function** | Clinical web viewing (`8042/tcp`) and modality image transfer (`4242/tcp`) |
| **What is technically wrong?** | `SslEnabled` is set to `false` in `orthanc.json`, transmitting ePHI metadata and radiology images in cleartext across the shared subnet. |
| **Patient-care / operational event** | Passive ARP spoofing or switch-port mirroring on the flat clinic LAN exposes patient ePHI in transit. |
| **Inherent Risk / Residual Risk** | **High** (Inherent) → **Medium** (Residual after UFW host isolation; **Low** after TLS reverse proxy) |
| **Recommended Action** | Bind Orthanc HTTP to `127.0.0.1:8042` behind an Nginx TLS 1.3 reverse proxy (`443/tcp`) for `AST-03`, and evaluate DICOM TLS or encrypted VLAN isolation for `AST-02`. |
| **Validation Test** | Verify `openssl s_client -connect 10.0.2.15:443 -tls1_3` negotiates TLS 1.3 and `ss -tulpn` confirms `8042` listens on `127.0.0.1` only. |
| **Governance Metadata** | **Owner:** Senior Systems & Network Admin \| **Priority:** P2 (30 Days) \| **Vendor Dependency:** Modality DICOM TLS capability check \| **Clinical Safety Constraint:** Confirm `AST-02` DICOM TLS support before enforcing encrypted DICOM; otherwise retain VLAN + PEP compensating control. |

---

## Finding `F-004`: Single-Host PACS Architecture & Unverified Offline Backup Isolation
| Field | Assessment Record |
| :--- | :--- |
| **Finding ID / Asset ID** | `F-004` / `AST-01` (`10.0.2.15`) & `AST-05` (Backup Target) |
| **Evidence ID(s)** | `E-005` |
| **Clinical Function** | Continuous availability and disaster recovery of diagnostic imaging archives |
| **What is technically wrong?** | Single Orthanc instance (`E-005`) lacks documented restore verification, defined RTO/RPO, and verified air-gapped/immutable separation from production credentials. |
| **Patient-care / operational event** | Ransomware encryption or storage failure halts all outpatient radiology reads and requires repeat patient radiation exposure (re-scans) if studies are lost. |
| **Inherent Risk / Residual Risk** | **High** (Inherent) → **High** (Residual until immutable backup & restore drill are completed) |
| **Recommended Action** | Implement automated pull-based, immutable/offline PACS backups (`PostgreSQL` index + DICOM storage), document clinical downtime procedures, and execute a non-production restore drill. |
| **Validation Test** | Inspect backup immutability/permissions and review signed quarterly restore-test log verifying RTO compliance. |
| **Governance Metadata** | **Owner:** Director of Operations & Senior Network Admin \| **Priority:** P2 (30–60 Days) \| **Vendor Dependency:** Backup storage vendor \| **Clinical Safety Constraint:** Perform restore validation on an isolated sandbox host, never overwriting production PACS. |

---

## Finding `F-005`: Unsegmented Administrative SSH & Third-Party Vendor Remote Access Governance Gaps
| Field | Assessment Record |
| :--- | :--- |
| **Finding ID / Asset ID** | `F-005` / `AST-01` (`10.0.2.15`) & `AST-02` (`10.0.2.20`) |
| **Evidence ID(s)** | `E-001`, `E-004`, `E-006` |
| **Clinical Function** | System administration and OEM vendor maintenance |
| **What is technically wrong?** | `22/tcp` (`OpenSSH 9.6p1`) is reachable across the subnet without bastion IP restriction, key-only enforcement (`PasswordAuthentication no`), or formalized just-in-time (JIT) vendor access governance. |
| **Patient-care / operational event** | Compromised vendor or admin credentials grant root-level access to PACS storage and lateral reach into clinical modalities. |
| **Inherent Risk / Residual Risk** | **Medium-High** (Inherent) → **Low** (Residual after bastion IP allowlist, Ed25519 key-only SSH, and JIT vendor access policy) |
| **Recommended Action** | Restrict `22/tcp` via UFW to dedicated admin jump-host IPs, enforce `PasswordAuthentication no` and `PermitRootLogin no`, and require ticket-approved, session-logged JIT access for OEM support. |
| **Validation Test** | Attempt SSH password authentication from an unauthorized subnet IP (expect packet drop / `Permission denied (publickey)`). |
| **Governance Metadata** | **Owner:** Senior Systems & Network Admin \| **Priority:** P2 (30 Days) \| **Vendor Dependency:** OEM remote support SLA alignment \| **Clinical Safety Constraint:** Maintain break-glass console access for emeremergency clinical engineering support. |
