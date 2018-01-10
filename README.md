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
Check [the official Grafana Docker page](https://github.com/grafana/grafana-docker) for further config options.

```bash
docker run -d \
    -p 3000:3000 \
    --env UID=1000 \
    --env GID=1000 \
    -v /your/var/lib/grafana/folder:/var/lib/grafana:rw \
    -v /your/etc/grafana/folder:/etc/grafana:rw \
    microbug/grafana:latest
```

### Read-only mounting
If you want to keep your host's filesystem protected from the container, this image allows you to mount the `/etc/grafana` folder read only. You can do this by changing `rw` to `ro` in the examples above. However, note that you cannot have a read-only `/var/lib/grafana` as Grafana needs to store its internal database there.

The only alternative to a read/write mount of `/var/lib/grafana` is to not map a host folder to it all, which will prevent Grafana settings and dashboards from persisting between container reboots. With Grafana 5.0+ there is [a provisioning feature](http://docs.grafana.org/administration/provisioning/) that allows you to automatically add dashboards and datasources from certain folder, which will presumably be allowed to be read-only. With the current Grafana 4.6.x you will have to use the API to add these with each reboot.

## A note on versions
At the moment, Docker Hub builds this repo automatically when it is pushed to, or when `grafana/grafana`  is pushed to. This means that it should be in line with `grafana/grafana:latest`. If there is demand I can do builds for specific Grafana versions (create an issue if you need this).
