# Stage 8 — Master Evidence Register & Provenance Log
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Collector:** Chris Armata (Lead Risk Assessor) | **Timezone:** UTC | **Authorization Ref:** Stage 1 Frozen ROE  
**Handling & Sensitivity:** Internal / Confidential Assessment Artifacts — Zero patient-identifiable DICOM image payloads retained.

> **Integrity & Provenance Notice:** SHA256 hashes verify that each evidence file has not been altered since collection. Integrity hashes are paired with collection timestamps, exact commands, and scope boundaries to establish full technical provenance.

---

## 1. Evidence Inventory & Cryptographic Hash Manifest
| Evidence ID | Collected (UTC) | Source / Asset | Collection Method & Exact Command | File Path (Relative to Case Study) | SHA256 Integrity Hash | Linked Finding(s) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `E-001` | 2026-11-15 01:15 | Nmap 7.94SVN (`AST-01`) | Approved low-rate TCP connect/version scan: `nmap -sT -Pn -T2 -sV -p 22,4242,8042 10.0.2.15` | `05-evidence-register/network/E-001-nmap-ast01.txt` | `d96a0729cafbca9349a2526b124335075fc7ea8486a8323e3aba11cadcae7f61` | `F-001`, `F-002`, `F-005` |
| `E-002` | 2026-11-15 01:32 | Linux Socket Table (`AST-01`) | Read-only socket inspection: `ss -tulpn \| grep -E "Netid\|22\|4242\|8042"` | `05-evidence-register/infrastructure/E-002-ss-sockets-ast01.txt` | `c9a9044608a903af6af8c2596acf25a5f08e813d08783510cbeedbd521e44738` | `F-001`, `F-002` |
| `E-003` | 2026-11-15 01:32 | Orthanc Config (`AST-01`) | Read-only config directive extraction: `grep -E '"(AuthenticationEnabled\|RemoteAccessAllowed\|SslEnabled\|DicomPort\|HttpPort\|DicomAet)"' /etc/orthanc/orthanc.json` | `05-evidence-register/imaging/E-003-orthanc-config-posture.txt` | `5b83bf747a0d4f2891819249d56bdd9b1c1c28f6dcc75cd907c84a6a4414f77c` | `F-001`, `F-002`, `F-003` |
| `E-004` | 2026-11-15 01:38 | UFW Firewall (`AST-01`) | Host PEP rule export: `sudo ufw status verbose` (post-remediation state; baseline captured in video walkthrough) | `05-evidence-register/network/E-004-ufw-status-verbose.txt` | `ecbcb30e9c25e0fbd6fa4ac811461c7d3620d6f35ecd5b75cb433679be2f9b27` | `F-001`, `F-002`, `F-005` |
| `E-005` | 2026-11-15 01:44 | Systemd & Orthanc (`AST-01`) | Service & storage path check: `systemctl is-active orthanc` + `grep StorageDirectory/IndexDirectory` | `05-evidence-register/resilience/E-005-orthanc-service-storage.txt` | `0ec6c6274381d90e6456e08ad27bc5eed858a30748f4df9e3ce19e2b260f6597` | `F-004` |
| `E-006` | 2026-11-15 01:55 | OpenSSH Config (`AST-01`) | Read-only SSH directive review across `/etc/ssh/sshd_config` & `sshd_config.d/*.conf` | `05-evidence-register/vendor-access/E-006-sshd-remote-access-posture.txt` | `eaf5c08f205e1784c8246166ea3e7c668a72b443283726cadf1992cef2bcc48e` | `F-005` |
