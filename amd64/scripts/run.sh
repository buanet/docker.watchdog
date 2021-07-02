#!/bin/sh

# Reading ENV
dockerSock=${DOCKER_SOCK:-/var/run/docker.sock}
curlTimeout=${CURL_TIMEOUT:-30}
watchdogContainerLabel=${WATCHDOG_CONTAINER_LABEL:=watchdog}

# SIGTERM-handler
shut_down() {
  echo ' '
  echo "Recived termination signal (SIGTERM) at $(date +%Y-%m-%d" "%H:%M:%S)."
  echo "Shutting down watchdog..."
  echo ' '
  exit
}

docker_curl() {
  curl --max-time "$curlTimeout" --no-buffer -s --unix-socket "$dockerSock" "$@" || return 1
  return 0
}


trap 'shut_down' SIGTERM

# Running watchdog
# https://docs.docker.com/engine/api/v1.25/

if [ -e /var/run/docker.sock ]
then
  # Set container selector
  if [ "$watchdogContainerLabel" == "all" ]
  then
    labelFilter=""
  else
    labelFilter=",\"label\":\[\"$watchdogContainerLabel=true\"\]"
  fi

  echo "Watchdog will now start monitoring containers for unhealthy status."
  echo ""

  while true
  do
    sleep ${WATCHDOG_INTERVAL:=5}

    apiUrl="http://localhost/containers/json?filters=\{\"health\":\[\"unhealthy\"\]${labelFilter}\}"
    stopTimeout=".Labels[\"watchdog.stop.timeout\"] // ${WATCHDOG_DEFAULT_STOP_TIMEOUT:-10}"
    docker_curl "$apiUrl" | \
    jq -r "foreach .[] as \$CONTAINER([];[]; \$CONTAINER | .Id, .Names[0], $stopTimeout )" | \
    while read -r CONTAINER_ID && read -r CONTAINER_NAME && read -r TIMEOUT
    do
        CONTAINER_SHORT_ID=${CONTAINER_ID:0:12}
        DATE=$(date +%Y-%m-%d" "%H:%M:%S)
        if [ "null" = "$CONTAINER_NAME" ]
        then
          echo "$DATE Container name of ($CONTAINER_SHORT_ID) is null, which implies container does not exist - don't restart."
        else
          echo "$DATE Container ${CONTAINER_NAME} ($CONTAINER_SHORT_ID) found to be unhealthy - Restarting container now with ${TIMEOUT}s timeout."
          docker_curl -f -XPOST "http://localhost/containers/${CONTAINER_ID}/restart?t=${TIMEOUT}" \
            || echo "$DATE Restarting container $CONTAINER_SHORT_ID failed!"
        fi
    done
  done
else
  echo "No access to /var/run/docker.sock! Cannot monitor running containes on this host."
  echo "For more information please see readme.md on Github."
  exec "$@"
fi

# Fallback process for development only
tail -f /dev/null
