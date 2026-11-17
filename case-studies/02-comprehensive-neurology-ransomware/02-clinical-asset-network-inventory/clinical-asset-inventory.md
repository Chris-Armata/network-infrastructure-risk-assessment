# Stage 02: Clinical Asset & Network Inventory
| Asset ID | Hostname | IPv4 | Criticality | Clinical Function |
| :--- | :--- | :--- | :--- | :--- |
| `AST-02` | `ast02.compneuro.local` | `10.0.2.15` | Tier 1 Critical | Centralized Samba repository (`ClinicBackups`) storing daily EHR snapshots and Q4 billing claims |
| `ADMIN-01` | `backup-admin.compneuro.local` | `10.0.2.50` | Tier 1 Control | Authorized nightly backup ingestion and Linux host administration |
| `ENDPT-01` | `front-desk-01.compneuro.local` | `10.0.2.25` | Tier 3 Access | Front-office workstation (assumed-breach vantage point) |
