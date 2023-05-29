-- удаление старой базы данных (если она существует)
DROP DATABASE IF EXISTS joins_homework_solution;

-- создание новой базы данных
CREATE DATABASE joins_homework_solution;

-- переключение на новую базу данных
USE joins_homework_solution;


/*
    СОЗДАНИЕ ТАБЛИЦ
*/

-- создание таблицы преподавателей
CREATE TABLE teachers(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    personal_code VARCHAR(255) NOT NULL UNIQUE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- создание таблицы студентов
CREATE TABLE students(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    personal_code VARCHAR(255) NOT NULL UNIQUE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- создание таблицы курсов
CREATE TABLE courses(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL UNIQUE
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- создание таблицы, соединяющей курсы и студентов
CREATE TABLE courses_students(
    course_id BIGINT UNSIGNED NOT NULL,
    student_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(course_id, student_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- создание таблицы, соединяющей курсы и преподавателей
CREATE TABLE courses_teachers(
    course_id BIGINT UNSIGNED NOT NULL,
    teacher_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(course_id, teacher_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*
    ДОБАВЛЕНИЕ ДАННЫХ В ТАБЛИЦЫ
*/

-- добавление данных в таблицу преподавателей
INSERT INTO teachers(id, name, personal_code)
VALUES
(1, 'Ivan Ivanov', '451237'),
(2, 'Boris Petrov', '572812'),
(3, 'Anna Nikolayeva', '913792'),
(4, 'Elena Grigoryeva', '147098'),
(5, 'Yekaterina Kuznecova', '510721');

-- добавление данных в таблицу студентов
INSERT INTO students(id, name, personal_code)
VALUES
(1, 'Sergey Kotov', '854389'),
(2, 'Yevgeniy Zaharov', '913543'),
(3, 'Alexandr Sidorov', '213456'),
(4, 'Vadim Sumkin', '790123'),
(5, 'Nikolay Smirnov', '751678');

-- добавление данных в таблицу курсов
INSERT INTO courses(id, name, code)
VALUES
(1, 'MySQL', '321'),
(2, 'Python', '913'),
(3, 'Java', '456');

-- добавление данных в таблицу, соединяющую курсы и студентов
INSERT INTO courses_students(course_id, student_id)
VALUES
(2,5),
(3,1),
(1,4),
(2,4),
(1,2);

-- добавление данных в таблицу, соединяющую курсы и преподавателей
INSERT INTO courses_teachers(course_id, teacher_id)
VALUES
(1,5),
(2,1),
(3,5),
(2,4);


/*
    ПОЛУЧЕНИЕ ДАННЫХ ИЗ ТАБЛИЦ
*/

-- получение всех студентов и курсов, на которые эти студенты записаны
SELECT 
    s.name AS student_name, 
    c.name AS course_name
FROM students s
JOIN courses_students cs ON s.id = cs.student_id
JOIN courses c ON cs.course_id = c.id;

-- получение всех преподавателей и курсов, на которые эти преподаватели ведут
SELECT 
    t.name AS teacher_name, 
    c.name AS course_name
FROM teachers t
JOIN courses_teachers ct ON t.id = ct.teacher_id
JOIN courses c ON ct.course_id = c.id;

-- получение всех студентов, курсов, на которые эти студенты записаны, а также преподавателей, которые эти курсы ведут
SELECT 
    s.name AS student_name, 
    c.name AS course_name, 
    t.name AS teacher_name
FROM students s
JOIN courses_students cs ON s.id = cs.student_id
JOIN courses c ON cs.course_id = c.id
JOIN courses_teachers ct ON c.id = ct.course_id
JOIN teachers t ON ct.teacher_id = t.id;

-- получение студентов, которые пока не записаны на курсы
SELECT s.name AS student_name
FROM students s
LEFT JOIN courses_students cs ON s.id = cs.student_id
WHERE cs.course_id IS NULL;

-- получение преподавателей, которые пока не ведут курсы
SELECT t.name AS teacher_name
FROM teachers t
LEFT JOIN courses_teachers ct ON t.id = ct.teacher_id
WHERE ct.course_id IS NULL;