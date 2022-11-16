-- count recipe
SELECT COUNT(id) FROM recipe;

-- sum duration of all recipe
SELECT SUM(duration) FROM recipe;

SELECT group_concat(title, ', ') FROM recipe;

-- count recipe and group them by duration
SELECT COUNT(id), duration FROM recipe GROUP BY duration;

-- can't use WHERE because WHERE is calling before GROUP BY
-- filter result using HAVING
SELECT COUNT(id) AS count, duration FROM recipe GROUP BY duration HAVING count >=2;

SELECT COUNT(ri.recipe_id) AS count, i.name
FROM ingredient i
LEFT JOIN recipe_ingredient ri on i.id = ri.ingredient_id
GROUP BY i.name;

-- DISTINCT where i.name & r.duration are unique
-- here sucre is used in 2 recipes
-- first recipe has duration 10
-- second recipe has duration 30
-- then sucre is repeat two times
-- if sucre used by two recipe BUT with same duration, then sucre will be present only one time
SELECT DISTINCT i.name, r.duration
FROM ingredient i
LEFT JOIN recipe_ingredient ri ON i.id = ri.ingredient_id
LEFT JOIN recipe r ON ri.recipe_id = r.id
WHERE ri.recipe_id IS NOT NULL;

-- count recipe created by user
SELECT COUNT(r.id), u.username
FROM recipe r
INNER JOIN user u ON r.user_id = u.id
GROUP BY u.id;

-- calcul sum recipe duration group by user
SELECT SUM(r.duration) AS duration
FROM recipe r
INNER JOIN user u ON r.user_id = u.id
GROUP BY u.id;
;

