-- удаление старой базы данных (если она существует)
DROP DATABASE IF EXISTS modifications;

-- создание новой базы данных
CREATE DATABASE modifications DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE modifications;

-- создание таблицы гостей
CREATE TABLE guests (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	visit_date DATE,
	total_paid DECIMAL(20,2) DEFAULT 0
);

-- создание таблицы клиентов
CREATE TABLE clients (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	verified BOOLEAN NOT NULL,
	created_at DATE
);
