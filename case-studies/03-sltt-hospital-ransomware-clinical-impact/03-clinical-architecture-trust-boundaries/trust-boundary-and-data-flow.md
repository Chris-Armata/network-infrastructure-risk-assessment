# Stage 03: Architecture & Trust Boundaries
- **Baseline:** Flat `/24` subnet allowed `WKST-01` to read `:389` LDAP & `:445` `SYSVOL`; `DC-01` loss froze `:8443-8445` (`HTTP 503`).
- **Hardened:** UFW PEP blocks `WKST-01`, restricts Tier-0 admin to `PAW-01` (`:636`, `SMB3_11`), and enables HIPAA Break-Glass (`HTTP 200 OK`) on `CLIN-01`.
