#!/bin/bash
#Show reddit_gitlab containers
sudo docker ps --filter name=reddit_gitlab*
# Stop containers
sudo docker stop $(sudo docker ps --filter name=reddit_gitlab* -q)
# Remove containers
sudo docker rm $(sudo docker ps --filter name=reddit_gitlab* -qa)

