# Single Machine Compose

Local single-machine stack for running the stream orchestrator with Postgres,
RabbitMQ, a stream server, Prometheus, Grafana, the API, workers, and dashboard.

## Start

Run from the repository root:

```bash
docker compose -f compose/single-machine/compose.yml up -d
```

Watch startup logs:

```bash
docker compose -f compose/single-machine/compose.yml logs -f
```

## Stop

```bash
docker compose -f compose/single-machine/compose.yml down
```

To also remove persisted local data:

```bash
docker compose -f compose/single-machine/compose.yml down -v
```

## Services

| Service | URL / Port | Notes |
| --- | --- | --- |
| Dashboard | http://localhost:8082 | Web dashboard |
| Orchestrator API | http://localhost:8080 | API service |
| Stream server RTSP | rtsp://localhost:8554 | RTSP ingest/read |
| Stream server HLS | http://localhost:8888 | HLS playback |
| Stream server API | http://localhost:9997 | Stream server control API |
| Stream server metrics | http://localhost:9998/metrics | Prometheus scrape target |
| Prometheus | http://localhost:9090 | Metrics |
| Grafana | http://localhost:3000 | Login: `admin` / `admin` |
| RabbitMQ management | http://localhost:15672 | Login: `guest` / `guest` |
| Postgres | localhost:5432 | DB: `stream_orchestrator`, user: `postgres`, password: `postgres` |

## Runtime Flow

The stack starts core dependencies first, runs database migrations, then starts
the API and background workers.

- `migrate` applies database migrations and exits.
- `orchestrator-api` exposes the HTTP API on port `8080`.
- `outbox-publisher` publishes persisted stream events to RabbitMQ.
- `stream-provisioner` runs in single-instance mode and controls the local
  stream server.
- `dashboard` exposes the web UI on port `8082`.

## Useful Commands

Check service status:

```bash
docker compose -f compose/single-machine/compose.yml ps
```

Tail one service:

```bash
docker compose -f compose/single-machine/compose.yml logs -f orchestrator-api
```

Restart one service:

```bash
docker compose -f compose/single-machine/compose.yml restart stream-provisioner
```
