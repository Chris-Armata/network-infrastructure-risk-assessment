# Stage 9 — Prioritized Healthcare Imaging Remediation Roadmap
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Sequencing Logic:** Prioritize immediate blast-radius reduction via non-disruptive host perimeter controls first, followed by maintenance-window application hardening and vendor-coordinated resilience improvements.

---

## Phase 1: Immediate Containment (Days 1–7 — Zero Modality Disruption)
1. **Enforce Host Policy Enforcement Point (PEP) Micro-Segmentation (`F-001`, `F-002` — Completed in Lab):**
   * Restrict `8042/tcp` exclusively to `10.0.2.30` (`AST-03`) and `4242/tcp` exclusively to `10.0.2.20` (`AST-02`) via UFW default-deny inbound rules.
   * *Clinical Safety Check:* Zero software modification on `AST-02` modality; preserves continuous DICOM `C-STORE` flow.
2. **Restrict SSH Management Plane (`F-005`):**
   * Limit `22/tcp` inbound connections to authorized administrative jump-host IPs and enforce `PasswordAuthentication no` / `PermitRootLogin no`.

## Phase 2: Scheduled Maintenance Window Hardening (Days 8–30)
3. **Enable Orthanc Application Authentication & DICOM AE-Title Allowlisting (`F-001`, `F-002`):**
   * Set `"AuthenticationEnabled": true` in `/etc/orthanc/orthanc.json` with role-based accounts for `AST-03` clinical users, and restrict `DicomModalities` to `NERAD_CT01` (`10.0.2.20`).
   * *Maintenance Window:* Execute during `22:00–02:00` low-volume window with Clinical Imaging Engineer on standby.
4. **Deploy TLS 1.3 Reverse Proxy for Clinical Web Access (`F-003`):**
   * Bind Orthanc HTTP to `127.0.0.1:8042` and terminate TLS 1.3 via Nginx on `443/tcp` for `AST-03`.

## Phase 3: Architectural Segmentation, Resilience & Vendor Governance (Days 31–90)
5. **Implement VLAN Segmentation & Vendor JIT Access (`F-003`, `F-005`):**
   * Separate Modality VLAN (`AST-02`), PACS Server VLAN (`AST-01`), Clinical Workstation VLAN (`AST-03`), and General Office LAN (`AST-04`) at the core switch/firewall, and transition OEM vendor support to ticket-gated, session-logged ZTNA/jump-host workflows.
6. **Establish Immutable/Offline Backups & Non-Production Restore Drill (`F-004`):**
   * Configure pull-based immutable PACS backups isolated from production credentials and execute a verified sandbox restore test to establish empirical RTO/RPO metrics.
