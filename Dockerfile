# Dev container for Next.js + Prisma (PostgreSQL)
FROM node:20-bookworm-slim

ENV NODE_ENV=development \
    NEXT_TELEMETRY_DISABLED=1

WORKDIR /app

# System deps required by Prisma (OpenSSL)
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends openssl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install pnpm globally and install deps (better layer caching)
COPY package.json ./
RUN npm install -g pnpm@9 \
  && pnpm install --no-frozen-lockfile

# Copy the rest of the repo
COPY . .

# Ensure entrypoint is executable
RUN chmod +x docker/entrypoint.sh || true

EXPOSE 3000

# Run dev server binding on 0.0.0.0
CMD ["/bin/sh", "docker/entrypoint.sh"]
