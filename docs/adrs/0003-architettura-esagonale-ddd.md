# ADR 0003 — Architettura esagonale + DDD

Status: Accepted
Data: 2025-08-28

Decisione
- Adottare Domain-Driven Design e architettura esagonale.
- Strati: domain (puro), application (use cases), infrastructure (adapters: db, mail, auth), presentation (Next.js UI/API).

Conseguenze
- Dominio testabile in isolamento; dipendenze invertite tramite porte/adapter; UI e DB sostituibili senza impatti sul core.
