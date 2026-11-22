# Stage 11: Enterprise Risk Register
| Risk | Scenario | Inherent | Residual |
| :--- | :--- | :--- | :--- |
| `RSK-01` | Lateral Tier-2 to Tier-0 ransomware encryption | **CRITICAL** | **LOW** (`[UFW BLOCK]` + `PAW-01`) |
| `RSK-02` | `DC-01` outage paralyzes Trauma CT, Pharmacy & Lab | **CRITICAL** | **LOW** (HIPAA Break-Glass mode) |
| `RSK-03` | Cleartext LAN credential/GPO interception | **HIGH** | **LOW** (`LDAPS :636` + `SMB3_11`) |
