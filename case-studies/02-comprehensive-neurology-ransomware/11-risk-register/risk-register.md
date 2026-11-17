# Stage 11: Enterprise Clinical Risk Register
| Risk ID | Findings | Scenario | Inherent | Residual |
| :--- | :--- | :--- | :--- | :--- |
| `RSK-01` | `F-01`, `F-02`, `F-03` | Front-desk compromise (`10.0.2.25`) encrypts `ClinicBackups` (`10.0.2.15`), causing ePHI loss and HHS OCR enforcement. | **Critical** | **Low** |
| `RSK-02` | `F-03`, `F-04` | Lateral SMB relay or brute-force against `AST-02` services (`22/tcp`, `445/tcp`). | **High** | **Low** |
