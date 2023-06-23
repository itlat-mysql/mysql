-- переключение на используемую базу данных
USE modifications;

-- создание таблицы авторов
CREATE TABLE authors (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255)
);

-- создание таблицы книг
CREATE TABLE books (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	author_id INT UNSIGNED NOT NULL,
	title VARCHAR(255) NOT NULL,
	FOREIGN KEY(author_id) REFERENCES authors (id) ON DELETE RESTRICT ON UPDATE RESTRICT 
);