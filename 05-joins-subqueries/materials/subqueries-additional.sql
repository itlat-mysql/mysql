-- создание старую базу данных (если она существует)
DROP DATABASE IF EXISTS bookings;

-- создание базы данных резерваций
CREATE DATABASE bookings DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE bookings;

-- создание таблицы доступных квартир
CREATE TABLE apartments (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_iso CHAR(2)  NOT NULL,
    city VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    rooms INT UNSIGNED NOT NULL,
    has_internet BOOLEAN NOT NULL,
    has_tv BOOLEAN NOT NULL,
    has_kitchen BOOLEAN NOT NULL,
    has_shower BOOLEAN NOT NULL,
    animals_allowed BOOLEAN NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- создание таблицы клиентов
CREATE TABLE clients (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- создание таблицы резерваций
CREATE TABLE bookings (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    apartment_id BIGINT UNSIGNED,
    client_id BIGINT UNSIGNED,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price_total DECIMAL(10,2) NOT NULL,
    price_per_day DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (apartment_id) REFERENCES apartments(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

-- создание таблицы отзывов
CREATE TABLE reviews (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT UNSIGNED NOT NULL,
    rating INT UNSIGNED CHECK(rating >= 1 AND rating <= 10),
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON UPDATE CASCADE ON DELETE CASCADE 
) ENGINE=InnoDB;

-- заполнение таблицы доступных квартир
INSERT INTO apartments (
    id, country_iso, city, address, rooms, has_internet, has_tv, has_kitchen, has_shower, animals_allowed, price_per_day
) VALUES
(1, 'LV', 'Riga', 'Brivibas st., 140', 2, TRUE, FALSE, TRUE, TRUE, FALSE, 100.0),
(2, 'LV', 'Riga', 'Maskavas st., 19',  1, FALSE, TRUE, FALSE, TRUE, FALSE, 50.0),
(3, 'LT', 'Vilnius', 'Laisves pr., 75', 3, TRUE, TRUE, TRUE, TRUE, TRUE, 300.0),
(4, 'LT', 'Vilnius', 'Konstitucijos pr., 34', 1, FALSE, FALSE, FALSE, FALSE, TRUE, 20.0),
(5, 'EE', 'Tallinn', 'Tonismagi st., 10', 2, TRUE, FALSE, TRUE, TRUE, TRUE, 170.0),
(6, 'EE', 'Tallinn', 'Magdaleena st., 3', 2, TRUE, FALSE, FALSE, TRUE, FALSE, 140.0);

-- заполнение таблицы клиентов
INSERT INTO clients (
    id, name, phone, email
) VALUES 
(1, 'John Smith', '+371 123456789', 'jsmith@gmail.com'),
(2, 'Anna Bowman', '+371 987654321', 'abowman@gmail.com'),
(3, 'Ivan Ivanov', '+371 543216789', 'iivanov@gmail.com'),
(4, 'Irina Petrova', '+371 678954321', 'ipetrova@gmail.com');

-- заполнение таблицы резерваций
INSERT INTO bookings (
    id, apartment_id, client_id, start_date, end_date, price_total, price_per_day
) VALUES 
(1, 2, 2, '2023-02-02', '2023-02-04', 150.0, 50.0),
(2, 3, 4, '2023-02-05', '2023-02-06', 500.0, 250.0),
(3, 1, 3, '2023-02-11', '2023-02-11', 100.0, 100.0),
(4, 4, 1, '2023-02-17', '2023-02-21', 100.0, 20.0),
(5, 1, 3, '2023-03-07', '2023-03-09', 300.0, 100.0),
(6, 2, 4, '2023-03-22', '2023-03-29', 400.0, 50.0),
(7, 5, 3, '2023-04-01', '2023-04-03', 510.0, 170.0),
(8, 1, 1, '2023-04-19', '2023-04-24', 600.0, 100.0),
(9, 3, 2, '2023-04-28', '2023-04-29', 500.0, 250.0);

-- заполнение таблицы отзывов
INSERT INTO reviews (
    id, booking_id, rating
) VALUES 
(1, 1, 3),
(2, 2, 5),
(3, 3, 4),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 7, 2),
(8, 8, 4),
(9, 9, 5);