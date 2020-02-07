FROM ubuntu:18.04

ENV LANG="C.UTF-8"

RUN apt-get update
RUN apt-get install -yy --no-install-recommends \
	ca-certificates \
	file \
	libexpat1 \
	libmagic-mgc \
	libmagic1 \
	libmpdec2 \
	libreadline7 \
	libsqlite3-0 \
	libssl1.0 \
	mime-support \
	readline-common \
	xz-utils

COPY snakes.tar.gz .
RUN tar xf snakes.tar.gz
RUN rm -rf snakes.tar.gz
