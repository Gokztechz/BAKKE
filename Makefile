.PHONY: dev seed test migrate reset logs down ps api worker frontend

include .env
export

api:
	@cd backend && ../.venv/bin/uvicorn app.main:app --reload --port 8000

worker:
	@cd backend && ../.venv/bin/python -m app.jobs.worker

seed:
	@cd backend && ../.venv/bin/python -m scripts.seed_demo

migrate:
	@cd backend && ../.venv/bin/alembic upgrade head

test:
	@cd backend && ../.venv/bin/python -m pytest -q

reset: down
	docker compose down -v

ps:
	docker compose ps

logs:
	docker compose logs -f --tail=200

down:
	docker compose down
