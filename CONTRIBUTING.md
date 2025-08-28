# Contributing

Grazie per contribuire al progetto di Giada Taribelli. Questo documento definisce il flusso di lavoro, le convenzioni e gli standard da seguire.

## Prerequisiti
- Node.js >= 20, pnpm
- Leggi `README.md`, `LLMS` e gli ADR in `docs/adrs`
- Configura `.env.local` come da README

## Workflow (TDD + DDD + Esagonale)
1) Leggi gli ADR
- Verifica se la modifica impatta architettura, modello dati o policy. In tal caso aggiorna/aggiungi un ADR.

2) Aggiorna la documentazione se necessario
- Modifica `README.md` e/o crea/aggiorna `docs/adrs/NNNN-titolo-kebab.md` con Status/Decisione/Razionale/Conseguenze.

3) Scrivi il test (failing first)
- Unit/integration (Vitest) per dominio/application; E2E (Playwright) solo se necessario.

4) Implementa la modifica minima
- Rispetta i layer: domain → application → infrastructure → presentation.
- Niente framework nel dominio; usa ports/adapters; valida input con Zod nelle API; RBAC a livello use case.
- Database: aggiorna `prisma/schema.prisma` e crea migrazione con `pnpm prisma migrate dev -n <nome>`.

5) Verifica che i test passino
- `pnpm test` e, se serve, `pnpm test:e2e`. Mantieni la suite verde.

6) Commit atomico con Conventional Commits
- Formato: `tipo(scope): descrizione sintetica`
- Tipi: `feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert`
- Scopes: `identity|courses|booking|notifications|content|auth|email|api|ui|prisma|db|infra|shared|config|deps|ci|release`
- Breaking change: `feat(scope)!: ...` o footer `BREAKING CHANGE:`
- Esempi: `feat(booking): impedisci overbooking con vincolo univoco` | `chore(prisma): crea migrazione iniziale`

## Branching e PR
- Branch naming: `feat/<scope>-<kebab>`, `fix/<scope>-<kebab>`, `chore/<scope>-<kebab>`
- Apri una PR con titolo in formato Conventional Commit (verrà squashed)
- Compila il template PR (sezione ADR, test plan, migrazioni, env vars)
- Preferisci PR piccole e focalizzate

## Stile codice e qualità
- ESLint/Prettier; tipi stretti in TypeScript
- Dominio puro, side effects confinati negli adapter
- Error handling consistente (Result/exception boundary) e logging essenziale
- Non introdurre dipendenze superflue

## Database e migrazioni
- Usa `pnpm prisma migrate dev` in locale e committa le migrazioni
- Non modificare a mano i file di migrazione; crea una nuova migrazione
- Identificativi: UUID; aggiungi indici e constraint dove serve

## Sicurezza e segreti
- Non committare `.env.local` o segreti
- Valida sempre input/parametri; verifica permessi/ruoli su use case

## Checklist di revisione
- [ ] Test aggiunti/aggiornati e verdi
- [ ] ADR valutati/aggiornati se necessario
- [ ] Documentazione aggiornata (README/LLMS se serve)
- [ ] Migrazioni Prisma presenti (se DB toccato)
- [ ] Tipi/limiti Zod coerenti, error handling chiaro
- [ ] Autorizzazioni e ruoli rispettati

## Comandi utili
- Dev: `pnpm dev` | Build: `pnpm build` | Lint: `pnpm lint`
- Test: `pnpm test` | E2E: `pnpm test:e2e`
- Prisma: `pnpm prisma generate` | `pnpm prisma migrate dev` | `pnpm prisma migrate deploy`
