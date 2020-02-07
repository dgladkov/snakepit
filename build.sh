#/bin/bash
set -e

docker build . -t snakepit-build:latest

docker container create --name extract snakepit-build:latest
trap 'docker container rm -f extract' EXIT
docker container cp extract:/snakes.tar.gz .

docker build . -t snakepit:latest
