#!/bin/bash

docker run --name heaven --hostname=heaven -d \
             -v /opt/containers:/opt/containers:ro \
             -v /var/run:/var/run/host \
             -v /usr/lib/systemd/system:/usr/lib/systemd/system/host \
             -v /opt/containers/nginx/etc/letsencrypt:/etc/letsencrypt \
             --cap-add=NET_ADMIN \
             -e DOCKER_VERSION=`docker -v | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'` \
             -p 80:80 -p 443:443 \
             --restart=always \
             --net=bridge \
             extremeprog/heaven
