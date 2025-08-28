# ADR 0008 — Email e notifiche con Resend

Status: Accepted
Data: 2025-08-28

Decisione
- Resend per invio email transazionali (conferma prenotazione, reminder, notifiche admin) usando template React.

Conseguenze
- Richiede dominio verificato; coda/notifiche idempotenti (fase 2) se necessario per volumi.
