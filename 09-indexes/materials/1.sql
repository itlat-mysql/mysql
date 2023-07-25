DROP DATABASE IF EXISTS indexes;

CREATE DATABASE indexes DEFAULT CHARSET utf8mb4;

USE indexes;

CREATE TABLE products (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NULL,
    type VARCHAR(255) NOT NULL,
    price DECIMAL(30,2),
    INDEX(name) -- объявление индекса
);