DROP DATABASE IF EXISTS js_messages;

CREATE DATABASE js_messages DEFAULT CHARSET utf8mb4;

USE js_messages;

CREATE TABLE IF NOT EXISTS messages (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content LONGTEXT
) ENGINE=InnoDB;