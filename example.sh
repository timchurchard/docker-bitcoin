#!/bin/bash

docker stop bitcoind
docker rm bitcoind

docker pull timchurchard/docker-bitcoin:0.19.1
docker image prune -f

docker create \
    --name bitcoind \
    -p 127.0.0.1:8332:8332 \
    -p 8333:8333 \
    -v /z-perf/solo.miner/bitcoind_data:/data \
    timchurchard/docker-bitcoin:0.19.1

# Don't restart plex on boot because encrypted drives not mounted!
docker update --restart=no bitcoind

docker start bitcoind

