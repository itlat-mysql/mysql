-- создание базы данных (и удаление старой, если таковая имеется)
DROP DATABASE IF EXISTS multiple_tables_queries;
CREATE DATABASE multiple_tables_queries;


-- переключение на базу данных
USE multiple_tables_queries;


-- создание таблиц
CREATE TABLE employees (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL
);

CREATE TABLE passports (
    employee_id INT UNSIGNED NULL UNIQUE,
    code VARCHAR(255) NOT NULL,
    nationality VARCHAR(255) NOT NULL,
    age INT UNSIGNED,
    sex VARCHAR(255) NOT NULL,
    CONSTRAINT fk_passport_employee_id FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

CREATE TABLE clients (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE projects (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    client_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_project_employee_id FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE,
    CONSTRAINT fk_project_client_id FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE
);


-- заполнение таблиц данными
INSERT INTO employees(id, name, position) 
VALUES 
(1, 'Barbara Schmidt', 'System Analytic'),
(2, 'Joe D’Amato', 'Android Programmer'),
(3, 'John Smith', 'Web Programmer');

INSERT INTO passports(employee_id, code, nationality, age, sex) 
VALUES 
(1, 's8f8798sdf', 'German', 35, 'woman'),
(2, '98dfg87dg8', 'Italian', 22, 'man'),
(NULL, '8s89sf889', 'Spanish', 18, 'man');

INSERT INTO clients(id, name) 
VALUES 
(1, 'Google'),
(2, 'Apple'),
(3, 'Microsoft');

INSERT INTO projects(name, employee_id, client_id) 
VALUES 
('CMS Development', 1, 2),
('Mobile App Development', 2, 1),
('Site Development', 1, 1);