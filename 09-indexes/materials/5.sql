USE indexes;

TRUNCATE multiple_indices_products;

INSERT INTO multiple_indices_products (id, name, code, type, price) VALUES
(1, 'Pinocchio', 'a00c1', 'book', 150),
(2, 'Robinson Crusoe', 'a00c2', 'book', 125),
(3, 'Tom Sawyer', 'a00c3', 'book', 225),
(4, 'The Lord of the Rings', 'a00c4', 'book', 80),
(5, 'The Jungle Book', 'a00c6', 'book', 25),
(6, 'Treasure Island', 'a00c7', 'book', 220),
(7, 'Harry Potter', 'a00c8', 'book', 50);