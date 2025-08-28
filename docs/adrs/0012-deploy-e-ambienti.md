# ADR 0012 — Deploy e ambienti

Status: Accepted
Data: 2025-08-28

Decisione
- Deploy su Vercel; database PostgreSQL gestito (es. Neon, Supabase, Render, Railway, RDS); Resend per email.
- Ambienti: `dev`, `preview`, `prod` con variabili dedicate e migrazioni controllate.

Conseguenze
- Pipeline CI per lint/build/test; `prisma migrate deploy` in prod durante il deploy; gestione sicura delle secret; rollback tramite Vercel previews.
