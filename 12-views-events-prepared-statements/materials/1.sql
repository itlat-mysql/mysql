DROP DATABASE IF EXISTS views_events_prep_statements;

CREATE DATABASE views_events_prep_statements DEFAULT CHARSET utf8mb4;

USE views_events_prep_statements;

-- создание таблицы persons
CREATE TABLE persons (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    citizenship CHAR(2) NOT NULL,
    personal_code VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL
);

-- создание таблицы accounts
CREATE TABLE accounts (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    person_id INT UNSIGNED NOT NULL,
    status VARCHAR(255) NOT NULL,
    total DECIMAL(20,2),
    currency CHAR(3) NOT NULL,
    CONSTRAINT person_fk FOREIGN KEY(person_id) REFERENCES persons(id)
);

-- создание таблицы payments
CREATE TABLE payments (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    account_id INT UNSIGNED NOT NULL,
    payment_sum DECIMAL(20,2),
    CONSTRAINT account_fk FOREIGN KEY(account_id) REFERENCES accounts(id)
);

-- заполнение данными таблицы persons
INSERT INTO persons VALUES
(1, 'John Smith', 'US', '110789-10345', '+1 23456789'),
(2, 'Andrew Norton', 'FR', '040765-85392', '+33 87654321'),
(3, 'Mary Sue', 'DE', '170199-23467', '+49 43215678');

-- заполнение данными таблицы accounts
INSERT INTO accounts VALUES
(1, 1, 'VIP', 100000, 'USD'),
(2, 2, 'VIP', 999000, 'EUR'),
(3, 2, 'REGULAR', 3500, 'USD'),
(4, 3, 'REGULAR', 50, 'GBP'),
(5, 3, 'REGULAR', 300, 'EUR');

-- заполнение данными таблицы payments
INSERT INTO payments VALUES
(1, 1, 1000),
(2, 2, 3000),
(3, 3, 50),
(4, 4, 10),
(5, 5, 100);