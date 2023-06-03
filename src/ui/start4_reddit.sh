#!/bin/bash
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db2:/data/db mongo:5.0
docker run -d --network=reddit --network-alias=post coolf124/post:1.0
docker run -d --network=reddit --network-alias=comment coolf124/comment:1.0
docker run -d --network=reddit -p 9292:9292 coolf124/ui:1.0
