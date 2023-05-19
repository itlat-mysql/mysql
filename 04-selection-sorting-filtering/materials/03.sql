-- переключаемся на базу данных selection
USE selection;

-- вставляем в таблицу products одну строку (с NULL в качестве значения столбца ean)
INSERT INTO products(name, ean, price, created_at) VALUES
('Nokia', NULL, 950.99, '2023-06-06');