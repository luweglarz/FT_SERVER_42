# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/09/25 15:47:49 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y 

#Installation et configuration de nginx avec ssl
RUN apt-get install -y nginx
COPY config/mywebsite-conf /etc/nginx/sites-available/mywebsite-conf
RUN ln -s /etc/nginx/sites-available/mywebsite-conf /etc/nginx/sites-enabled/mywebsite-conf \
&& rm -rf /etc/nginx/sites-enabled/default 
RUN apt-get install -y openssl \
&&      openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj '/CN=mywebsite' \ 
        -keyout /etc/ssl/private/mywebsite.key -out /etc/ssl/certs/mywebsite.crt

COPY config/setup.sh ./
CMD bash setup.sh