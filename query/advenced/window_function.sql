-- reset
DROP TABLE IF EXISTS demo_0;
DROP TABLE IF EXISTS demo_1;
DROP TABLE IF EXISTS demo_2;
DROP TABLE IF EXISTS demo_post;
DROP TABLE IF EXISTS demo_comment;

-- create table sales
CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER,
    country VARCHAR(255),
    product VARCHAR(255),
    profit INTEGER
);

CREATE TABLE IF NOT EXISTS demo_0 (
    a PRIMARY KEY,
    b,
    c
);

CREATE TABLE IF NOT EXISTS demo_1 (
    a PRIMARY KEY,
    b VARCHAR(50),
    c VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS demo_2 (
  a PRIMARY KEY,
  b VARCHAR(50),
  c INTEGER,
  d VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS demo_post (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150),
    content TEXT
);
--enable foreign key (SQLite)
PRAGMA foreign_keys = ON;
CREATE TABLE  IF NOT EXISTS demo_comment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author VARCHAR(150),
    content TEXT,
    post_id INTEGER,
    FOREIGN KEY (post_id) REFERENCES demo_post (id) ON DELETE CASCADE
);

-- add row
INSERT INTO sales (year, country, product, profit)
VALUES
    (2000,'Finland','Computer'  ,  1500),
    (2000,'Finland','Phone'     ,   100),
    (2001,'Finland','Phone'     ,    10),
    (2000,'India'  ,'Calculator',    75),
    (2000,'India'  ,'Calculator',    75),
    (2000,'India'  ,'Computer'  ,  1200),
    (2000,'USA'    ,'Calculator',    75),
    (2000,'USA'    ,'Computer'  ,  1500),
    (2001,'USA'    ,'Calculator',    50),
    (2001,'USA'    ,'Computer'  ,  1500),
    (2001,'USA'    ,'Computer'  ,  1200),
    (2001,'USA'    ,'TV'        ,   150),
    (2001,'USA'    ,'TV'        ,   100);

INSERT INTO demo_0
VALUES
    (1, 'A', 'one'  ),
    (2, 'B', 'two'  ),
    (3, 'C', 'three'),
    (4, 'D', 'one'  ),
    (5, 'E', 'two'  ),
    (6, 'F', 'three'),
    (7, 'G', 'one'  );

INSERT INTO demo_1
VALUES
    (1, 'A', 'one'  ),
    (2, 'W', 'two'  ),
    (3, 'G', 'three'),
    (4, 'D', 'one'  ),
    (5, 'B', 'two'  ),
    (6, 'C', 'three'),
    (7, 'Z', 'one'  );

INSERT INTO demo_2
VALUES
    (1, 'A', 5, 'AAA'),
    (2, 'A', 6, 'AAA'),
    (3, 'A', 15, 'CCC'),
    (4, 'B', 1, 'AAA'),
    (5, 'B', 1, 'BBB'),
    (6, 'B', 3, 'BBB'),
    (7, 'B', 7, 'AAA'),
    (8, 'C', 3, 'AAA'),
    (9, 'C', 1, 'CCC'),
    (10, 'D', 10, 'AAA'),
    (11, 'D', 5, 'AAA')
;

INSERT INTO demo_post (title, content)
VALUES
       ('title 1', 'contenu de du post 1'),
       ('title 2', 'contenu de du post 2'),
       ('title 3', 'contenu de du post 3'),
       ('title 4', 'contenu de du post 4')
;

INSERT INTO demo_comment (author, content, post_id)
VALUES
       ('john@doe.fr', 'My super comment content', 1),
       ('jane@doe.fr', 'An other comment for post 1', 1),
       ('paul@doe.fr', 'Hello its a comment', 1),
       ('user@gmail.com', 'My first comment', 1),
       ('jean@dupont.net', 'Un commentaire test', 1),
       ('john@hotmail.com', 'Content comment... i have no idea', 1),
       ('john@doe.fr', 'My super comment content', 2),
       ('jane@doe.fr', 'An other comment for post 2', 2),
       ('paul@doe.fr', 'Hello its a comment', 2),
       ('user@gmail.com', 'My second comment', 2),
       ('jean@dupont.net', 'Un commentaire test', 2),
       ('john@hotmail.com', 'Content comment... i have no idea', 2),
       ('john@doe.fr', 'My second super comment content', 3),
       ('jane@doe.fr', 'An other comment for post 3', 3),
       ('paul@doe.fr', 'Hello its a comment', 3),
       ('user@gmail.com', 'My third comment', 3),
       ('jean@dupont.net', 'Un commentaire test', 3),
       ('john@hotmail.com', 'Content comment... i have no idea', 3),
       ('hello@mail.fr', 'My super comment content', 4),
       ('bad@user.fr', 'An other comment for post 4', 4),
       ('paul@doe.fr', 'Hello its a comment', 4),
       ('user@gmail.com', 'My fourth comment', 4),
       ('jean@dupont.net', 'Un commentaire test', 4),
       ('mistercat@hotmail.com', 'Content comment... i have no idea', 4)
;

------------------------------------------------------
-- PARTITION BY x == GROUP BY x
-- Concaténation de (b + .) sur partition utilisant c
-- la concaténation utilise :
-- CURRENT ROW = b de la ligna actuel
-- AND
-- 1 FOLLOWING = le b de la ligne qui suit
------------------------------------------------------
SELECT
    a,
    b,
    c,
    group_concat(b, '.') OVER (
        PARTITION BY c
        ORDER BY a
        ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING
    ) AS group_concat
FROM demo_0
;

-- The following SELECT statement returns:
--
--   a | b | c | group_concat
------------------------
--   1 | A | one | A.D
--   4 | D | one | D.G
--   7 | G | one | G
--   3 | C | Three | C.F
--   3 | F | Three | F
--   3 | B | Two | B.E
--   3 | E | Two | E


------------------------------------------------------
-- Même query mais utilisant "UNBOUNDED FOLLOWING"
-- UNBOUNDED FOLLOWING = La limite de trame est la dernière ligne de la partition .
-- Concaténation de (b + .) sur partition utilisant c (-> group by "c")
-- la concaténation utilise :
-- CURRENT ROW = b de la ligna actuel
-- AND
-- UNBOUNDED FOLLOWING = jusqu'a la dernière ligne de la partition
------------------------------------------------------
SELECT
    a,
    b,
    c,
    group_concat(b, '.') OVER (
        PARTITION BY c
        ORDER BY b
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
        ) AS group_concat
FROM demo_0
;
-- The following SELECT statement returns:
--
--   a | b | c | group_concat
------------------------
--   1 | A | one | A.D.G
--   4 | D | one | D.G
--   7 | G | one | G
--   3 | C | three | C.F
--   3 | F | three | F
--   3 | B | two | B.E
--   3 | E | two | E


------------------------------------------------------
-- Fonction de fenêtre intégrées :  ROW_NUMBER()
-- La function row_number() assigne un integer qui s'incrémente à chaque ligne en utilisant le ORDER BY
-- Si row_number() n'a pas de ORDER BY alors utilise la clause ORDER BY du SELECT
-- Si row_number() et SELECT n'ont pas de clause ORDER BY utilise id
------------------------------------------------------
SELECT
    a,
    b,
    c,
    row_number() over () AS row_number
FROM demo_1;
-- The following SELECT statement returns:
--
--   a | b | c      | row_number
------------------------
--   1 | A | one    | 1
--   2 | W | two    | 2
--   3 | G | three  | 3
--   4 | D | one    | 4
--   5 | B | two    | 5
--   6 | C | three  | 6
--   7 | Z | one    | 7

------------------------------------------------------
-- Fonction de fenêtre intégrées :  ROW_NUMBER()
-- ROW_NUMBER() avec clause ORDER BY
------------------------------------------------------
SELECT
    a,
    b,
    c,
    row_number() over (ORDER BY b) AS row_number
FROM demo_1;
-- The following SELECT statement returns:
--
--   a | b | c      | row_number
------------------------
--   1 | A | one    | 1
--   5 | B | two    | 2
--   6 | C | three  | 3
--   4 | D | one    | 4
--   3 | G | three  | 5
--   2 | W | two    | 6
--   7 | Z | one    | 7

------------------------------------------------------
-- Fonction de fenêtre intégrées :  ROW_NUMBER()
-- ROW_NUMBER() avec clause ORDER BY
-- SELECT avec clause ORDER BY
-- Réorganise la table en utilisant le ORDER BY du SELECT
-- Le row_number reste organisé avec la clause ORDER BY utilisé
------------------------------------------------------
SELECT
    a,
    b,
    c,
    row_number() over (ORDER BY b) AS row_number
FROM demo_1
ORDER BY a;
-- The following SELECT statement returns:
--
--   a | b | c      | row_number
------------------------
--   1 | A | one    | 1
--   2 | W | two    | 6
--   3 | G | three  | 5
--   4 | D | one    | 4
--   5 | B | two    | 2
--   6 | C | three  | 3
--   7 | Z | one    | 7

------------------------------------------------------
-- Fonction de fenêtre intégrées :  ROW_NUMBER()
-- ROW_NUMBER() avec clause ORDER BY dans une PARTITION
-- Donne la position de chaque ligne par rapport à sa partition
------------------------------------------------------
SELECT
    a,
    b,
    c,
    row_number() over (PARTITION BY c ORDER BY b) AS row_number
FROM demo_1
;
-- The following SELECT statement returns:
--
--   a | b | c      | row_number
------------------------
--   1 | A | one    | 1
--   4 | D | one    | 2
--   7 | Z | one    | 3
--   6 | C | three  | 1
--   3 | G | three  | 2
--   5 | B | two    | 1
--   2 | W | two    | 2

------------------------------------------------------
-- Fonction de fenêtre intégrées :  ROW_NUMBER()
-- ROW_NUMBER() avec clause ORDER BY dans une PARTITION
-- SELECT avec clause ORDER BY
-- Réorganise la table en utilisant le ORDER BY du SELECT
-- Donne la position de chaque ligne par rapport à sa partition et conserve le ORDER BY
------------------------------------------------------
SELECT
    a,
    b,
    c,
    row_number() over (PARTITION BY c ORDER BY b) AS row_number
FROM demo_1
ORDER BY a;
-- The following SELECT statement returns:
--
--   a | b | c      | row_number
------------------------
--   1 | A | one    | 1
--   2 | W | two    | 2
--   3 | G | three  | 2
--   4 | D | one    | 2
--   5 | B | two    | 1
--   6 | C | three  | 1
--   7 | Z | one    | 3

------------------------------------------------------
-- Fonction de fenêtre intégrées :  RANK()
-- Similaire a ROW_NUMBER() avec des GAP
-- Classe les éléments dans la partition en utilisant le ORDER BY en effectuant un gap lors d'une égalité
-- en effectuant un gap lors d'une égalité
-- a=1 et a=2 ont la même valeur de d=AAA donc le rank 2 est supprimé et passe directement à 3
-- Si le ORDER BY est manquant alors tous les rank=1
------------------------------------------------------
SELECT
    *,
    SUM(c) OVER (PARTITION BY b) AS total,
    rank() over (PARTITION BY b ORDER BY d) AS rank
FROM demo_2;
-- The following SELECT statement returns:
--
--   a | b | c      | d     | total | rank
------------------------
--   1 | A | 5      | AAA   | 26    | 1
--   2 | A | 6      | AAA   | 26    | 1
--   3 | A | 15     | CCC   | 26    | 3 <- gap no 2
--   4 | B | 1      | AAA   | 12    | 1
--   5 | B | 7      | AAA   | 12    | 1
--   6 | B | 1      | BBB   | 12    | 3
--   7 | B | 3      | BBB   | 12    | 3

------------------------------------------------------
-- Fonction de fenêtre intégrées :  DENSE_RANK()
-- Similaire a RANK() sans GAP
-- Classe les éléments dans la partition en utilisant le ORDER BY sans effectuer de gap lors d'une égalité
------------------------------------------------------
SELECT
    *,
    SUM(c) OVER (PARTITION BY b) AS total,
    dense_rank() over (PARTITION BY b ORDER BY d) AS rank
FROM demo_2;

--   a | b | c      | d     | total | rank
------------------------
--   1 | A | 5      | AAA   | 26    | 1
--   2 | A | 6      | AAA   | 26    | 1
--   3 | A | 15     | CCC   | 26    | 2 <-no gap
--   4 | B | 1      | AAA   | 12    | 1
--   5 | B | 7      | AAA   | 12    | 1
--   6 | B | 1      | BBB   | 12    | 2
--   7 | B | 3      | BBB   | 12    | 2

------------------------------------------------------
-- Fonction d'agrégation :
-- SUM() dans une partition
-- Calcul la somme des profit par pays
------------------------------------------------------
SELECT
       id,
       country,
       product,
       profit,
       SUM(profit) OVER () AS total,
       SUM(profit) OVER (PARTITION BY country) AS country_total
FROM sales;

-- The following SELECT statement returns:
--
--   id | country   | product       | profit    | total | country_total
------------------------
--   1 | Finland    | Computer      | 10        | 7535  | 1610
--   2 | Finland    | Phone         | 100       | 7535  | 1610
--   3 | Finland    | Phone         | 1500      | 7535  | 1610
--   4 | India      | Calculator    | 75        | 7535  | 1350
--   5 | India      | Calculator    | 75        | 7535  | 1350
--   6 | India      | Computer      | 1200      | 7535  | 1350
-- ...


------------------------------------------------------
-- Fonction d'agrégation :
-- SUM() dans une partition avec clause ORDER BY
-- calcule de la somme des profits par pays

-- SUM(profil) OVER (PARTITION country ORDER BY country)
-- Si le ORDER BY est identique à la partition cela ne change rien au calcule de la somme.
-- Toutes les ligne de la partition ont le même ordre
-- Le cadre de la fenêtre est le meme pour toutes les ligne de la partition
-- et donc aussi sur le result de la fonction d'agrégation (SUM)
-- Le ORDER BY peut être omit ou peut être remplacer par :
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING (du debut jusqu'à la fin de la partition)

-- SUM(profil) OVER (PARTITION country ORDER BY product)
-- Si le ORDER BY est different de la partition, cela a un impact sur la façon de calculer la somme.
-- La position des lignes dans la partition n'est plus la même.
-- Et comme le cadre est relatif à la position de la ligne dans cet ordre,
-- Le cadre de la fenêtre est presque différent pour chaque ligne
-- tout comme le résultat de la fonction d'agrégation (SUM)

-- PRESQUE car si produit est identique (exemple: Findland a deux produit identique "Phone"),
-- il partage la même position.
-- Et donc pour ces deux lignes, le résultat de la fonction d'agrégation sera le même pour les raison mentionné précédemment
------------------------------------------------------
SELECT
    id,
    country,
    product,
    profit,
    SUM(profit) OVER () AS total,
    SUM(profit) OVER (
        PARTITION BY country ORDER BY country DESC
    ) AS country_total_order_by_product,
    SUM(profit) OVER (
        PARTITION BY country ORDER BY product DESC
        ) AS country_total_order_by_country
FROM sales
;

-- The following SELECT statement returns:
--
--   id | country   | product       | profit    | total | country_total_order_by_product    | country_total_order_by_country
------------------------
--   2 | Finland    | Phone         | 100       | 7535  | 1610                              | 110 <- same product (100 + 10)
--   3 | Finland    | Phone         | 10        | 7535  | 1610                              | 110 <- same product (100 + 10)
--   1 | Finland    | Computer      | 1500      | 7535  | 1610                              | 1610 <- not same product (110 + 1500)
--   4 | India      | Computer      | 1200      | 7535  | 1350                              | 1200
--   5 | India      | Calculator    | 75        | 7535  | 1350                              | 1350
--   6 | India      | Calculator    | 75        | 7535  | 1350                              | 1350
-- ...

------------------------------------------------------
-- Classe les elements
--      groupé par pays
--      et organisé par profit descendant
-- Place cette query comme sub query pour filtrer uniquement les 3 premieres ligne par pays (row_number)
------------------------------------------------------
SELECT * FROM (
    SELECT
        id,
        country,
        product,
        profit,
        SUM(profit) OVER (PARTITION BY country) AS total,
        row_number() OVER (PARTITION BY country ORDER BY profit DESC) AS row_number
    FROM sales
) AS sub_query
WHERE sub_query.row_number < 4
;

------------------------------------------------------
-- Récupérer les 3 premiers commentaires par post
------------------------------------------------------
SELECT
    id,
    post_id,
    comment.author AS comment_author,
    comment.content AS comment_content
FROM (
    SELECT
        id,
        author,
        content,
        post_id,
        row_number() over (PARTITION BY post_id) AS row_number
    FROM demo_comment
) as comment
WHERE comment.row_number < 4;

------------------------------------------------------
-- Récupérer les 3 dernier commentaires par post
------------------------------------------------------
SELECT
    id,
    post_id,
    comment.author AS comment_author,
    comment.content AS comment_content
FROM (
         SELECT
             id,
             author,
             content,
             post_id,
             row_number() over (PARTITION BY post_id ORDER by id DESC) AS row_number
         FROM demo_comment
     ) as comment
WHERE comment.row_number < 4;