-- create UNIQUE index idx_slug for recipe.slug
CREATE UNIQUE INDEX idx_slug ON recipe (slug);

-- Now adding a new data with an existing slug will fail
INSERT INTO recipe (
        title,
        content,
        slug,
        duration,
        online,
        created_at
    ) VALUES (
        'Soupe',
        'contenu de test',
        'soupe',
        20,
        TRUE,
        1668391132
    );

/**
  PROS: Search using index is faster.
  CONS: Insert or Update is slower when there are many index.
  (Use index for fields used often in queries, ex: id, slug)
*/

-- Search USING INDEX ids_slug (faster)
EXPLAIN QUERY PLAN SELECT * FROM recipe WHERE slug='soupe1';
-- SCAN table recipe (slower)
EXPLAIN QUERY PLAN SELECT * FROM recipe WHERE title='Soupe1';

-- List index (SQLite only)
PRAGMA index_list('recipe');

-- DROP index
DROP INDEX idx_slug;


