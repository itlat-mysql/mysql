-- удаляем базу данных selection если она существует
DROP DATABASE IF EXISTS selection;

-- создаем новую базу данных selection
CREATE DATABASE selection DEFAULT CHARSET utf8mb4;

-- переключаемся на базу данных selection
USE selection;

-- создаем таблицу products
CREATE TABLE products(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    ean VARCHAR(255),
    price DECIMAL(20,2),
    created_at DATE NOT NULL
);

-- вставляем в таблицу products три строки
INSERT INTO products(name, ean, price, created_at)
VALUES
('iPhone', '74748484', 999.99, '2023-01-01'),
('Samsung', '9393983', 1099.99, '2023-02-02'),
('Xiaomi', '35333653', 899.99, '2023-03-03');