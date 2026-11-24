# Case Study 05: HHS-OIG Northeastern Hospital Audit (`A-18-22-08019`)

- **Framework & Standard Alignment:** HHS-OIG Healthcare Audit Methodology, NIST SP 800-53 (`AC-2`, `CM-4`, `SC-7`), NIST SP 800-207 Zero Trust, HIPAA Security Rule (`164.308(a)(3)`, `164.312(a)(1)`).
- **Target Assets:** Hospital EHR Server (`10.200.0.15`, ports `22/tcp` SSH & `8443/tcp` EHR Portal), Ex-Contractor Laptop (`10.200.0.45`), Approved Audit Safe (`10.200.0.50`), Contractor Account `vendor_maint`.
- **Walkthrough Runtime:** `03:26` (`media/case_study_5_web.mp4`) | Showcase: [showcase/case-study-5.html](../../showcase/case-study-5.html)
- **Integrity Manifest:** [21-evidence-hash-manifest.txt](21-evidence-hash-manifest.txt) (27/27 deterministic SHA-256 hashes).
