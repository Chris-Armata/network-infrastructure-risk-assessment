# Stage 04: Coverage & Exceptions Register
| ID | Exclusion | Rationale | Compensating Control |
| :--- | :--- | :--- | :--- |
| `EXC-01` | Destructive memory-corruption exploits | Non-destructive clinical safety RoE | Protocol/auth verification via `nmap`, `curl`, `smbclient` |
| `EXC-02` | Physical CT/Pyxis hardware | Virtualized lab scope | Simulated clinical REST endpoints (`:8443-8445`) |
