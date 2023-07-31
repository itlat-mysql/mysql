USE functions;

-- создание таблицы
CREATE TABLE materials (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    width DECIMAL(20, 6),
    height DECIMAL(20, 6),
    length DECIMAL(20, 6),
    price DECIMAL(20, 6),
    quantity INTEGER
);

-- заполнение таблицы данными
INSERT INTO materials VALUES 
(1, 'Wood Beam', 15, 7, 300, 30.56, 300),
(2, 'Iron Rod', 3, 3, 600, 35.12, 500),
(3, 'Brick', 12, 6.5, 25, -5.68, 280),
(4, 'Block', 30, 25, 60, 40.79, 650),
(5, 'Plank', 10, 4, 225, 20.50, 180);