# Giada Taribelli — Sito e piattaforma corsi

Sito ufficiale e piattaforma di prenotazione corsi per Giada Taribelli, pedagogista e content creator specializzata nell’uso del gioco di ruolo in ambito educativo.

Obiettivi principali:
- Presentare il profilo professionale, i servizi e i contenuti di Giada.
- Consentire la prenotazione e gestione di corsi/eventi (per utenti registrati).
- Offrire autenticazione sicura per ruoli distinti: `ADMIN` (noi), `CREATOR` (Giada), `CLIENT` (utenti).

## Stack
- Next.js 15 (App Router) + TypeScript
- Prisma (ORM) + PostgreSQL
- BetterAuth (autenticazione/ruoli)
- Resend (invio email transazionali, template React)
- Zod (validation) + React Hook Form (UI forms)
- Vitest (unit/integration), Playwright (e2e)

## Architettura
- Domain-Driven Design con bounded contexts principali: `Identity & Access`, `Courses`, `Booking`, `Notifications` (email), `Content` (presentazione).
- Architettura esagonale (ports/adapters): dominio puro isolato da framework; adapter web/API con Next.js route handlers, adapter DB con Prisma, adapter mail con Resend.
- TDD come pratica di sviluppo: prima i test sul dominio, poi implementazione e adapter.

## Struttura progetto (proposta)
```
src/
  app/                         # Next.js (route handlers, pages/app, UI)
  modules/
    identity/                  # bounded context Identity & Access
      domain/                  # entità, value objects, services, policies
      application/             # use cases, orchestrazione
      infrastructure/          # repo prisma, adapters betterauth
    courses/
      domain/
      application/
      infrastructure/
    booking/
      domain/
      application/
      infrastructure/
    notifications/
      domain/
      application/
      infrastructure/          # adapter Resend (email)
    content/
      domain/
      application/
      infrastructure/          # sorgenti contenuto (MDX o DB)
  shared/                      # util comuni (es. errori, zod, date)
  tests/                       # test domain/application + fixtures
prisma/
  schema.prisma
docs/
  adrs/
```

- I layer `domain` non dipendono da framework o database.
- I layer `application` espongono i casi d’uso (porte) e orchestrano transazioni.
- Gli `infrastructure adapters` implementano porte (repository, mailer, auth provider).

## API e integrazioni
- API: Next.js Route Handlers (`app/api/**/route.ts`) stile REST (JSON), con validazione Zod.
- Auth: BetterAuth con sessioni sicure, ruoli `ADMIN | CREATOR | CLIENT` (RBAC). Middleware per protezione route.
- DB: PostgreSQL via Prisma; id `String @id @default(uuid()) @db.Uuid`; migrazioni gestite con `prisma migrate`.
- Email: Resend con template React per conferme prenotazione, reminder, notifiche admin.

## Modello di dominio (prima iterazione)
- `User`: id, email, name, role.
- `Course`: id, title, description, tags, capacity, visibility, owner (Giada).
- `Session`: id, courseId, startAt, endAt, capacityOverride?, location/onlineLink.
- `Booking`: id, sessionId, userId, status (PENDING|CONFIRMED|CANCELLED), createdAt.
- Policy di prenotazione: niente overbooking; lista attesa (fase 2); finestra di cancellazione (configurabile).

## Setup locale
Prerequisiti: Node.js >= 20, pnpm (o npm), database PostgreSQL (Neon/Supabase/locale), account Resend, BetterAuth secret.

1) Installazione
```
pnpm install
```

2) Variabili d'ambiente (`.env.local`)
```
# Database
DATABASE_URL="postgresql://<user>:<pass>@<host>:5432/<db>?schema=public"

# Auth
BETTER_AUTH_SECRET="<random-64-128-hex>"
BETTER_AUTH_URL="http://localhost:3000"

# Email
RESEND_API_KEY="re_..."
RESEND_FROM="Giada <noreply@giadataribelli.it>"

# App
APP_BASE_URL="http://localhost:3000"
```

3) Prisma
```
pnpm prisma generate
pnpm prisma migrate dev --name init
```

4) Dev server
```
pnpm dev
```

## Test
- Unit/integration (dominio e application): Vitest.
- E2E (percorsi critici booking/auth): Playwright.
```
pnpm test              # vitest
pnpm test:e2e          # playwright
```

## Qualità e sicurezza
- Lint/format: ESLint + Prettier.
- Validazione input: Zod.
- Autorizzazioni: RBAC su use case + middleware API.
- Log/Tracing: Next.js + (fase 2) OpenTelemetry.

## Conventional Commits
- Tipi: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- Scopes (domini/sottosistemi): `identity`, `courses`, `booking`, `notifications`, `content`, `auth`, `email`, `api`, `ui`, `prisma`, `db`, `infra`, `shared`, `config`, `deps`, `ci`, `release`.
- Breaking change: usare `!` dopo il tipo/scope o footer `BREAKING CHANGE:`.
- Formato: `tipo(scope): descrizione sintetica`.
- Esempi:
  - `feat(booking): impedisci overbooking con vincolo univoco`
  - `fix(auth): gestisci refresh sessione BetterAuth`
  - `docs(content): aggiorna bio e sezione servizi`
  - `chore(prisma): crea migrazione iniziale postgres`
  - `refactor(shared): estrai Result<T> per error handling`

## Deploy (proposta)
- Vercel (Next.js), PostgreSQL gestito (Neon, Supabase, Render, Railway, RDS).
- Env per Vercel impostate come in `.env.local`.
- CI GitHub Actions: lint + build + tests su PR.

## Docker e Make
- Prerequisiti: Docker Desktop o compatibile.
- Avvio locale (dev): `make up` poi apri `http://localhost:3000`.
- Fermare e pulire: `make down`.
- Log: `make logs`.
- Shell nel container app: `make shell`; DB: `make dbshell`.
- Prisma: `make generate` (client), `make migrate name=<nome>` (migrazione).
- Prisma Studio: `make studio` e apri `http://localhost:5555`.
- Test/lint/build: `make test` | `make lint` | `make build`.
- Reset DB (svuota e rimigra): `make reset`.
- Preview prod (build + start): `make preview` (usa profilo compose `preview`).

## Migrazioni Prisma
- In avvio container usiamo `prisma migrate deploy` (non interattivo) per applicare le migrazioni già committate.
- Per creare una nuova migrazione in sviluppo, usa: `make migrate name=<nome>` (interattivo).
- Prima migrazione: è già presente in `prisma/migrations/*_init/`. Per ri‑crearla da zero fai `make reset` e poi `make migrate name=init`.

## ADRs
Le decisioni architetturali sono documentate in `./docs/adrs`. Leggere in particolare:
- 0002 (Stack), 0003 (Architettura esagonale + DDD), 0005 (Stile API), 0006 (Auth), 0007 (DB/Prisma), 0010 (Modello prenotazioni), 0012 (Deploy).

## Roadmap iniziale
- Fase 1: Presentazione + catalogo corsi pubblico, autenticazione, prenotazione base con email di conferma.
- Fase 2: Lista d’attesa, reminder automatici, dashboard admin/creator per gestione corsi e iscritti.
- Fase 3: Pagamenti online (Stripe) e fatturazione.

***
Senior dev note: il codice seguirà i principi DDD/Hexagonal; inizieremo dal dominio (`Booking`/`Courses`) con TDD, poi adapter (Prisma/Resend) e infine le route API/Ui.
