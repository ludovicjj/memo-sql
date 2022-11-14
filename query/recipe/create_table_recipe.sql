-- create table recipe
CREATE TABLE recipe(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(150),
    content TEXT,
    slug VARCHAR(50),
    duration SMALLINT,
    online BOOLEAN,
    created_at DATETIME
);
