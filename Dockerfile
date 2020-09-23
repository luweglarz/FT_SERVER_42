# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lweglarz <lweglarz@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/23 13:43:47 by lweglarz          #+#    #+#              #
#    Updated: 2020/09/23 15:33:21 by lweglarz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
&&  apt-get wget \
&&	apt-get install -y nginx

ADD  /config/nginx.conf /etc/nginx/sites-available/mywebsite

RUN apt-get -y install mariadb-server

RUN service nginx start

EXPOSE 80
EXPOSE 443

CMD [ "executable" ]