--enable foreign key (SQLite)
PRAGMA foreign_keys = ON;
-- reset
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS category;

-- Create table category
CREATE TABLE IF NOT EXISTS category (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150) NOT NULL,
    description TEXT
);
-- Create table recipe
-- Got foreign key to category
-- ON DELETE
-- RESTRICT: prevent to delete a category if one recipe is join to this category
-- CASCADE: when delete one category DELETE all recipes join to this category
-- SET NULL: when delete one category set NULL to all recipes join to this category
CREATE TABLE IF NOT EXISTS recipe (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE SET NULL
);


-- Add 2 row
INSERT INTO category (title)
VALUES
    ('Plat'),
    ('Dessert');

-- Add 2 row
INSERT INTO recipe (title, slug, category_id)
VALUES
    ('Creme Anglaise', 'creme-anglaise', 2),
    ('Crepe au sucre', 'creme-au-sucre', 2),
    ('Soupe', 'soupe', 1),
    ('Salade de fruit', 'salade-de-fruit', NULL);

-- INNER JOIN (default)
-- The inner join will keep only the information from the two joined tables that is related
-- The recipe ('salade de fruit') will not be included into result because it not joined to one category
SELECT r.id, r.title AS recipe_title, c.title AS catgory_title
FROM recipe AS r
INNER JOIN category AS c ON  r.category_id = c.id;

-- OUTER JOIN -> left
-- The left join (outer) will keep unrelated data from the left table (recipe)
-- (left) <---> (right)
-- recipe ---- category

SELECT r.id, r.title AS recipe_title, c.title AS catgory_title
FROM recipe AS r
LEFT OUTER JOIN category AS c ON  r.category_id = c.id;

-- OUTER JOIN -> right
-- The right join (outer) will keep unrelated data from the right table (category)
-- (left) <---> (right)
-- recipe ---- category

-- TEST: fetch recipes (id and title) join with category.title = 'Dessert'
SELECT r.id, r.title AS recipe
FROM recipe AS r
INNER JOIN category AS c ON  r.category_id = c.id
WHERE c.title = 'Dessert';


-- Try On DELETE
--DELETE FROM category WHERE id = 2;
