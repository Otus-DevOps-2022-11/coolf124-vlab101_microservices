#!/bin/bash
#add gitlab runner
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlabrunner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest

#зарегистрировать gitlab-runner
docker exec -it gitlab-runner gitlab-runner register \
--url http://62.84.125.180/ \
--non-interactive \
--locked=false \
--name DockerRunner \
--executor docker \
--docker-image alpine:latest \
--registration-token GR134894145X_yNa_hwxHsgW4NTZR \
--tag-list "linux,xenial,ubuntu,docker" \
--run-untagged
