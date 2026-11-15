# Stage 6 — Imaging Workflow & Dependency Resilience Assessment
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Evidence References:** `E-005-orthanc-service-storage.txt`, Stage 3 Data-Flow Map (`DF-04`)

---

## 1. Critical Clinical Workflow Dependencies
| Dependency Layer | Component | Single Point of Failure? | Clinical Impact if Unavailable |
| :--- | :--- | :--- | :--- |
| **Image Ingestion & Storage** | `AST-01` Orthanc PACS (`10.0.2.15`) | **Yes** — Single PACS instance storing index and DICOM blobs (`E-005`) | Modality queue saturation on `AST-02`; radiologists unable to retrieve prior or current studies |
| **Clinical Viewing Interface** | Orthanc Web Explorer (`TCP 8042`) | **Yes** — No secondary diagnostic viewer or VNA failover | Outpatient diagnostic reads halt; clinicians forced onto manual/CD downtime workflows |
| **Backup & Archive Path** | `AST-05` Logical Archive (`DF-04`) | **High Risk** — Reachable over flat subnet without verified immutable/offline isolation | Ransomware or unauthorized API deletion (`DELETE /studies/{id}`) destroys both primary and reachable backup copies |

---

## 2. Resilience & Recovery Findings
1. **No Verified Restore Test or Defined RTO/RPO:** NERAD lacked documented Recovery Time Objective (RTO) benchmarks and verified restoration logs for PACS database and DICOM storage recovery.
2. **Production-to-Backup Trust Exposure:** Backup targets sharing the same flat subnet or production credentials violate ransomware resilience principles; backups must be pull-based, immutable, or offline-segmented.
3. **Undocumented Clinical Downtime Workflow:** Modality local buffer capacity (`AST-02`) and manual study routing procedures during PACS outage were not formalized.
