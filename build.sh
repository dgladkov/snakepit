#/bin/bash
set -e

docker build ./build -t snakepit-build:latest

docker container create --name extract snakepit-build:latest
trap 'docker container rm -f extract' EXIT
docker container cp extract:/snakes.tar.gz final/

docker build ./final -t snakepit:latest
