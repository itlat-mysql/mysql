DROP DATABASE IF EXISTS functions;

CREATE DATABASE functions DEFAULT CHARSET utf8mb4;

USE functions;

-- создание таблицы
CREATE TABLE students (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    admission_date DATE,
    scholarship DECIMAL(20, 6),
    age TINYINT UNSIGNED,  
    avg_mark DECIMAL(20, 6)
) DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_0900_as_cs;

-- заполнение таблицы данными
INSERT INTO students VALUES 
(1, ' Britney Baker ', '2022-09-06', 1000, 21, 8.8),
(2, 'Fang Yu', '2022-08-05', 1200, 17, 9.5),
(3, 'Иван Иванов', '2022-07-18', 900, 25, 7.9),
(4, 'Dolores Rivera ', '2022-04-22', 800, 23, 8.4),
(5, ' adriano Caruso', '2022-10-25', 500, 20, 6.3),
(6, 'Katrin Roth', '2023-03-03', 0, 18, NULL);