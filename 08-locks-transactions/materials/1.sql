CREATE DATABASE locks_and_transactions;

USE locks_and_transactions;

CREATE TABLE accounts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	total DECIMAL(30,2) NOT NULL
);

CREATE TABLE payments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	from_account_id INT UNSIGNED NOT NULL,
	to_account_id INT UNSIGNED NOT NULL,
	payment_sum DECIMAL(30,2) NOT NULL,
	FOREIGN KEY(from_account_id) REFERENCES accounts(id),
	FOREIGN KEY(to_account_id) REFERENCES accounts(id)
);

INSERT INTO accounts
VALUES
(1, 'John Smith', 10000),
(2, 'Mary Sue', 20000),
(3, 'Michael Adams', 30000);