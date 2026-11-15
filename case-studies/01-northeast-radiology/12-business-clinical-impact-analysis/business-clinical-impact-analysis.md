# Stage 8.5 — Business & Clinical Impact Analysis
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Core Principle:** *Cyber safety is patient safety.* Technical weaknesses are evaluated by their direct effect on diagnostic accuracy, care continuity, and patient privacy.

---

## 1. Clinical & Operational Consequence Matrix
| Impact Dimension | Technical Trigger (`F-001`–`F-005`) | Direct Clinical & Patient-Care Consequence | Business & Regulatory Consequence (HIPAA / OCR Context) |
| :--- | :--- | :--- | :--- |
| **Confidentiality** | Unauthenticated `8042/tcp` Web Explorer & cleartext LAN transport (`F-001`, `F-003`) | Exposure of sensitive
diagnostic imaging, oncology/neurology findings, and patient demographics | Mirrors the real-world Northeast Radiology enforcement action ($350,000 OCR settlement, 298,532 affected patients, mandatory Corrective Action Plan) |
| **Integrity** | Unrestricted `4242/tcp` DICOM ingestion & unauthenticated REST writes (`F-001`, `F-002`) | Alteration, misassociation, or corruption of diagnostic images—creating direct risk of delayed or incorrect clinical diagnosis | Loss of physician trust in PACS records; manual reconciliation across modality local caches |
| **Availability** | Single-host PACS SPOF & unverified backup isolation (`F-001`, `F-004`) | Inability to store or read CT/MRI exams; emergency/urgent patients diverted; potential repeat radiation exposure if unarchived studies are lost | Complete outpatient imaging revenue stoppage during downtime plus costly forensic recovery |
