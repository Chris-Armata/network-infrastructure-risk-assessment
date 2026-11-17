# Stage 07: Clinical Network Exposure & Ransomware Blast Radius Analysis
* **Baseline Blast Radius (`E-001`–`E-003`):** All 254 subnet hosts on `10.0.2.0/24` can mount `//10.0.2.15/ClinicBackups` anonymously and encrypt `ehr_neuro_daily_20261116.bak` (`18.4 MB`) and `billing_claims_q4.tar.gz` (`4.19 MB`).
* **Remediated Blast Radius (`E-004`–`E-006`):** UFW allowlisting (`10.0.2.50` only) plus `valid users = backup_admin` restricts access to **1 privileged backup host**.
