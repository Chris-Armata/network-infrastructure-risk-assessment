# Stage 09: Remote Access Register
| Channel | Source | Target | Control |
| :--- | :--- | :--- | :--- |
| Tier-0 Admin | `PAW-01` (`10.0.2.50`) | `DC-01` (`:22,:636,:445`) | UFW `/32` lock + `X-Tier0-Token` + `SMB3_11` |
| Clinical Floor | `CLIN-01` (`10.0.2.30`) | `DC-01` (`:8443-8445`) | UFW `/32` lock + Break-Glass emergency tokens |
