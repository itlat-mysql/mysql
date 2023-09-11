USE views_events_prep_statements;

-- создание таблицы sessions
CREATE TABLE sessions (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    logged_in DATETIME NOT NULL
);

-- создание таблицы transactions
CREATE TABLE transactions (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total_sum DECIMAL(20,2) NOT NULL,
    paid_at DATETIME NOT NULL
);

-- создание таблицы accounting
CREATE TABLE accounting (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    all_tansactions_sum DECIMAL(20,2) NOT NULL,
    calculated_at DATETIME NOT NULL
);