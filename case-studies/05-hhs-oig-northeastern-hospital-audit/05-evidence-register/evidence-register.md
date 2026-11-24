# 05 — Empirical Evidence Register

| ID | Artifact | Description |
| --- | --- | --- |
| `E-001` | `network/E-001-open-sockets-baseline.txt` | Open listening sockets on ports `22` and `8443` |
| `E-002` | `infrastructure/E-002-orphaned-vendor-account.txt` | Active `vendor_maint` account with no expiration |
| `E-003` | `clinical-storage/E-003-unauthorized-contractor-access.txt` | Live connection from `10.200.0.45` prior to lockdown |
| `E-004` | `network/E-004-ufw-zero-trust-policy.txt` | UFW default-deny and `10.200.0.50` allowlist rules |
| `E-005` | `resilience/E-005-account-lock-and-ufw-block.txt` | Locked `vendor_maint` account & `[UFW BLOCK]` logs |
| `E-006` | `vendor-access/E-006-audit-safe-continuity.txt` | Verified `HTTP 200 OK` access from `10.200.0.50` |
