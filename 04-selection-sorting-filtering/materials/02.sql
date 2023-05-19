-- переключаемся на базу данных selection
USE selection;

-- вставляем в таблицу products две строки (с уже существующими внутри таблицы именами)
INSERT INTO products(name, ean, price, created_at)
VALUES
('Samsung', '5394983', 1199.99, '2023-04-04'),
('Xiaomi', '65322653', 799.99, '2023-05-05');