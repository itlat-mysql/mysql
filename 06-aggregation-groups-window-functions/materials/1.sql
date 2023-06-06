-- создание базы данных (и удаление старой, если таковая имеется)
DROP DATABASE IF EXISTS aggregation;
CREATE DATABASE aggregation;

-- переключение на базу данных
USE aggregation;

-- создание таблиц
CREATE TABLE workers (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    nationality VARCHAR(255),
    sex VARCHAR(255),
    salary DECIMAL(10,2)
);

CREATE TABLE tasks (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255)
);

CREATE TABLE workers_tasks (
    worker_id BIGINT UNSIGNED NOT NULL,
    task_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(worker_id) REFERENCES workers(id) ON DELETE CASCADE,
    FOREIGN KEY(task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    PRIMARY KEY(worker_id, task_id)
);

-- заполнение таблиц данными
INSERT INTO workers(id, name, department, nationality, sex, salary)
VALUES
(1, 'Eleonore Bergmann',  'Head Office', 'German', 'woman', 7800),
(2, 'Ennio Salieri',  'Development', 'Italian', 'man', 5200),
(3, NULL,  'Head Office', 'American', 'woman', 5100),
(4, 'John Smith',  'Sales', 'Canadian', 'man', 2300),
(5, 'Helene Kempf', 'Development', 'German', 'woman', 900),
(6, 'Anna Johnson',  'Sales', 'American', 'woman', 1100),
(7, 'Tommy Angelo',  'Sales', 'Italian', 'man', 3700),
(8, 'Rosa Hawkins',  'Development', 'American', 'woman', 2300),
(9, 'Frank Colletti',  'Head Office', 'Italian', 'man', 4874),
(10, 'Johan Hofmann', 'Sales', 'German', 'man', 2700);

INSERT INTO tasks(id, title) VALUES (1, 'Accounting Automatization'), (2, 'AI Algorithms Design'), (3, 'Site Development');

INSERT INTO workers_tasks (worker_id, task_id) VALUES (1, 1), (2, 2), (3, 2), (4, 1), (5, 3), (6, 1), (7, 1), (8, 3), (9, 2), (10, 1), (1, 2), (1, 3);
