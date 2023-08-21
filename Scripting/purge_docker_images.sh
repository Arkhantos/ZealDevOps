#!/bin/sh
docker stop registry
docker system prune -f
docker run -d -p 5000:5000 --restart=always --name registry -v /etc/docker/registry/config.yml:/etc/docker/registry/config.yml registry:2