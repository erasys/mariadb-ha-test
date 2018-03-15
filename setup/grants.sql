CREATE DATABASE IF NOT EXISTS maxscale_schema;

CREATE USER IF NOT EXISTS 'maxscale'@'localhost';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'localhost' IDENTIFIED BY 'maxscale';
GRANT SELECT ON mysql.* TO 'maxscale'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON maxscale_schema.* TO 'maxscale'@'localhost';

CREATE USER IF NOT EXISTS 'maxscale'@'%';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'%' IDENTIFIED BY 'maxscale';
GRANT SELECT ON mysql.* TO 'maxscale'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON maxscale_schema.* TO 'maxscale'@'%';


CREATE USER IF NOT EXISTS 'replmon'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'replmon'@'%' IDENTIFIED BY 'replmon';


CREATE USER IF NOT EXISTS 'replicator'@'%';
GRANT RELOAD, SUPER, REPLICATION SLAVE, EVENT, TRIGGER ON *.* TO 'replicator'@'%' IDENTIFIED BY 'replicator';
GRANT SELECT, EXECUTE, CREATE TEMPORARY TABLES ON *.* TO 'replicator'@'%';

CREATE USER IF NOT EXISTS 'stress'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON *.* TO 'stress'@'%' IDENTIFIED BY 'stress';
