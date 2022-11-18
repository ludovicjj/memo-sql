PRAGMA foreign_keys = ON;

--reset
DROP TABLE IF EXISTS recipe_ingredient;
DROP TABLE IF EXISTS recipe_category;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS ingredient;

-- Create table
CREATE TABLE IF NOT EXISTS user (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username VARCHAR(150) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS recipe (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    date DATETIME,
    duration INTEGER DEFAULT 0 NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS category (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS recipe_category (
    recipe_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipe (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, category_id),
    UNIQUE (recipe_id, category_id)
);

CREATE TABLE IF NOT EXISTS ingredient (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name VARCHAR(150) NOT NULL,
    usage_count INTEGER DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS recipe_ingredient (
    recipe_id INTEGER NOT NULL,
    ingredient_id INTEGER NOT NULL,
    quantity INTEGER,
    unit VARCHAR(20),
    FOREIGN KEY (recipe_id) REFERENCES recipe (id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient (id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, ingredient_id),
    UNIQUE (recipe_id, ingredient_id)
);

-- triggers
CREATE TRIGGER increment_usage_count_on_ingredient_insert
    AFTER INSERT ON recipe_ingredient
BEGIN
    UPDATE ingredient
    SET usage_count = ingredient.usage_count + 1
    WHERE ingredient.id = NEW.ingredient_id;
end;

CREATE TRIGGER decrement_usage_count_on_ingredient_delete
    AFTER DELETE ON recipe_ingredient
BEGIN
    UPDATE ingredient
    SET usage_count = ingredient.usage_count - 1
    WHERE ingredient.id = OLD.ingredient_id;
end;

-- Set data
INSERT INTO user (username, email)
VALUES
    ('John Doe', 'john@doe.fr'),
    ('Jane Doe', 'jane@doe.fr');

INSERT INTO category (title)
VALUES
       ('Plat'),
       ('Dessert'),
       ('Gateau');

INSERT INTO recipe (title, slug, duration, user_id)
VALUES
       ('Soupe à la tomate', 'soupe_a_la_tomate', 10, 1),
       ('Madelaine', 'madelaine', 30, 1),
       ('Salade de fruit', 'salade-de-fruit', 10, 1),
       ('Boeuf bourguignon', 'boeuf-bourguignon', 120, 2);

INSERT INTO recipe_category (recipe_id, category_id)
VALUES
       (1, 1),
       (2, 2),
       (2, 3),
       (3, 2),
       (4, 1)
;
INSERT INTO ingredient (name)
VALUES
       ('sucre'),
       ('farine'),
       ('levure chimique'),
       ('beurre'),
       ('lait'),
       ('oeuf'),
       ('miel'),
       ('eau'),
       ('tomate'),
       ('creme fraiche')
;

INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES
       (1, 8, 50, 'cl'),
       (1, 9, 250, 'g'),
       (1, 10, 10, 'g'),
       (2, 1, 150, 'g'),
       (2, 2, 200, 'g'),
       (2, 3, 8, 'g'),
       (2, 4, 100, 'g'),
       (2, 5, 50, 'cl'),
       (2, 6, 3, NULL),
       (3, 1, 50, 'g')
       ;

-- Test
-- fetch recipe who use 'oeuf' as ingredient
SELECT r.title
FROM ingredient i
JOIN recipe_ingredient ri on i.id = ri.ingredient_id
JOIN recipe r on ri.recipe_id = r.id
WHERE i.name = 'oeuf';

-- fetch all recipe who not have ingredient
SELECT *
FROM recipe r
LEFT JOIN recipe_ingredient ri on r.id = ri.recipe_id
WHERE ri.ingredient_id IS NULL
;

-- update quantity for recipe 'madelaine' and ingredient 'levure chimique'
UPDATE recipe_ingredient
SET quantity = 10
WHERE recipe_id = 2 AND ingredient_id = 3
;

-- fetch recipe with quantity, unit and ingredients
SELECT r.title, ri.quantity, ri.unit, i.name AS ingredient
FROM recipe r
JOIN recipe_ingredient ri on r.id = ri.recipe_id
JOIN ingredient i on i.id = ri.ingredient_id


--DELETE FROM ingredient WHERE id = 3;