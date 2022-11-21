-- create table sales
CREATE TABLE IF NOT EXISTS sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER,
    country VARCHAR(255),
    product VARCHAR(255),
    profit INTEGER
);

-- add row
INSERT INTO sales (year, country, product, profit)
VALUES
    (2000,'Finland','Computer'  ,  1500),
    (2000,'Finland','Phone'     ,   100),
    (2001,'Finland','Phone'     ,    10),
    (2000,'India'  ,'Calculator',    75),
    (2000,'India'  ,'Calculator',    75),
    (2000,'India'  ,'Computer'  ,  1200),
    (2000,'USA'    ,'Calculator',    75),
    (2000,'USA'    ,'Computer'  ,  1500),
    (2001,'USA'    ,'Calculator',    50),
    (2001,'USA'    ,'Computer'  ,  1500),
    (2001,'USA'    ,'Computer'  ,  1200),
    (2001,'USA'    ,'TV'        ,   150),
    (2001,'USA'    ,'TV'        ,   100);