CREATE USER 'repl'@'%' IDENTIFIED BY 'pass';
GRANT REPLICATION SLAVE ON *.* TO 'repl';

CREATE USER 'maxscale'@'%' IDENTIFIED BY 'pass';
GRANT SELECT ON mysql.user TO 'maxscale'@'%';
GRANT SELECT ON mysql.db TO 'maxscale'@'%';
GRANT SELECT ON mysql.tables_priv TO 'maxscale'@'%';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'%';
GRANT REPLICATION CLIENT ON *.* TO 'maxscale'@'%';

CREATE USER 'healthcheck'@'localhost' IDENTIFIED BY 'healthcheck';
GRANT SHOW DATABASES ON *.* to 'healthcheck'@'localhost';
flush privileges;
