#!/bin/bash

groupmod -g $GID grafana
usermod -u $UID grafana
chown -R grafana:grafana /var/lib/grafana

# && `find / -user 104 -exec chown -h $UID {} \;` 
# && `find / -group 107 -exec chgrp -h $GID {} \;`

/run.sh
