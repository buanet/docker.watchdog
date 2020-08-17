#!/bin/bash

# Docker engine API v1.24 (https://docs.docker.com/engine/api/v1.24/)
curl --max-time 10 --no-buffer -s --unix-socket /var/run/docker.sock --fail http://localhost/_ping || exit 1
exit 0
