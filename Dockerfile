# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/09/25 16:56:40 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
&&  apt-get -y install wget 

#Installation et configuration de nginx avec ssl
RUN apt-get install -y nginx
COPY config/mywebsite-conf /etc/nginx/sites-available/mywebsite-conf
RUN ln -s /etc/nginx/sites-available/mywebsite-conf /etc/nginx/sites-enabled/mywebsite-conf \
&& rm -rf /etc/nginx/sites-enabled/default 
RUN apt-get install -y openssl \
&&      openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj '/CN=mywebsite' \ 
        -keyout /etc/ssl/private/mywebsite.key -out /etc/ssl/certs/mywebsite.crt


RUN apt-get -y install mariadb-server

RUN apt-get -y install php7.3 \   
                php7.3-fpm \
                php7.3-mysql \
                php-mbstring \
                php-json 
RUN mkdir /var/www/mywebsitecontent
RUN  wget https://wordpress.org/latest.tar.gz \
&&   tar xf latest.tar.gz \
&&   mv wordpress/ /var/www/mywebsitecontent/ \
&&   rm latest.tar.gz 

COPY config/setup.sh ./ 
CMD bash setup.sh