# 13 — Prioritized Remediation Roadmap

1. Lock and expire `vendor_maint` (`usermod -L -s /usr/sbin/nologin`, `chage -E`) and require hardware FIDO2 MFA.
2. Enforce UFW `default deny incoming`, block `10.200.0.45`, and allow `10.200.0.50` on `22/tcp` and `8443/tcp` under Ticket `#CHG-2026-089`.
