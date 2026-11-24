# Stage 2: Shared IT Provider & Hospital Asset Inventory

| Asset ID | System Name | Network Address & Door (Port) | Plain-English Role |
| :--- | :--- | :--- | :--- |
| `AST-SSO-01` | `TransForm SSO Hub` | `10.0.2.15` — Port `2222` (SSH) | Encrypted maintenance entrance for IT engineers |
| `AST-SSO-02` | `Clinical Data Hub` | `10.0.2.15` — Port `8443` (HTTPS) | Encrypted medical records hub serving all 5 hospitals |
| `AST-SSO-03` | `Admin Laptop` | `10.0.2.40` | Technician laptop stolen/compromised by attackers |
| `AST-SSO-04` | `Approved Tech Safe` | `10.0.2.50` | Hardened security workstation with physical MFA key |
