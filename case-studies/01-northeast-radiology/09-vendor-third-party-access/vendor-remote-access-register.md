# Stage 7 — Vendor Remote Access & Third-Party Exposure Register
**Engagement:** Case Study 01 — Northeast Radiology (NERAD)  
**Evidence References:** `E-001-nmap-ast01.txt`, `E-004-ufw-status-verbose.txt`, `E-006-sshd-remote-access-posture.txt`

---

## 1. Third-Party & Remote Administration Path Inventory
| Access ID | Third-Party / Admin Role | Target Asset(s) | Protocol / Mechanism | Observed Control Posture | Governance & Risk Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `VND-01` | PACS System Integrator / Linux Support | `AST-01` (`10.0.2.15`) | SSH (`TCP 22` — `OpenSSH 9.6p1`) | Exposed on `22/tcp` (`E-001`, `E-004`); default `sshd_config` permits password-based auth fallback unless explicitly hardened (`E-006`) | **Gap:** Requires key-only auth (`PasswordAuthentication no`), MFA jump-host gating, and source-IP restriction |
| `VND-02` | Imaging Modality OEM Support | `AST-02` (`10.0.2.20`) | Vendor Remote Service Tunnel | Outbound vendor support path not segmented from general clinic LAN | **Gap:** Must enforce time-bound, session-logged, approval-gated vendor access (`ZTNA`/jump host) with zero lateral reach to `AST-01` |
| `VND-03` | Remote Clinical / Teleradiology Access | `AST-01` (`TCP 8042`) | HTTP REST / Web Explorer | Baseline allowed unauthenticated `Anywhere` access; remediated to `10.0.2.30` only (`E-004`) | **Mitigated at Network Layer:** Requires TLS 1.3 + individual user RBAC before any remote clinical expansion |

---

## 2. Key Stage 7 Takeaways
* **Eliminate Standing Vendor Access:** Remote support channels for PACS (`AST-01`) and modalities (`AST-02`) must operate on a just-in-time (JIT), ticket-approved basis with session logging and immediate revocation upon maintenance completion.
* **Lock Down SSH Management Plane (`22/tcp`):** Restrict `22/tcp` to dedicated administrative bastion IPs and enforce Ed25519 key-only authentication.
