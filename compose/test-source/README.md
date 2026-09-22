# RTSP Test Source

Standalone Docker Compose bundle for running three reusable virtual camera
streams through a local stream server.

## Start

```bash
docker compose -f compose/test-source/compose.yml up -d
```

## Stop

```bash
docker compose -f compose/test-source/compose.yml down
```

## Streams

RTSP:

```text
rtsp://localhost:18554/live/cam-1
rtsp://localhost:18554/live/cam-2
rtsp://localhost:18554/live/cam-3
```

HLS:

```text
http://localhost:18888/live/cam-1/index.m3u8
http://localhost:18888/live/cam-2/index.m3u8
http://localhost:18888/live/cam-3/index.m3u8
```

## Port Overrides

The default host ports are defined in `.env` so this bundle can run alongside
the single-machine stack without conflicting with its MediaMTX ports.

Use environment variables when you need a different local port set.

```bash
RTSP_PORT=28554 HLS_PORT=28888 API_PORT=29997 METRICS_PORT=29998 \
  docker compose -f compose/test-source/compose.yml up -d
```

With the example above, the RTSP URLs become:

```text
rtsp://localhost:28554/live/cam-1
rtsp://localhost:28554/live/cam-2
rtsp://localhost:28554/live/cam-3
```

## Camera Overrides

Each camera can be tuned independently.

```bash
CAM_1_SIZE=1920x1080 CAM_1_RATE=30 CAM_1_BITRATE=4500k \
  docker compose -f compose/test-source/compose.yml up -d
```
