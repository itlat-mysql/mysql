-- удаление старой базы данных (если она есть)
DROP DATABASE IF EXISTS procedures_and_triggers; 

-- создание новой базы данных
CREATE DATABASE procedures_and_triggers DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE procedures_and_triggers;

-- создание таблицы animals
CREATE TABLE animals (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    breed VARCHAR(255) NOT NULL,
    age INT UNSIGNED NOT NULL,
    food_kg_per_day DECIMAL(20,3)
);

-- заполнение таблицы animals данными
INSERT INTO animals VALUES 
(1, 'Shere Khan', 'Tiger', 8, 12),
(2, 'Bagheera', 'Panther', 6, 7),
(3, 'Father', 'Wolf', 10, 5),
(4, 'Raksha', 'Wolf', 11, 6),
(5, 'Akela', 'Wolf', 15, 7),
(6, 'Baloo', 'Bear', 20, 10),
(7, 'Kaa', 'Python', 7, 2),
(8, 'Hathi', 'Elephant', 42, 15);