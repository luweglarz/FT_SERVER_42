# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/09/25 15:10:45 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
&&  apt-get install -y openssl \
&&	apt-get install -y nginx 

COPY config/mywebsite-conf /etc/nginx/sites-available/mywebsite-conf
COPY config/setup.sh ./

RUN ln -s /etc/nginx/sites-available/mywebsite-conf /etc/nginx/sites-enabled/mywebsite-conf \
&& rm -rf /etc/nginx/sites-enabled/default 
#&& mkdir -p var/www/mywebsite

#COPY config/index.html var/www/mywebsite

RUN  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/CN=mywebsite' -keyout /etc/ssl/private/mywebsite.key -out /etc/ssl/certs/mywebsite.crt

CMD bash setup.sh