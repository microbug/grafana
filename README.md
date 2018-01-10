# Grafana
`grafana/grafana:latest` with user-configurable UID and GID. Almost exactly the same as [the official image (`grafana/grafana`)](https://github.com/grafana/grafana/) except for the UID/GID configuration — for anything not related to UIDs/GIDs, go there.

## Usage
The UID and GID of the `grafana` user can be set through environment variables. Examples below use the usual default of UID and GID both equal to 1000, substitute your own for different situations.

Because the `grafana` user has the right permissions, you can pass through folders to map to `/var/lib/grafana` and `/etc/grafana` to enable persistence. On the host you should do `chown -R 1000:1000 FOLDER_NAME` on each folder that you will map.

### docker-compose
Check [the official Grafana Docker page](https://github.com/grafana/grafana-docker) for further config options.

```yaml
version: '3'

services:
  grafana:
    image: microbug/grafana:latest
    environment:
      - UID=1000
      - GID=1000
    volumes:
      - /your/var/lib/grafana/folder:/var/lib/grafana:rw
      - /your/etc/grafana/folder:/etc/grafana:rw
    ports:
      - "3000:3000"
```

### docker run
```bash
docker run -d \
    -p 3000:3000 \
    --env UID=1000 \
    --env GID=1000 \
    -v /your/var/lib/grafana/folder:/var/lib/grafana \
    -v /your/etc/grafana/folder:/etc/grafana \
    microbug/grafana:latest
```

## A note on versions
At the moment, Docker Hub builds this repo automatically when it is pushed to, or when `grafana/grafana`  is pushed to. This means that it should be in line with `grafana/grafana:latest`. If there is demand I can do builds for specific Grafana versions (create an issue if you need this).
