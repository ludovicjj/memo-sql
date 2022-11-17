SELECT *, (
    SELECT COUNT(*)
    FROM recipe_ingredient ri
    WHERE ri.recipe_id = r.id
) AS count
FROM recipe r
;

SELECT *
FROM recipe r
WHERE r.id IN (
    SELECT rc.recipe_id
    FROM category c
    LEFT JOIN recipe_category rc on c.id = rc.category_id
    WHERE c.title NOT IN ('Gateau', 'Dessert')
);
