#!/bin/bash
docker run -d --network=reddit --network-alias=post_db2 --network-alias=comment_db2 mongo:5.0
docker run -d --network=reddit --network-alias=post2 -e POST_DATABASE_HOST='post_db2' coolf124/post:1.0
docker run -d --network=reddit --network-alias=comment2 -e COMMENT_DATABASE_HOST='comment_db2' coolf124/comment:1.0
docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST='post2' -e COMMENT_SERVICE_HOST='comment2' coolf124/ui:1.0
