# Stage 02: Clinical Asset Inventory
| ID | Host | IP | Criticality | Baseline Ports | Hardened Ports |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `AST-03` | `DC-01` | `10.0.2.15` | Tier-0 | `22,389,445,8443-8445/tcp` | `22,636,445` (`PAW-01`); `8443-8445` (`CLIN-01`) |
| `ADMIN-01` | `PAW-01` | `10.0.2.50` | Tier-0 Admin | Unrestricted | Source-allowlisted admin |
| `CLIN-01` | `CLIN-01` | `10.0.2.30` | Tier-1 Clinical | Fail-closed `:8443-8445` | Allowlisted + Break-Glass queue |
| `ENDPT-01` | `WKST-01` | `10.0.2.25` | Tier-2 Endpoint | Unrestricted | Blocked (`[UFW BLOCK]`) |
