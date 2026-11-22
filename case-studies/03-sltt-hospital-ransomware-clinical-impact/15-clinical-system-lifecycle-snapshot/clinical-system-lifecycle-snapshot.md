# Stage 15: System Lifecycle Snapshot
- **UFW:** `Anywhere` -> default-deny + `/32` rules | **LDAP:** `:389` -> `:636` | **Samba:** `guest ok=yes, 0777` -> `SMB3_11, 0750` (`testparm -s` validated) | **Clinical:** Fail-closed -> Break-Glass fallback.
