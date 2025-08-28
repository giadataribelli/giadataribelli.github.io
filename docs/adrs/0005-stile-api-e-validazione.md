# ADR 0005 — Stile API e validazione

Status: Accepted
Data: 2025-08-28

Opzioni
- REST con Next.js Route Handlers + Zod (scelto)
- tRPC end-to-end types; GraphQL

Decisione
- Esporre API RESTful sotto `/api/**` con route handlers, body JSON, risposta problem+json per errori; validazione con Zod.

Conseguenze
- Chiara interoperabilità; tipi coerenti via Zod; minore lock-in rispetto a tRPC.
