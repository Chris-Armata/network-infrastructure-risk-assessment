# Stage 04: Coverage Exceptions Register
* **`EXC-01` (SMBv1 Kernel Exploits):** Excluded; Samba `4.19.5` disables SMB1 by default (`E-003`) and UFW drops unauthorized TCP/445 handshakes (`E-005`).
* **`EXC-02` (External WAN):** Scoped to East-West lateral movement inside `10.0.2.0/24` following an assumed phishing compromise on `10.0.2.25`.
