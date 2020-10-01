rm -f /etc/nginx/sites-available/mywebserv-conf
cp tmp/autoindex-conf /etc/nginx/sites-available/autoindex-conf
ln -s /etc/nginx/sites-available/autoindex-conf /etc/nginx/sites-enabled/autoindex-conf
rm -rf /etc/nginx/sites-enabled/mywebserv-conf
service nginx restart