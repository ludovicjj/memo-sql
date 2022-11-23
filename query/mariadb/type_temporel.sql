-- remove all records from  a table in MariaDB
-- It perform the same function as DELETE statement without a WHERE clause
-- TRUNCATE TABLE tuto.posts;

--
-- DATETIME
--

-- Add colonne publish_at definition DATETIME (nullable)
ALTER TABLE posts
ADD published_at DATETIME;

-- DATETIME format : YYYY-MM-DD hh:mm:ss
INSERT INTO posts (title, published_at) VALUE ('Hello world', '2022-11-23 07:00:00');

-- Function to datetime
-- YEAR (récupérer seulement la partie année)
SELECT title, YEAR(published_at) FROM posts;

-- TIMEDIFF : récupérer le nombre d'heur depuis la date de publication
SELECT title, TIMEDIFF(NOW(), published_at) FROM posts;

-- Récupérer les post ou la date de publication est inférieur à la date d'aujourd'hui
SELECT * FROM posts WHERE published_at <= NOW();
-- Récupérer les post ou l'année de publication est égale à 2022
SELECT * FROM posts WHERE YEAR(published_at) = 2022;

--
-- TIMESTAMP
--

-- Add colonne created_at definition TIMESTAMP (nullable)
ALTER TABLE posts
ADD created_at TIMESTAMP;

-- défini le timestamp
UPDATE posts SET created_at = '2022-11-23 07:00:00' WHERE id = 1;

-- récupérer id, published_at et created_at du post id = 1
SELECT id, published_at, created_at FROM posts WHERE id = 1;

-- The following SELECT statement returns:
--
--   id | title         | published_at        | created_at
-- ----------------------------------------------------------------------
--   4 | Hello world    | 2022-11-23 07:00:00 | 2022-11-23 07:00:00

-- Différence entre le DATETIME et le TIMESTAMP
-- LE DATETIME reste égale à la date précisé
-- Le TIMESTAMP est calculé par rapport au 1er janvier 1970

-- Si je change le fuseau horaire de ma session sql (france : '+01:00')
SET time_zone = '+03:00';
-- récupérer de nouveau  id, published_at et created_at du post id = 4
SELECT * FROM posts WHERE id = 1;

-- The following SELECT statement returns:
--
--   id | title         | published_at        | created_at
-- ----------------------------------------------------------------------
--   1 | Hello world    | 2022-11-23 07:00:00 | 2022-11-23 09:00:00

-- Favorisé DATETIME...

--
-- DEFAULT DATE
--

-- drop colonne created_at
ALTER TABLE posts
DROP created_at;

-- Recréer le champ created_at (NOT NULL) et default value  = current_timestamp (par rapport à mon fuseau horaire).
-- Créer le champ updated_at (NOT NULL) et default value  = current_timestamp (par rapport à mon fuseau horaire),
-- lors d'un update change le TIMESTAMP par le TIMESTAMP actuelle (toujours par rapport à mon fuseau horaire)
ALTER TABLE posts
ADD created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Mise à jour automatique de champs created_at lors d'un update
-- Problem du contrôle du fuseau horaire
UPDATE posts SET title = 'hello' WHERE id = 1;



