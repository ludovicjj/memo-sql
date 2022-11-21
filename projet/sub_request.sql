-- Utilisation d'une sous requête dans le FROM
-- Récupérer toutes les data de chaque ligne de la table recipe
-- et ajoute une colonne "count" provenant d'une sous requête qui content le nombre d'ingrédient par recette
-- la sous requête dépendre de l'extérieur (requête corrélé), ici recipe.id
SELECT *, (
    SELECT COUNT(*)
    FROM recipe_ingredient ri
    WHERE ri.recipe_id = r.id
) AS count
FROM recipe r
;

-- Utilisation d'une sous requête dans le FROM
SELECT subquery.title
FROM (
    SELECT * FROM  recipe
) AS subquery;


-- Utilisation d'une sous requête dans le WHERE
-- Récupérer toutes les recettes qui n'appartiennent pas à la catégorie Gateau et Dessert
SELECT *
FROM recipe r
WHERE r.id IN (
    SELECT rc.recipe_id
    FROM category c
    LEFT JOIN recipe_category rc on c.id = rc.category_id
    WHERE c.title NOT IN ('Gateau', 'Dessert')
);
