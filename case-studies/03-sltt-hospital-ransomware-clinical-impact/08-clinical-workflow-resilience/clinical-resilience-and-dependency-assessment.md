# Stage 08: Clinical Workflow Resilience
| Service | Port | Baseline (`DC-01` Offline) | Hardened Break-Glass (`DC-01` Offline) |
| :--- | :--- | :--- | :--- |
| Trauma CT | `8443` | `HTTP 503 Service Unavailable` | `HTTP 200 OK — CONTINGENCY BREAK-GLASS ACTIVE` |
| Pharmacy | `8444` | `HTTP 503 Service Unavailable` | `HTTP 200 OK — CONTINGENCY BREAK-GLASS ACTIVE` |
| Stat Lab | `8445` | `HTTP 503 Service Unavailable` | `HTTP 200 OK — CONTINGENCY BREAK-GLASS ACTIVE` |
