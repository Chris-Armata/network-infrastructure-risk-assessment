# Stage 8 — Consolidated Healthcare Imaging Risk Register
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)

| Risk ID | Finding Summary | Asset(s) | Evidence | Likelihood | Clinical / Business Impact | Inherent Risk | Existing / Applied Controls | Residual Risk | Priority | Risk Owner |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `RSK-01` | Unauthenticated PACS REST API & Web Explorer exposed on flat subnet (`8042/tcp`) | `AST-01` | `E-001`–`E-004` | High | Severe (Mass ePHI breach / study deletion) | **Critical** | UFW PEP restricted to `10.0.2.30`; Orthanc auth pending | **Low** | **P1** | Senior Network Admin |
| `RSK-02` | Unrestricted DICOM listener (`4242/tcp`) without IP/AE-title enforcement | `AST-01`, `AST-02` | `E-001`–`E-004` | High | Severe (Study injection / diagnostic corruption) | **High** | UFW PEP restricted to `10.0.2.20` | **Low** | **P1** | Clinical Imaging Engineer |
| `RSK-03` | Single-host PACS SPOF & unverified immutable/offline backup recovery | `AST-01`, `AST-05` | `E-005` | Medium | Severe (Prolonged imaging outage / re-scans) | **High** | Local storage active; offline restore drill missing | **High** | **P2** | Director of Operations |
| `RSK-04` | Cleartext HTTP & DICOM transport across shared clinic subnet (`SslEnabled: false`) | `AST-01`–`AST-03` | `E-003` | Medium | High (On-path ePHI interception) | **High** | UFW source-IP isolation reduces active peers | **Medium** | **P2** | Senior Network Admin |
| `RSK-05` | Unsegmented SSH management plane (`22/tcp`) & standing vendor remote access | `AST-01`, `AST-02` | `E-001`, `E-004`, `E-006` | Medium | High (Privileged takeover / lateral pivot) | **Medium-High** | Standard OpenSSH 9.6p1 baseline | **Medium** | **P2** | Senior Network Admin |
