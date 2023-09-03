-- переключение на базу данных
USE procedures_and_triggers;

-- создание таблицы clients
CREATE TABLE IF NOT EXISTS clients (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    status VARCHAR(255) NOT NULL
);

-- создание таблицы clients_log
CREATE TABLE IF NOT EXISTS clients_log (
    id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    action VARCHAR(255) NOT NULL,
    modified_at DATETIME NOT NULL
);

-- создание таблицы coupons
CREATE TABLE IF NOT EXISTS coupons (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT UNSIGNED NOT NULL,
    discount DECIMAL(20,2)
);