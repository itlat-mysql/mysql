-- создание базы данных (и удаление старой, если таковая имеется)
DROP DATABASE IF EXISTS tables_subqueries;
CREATE DATABASE tables_subqueries;


-- переключение на базу данных
USE tables_subqueries;


-- создание таблиц
CREATE TABLE customers (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    debt DECIMAL(10,2) NOT NULL,
    city VARCHAR(255) NOT NULL
);

CREATE TABLE shops (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    shop_id INT UNSIGNED NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_customer_id FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    CONSTRAINT fk_order_shop_id FOREIGN KEY(shop_id) REFERENCES shops(id) ON DELETE CASCADE
);


-- заполнение таблиц данными
INSERT INTO customers(id, name, debt, city) 
VALUES 
(1, 'John Smith', 120, 'Rīga'),
(2, 'Brandon Adams', 0, 'Liepaja'),
(3, 'Mary Sue', 0, 'Rēzekne'),
(4, 'Paul George', 300, 'Rīga'),
(5, 'Connor MacLeod', 0, 'Daugavpils');


INSERT INTO shops(id, brand, city) 
VALUES 
(1, 'Maxima', 'Rīga'),
(2, 'Lidl', 'Rīga'),
(3, 'Rimi', 'Daugavpils'),
(4, 'Top', 'Liepaja');

INSERT INTO orders(id, customer_id, shop_id, price)
VALUES 
(1,  1, 1, 999.99),
(2,  1, 2, 505.69),
(3,  1, 2, 656.17),
(4,  3, 4, 15.22),
(5,  3, 2, 199.76),
(6,  3, 2, 1059.13),
(7,  4, 1, 236.87),
(8,  4, 1, 517.89),
(9,  5, 3, 1000.0),
(10, 5, 1, 700.11);