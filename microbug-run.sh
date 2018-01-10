#!/bin/bash

groupmod -g "$GID" grafana
usermod -u "$UID" grafana
chown -R grafana:grafana /var/lib/grafana

find / -user 104 -exec chown -h "$UID" {} \; 2>/dev/null
find / -group 107 -exec chgrp -h "$GID" {} \; 2>/dev/null

# Allow read-only /etc/grafana
sed -i 's/chown -R grafana:grafana \/etc\/grafana/chown -R grafana:grafana \/etc\/grafana || true/g' /run.sh

/run.sh
