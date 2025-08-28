# ADR 0010 — Modello Booking e policy

Status: Accepted
Data: 2025-08-28

Decisione
- Aggregati principali: `Course`, `Session`, `Booking`.
- Regole: no overbooking, cancellazione entro finestra configurabile, stato `PENDING|CONFIRMED|CANCELLED`.

Conseguenze
- Necessità di controlli di concorrenza a livello repository (unique su `sessionId+userId`, contatori di posti) e transazioni applicative.
