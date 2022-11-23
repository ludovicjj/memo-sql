-- drop table
DROP TABLE IF EXISTS posts;

-- recreate table

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL ,
    content LONGTEXT,
    online BOOLEAN DEFAULT 0,
    author JSON
);

INSERT INTO posts (title, content, author)
VALUE
    ('Titre de Test', 'Hello world', '{"age": 20, "firstname": "John"}'),
    ('Titre de Test', 'Hello world', '{"age": 42, "firstname": "Jean"}'),
    ('Titre de Test', 'Hello world', '{"age": 18, "firstname": "Jane"}'),
    ('Titre de Test', 'Hello world', null)

;

-- Sélectionne les ligne ou author.age === 42 (JSON_CONTAINS)
SELECT * FROM posts WHERE JSON_CONTAINS(author, 42, '$.age');

-- Filtre les ligne ou author.age > 18 (JSON_EXTRACT)
SELECT title, author
FROM posts
WHERE json_extract(author, '$.age') > 18;

-- Sélectionne author.age (inclue NULL) de chaque ligne (JSON_EXTRACT)
SELECT json_extract(author, '$.age') FROM posts;

-- Mis à jour de author.age pour posts.id = 1 (JSON_SET)
UPDATE posts SET author = JSON_SET(author, '$.age', 25) WHERE id = 1;

