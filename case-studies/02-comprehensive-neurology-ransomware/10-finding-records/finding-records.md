# Stage 10: Detailed Security Finding Records

## Finding F-01: Unauthenticated SMB Write Access to Clinical Backup Share
* **Severity:** **Critical (CVSS v3.1: 9.8)** | **Evidence:** `E-002`, `E-003`
* **Compliance:** `45 CFR § 164.312(a)(1)` (Access Control); `45 CFR § 164.308(a)(7)(ii)(A)` (Data Backup Plan); NIST SP 800-207
* **Technical Detail & Fix (`E-005`):** Replaced `guest ok = Yes` and `map to guest = Bad User` with `map to guest = Never`, `restrict anonymous = 2`, and `valid users = backup_admin`. Verified `NT_STATUS_ACCESS_DENIED`.

## Finding F-02: World-Writable (`0777`) Permissions on Backup Storage Mount
* **Severity:** **High (CVSS v3.1: 8.1)** | **Evidence:** `E-002`
* **Compliance:** `45 CFR § 164.312(c)(1)` (Integrity Controls)
* **Technical Detail & Fix (`E-005`):** Changed `/srv/samba/ClinicBackups` ownership to `backup_admin:backup_admin` and permissions to `0750` (`create mask = 0640`).

## Finding F-03: Unrestricted Subnet Exposure of SMB (`139`, `445`) & SSH (`22`)
* **Severity:** **Critical (CVSS v3.1: 9.1)** | **Evidence:** `E-001`, `E-004`
* **Compliance:** `45 CFR § 164.308(a)(1)(ii)(B)` (Risk Management); NIST SP 800-207 (Policy Enforcement Point)
* **Technical Detail & Fix (`E-004`, `E-005`):** Closed `139/tcp` and restricted `445/tcp` and `22/tcp` strictly to `10.0.2.50`. Verified `[UFW BLOCK]` on probes from `10.0.2.25`.

## Finding F-04: Optional SMB Packet Signing
* **Severity:** **Medium (CVSS v3.1: 5.9)** | **Evidence:** `E-001`, `E-002`
* **Compliance:** `45 CFR § 164.312(e)(1)` (Transmission Security)
* **Technical Detail & Fix (`E-005`):** Enforced `min protocol = SMB3_11` and `server signing = mandatory`.
