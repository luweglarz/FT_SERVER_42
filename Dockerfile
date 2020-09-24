# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/09/24 16:24:40 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
&&  apt-get install -y wget \
&&	apt-get install -y nginx \
&&  apt-get -y install mariadb-server

COPY config/mywebsite-conf /etc/nginx/sites-available/mywebsite-conf

RUN ln -s /etc/nginx/sites-available/mywebsite-conf /etc/nginx/sites-enabled/mywebsite-conf \
&& rm -rf /etc/nginx/sites-enabled/default

RUN  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=mywebsite' -keyout /etc/ssl/private/mywebsite.key -out /etc/ssl/certs/mywebsite.crt

RUN service nginx start 
