On Windows

you need to convert your line ends before running the script

sed -i.bak 's/\r$//' docker-entrypoint.sh
sed -i.bak 's/\r$//' healthcheck.sh


Import initial tables into MariaDB

in MariaDB container:

mysql -ufouroneone -pfouroneone fouroneone < 01-fouroneoned_db.sql


Intial migration

from fouroneone container

php -f bin/migration.php
php -f bin/create_site.php
php -f bin/create_user.php
php -f init