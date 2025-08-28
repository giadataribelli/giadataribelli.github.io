#!/bin/sh
set -e

# Prisma generate and migrate (dev)
if [ -f ./prisma/schema.prisma ]; then
  # Ensure deps are installed in mounted volume (pnpm)
  if [ ! -d node_modules ] || [ ! -x node_modules/.bin/next ]; then
    echo "[entrypoint] pnpm install"
    pnpm install --no-frozen-lockfile
  fi

  # Prune stray/empty migration folders (e.g., renamed folders without migration.sql)
  if [ -d prisma/migrations ]; then
    for d in prisma/migrations/*; do
      if [ -d "$d" ] && [ ! -f "$d/migration.sql" ]; then
        echo "[entrypoint] pruning invalid migration folder: $d"
        rm -rf "$d"
      fi
    done
  fi

  echo "[entrypoint] prisma generate"
  pnpm exec prisma generate
  if [ -n "$DATABASE_URL" ]; then
    echo "[entrypoint] prisma migrate deploy"
    if ! pnpm exec prisma migrate deploy; then
      if [ "${RESET_ON_MIGRATE_FAILURE:-}" = "true" ]; then
        echo "[entrypoint] migrate deploy failed; resetting database (dev only)"
        pnpm exec prisma migrate reset -f --skip-seed
        pnpm exec prisma migrate deploy
      else
        echo "[entrypoint] migrate deploy failed and auto-reset disabled" 1>&2
        exit 1
      fi
    fi
  fi
fi

echo "[entrypoint] starting Next.js dev server"
exec pnpm dev -- -H 0.0.0.0
