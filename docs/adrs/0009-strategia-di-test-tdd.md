# ADR 0009 — Strategia di test e TDD

Status: Accepted
Data: 2025-08-28

Decisione
- TDD guidando il dominio: test unitari per entità/policy, test di application con repo in-memory, e2e con Playwright per flussi critici.

Conseguenze
- Feedback rapido e regressioni ridotte; necessità di doppie implementazioni (in-memory vs prisma) per i repository.
