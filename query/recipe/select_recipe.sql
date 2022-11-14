-- get title, slug and duration from recipe
SELECT title, slug, duration FROM recipe;

-- get all data from recipe
SELECT * FROM recipe;

-- get all data from recipe with where condition
SELECT * FROM recipe WHERE online = true;
SELECT * FROM recipe WHERE title = 'Soupe';
SELECT * FROM recipe WHERE duration > 10;
SELECT * FROM recipe WHERE duration BETWEEN 0 AND 20;
SELECT * FROM recipe WHERE slug IN ('soupe', 'soupe2'); -- like in_array
SELECT * FROM recipe WHERE slug = 'soupe' AND duration > 5;
SELECT * FROM recipe WHERE slug = 'soupe' OR duration > 5;
SELECT * FROM recipe WHERE slug LIKE '%sou%';