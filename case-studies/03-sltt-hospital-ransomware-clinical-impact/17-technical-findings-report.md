# Stage 17: Technical Findings Report
- **Baseline (`E-001..E-003`):** `WKST-01` dumped `:389` accounts & `:445` GPO; `DC-01` offline caused `HTTP 503` across `:8443-8445`.
- **Verified Fix (`E-004..E-006`):** `WKST-01` dropped (`[UFW BLOCK]`); `PAW-01` authenticated via `:636`; `CLIN-01` returned `HTTP 200 OK — CONTINGENCY BREAK-GLASS ACTIVE`.
