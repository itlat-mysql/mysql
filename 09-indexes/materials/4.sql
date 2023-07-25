USE indexes;

CREATE TABLE IF NOT EXISTS single_index_products (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NULL,
    type VARCHAR(255) NOT NULL,
    price DECIMAL(30,2),
    INDEX price_name_idx (price, name)
);

CREATE TABLE IF NOT EXISTS multiple_indices_products (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NULL,
    type VARCHAR(255) NOT NULL,
    price DECIMAL(30,2),
    INDEX price_idx (price),
    INDEX name_idx (name)
);

INSERT INTO single_index_products SELECT * FROM products;

INSERT INTO multiple_indices_products SELECT * FROM products;