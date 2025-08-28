# ADR 0004 — Struttura repo e moduli

Status: Accepted
Data: 2025-08-28

Decisione
- Singolo repository Next.js con `src/modules/<bounded-context>/{domain,application,infrastructure}` e `src/app` per UI/API.

Conseguenze
- Separazione chiara dei contesti (`identity`, `courses`, `booking`, `notifications`, `content`) e riuso di componenti `shared`.
