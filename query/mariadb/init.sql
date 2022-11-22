-- Dump encodage utilisé pour une table
SELECT DEFAULT_CHARACTER_SET_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = 'tuto';

-- UNSIGNED :
-- ne sauvegarde que le nombre sans le signe
-- -4 -> 4

-- init table (invalid type for field online)
CREATE TABLE posts (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(250) NOT NULL,
    content LONGTEXT,
    online VARCHAR(255) DEFAULT 0
);

-- init insert
INSERT INTO posts (title, online) VALUES ('Hello', 0);
INSERT INTO posts SET title = 'Hello online', online = 1;
INSERT INTO posts SET title = 'Hello online', online = 'online...';

-- Select *
SELECT * FROM posts;

-- Fix online value
UPDATE posts
SET online = 1
WHERE id = 3;

-- Modifie le type du champ online
-- échec: impossible de transformer 'online...' en boolean
ALTER TABLE posts
MODIFY online BOOLEAN NOT NULL DEFAULT 0;