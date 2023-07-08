-- удаляем старую базу данных orders (если она существует)
DROP DATABASE IF EXISTS orders;

-- создаем новую базу данных orders
CREATE DATABASE orders DEFAULT CHARSET utf8mb4;

-- переключаемся на новую базу данных orders
USE orders;

-- создание таблицы clients
CREATE TABLE clients (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- создание таблицы orders
CREATE TABLE orders (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT UNSIGNED NOT NULL,
    reference VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(20,2) NOT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- создание таблицы statuses
CREATE TABLE statuses (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    order_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- заполнение таблицы clients
INSERT INTO clients (id, name, type) VALUES
(1, 'John Silver', 'LEGAL PERSON'),
(2, 'Mary Adams', 'PHYSICAL PERSON'),
(3, 'Peter Hawk', 'LEGAL PERSON'),
(4, 'Helen Carter', 'PHYSICAL PERSON');

-- заполнение таблицы orders
INSERT INTO orders (id, client_id, reference, price, created_at) VALUES
(1,  1, '64a4655ad2082', 99.99, '2023-05-01 00:00:00'),
(2,  2, '64a46562cb60e', 77.21, '2023-05-02 00:00:00'),
(3,  3, '64a46577585bd', 15.75, '2023-05-03 00:00:00'),
(4,  4, '64a4657b55320', 49.49, '2023-05-04 00:00:00'),
(5,  1, '64a4657ed5c6a', 50.62, '2023-05-05 00:00:00'),
(6,  2, '64a465825852c', 27.43, '2023-05-06 00:00:00'),
(7,  3, '64a465869bf04', 84.33, '2023-05-07 00:00:00'),
(8,  4, '64a4658a72c19', 63.72, '2023-05-08 00:00:00'),
(9,  1, '64a4658db6cf7', 99.99, '2023-05-09 00:00:00'),
(10, 2, '64a46592755df', 45.70, '2023-05-10 00:00:00'),
(11, 3, '64a4659571662', 32.17, '2023-05-11 00:00:00'),
(12, 4, '64a465990cefb', 13.88, '2023-05-12 00:00:00');

-- заполнение таблицы statuses
INSERT INTO statuses (
    id, name, order_id, created_at
) VALUES
(1,  'PLACED',    1,  '2023-05-01 00:00:00'),
(2,  'CONFIRMED', 1,  '2023-05-01 00:12:00'),
(3,  'DELIVERED', 1,  '2023-05-01 05:23:00'),
(4,  'PLACED',    2,  '2023-05-02 00:00:00'),
(5,  'CONFIRMED', 2,  '2023-05-02 00:15:00'),
(6,  'DELIVERED', 2,  '2023-05-02 06:47:00'),
(7,  'PLACED',    3,  '2023-05-03 00:00:00'),
(8,  'CONFIRMED', 3,  '2023-05-03 00:19:00'),
(9,  'DELIVERED', 3,  '2023-05-03 05:55:00'),
(10, 'PLACED',    4,  '2023-05-04 00:00:00'),
(11, 'CONFIRMED', 4,  '2023-05-04 00:22:00'),
(12, 'DELIVERED', 4,  '2023-05-04 07:13:00'),
(13, 'PLACED',    5,  '2023-05-05 00:00:00'),
(14, 'CONFIRMED', 5,  '2023-05-05 00:25:00'),
(15, 'DELIVERED', 5,  '2023-05-05 07:56:00'),
(16, 'PLACED',    6,  '2023-05-06 00:00:00'),
(17, 'CONFIRMED', 6,  '2023-05-06 00:27:00'),
(18, 'DELIVERED', 6,  '2023-05-06 06:34:00'),
(19, 'PLACED',    7,  '2023-05-07 00:00:00'),
(20, 'CONFIRMED', 7,  '2023-05-07 00:43:00'),
(21, 'DELIVERED', 7,  '2023-05-07 09:22:00'),
(22, 'PLACED',    8,  '2023-05-08 00:00:00'),
(23, 'CONFIRMED', 8,  '2023-05-08 00:37:00'),
(24, 'DELIVERED', 8,  '2023-05-08 09:02:00'),
(25, 'PLACED',    9,  '2023-05-09 00:00:00'),
(26, 'CONFIRMED', 9,  '2023-05-09 00:40:00'),
(27, 'DELIVERED', 9,  '2023-05-09 08:17:00'),
(28, 'PLACED',    10, '2023-05-10 00:00:00'),
(29, 'CONFIRMED', 10, '2023-05-10 00:07:00'),
(30, 'DELIVERED', 10, '2023-05-10 12:34:00'),
(31, 'PLACED',    11, '2023-05-11 00:00:00'),
(32, 'CONFIRMED', 11, '2023-05-11 00:05:00'),
(33, 'DELIVERED', 11, '2023-05-11 14:16:00'),
(34, 'PLACED',    12, '2023-05-12 00:00:00'),
(35, 'CONFIRMED', 12, '2023-05-12 00:06:00'),
(36, 'DELIVERED', 12, '2023-05-12 15:24:00');