-- Lab 4: Introduction to use of DataGrip. In this lab, we created and tested a database and tables from the given diagram using queries.
--Parth Patel , Keval Varia  ,Christopher De Jong

DROP TABLE author_title;
DROP TABLE books;
DROP TABLE publishers;
DROP TABLE authors;

CREATE TABLE authors(
    id              INTEGER NOT NULL,
    firstName       VARCHAR(20) NOT NULL,
    lastName        VARCHAR(20) NOT NULL,
    phone           CHAR(12) NOT NULL,
    city            VARCHAR(30) NOT NULL,
    region          VARCHAR(50) NOT NULL,
    country         VARCHAR(40) NOT NULL,
    booksWritten    INTEGER NOT NULL,           -- derived
    CONSTRAINT author_pk PRIMARY KEY (id),
    CONSTRAINT author_ck UNIQUE (firstName, lastName, phone));


CREATE TABLE publishers
(  id              INTEGER NOT NULL,
   name            VARCHAR(50) NOT NULL,
   city            VARCHAR(30) NOT NULL,
   region          VARCHAR(15) NOT NULL,
   country         VARCHAR(40) NOT NULL,
   books_published INTEGER NOT NULL,
   CONSTRAINT publisher_PK PRIMARY KEY(id),
   CONSTRAINT publisher_CK UNIQUE (name));


CREATE TABLE books(
    id              INTEGER NOT NULL,
    title           VARCHAR(50) NOT NULL,
    date_published  DATE NOT NULL,
    publisher       INTEGER NOT NULL,
    page_count      INTEGER NOT NULL,
    price           DOUBLE,
    sales           INTEGER,
    genre           VARCHAR(20) NOT NULL ,
    CONSTRAINT books_pk PRIMARY KEY (id),
    CONSTRAINT books_ck UNIQUE (title, date_published),
    CONSTRAINT books_fk FOREIGN KEY (publisher) REFERENCES  publishers(id) ON DELETE CASCADE
    --CONSTRAINT books_fk FOREIGN KEY (publisher) REFERENCES  publishers(id) ON DELETE RESTRICT
);


CREATE TABLE author_title(
    author INTEGER NOT NULL,
    book INTEGER NOT NULL,
    royalty_share DOUBLE,
    CONSTRAINT author_title_pk PRIMARY KEY (author, book),
--     CONSTRAINT author_title_fk FOREIGN KEY (author) REFERENCES authors(id) ON DELETE CASCADE,
--     CONSTRAINT author_title_fkk FOREIGN KEY (book) REFERENCES books(id) ON DELETE CASCADE
    CONSTRAINT author_title_fk FOREIGN KEY (author) REFERENCES authors(id) ON DELETE RESTRICT,
    CONSTRAINT author_title_fkk FOREIGN KEY (book) REFERENCES books(id) ON DELETE RESTRICT
);

-- Since we didn't know how to derive an attribute (booksWritten), we hardcoded it for now. I assume we will learn the
-- count() function or any alternative soon.
INSERT INTO authors(id, firstName, lastName, phone, city, region, country, booksWritten) VALUES
(012345, 'James', 'Bond', '5625551223', 'Bellflower', 'California', 'United States of America',2),
(023132, 'Fred', 'Smith', '5625553434', 'Cerritos', 'California', 'United States of America',1),
(012346, 'Joe', 'Jona', '5625552525', 'Artiesa', 'California', 'United States of America',4);

INSERT INTO publishers (id, name, city, region, country, books_published) VALUES
(345345, 'Empire, Madison', 'Las Vegas','Nevada', 'United States of America', 3435),
(364545, 'The Book Maker', 'Long Beach', 'California','United States of America', 563446),
(745464, 'The Better Book Maker', 'Cerritos', 'California','United States of America', 23423);

INSERT INTO books( id, title, date_published, publisher, page_count, price, sales, genre) VALUES
(432423, 'How To Ride a Bike', '2010-10-09', 345345, 32, 19.99, 124203, 'Guidebook'),
(634543, 'How Not to Code', '2013-11-06', 364545, 1337, 95.99, 30, 'Programming'),
(353542, 'The Jumping Rock', '1998-04-06', 745464, 353, 29.99, 34242534, 'Fairytale');

INSERT INTO author_title(author, book, royalty_share) VALUES
(012345, 432423, .50),
(023132, 432423, .50),
(012346, 634543, 1.00);

-- DELETE from author_title where author=012345;
-- CASCADE: Deletion made to author_title should delete only the author title relating to author #012345

-- DELETE FROM authors where city='Bellflower';
-- CASCADE: Deletion made in the authors table will also affect the data author_title table as result of cascade.

-- DELETE from author_title where author=012345;
-- RESTRICT: Deletion made to a valid key in the author_title should delete only the author title relating to author #012345

-- DELETE FROM authors where city='Bellflower';
-- RESTRICT: Deletion made to a valid attribute in the authors table will not affect any data in the author_title table.
-- ERROR RESULT: [2020-09-17 17:11:36] [23503][30000] DELETE on table 'AUTHORS' caused a violation of foreign key constraint 'AUTHOR_TITLE_FK' for key (12345).  The statement has been rolled back.
CREATE TABLE employees(
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1),
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
phone VARCHAR(12) NOT NULL,
salary double,
manager INTEGER,
CONSTRAINT employees_pk PRIMARY KEY (id),
CONSTRAINT employees_ck UNIQUE (first_name,last_name,phone),
CONSTRAINT employees_fk FOREIGN KEY (manager) REFERENCES employeed (id));