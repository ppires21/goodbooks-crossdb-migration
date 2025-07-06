DROP DATABASE IF EXISTS goodbooks;

CREATE DATABASE goodbooks;

USE goodbooks;

DROP TABLE IF EXISTS book_tags;
CREATE TABLE book_tags (
    book_id INT,
    tag_id INT,
    count INT,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (tag_id) REFERENCES tags (tag_id),
    PRIMARY KEY (book_id, tag_id, count)
);

DROP TABLE IF EXISTS books;
CREATE TABLE books (
    book_id INT,
    goodreads_book_id INT,
    best_book_id INT,
    work_id INT,
    books_count INT,
    isbn VARCHAR(20),
    isbn13 VARCHAR(20),
    authors VARCHAR(200),
    original_publication_year INT,
    original_title VARCHAR(200),
    title VARCHAR(200),
    language_code VARCHAR(10),
    average_rating DECIMAL(3,2),
    ratings_count INT,
    work_ratings_count INT,
    work_text_reviews_count INT,
    ratings_1 INT,
    ratings_2 INT,
    ratings_3 INT,
    ratings_4 INT,
    ratings_5 INT,
    image_url VARCHAR(500),
    small_image_url VARCHAR(500),
    PRIMARY KEY (book_id)
);

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (	
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    rating INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    PRIMARY KEY (user_id, book_id, rating)
);

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    tag_id INT NOT NULL,
    tag_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (tag_id)
);

DROP TABLE IF EXISTS to_read;
CREATE TABLE to_read (
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    PRIMARY KEY (user_id, book_id)
);


LOAD DATA INFILE '/var/lib/mysql/csv/book_tags.csv'
INTO TABLE book_tags
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/books.csv'
INTO TABLE books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/ratings.csv'
INTO TABLE ratings
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/tags.csv'
INTO TABLE tags
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csw    v/to_read.csv'
INTO TABLE to_read
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;



-- Pergunta 1
Select *
From books
Order by original_publication_year asc;

-- Pergunta 2
select title
from books
where book_id in (select book_id
                    from ratings
                    where rating<4);
                   
-- Pergunta 3
select count(*) 
from ratings 
where user_id = 8;	

-- Pergunta 4
Select *
From books
Order by authors;

-- Pergunta 5
Select book_id, original_title, average_rating 
From books
Where average_rating > 4.5;

-- Pergunta 6
Select authors, original_title 
From books
Where ratings_count > 4000000;



