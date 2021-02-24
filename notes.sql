SQL
  - SQL or Structured Query Language 
  - we use to talk to databases.
    - Databases collect and organize data to
    allow for easy retrieval.

TSQL, SQLite, MySQL, Postgres, Oracle and Microsoft SQL 

No SQL 
  MongoDB CouchDB

PostgreSQL

integer
boolean
dates 
varchar 
text 
time 
timestamp


Database
  The term when describing the whole database server

Table
  A container that is stored inside of the database server
  A Table can have many rows
  To rep an object

Row
  The actual data that is stored in the table
  Often referred to as a record as well

Column
  Is a value that is stored in a Row

PRIMARY KEY
  All database tables should have a primary key, this should be a 
  unique key that is used as a safe way to look up a row in your 
  database
  id 

NOT NULL
  Means that specific value in the row needs to be there or the 
  database won’t let you save that record  

UNIQUE
  Means that the value of data in that row cannot be in any other row

DEFAULT
  This gives a default value to the column of a row







Most Common PostgreSQL DataTypes:
  integer     1
  varchar     c 
  boolean     true false
  date        YYYY-MM-DD
  text        text
  time        HH:MI:SS 
  timestamp   YYYY-MM-DD HH:MI:SS


CRUD
  create
  Read
  update
  destroy 

SQL Commands
  SELECT - extracts data from a database
  UPDATE - updates data in a database
  DELETE - deletes data from a database
  INSERT INTO - inserts new data into a database
  CREATE DATABASE - creates a new database
  ALTER DATABASE - modifies a database
  CREATE TABLE - creates a new table
  ALTER TABLE - modifies a table
  DROP TABLE - deletes a table
  CREATE INDEX - creates an index (search key)
  DROP INDEX - deletes an index


Constraits
NOT NULL (Links to an external site.) 
  - Ensures that a column cannot have a NULL value
UNIQUE (Links to an external site.) 
  - Ensures that all values in a column are different
PRIMARY KEY (Links to an external site.) 
  - A combination of a NOT NULL and UNIQUE. Uniquely identifies 
    each row in a table
FOREIGN KEY (Links to an external site.) 
  - Uniquely identifies a row/record in another table
CHECK (Links to an external site.) 
  - Ensures that all values in a column satisfy 
  a specific condition
DEFAULT (Links to an external site.) 
  - Sets a default value for a column when no value is specified
INDEX (Links to an external site.) 
  - Use to create and retrieve data from 
  the database very quickly


-- Comment 
CREATE DATABASE dealership_spring21;

\c dealership_winter20;

CREATE TABLE cars (
  id SERIAL PRIMARY KEY,
  make VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  year INTEGER NOT NULL,
  color VARCHAR(25) NOT NULL,
  mileage INTEGER NOT NULL,
  runs BOOLEAN DEFAULT true
)

-- Insert to the cars table
INSERT INTO cars (make, model, year, color, mileage) 
VALUES ('Mazda', 'CX9', 2018, 'white', 22000)

INSERT INTO cars (make, model, color, year, mileage, runs)
VALUES ('Jeep', 'Cherokee', 'Black', 2011, 332131, DEFAULT),
       ('Toyota', 'Tacoma', 'White', 2017, 50, DEFAULT),
       ('Ford', 'F150', 'Sliver', 1999, 100000, false),
       ('Toyota', 'Prius', 'Green', 2013, 54313, DEFAULT),
       ('Dodge', 'Ram', 'Blue', 1983, 65234132, false),
       ('Ford', 'Focus', 'Purple', 1993, 4321421, DEFAULT),
       ('Jaguar', 'F-Type', 'Gold', 2018, 0, DEFAULT);

-- Select 
SELECT * FROM cars;

-- WHERE 
SELECT * FROM cars
WHERE cars.year > 2005

SELECT make, model, year FROM cars
WHERE cars.year > 2005

-- AND OR NOT
SELECT * FROM cars
WHERE cars.year > 2005 AND cars.make = 'Toyota' 

SELECT * FROM cars
WHERE cars.year > 2005 OR cars.make = 'Toyota' )

SELECT * FROM cars
WHERE (cars.year > 2005 OR cars.make = 'Toyota' ) AND (cars.year > 2005 OR cars.make = 'Toyota' )

SELECT * FROM cars
WHERE NOT cars.year > 2005 

SELECT * FROM cars
WHERE cars.year < 2005 

-- order by
SELECT * FROM cars 
ORDER BY cars.mileage 

SELECT * FROM cars 
ORDER BY cars.mileage DESC

-- when updating and deleting be sure to include the item or condition
UPDATE cars 
SET runs = false 
WHERE cars.id = 3

DELETE FROM cars
WHERE cars.make = 'Jeep'

INSERT INTO cars (make, model, year, color, mileage) 
VALUES ('Toyota', 'Coralla', 2017, 'falcon', 76000)

-- Like 
SELECT * FROM cars 
WHERE cars.model LIKE 'F%'

-- IN 
SELECT * FROM cars 
WHERE cars.make IN ('Ford', 'Toyota')

-- between
SELECT make, model, mileage FROM cars
WHERE cars.mileage BETWEEN 30000 AND 100000;

SELECT column_name AS alias_name
FROM table_name; 

SELECT make, model, year AS y, mileage
FROM cars AS c
WHERE c.mileage = 1000;

-- JOINS
CREATE TABLE parts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(50),
  serial_number BIGINT UNIQUE NOT NULL,
  broken BOOLEAN DEFAULT false,
  car_id INTEGER REFERENCES cars
);

INSERT INTO parts (name, description, serial_number, car_id, broken)
VALUES (
         'Hood Scoop', 
         '10 More Horse Power', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1), 
         DEFAULT
       ),
       (
         'Spoiler', 
         '50 More Horse Power', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         true
       ),
       (
         'Rims And Tires', 
         'Looks So Good!', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         DEFAULT
       ),
       (
         'Lift Kit', 
         'Climb Mountains!', 
         (SELECT floor(random()*(5341254321-1+1))+1), 
         (SELECT id FROM cars ORDER BY RANDOM() LIMIT 1),
         true
       );

SELECT p.name AS part_name, p.broken, p.serial_number, c.make, c.model
FROM cars as c
INNER JOIN parts AS p ON p.car_id = c.id

-- drop
DROP TABLE cars
DROP DATABASE dealership_spring21

-- alter 
ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE table_name
ALTER COLUMN column_name datatype;