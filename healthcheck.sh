#!/bin/sh

DOCKER_SOCK=${DOCKER_SOCK:-/var/run/docker.sock}
CURL_TIMEOUT=${CURL_TIMEOUT:-30}

docker_curl() {
  curl --max-time "${CURL_TIMEOUT}" --no-buffer -s --unix-socket "${DOCKER_SOCK}" "$@" || return 1
  return 0
}

docker_curl --fail http://localhost/_ping
exit $?
