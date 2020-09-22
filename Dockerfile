FROM debian:buster

RUN apt-get update -yq \
&&	apt-get install -y nginx \
