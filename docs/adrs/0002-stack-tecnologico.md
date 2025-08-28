# ADR 0002 — Stack tecnologico

Status: Accepted
Data: 2025-08-28

Opzioni
- Next.js/TypeScript + Prisma + PostgreSQL + BetterAuth + Resend (scelto)
- Alternativa: Next.js + Prisma + MySQL; oppure tRPC/Auth.js/Sendgrid/Postgres

Decisione
- Usare Next.js (App Router), TypeScript, Prisma con PostgreSQL, BetterAuth per auth, Resend per email.

Razionale
- Coerenza con requisiti, DX elevata, transazioni/constraint robusti con Postgres, hosting semplice (Vercel + DB gestito).

Conseguenze
- Uso di `prisma migrate` per versionare lo schema; attenzione a performance degli indici e alla gestione delle transazioni nei casi d’uso concorrenti (booking).
