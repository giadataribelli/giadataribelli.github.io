# ADR 0007 — Database e Prisma con PostgreSQL

Status: Accepted
Data: 2025-08-28

Decisione
- PostgreSQL come database principale; Prisma come ORM con migrazioni versionate.
- Identificativi: `String @id @default(uuid()) @db.Uuid` (oppure `cuid()`), timestamp `DateTime @default(now())`.
- Migrazioni tramite `prisma migrate dev` in sviluppo e `prisma migrate deploy` in produzione.

Razionale
- Integrità referenziale, vincoli e transazioni robuste; concorrenza gestibile con constraint unici e transazioni serializzabili quando necessario.

Conseguenze
- Schema relazionale con FK tra `Course`, `Session`, `Booking`, `User`.
- Indici su `user.email`, `booking(sessionId,userId)`, `session(courseId,startAt)`.
- Possibilità di usare lock/`SELECT ... FOR UPDATE` tramite Prisma su operazioni critiche (se supportate) o vincoli per prevenire overbooking.
