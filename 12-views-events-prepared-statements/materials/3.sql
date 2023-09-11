USE views_events_prep_statements;

-- создание таблицы admins
CREATE TABLE admins (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- заполнение данными таблицы admins
INSERT INTO admins (login, password) 
VALUES 
('john.smith@gmail.com', 'abacaba'),
('alex.kova@gmail.com', '1a2b3c');