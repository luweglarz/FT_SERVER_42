rm -f /etc/nginx/sites-available/autoindex-conf
cp tmp/mywebserv-conf /etc/nginx/sites-available/mywebserv-conf
ln -s /etc/nginx/sites-available/mywebserv-conf /etc/nginx/sites-enabled/mywebserv-conf
rm -rf /etc/nginx/sites-enabled/autoindex-conf
service nginx restart