-- Create databases
CREATE DATABASE IF NOT EXISTS `bookstack`;
CREATE DATABASE IF NOT EXISTS `bookstack-test`;

-- Create users
CREATE USER IF NOT EXISTS 'bookstack'@'%' IDENTIFIED BY 'bookstack';
CREATE USER IF NOT EXISTS 'bookstack-test'@'%' IDENTIFIED BY 'bookstack-test';

-- Grant rights
GRANT ALL PRIVILEGES ON `bookstack`.* to 'bookstack'@'%';
GRANT ALL PRIVILEGES ON `bookstack-test`.* TO 'bookstack-test'@'%';
FLUSH PRIVILEGES;
