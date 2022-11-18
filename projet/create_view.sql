CREATE VIEW recipe_ingredient_view
AS
    SELECT r.title, GROUP_CONCAT(i.name) as ingredients_list
    FROM recipe r
    LEFT JOIN recipe_ingredient ri ON r.id = ri.recipe_id
    LEFT JOIN ingredient i ON ri.ingredient_id = i.id
    GROUP BY r.title
;

SELECT *
FROM recipe_ingredient_view
WHERE ingredients_list LIKE '%Farine%';

DROP VIEW recipe_ingredient_view;