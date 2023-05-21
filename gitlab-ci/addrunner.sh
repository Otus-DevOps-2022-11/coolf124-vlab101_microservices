#!/bin/sh
#зарегистрировать gitlab-runner
sudo docker exec -it gitlab-runner gitlab-runner register \
--url http://62.84.125.180/ \
--non-interactive \
--locked=false \
--name DockerRunner \
--executor docker \
--docker-image alpine:latest \
--docker-volumes /var/run/docker.sock:/var/run/docker.sock \
--registration-token GR134894145X_yNa_hwxHsgW4NTZR \
--tag-list "linux,xenial,ubuntu,docker" \
--run-untagged

