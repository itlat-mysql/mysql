DROP DATABASE IF EXISTS company;

DROP DATABASE IF EXISTS documents;

CREATE DATABASE company;

CREATE DATABASE documents;

CREATE TABLE company.employees(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255)
);

CREATE TABLE company.salaries(
	employee_id INT UNSIGNED NOT NULL,
	salary DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES company.employees(id)
);

CREATE TABLE documents.documents(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	content TEXT
);

INSERT INTO company.employees VALUES (1, 'John Smith'), (2, 'Mary Sue');

INSERT INTO company.salaries VALUES (1, 1000), (2, 1200);

INSERT INTO documents.documents VALUES (1, 'Important Document 1'), (2, 'Important Document 2');