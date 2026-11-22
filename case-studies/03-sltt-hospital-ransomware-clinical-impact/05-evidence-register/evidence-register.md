# Stage 05: Evidence Register
| ID | File | Command | Findings |
| :--- | :--- | :--- | :--- |
| `E-001` | [`05-evidence-register/network/E-001-nmap-tier0-and-clinical-ports.txt`](../05-evidence-register/network/E-001-nmap-tier0-and-clinical-ports.txt) | `nmap -sV -p 22,389,445,8443,8444,8445 10.0.2.15` | `F-01, F-03` |
| `E-002` | [`05-evidence-register/infrastructure/E-002-ldap-sysvol-baseline-exposure.txt`](../05-evidence-register/infrastructure/E-002-ldap-sysvol-baseline-exposure.txt) | `testparm -s`, `sshd -T`, `ls -ld /srv/sltt_sysvol` | `F-01, F-02` |
| `E-003` | [`05-evidence-register/clinical-storage/E-003-dc01-outage-clinical-cascade.txt`](../05-evidence-register/clinical-storage/E-003-dc01-outage-clinical-cascade.txt) | `curl :389/directory`, `smbclient //10.0.2.15/SYSVOL -N`, `HTTP 503` check | `F-01..F-04` |
| `E-004` | [`05-evidence-register/network/E-004-ufw-tier0-microsegmentation.txt`](../05-evidence-register/network/E-004-ufw-tier0-microsegmentation.txt) | `sudo ufw status verbose` (Before vs. After) | `F-03` |
| `E-005` | [`05-evidence-register/resilience/E-005-wkst01-containment-and-ufw-block.txt`](../05-evidence-register/resilience/E-005-wkst01-containment-and-ufw-block.txt) | `wkst01` `smbclient` timeout & `journalctl -k -g "UFW BLOCK"` | `F-01..F-03` |
| `E-006` | [`05-evidence-register/vendor-access/E-006-breakglass-clinical-continuity-proof.txt`](../05-evidence-register/vendor-access/E-006-breakglass-clinical-continuity-proof.txt) | `PAW-01` `:636` token auth & `CLIN-01` `HTTP 200 OK` Break-Glass | `F-03, F-04` |
