ALTER TABLE posts
ADD location POINT;

INSERT INTO posts (title, location)
VALUE
    ('Perpignan', ST_GeomFromText('POINT(2.895600 42.698601)')),
    ('Poitiers', ST_GeomFromText('POINT(0.340196 46.580260)')),
    ('Montpellier', ST_GeomFromText('POINT(3.876734 43.611242)'));

-- calcule la distance entre deux points
SELECT CONCAT(ROUND(
    ST_Distance_Sphere(
        (SELECT location FROM posts WHERE title = 'Perpignan'),
        (SELECT location FROM posts WHERE title = 'Montpellier')
    ) / 1000 ), 'km')
as distance;