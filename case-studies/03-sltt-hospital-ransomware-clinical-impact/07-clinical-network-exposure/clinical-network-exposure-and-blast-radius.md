# Stage 07: Exposure & Blast Radius
- **Kill Chain:** Phished `WKST-01` (`.25`) scans `DC-01` (`.15`) -> dumps `:389` accounts & `:445` `clinical_gpo_mount.ps1` -> encrypts `DC-01` -> freezes `:8443-8445` (`HTTP 503`).
- **Blast Radius Reduction:** `254` subnet hosts -> `1` allowlisted `PAW-01` (`99.6%` reduction).
