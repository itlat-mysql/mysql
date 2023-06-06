-- создание базы данных (и удаление старой, если таковая имеется)
DROP DATABASE IF EXISTS window_functions;
CREATE DATABASE window_functions;

-- переключение на базу данных
USE window_functions;

-- создание таблицы
CREATE TABLE devices(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    quantity INT UNSIGNED,
    price DECIMAL(10, 2),
    c_year YEAR
);

-- заполнение таблицы данными
INSERT INTO devices(id, name, type, quantity, price, c_year)
VALUES 
(1, 'Apple Mac Mini M2', 'Computer', 3, 969, 2019),
(2, 'Microsoft Surface', 'Tablet', 2, 455, 2021),
(3, 'Samsung Odyssey', 'Monitor', 4, 227, 2022),
(4, 'Lenovo Legion T7', 'Computer', 2, 815, 2019),
(5, 'Nokia T20', 'Tablet', 3, 408, 2023),
(6, 'Philips Envia 34M', 'Monitor', 5, 327, 2022),
(7, 'Huawei MatePad', 'Tablet', 2, 473, 2021),
(8, 'Dell Precision 3660', 'Computer', 1, 878, 2022),
(9, 'Acer Nitro 50', 'Computer', 7, 928, 2021),
(10, 'LG UltraWide 49W', 'Monitor', 4, 289, 2019);
