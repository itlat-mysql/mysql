-- удаление старой базы данных (если она существует)
DROP DATABASE IF EXISTS homework_library_solution;

-- создание новой базы данных
CREATE DATABASE homework_library_solution DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE homework_library_solution;


/*
    СОЗДАНИЕ ТАБЛИЦ
*/

-- имя (firstname), фамилия (lastname), год рождения (birth_year) и год смерти (death_year) автора - уникальная комбинация (чтобы не занести одного автора несколько раз)
-- год рождения (birth_year) и год смерти (death_year) может быть отрицательным (до нашей эры)
-- год смерти (death_year) может равняться NULL (автор пока не умер)
CREATE TABLE authors (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    birth_year INT NOT NULL,
    death_year INT NULL,
    UNIQUE(firstname, lastname, birth_year, death_year)
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- название (title) и год публикации (pub_year) книги - уникальная комбинация (чтобы не занести одну и ту же книгу несколько раз)
CREATE TABLE books (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    pub_year INT NOT NULL,
    reserved BOOLEAN NOT NULL,
    UNIQUE(title, pub_year)
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- book_id представляет собой ссылку на таблицу books (посредством ограничения внешнего ключа через столбец id)
-- author_id представляет собой ссылку на таблицу authors (посредством ограничения внешнего ключа через столбец id)
-- автор (author_id) и написанная им книга (book_id) - первичный ключ - уникальная комбинация (нельзя написать одну и ту же книгу несколько раз)
CREATE TABLE books_authors (
    book_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(book_id) REFERENCES books(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(author_id) REFERENCES authors(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(book_id, author_id)
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- персональный код - уникальное значение (чтобы не занести одного и того же посетителя несколько раз)
CREATE TABLE visitors (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    personal_code VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;

-- book_id представляет собой ссылку на таблицу books (посредством ограничения внешнего ключа через столбец id)
-- visitor_id представляет собой ссылку на таблицу visitors (посредством ограничения внешнего ключа через столбец id)
-- действительная дата возвращение книги (actual_return_date) может равняться NULL, т.к. мы заранее не знаем, когда человек вернет книгу
CREATE TABLE reservations (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    book_id BIGINT UNSIGNED NULL,
    visitor_id BIGINT UNSIGNED NULL,
    reservation_date DATE NOT NULL,
    return_deadline_date DATE NOT NULL,
    actual_return_date DATE NULL,
    FOREIGN KEY(book_id) REFERENCES books(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(visitor_id) REFERENCES visitors(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET utf8mb4;


/*
    ВСТАВКА ДАННЫХ ВО ВСЕ ТАБЛИЦЫ
*/

-- вставка данных в таблицу authors
INSERT INTO authors(id, firstname, lastname, birth_year, death_year) 
VALUES 
(1, 'Джоан', 'Роулинг', 1965, NULL),
(2, 'Илья', 'Ильф', 1897, 1937),
(3, 'Евгений', 'Петров', 1902, 1942),
(4, 'Марк', 'Твен', 1835, 1910),
(5, 'Юлий', 'Цезарь', -100, -44);

-- вставка данных в таблицу books
INSERT INTO books(id, title, pub_year, reserved) 
VALUES 
(1, 'Гарри Поттер и философский камень', 1997, TRUE),
(2, 'Остров мира', 1946, FALSE),
(3, 'Приключения Тома Сойера', 2020, FALSE),
(4, 'Двенадцать стульев', 1974, FALSE),
(5, 'Записки о Галльской войне', 1985, FALSE);

-- вставка данных в таблицу books_authors
INSERT INTO books_authors(author_id, book_id)
VALUES
(1, 1), -- Джоан Роулинг (1) написала "Гарри Поттер и философский камень" (1)
(2, 4), -- Илья Ильф (2) написал "Двенадцать стульев" (4)
(3, 4), -- Евгений Петров (3) написал "Двенадцать стульев" (4)
(3, 2), -- Евгений Петров (3) написал "Остров мира" (2)
(4, 3), -- Марк Твен написал (4) "Приключения Тома Сойера" (3)
(5, 5); -- Юлий Цезарь (5) написал "Записки о Галльской войне" (5)

-- вставка данных в таблицу visitors
INSERT INTO visitors(id, firstname, lastname, personal_code)
VALUES
(1, 'Мэри', 'Сью', '126356-1263126'),
(2, 'Джон', 'Смит', '526351-5263121'),
(3, 'Янис', 'Берзиньш', '426352-4263122'),
(4, 'Иван', 'Иванов', '226354-2263124'),
(5, 'Мария', 'Петрова', '126355-1263125');

-- вставка данных в таблицу reservations
INSERT INTO reservations(visitor_id, book_id, reservation_date, return_deadline_date, actual_return_date)
VALUES
(5, 4, '2023-01-01', '2023-01-15', '2023-01-10'), -- Мария Петрова (5) взяла "Двенадцать стульев" (4) - вернула вовремя
(3, 5, '2023-01-07', '2023-01-21', '2023-01-20'), -- Янис Берзиньш (3) взял "Записки о Галльской войне" (5) - вернул вовремя
(4, 1, '2023-01-08', '2023-01-22', '2023-01-24'), -- Иван Иванов (4) взял "Гарри Поттер и философский камень" (1) - просрочил
(1, 3, '2023-01-28', '2023-02-11', '2023-02-05'), -- Мэри Сью (1) взяла взял "Приключения Тома Сойера" (3) - вернула вовремя
(2, 4, '2023-02-03', '2023-02-17', '2023-02-22'), -- Джон Смит (2) взял "Двенадцать стульев" (4) - просрочил
(1, 1, '2023-02-05', '2023-02-19', NULL);         -- Мэри Сью (1) взяла "Гарри Поттер и философский камень" (1) - ещё читает


/*
    ВЫБОРКА ДАННЫХ ИЗ ВСЕХ ТАБЛИЦ
*/

-- выборка данных из таблицы authors
SELECT id, firstname, lastname, birth_year, death_year FROM authors;

-- выборка данных из таблицы books
SELECT id, title, pub_year, reserved FROM books;

-- выборка данных из таблицы books_authors
SELECT book_id, author_id FROM books_authors;

-- выборка данных из таблицы visitors
SELECT id, firstname, lastname, personal_code FROM visitors;

-- выборка данных из таблицы reservations
SELECT id, book_id, visitor_id, reservation_date, return_deadline_date, actual_return_date FROM reservations;


/*
    ПРИМЕРЫ ЗАПРОСОВ НА ПОЛУЧЕНИЕ ДАННЫХ ИЗ НЕСКОЛЬКИХ ТАБЛИЦ ОДНОВРЕМЕННО (МЫ ПОКА НЕ ПРОХОДИЛИ ЭТИ ТЕМЫ, НО ПОЛЕЗНО ПОСМОТРЕТЬ РЕАЛЬНЫЕ ВОЗМОЖНОСТИ MYSQL).
*/

-- получение всех книг всех авторов
SELECT a.firstname, a.lastname, b.title, b.pub_year
FROM authors a 
LEFT JOIN books_authors ba ON a.id = ba.author_id
LEFT JOIN books b ON ba.book_id = b.id; 

-- получение всех книг, которые заказывали посетители
SELECT v.firstname, v.lastname, b.title, bk.reservation_date
FROM visitors v 
LEFT JOIN reservations bk ON v.id = bk.visitor_id
LEFT JOIN books b ON bk.book_id = b.id;