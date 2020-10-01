service mysql start
mysql -u root -e "CREATE USER 'admin'@'localhost' identified by 'pass';";
mysql -u root -e "CREATE DATABASE wordpress";
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' WITH GRANT OPTION;";
mysql -u root -e "FLUSH PRIVILEGES;";