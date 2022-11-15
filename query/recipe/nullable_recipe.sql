-- reset table
DROP TABLE recipe;

-- Recreate table
-- Add constraint NOT NULL for fields title, slug, content, duration and online
-- Add DEFAULT value for fields: content, duration and online
-- Assign UNIQUE transform field as INDEX ?
CREATE TABLE recipe (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(50) NOT NULL UNIQUE,
    content TEXT DEFAULT 'my recipe' NOT NULL,
    duration SMALLINT DEFAULT 10 NOT NULL,
    online BOOLEAN DEFAULT FALSE NOT NULL,
    created_at DATETIME
);

-- Add new row not using default value.
INSERT INTO recipe
    (title, slug, content, duration, online, created_at)
VALUES ('Recipe 1', 'recipe-1', 'recipe content', 20, TRUE, 1668391132);

-- Add new row with default value for fields content, duration and online
INSERT INTO recipe
    (title, slug, created_at)
VALUES ('Recipe 2', 'recipe-2', 1668391132);

-- Fetch data where content IS NOT NULL
SELECT * FROM recipe WHERE content IS NOT NULL;
-- Fetch data where content IS NULL
SELECT * FROM recipe WHERE content IS NULL;

-- Update all recipe row and set null value for content
UPDATE recipe SET content = NULL WHERE content IS NOT NULL;