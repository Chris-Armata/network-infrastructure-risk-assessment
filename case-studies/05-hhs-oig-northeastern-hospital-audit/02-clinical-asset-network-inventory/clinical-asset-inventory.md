# 02 — Clinical Asset & Network Inventory

- **Hospital EHR Server (`10.200.0.15`):** Hosts SSH (`22/tcp`) and Clinical EHR/PACS Portal (`8443/tcp`).
- **Ex-Contractor Endpoint (`10.200.0.45`):** Associated with expired maintenance account `vendor_maint`.
- **Approved Audit Safe (`10.200.0.50`):** Authorized administrative/audit endpoint governed by FIDO2 MFA and Change Ticket `#CHG-2026-089`.
