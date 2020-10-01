# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/10/01 15:22:02 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
&&  apt-get -y install wget 

#Installation et configuration de nginx avec ssl
RUN apt-get install -y nginx
COPY srcs/autoindex-conf /tmp
COPY srcs/mywebserv-conf /etc/nginx/sites-available/mywebserv-conf
RUN ln -s /etc/nginx/sites-available/mywebserv-conf /etc/nginx/sites-enabled/mywebserv-conf \
&& cp /etc/nginx/sites-enabled/mywebserv-conf /tmp \
&& rm -rf /etc/nginx/sites-enabled/default 
RUN apt-get install -y openssl \
&&      openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -subj '/CN=mywebsite' \ 
        -keyout /etc/ssl/private/mywebserv.key -out /etc/ssl/certs/mywebserv.crt

RUN mkdir /var/www/mywebservcontent

#Installation de php et ses differents module
RUN apt-get -y install php7.3 \   
                php7.3-fpm \
                php7.3-mysql \
                php-mbstring \
                php-json 


RUN apt-get -y install mariadb-server

#Installation de Wordpress
RUN wget https://wordpress.org/latest.tar.gz \
&&  tar xf latest.tar.gz \
&&  mv wordpress/ /var/www/mywebservcontent/ \
&&  rm latest.tar.gz 
COPY srcs/wp-config.php var/www/mywebservcontent/wordpress

#Installation de phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz \
&&  tar -xf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
&&  mv phpMyAdmin-4.9.0.1-all-languages /var/www/mywebservcontent/phpmyadmin \
&&  rm phpMyAdmin-4.9.0.1-all-languages.tar.gz 
COPY srcs/config.inc.php var/www/mywebservcontent/phpmyadmin

COPY srcs/mysqlsetup.sh ./
RUN bash mysqlsetup.sh

COPY srcs/autoindex.sh ./
COPY srcs/reset.sh ./
CMD	service mysql restart; \
	service nginx start; \
	service php7.3-fpm start; \
        bash 