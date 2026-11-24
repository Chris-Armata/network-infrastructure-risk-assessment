# 03 — Clinical Architecture, Trust Boundaries & Data Flows

Separates external/contractor endpoints (`10.200.0.45`) and unapproved inbound traffic from the protected EHR enclave (`10.200.0.15`), permitting `22/tcp` and `8443/tcp` exclusively from `10.200.0.50`.
