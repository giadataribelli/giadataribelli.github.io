# ADR 0013 — Upgrade a Next.js 15

Status: Accepted
Data: 2025-08-28

Contesto
- Il progetto è in fase iniziale con Next.js 14. Abbiamo warning di deprecazione su ESLint 8 e vogliamo allinearci allo stack corrente.

Decisione
- Aggiornare a Next.js 15 e React 19, allineando eslint-config-next ed ESLint alla baseline di Next 15.
- Mantenere Node 20 LTS nelle immagini Docker e in CI.

Razionale (Pro)
- Performance e DX migliori (Turbopack/SWC, stabilità App Router e Server Actions).
- Allineamento ecosistema (Vercel) e patch di sicurezza/bugfix più recenti.
- Riduzione dei warning di deprecazione (ESLint 9 baseline).

Rischi (Contro) e mitigazioni
- Possibili incompatibilità con librerie (BetterAuth/Resend). Mitigare testando con profilo `preview` e TDD sui casi d’uso.
- Aggiornamenti di toolchain (ESLint 9, @types). Rimuovere i tipi di React se inclusi in React 19.

Impatto
- Bump di versioni in `package.json`; rimozione di `@types/react` e `@types/react-dom` se non più necessari.
- Nessun cambio previsto su Docker (Node 20 ok). Verifica build e test in CI/Compose.
