SELECT COUNT(*) count, u.username
FROM recipe r
INNER JOIN user u ON r.user_id = u.id
GROUP BY u.id
ORDER BY count DESC
;

SELECT i.name, COUNT(ri.ingredient_id) AS count
FROM ingredient i
LEFT JOIN recipe_ingredient ri on i.id = ri.ingredient_id
GROUP BY i.id
ORDER BY count DESC
LIMIT 3 OFFSET 0
;