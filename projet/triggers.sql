ALTER TABLE ingredient
ADD COLUMN usage_count INTEGER DEFAULT 0;

-- keyword references to data
-- insert: NEW data
-- update: NEW data, OLD data
-- delete: OLD
-- trigger are into table sqlite_master

-- Delete trigger
-- DROP TRIGGER decrement_usage_count_on_ingredient;
-- Drop table delete trigger too

-- Add trigger to increment 'usage_count'
-- When add new ingredient into 'recipe_ingredient'
CREATE TRIGGER update_usage_count_on_ingredient_added
AFTER INSERT ON recipe_ingredient
BEGIN
    UPDATE ingredient
    SET usage_count = ingredient.usage_count + 1
    WHERE ingredient.id = NEW.ingredient_id;
end;

CREATE TRIGGER decrement_usage_count_on_ingredient_deleted
AFTER DELETE ON recipe_ingredient
BEGIN
    UPDATE ingredient
    SET usage_count = ingredient.usage_count - 1
    WHERE ingredient.id = OLD.ingredient_id;
end;

-- Bind ingredient to recipe
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit)
VALUES
    (1, 7, 10, 'g')
;

-- Remove ingredient to recipe
DELETE FROM recipe_ingredient
WHERE recipe_id = 1 AND ingredient_id = 7;

SELECT *
FROM ingredient;