-- переключаемся на базу данных selection
USE selection;

-- создаем таблицу documents
CREATE TABLE documents (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    data JSON NOT NULL
);

-- вставляем в таблицу documents две строки
INSERT INTO documents (data)
VALUES
('{"title": "1st Document", "content": {"en": "Text 1", "ru": "Текст 1"}, "paragraphs": [10, 55, 18]}'),
('{"title": "2nd Document", "content": {"en": "Text 2", "ru": "Текст 2"}, "paragraphs": [16, 47, 98]}');