-- Insert data into recipe table
INSERT INTO recipe
    (
        title, content, slug, duration, online, created_at
    )
    VALUES
    (
        'Soupe', 'contenu de test', 'soupe', 20, TRUE, 1668391132
    ),
    (
        'Soupe2', 'contenu de test', 'soupe2', 10, FALSE, 1668391132
    );