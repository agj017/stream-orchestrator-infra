# RTSP Test Source

Standalone Docker Compose bundle for running three reusable virtual camera
streams through MediaMTX.

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
rtsp://localhost:8554/live/cam-1
rtsp://localhost:8554/live/cam-2
rtsp://localhost:8554/live/cam-3
```

HLS:

```text
http://localhost:8888/live/cam-1/index.m3u8
http://localhost:8888/live/cam-2/index.m3u8
http://localhost:8888/live/cam-3/index.m3u8
```

## Port Overrides

Use environment variables when default ports conflict with another local stack.

```bash
RTSP_PORT=18554 HLS_PORT=18888 API_PORT=19997 METRICS_PORT=19998 \
  docker compose -f compose/test-source/compose.yml up -d
```

With the example above, the RTSP URLs become:

```text
rtsp://localhost:18554/live/cam-1
rtsp://localhost:18554/live/cam-2
rtsp://localhost:18554/live/cam-3
```

## Camera Overrides

Each camera can be tuned independently.

```bash
CAM_1_SIZE=1920x1080 CAM_1_RATE=30 CAM_1_BITRATE=4500k \
  docker compose -f compose/test-source/compose.yml up -d
```
