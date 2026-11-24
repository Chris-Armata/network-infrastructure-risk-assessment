# Executive Risk Report — Case Study 04: TransForm Shared Service Organization (SSO)

Even if a hospital locks all of its own doors, it can still be knocked offline if its outside IT company holds a single master key to everyone's computers. Modeled on the October 2023 ransomware attack affecting five Ontario hospitals under **PHIPA**, this assessment proves how revoking the shared master key, enforcing hardware **MFA** and single-hospital **RBAC**, and locking ports `2222` (SSH) and `8443` (HTTPS) via **UFW** to `10.0.2.50` restores all five hospitals to `200 OK - ONLINE & ISOLATED`.
