# Stage 14: NIST SP 800-207 Snapshot
- **Explicit Verification:** Anonymous `:389/:445` -> `X-Tier0-Token` + `SMB3_11`.
- **Least Privilege:** `ALLOW IN Anywhere` -> `/32` UFW allowlists (`10.0.2.50`, `10.0.2.30`).
- **Assume Breach:** `HTTP 503` freeze -> `HTTP 200 OK` Break-Glass offline queuing.
