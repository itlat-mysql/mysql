USE indexes;

CREATE TABLE books (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    FULLTEXT INDEX content_idx(content)
) ENGINE=InnoDB;

INSERT INTO books(id, title, author, content) VALUES
(1, 'Pinocchio', 'C. Collodi', 'How ridiculous I was as a Marionette! And how happy I am, now that I have become a real boy!'),
(2, 'Robinson Crusoe', 'D. Defoe', 'When I took leave of this island, I carried on board, for relics, the great goat-skin cap I had made, my umbrella, and one of my parrots'),
(3, 'Tom Sawyer', 'M. Twain', 'While Tom was eating his supper, and stealing sugar as opportunity offered, Aunt Polly asked him questions that were full of guile.'),
(4, 'The Lord of the Rings', 'J. R. R. Tolkien', 'As is told in The Hobbit, there came one day to Bilbo’s door the great Wizard, Gandalf the Grey, and thirteen dwarves with him.'),
(5, 'The Jungle Book', 'J.R. Kipling', 'All this will show you how much Mowgli had to learn by heart, and he grew very tired of saying the same thing over a hundred times.'),
(6, 'Treasure Island', 'R. L. Stevenson', 'Of Silver we have heard no more. That formidable seafaring man with one leg has at last gone clean out of my life.'),
(7, 'Harry Potter', 'J. K. Rowling', 'Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they were perfectly normal, thank you very much.');