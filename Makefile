SHELL := /bin/sh

COMPOSE := docker compose

.PHONY: up down logs ps shell dbshell migrate generate studio test lint build dev reset preview

up:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down -v

logs:
	$(COMPOSE) logs -f app db

ps:
	$(COMPOSE) ps

shell:
	$(COMPOSE) exec app /bin/sh

dbshell:
	$(COMPOSE) exec -e PGPASSWORD=postgres db psql -U postgres -d giada

# Usage: make migrate name=add-booking-unique
migrate:
	$(COMPOSE) exec -it app pnpm exec prisma migrate dev --name "$(name)"

generate:
	$(COMPOSE) exec app npx prisma generate

studio:
	$(COMPOSE) exec -e BROWSER=none app npx prisma studio --host 0.0.0.0 --port 5555

test:
	$(COMPOSE) exec app npm test --silent -- --reporter=dot

lint:
	$(COMPOSE) exec app npm run lint --silent || true

build:
	$(COMPOSE) exec app npm run build --silent

dev: up

reset:
	$(COMPOSE) exec app npx prisma migrate reset -f --skip-seed

preview:
	$(COMPOSE) --profile preview up --build app_preview
