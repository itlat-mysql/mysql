USE functions;

-- создание таблицы
CREATE TABLE schedule (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    train VARCHAR(255),
    departed_at DATETIME,
    arrived_at DATETIME
);

-- заполнение таблицы данными
INSERT INTO schedule VALUES 
(1, 'Orient Express', '2023-02-01 17:30:00', '2023-02-03 13:45:00'),
(2, 'Blue Arrow', '2023-03-07 09:15:00', '2023-03-09 22:15:00'),
(3, 'Union Pacific', '2023-03-14 05:00:00', '2023-03-15 18:35:00'),
(4, 'Lone Star', '2023-04-02 02:25:00', '2023-04-04 23:55:00'),
(5, 'Golden Eagle', '2023-04-22 14:05:00', '2023-04-25 02:15:00');