# ADR 0006 — Autenticazione e autorizzazione (BetterAuth)

Status: Accepted
Data: 2025-08-28

Decisione
- BetterAuth per gestione sessioni e provider email; ruoli: `ADMIN`, `CREATOR`, `CLIENT` (RBAC). Session cookie httpOnly, rotazione token.

Conseguenze
- Middleware per protezione route API e pagine; controlli di autorizzazione a livello di use case (application layer).
