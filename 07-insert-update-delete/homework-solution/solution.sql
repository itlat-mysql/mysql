/*
	1. [CREATE DATABASE] Создать базу данных db_modifications.
*/
CREATE DATABASE db_modifications DEFAULT CHARSET utf8mb4;

-- переключение на новую базу данных
USE db_modifications;

/*
	2. [CREATE TABLE] Внутри db_modifications создать таблицу
	students, которая должна содержать следующие столбцы - id
	(BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY), name
	(VARCHAR(255)), personal_code (VARCHAR(255) NOT NULL
	UNIQUE), faculty (VARCHAR(255) NOT NULL), years_of_study
	(TINYINT UNSIGNED NOT NULL).
*/
CREATE TABLE students (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255),
	personal_code VARCHAR(255) NOT NULL UNIQUE,
	faculty VARCHAR(255) NOT NULL,
	years_of_study TINYINT UNSIGNED NOT NULL
) ENGINE=InnoDB;

/*
	3. [INSERT] Вставить в таблицу students одну строку, перечислив
	все столбцы и их значения в том порядке, который был
	установлен при создании таблицы (id, name, personal_code,
	faculty, years_of_study). Здесь и далее значения для
	столбцов придумывайте сами - только постарайтесь, чтобы они
	были осмысленными.
*/
INSERT INTO students(
	id, name, personal_code, faculty, years_of_study
) VALUES (
	1, 'John Smith', '230590-10438', 'Biology', 1
);

/*
	4. [INSERT] Вставить в таблицу students одну строку, перечислив
	все столбцы и их значения в произвольном порядке (не таком,
	который был установлен при создании таблицы).
*/
INSERT INTO students(
	faculty, years_of_study, personal_code, id, name
) VALUES (
	'Geography', 3, '120387-11538', 2, 'Mary Sue'
);

/*
	5. [INSERT] Вставить в таблицу students одну строку вообще без
	перечисления тех столбцов, значения которых будут вставлены
	(т.е. должны быть указаны только значения, названия столбцов
	указывать нельзя).
*/
INSERT INTO students VALUES (
	3, 'Ivan Ivanov', '110677-14438', 'Sociology', 2
);


/*
	6. [INSERT] При помощи одного запроса вставить в таблицу
	students 3 строки одновременно.
*/
INSERT INTO students(
	id, name, personal_code, faculty, years_of_study
) VALUES 
(4, 'Michael Adams', '120588-20438', 'Pedagogy', 4),
(5, 'Anna Jones', '220585-30438', 'Physics', 2),
(6, 'Peter Smirnov', '110591-70438', 'Math', 3);

/*
	7. [INSERT] Вставьте в таблицу students одну строку, которая
	будет содержать только обязательные значения (personal_code,
	faculty и years_of_study). Убедитесь, что данные столбца с
	автоинкрементом (id) были вставлены автоматически, а столбец
	name получил значение NULL.
*/
INSERT INTO students(
	personal_code, faculty, years_of_study
) VALUES (
	'271281-71345', 'Psychology', 2
);

/*
	8. [CREATE TABLE, INSERT] Создать таблицу students_archive,
	структура (столбцы) которой повторяет структуру таблицы
	students. При помощи одного запроса вставить все данные
	таблицы students в таблицу students_archive.
*/
CREATE TABLE students_archive (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255),
	personal_code VARCHAR(255) NOT NULL UNIQUE,
	faculty VARCHAR(255) NOT NULL,
	years_of_study TINYINT UNSIGNED NOT NULL
) ENGINE=InnoDB;

INSERT INTO students_archive SELECT * FROM students;

/*
	9. [UPDATE] Обновить столбец name для того студента из таблицы
	students, имя которого имеет значение NULL - новое имя
	должно быть равно какой-либо осмысленной строке.
*/
UPDATE students SET name = 'Barbara Taylor' WHERE name IS NULL;

/*
	10. [UPDATE] Обновить при помощи одного запроса всем строкам
	в таблице students столбец faculty - теперь он должен
	содержать строку Math.
*/
UPDATE students SET faculty = 'Math';

/*
	11. [UPDATE] При помощи одного запроса увеличить на единицу
	значение столбца years_of_study для всех строк (студентов)
	таблицы students.
*/
UPDATE students SET years_of_study = years_of_study + 1;

/*
	12. [UPDATE] При помощи одного запроса в таблице students
	установить строку Chemistry новым значением столбца faculty
	- но только для тех студентов, id которых является четным
	числом.
*/
UPDATE students SET faculty = 'Chemistry' WHERE id % 2 = 0;

/*
	13. [UPDATE] При помощи одного запроса обновить всем
	студентам в таблице students имя (name) и факультет
	(faculty) - после обновления имя должно равняться строке
	John Smith, а факультет - строке History.
*/
UPDATE students SET name = 'John Smith', faculty = 'History';

/*
	14. [UPDATE] При помощи одно запроса обновить таблицу
	students_archive данными из таблицы students (они должны
	стать идентичными).
*/
UPDATE students_archive sa 
JOIN students s ON sa.id = s.id
SET 
	sa.name = s.name,
	sa.personal_code = s.personal_code,
	sa.faculty = s.faculty,
	sa.years_of_study = s.years_of_study;

/*
	15. [DELETE] Удалить из таблицы students тех студентов, id
	которых является нечетным числом.
*/
DELETE FROM students WHERE id % 2 = 1;

/*
	16. [DELETE] Удалить из таблицы students всех студентов.
*/
DELETE FROM students;

/*
	17. [TRUNCATE] Очистить (TRUNCATE) таблицу students и
	убедиться, что новое значение автоинкремента равняется
	единице.
*/
TRUNCATE TABLE students;