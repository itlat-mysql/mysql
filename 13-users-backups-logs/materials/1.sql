DROP DATABASE IF EXISTS site;

CREATE DATABASE site;

USE site;

CREATE TABLE users (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL
);