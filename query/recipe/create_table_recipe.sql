-- create table recipe
CREATE TABLE recipe(
    title VARCHAR(150),
    content TEXT,
    slug VARCHAR(50),
    duration SMALLINT,
    online BOOLEAN,
    created_at DATETIME
);