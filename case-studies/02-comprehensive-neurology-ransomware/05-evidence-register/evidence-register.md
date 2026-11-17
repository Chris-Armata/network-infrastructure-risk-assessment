# Stage 8: Master Evidence Register (`E-001` – `E-005`)
| ID | Stage | Evidence | Result |
| :--- | :--- | :--- | :--- |
| `E-001` | Baseline | `smbclient -L //10.0.2.15 -N` | Enumerated `ClinicRecords` & `ClinicBackups` |
| `E-002` | Baseline | `smbclient //10.0.2.15/ClinicBackups -N -c "put payload.txt"` | Anonymous upload succeeded |
| `E-003` | Remediation | Hardened `smb.conf` & UFW rule | `445/tcp ALLOW 10.0.2.50` active |
| `E-004` | Validation | `smbclient //10.0.2.15/ClinicBackups -N -c "put payload2.txt"` | `NT_STATUS_ACCESS_DENIED` |
| `E-005` | Validation | `nc -zv 10.0.2.15 445` | `Connection timed out` |
