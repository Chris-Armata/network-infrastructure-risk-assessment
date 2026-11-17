# Stage 10: Technical Findings Report
- **Baseline (`E-001`/`E-002`):** `smbclient //10.0.2.15/ClinicBackups -N -c "put payload.txt"` succeeded.
- **Validation (`E-004`/`E-005`):** Re-attack returned `NT_STATUS_ACCESS_DENIED` and `nc -zv 10.0.2.15 445` timed out.
