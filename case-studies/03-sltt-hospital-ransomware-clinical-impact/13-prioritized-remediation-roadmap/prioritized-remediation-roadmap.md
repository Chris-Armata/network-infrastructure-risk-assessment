# Stage 13: Remediation Roadmap
- **P1 (Immediate):** UFW default-deny + `PAW-01`/`CLIN-01` allowlists; retire `:389` for `:636`; enforce `SMB3_11` (`0750`); activate Break-Glass queuing via `remediate_sltt_hospital_zt.sh`.
- **P2 (30-Day):** Forward `[UFW BLOCK]` & Break-Glass logs to SIEM.
