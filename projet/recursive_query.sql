PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS pet;

CREATE TABLE IF NOT EXISTS pet (
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES pet(id) ON DELETE CASCADE
);

INSERT INTO pet (id, name, parent_id)
VALUES
       (1, 'Mammifères', NULL),
       (2, 'Chat', 1),
       (3, 'Singe', 1),
       (4, 'Gorille', 3),
       (5, 'Chimpanzé', 3),
       (6, 'Chien', 1),
       (7, 'Shiba', 6),
       (8, 'Corgi', 6),
       (9, 'Labrador', 6),
       (10, 'Poisson', NULL),
       (11, 'Requin', 10),
       (12, 'Requin blanc', 11),
       (13, 'Requin marteau', 11),
       (14, 'Requin titre', 11)
;

WITH RECURSIVE temptable AS (
    SELECT id, name, parent_id FROM pet WHERE id = 12
    UNION ALL
    SELECT p.id, p.name, p.parent_id FROM pet p, temptable WHERE p.id = temptable.parent_id
) SELECT * FROM temptable;

WITH RECURSIVE children (id, name, parent_id, level, path) AS (
    SELECT id, name, parent_id, 0, ''
    FROM pet
    WHERE id = 10
    UNION ALL
    SELECT p.id, p.name, p.parent_id, children.level + 1, children.path || ' > ' || children.name
    FROM pet p, children
    WHERE children.id = p.parent_id
) SELECT id, name, parent_id, level, path FROM children;

WITH RECURSIVE cte AS (
    SELECT id, name, parent_id FROM pet WHERE id = 5
    UNION
    SELECT p.id, p.name, p.parent_id FROM pet p, cte WHERE p.id = cte.parent_id
) SELECT * FROM cte;

WITH RECURSIVE cte AS (
    SELECT id, name, parent_id, 0 AS level FROM pet WHERE id = 1
    UNION
    SELECT
           p.id,
           p.name,
           p.parent_id,
           cte.level + 1
    FROM pet p, cte
    WHERE cte.id = p.parent_id
) SELECT id, name, level FROM cte;

WITH
     cte1 AS ( SELECT * FROM user),
     cte2 AS ( SELECT * FROM recipe)
SELECT *
FROM cte1
JOIN cte2 ON cte1.id = cte2.user_id