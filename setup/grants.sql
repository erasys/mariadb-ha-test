CREATE DATABASE maxscale_schema;

CREATE USER 'maxscale'@'localhost';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'localhost' IDENTIFIED BY 'maxscale';
GRANT SELECT ON mysql.* TO 'maxscale'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON maxscale_schema.* TO 'maxscale'@'localhost';

CREATE USER 'maxscale'@'%';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'%' IDENTIFIED BY 'maxscale';
GRANT SELECT ON mysql.* TO 'maxscale'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON maxscale_schema.* TO 'maxscale'@'%';


CREATE USER 'replmon'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'replmon'@'%' IDENTIFIED BY 'replmon';


CREATE USER 'replicator'@'%';
GRANT RELOAD, SUPER, REPLICATION SLAVE, EVENT, TRIGGER ON *.* TO 'replicator'@'%' IDENTIFIED BY 'replicator';
GRANT SELECT, EXECUTE, CREATE TEMPORARY TABLES ON *.* TO 'replicator'@'%';

CREATE USER 'stress'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON *.* TO 'stress'@'%' IDENTIFIED BY 'stress';
