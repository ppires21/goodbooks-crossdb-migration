-- Create a keyspace
CREATE KEYSPACE IF NOT EXISTS goodbooks_keyspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

DROP TABLE IF EXISTS goodbooks_keyspace.books_all;
CREATE TABLE goodbooks_keyspace.books_all (
    book_id INT,
    goodreads_book_id INT,
    best_book_id INT,
    work_id INT,
    books_count INT,
    isbn TEXT,
    isbn13 TEXT,
    authors TEXT,
    original_publication_year INT,
    original_title TEXT,
    title TEXT,
    language_code TEXT,
    average_rating DECIMAL,
    ratings_count INT,
    work_ratings_count INT,
    work_text_reviews_count INT,
    ratings_1 INT,
    ratings_2 INT,
    ratings_3 INT,
    ratings_4 INT,
    ratings_5 INT,
    image_url TEXT,
    small_image_url TEXT,
    tag_id INT,
    tag_name TEXT,
    book_tag_count INT,
    ratings_user_id INT,
    user_rating INT,
    to_read_user_id INT,
    PRIMARY KEY (book_id, tag_id, ratings_user_id, to_read_user_id)
);


-- Comando colocado no terminal para aceder ao CQLSH:  docker exec -it bd2_cassandra cqlsh


-- Copy colocado no terminal 
COPY goodbooks_keyspace.books_all (book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn, isbn13, authors, original_publication_year, original_title, title, language_code, average_rating, ratings_count, work_ratings_count, work_text_reviews_count, ratings_1, ratings_2, ratings_3, ratings_4, ratings_5, image_url, small_image_url, tag_id, tag_name, book_tag_count, ratings_user_id, user_rating, to_read_user_id) 
FROM '/var/lib/cassandra/csv/books_all.csv' 
WITH DELIMITER = ',' AND HEADER = true;

select * from goodbooks_keyspace.books_all;



-- Pergunta 1 - Listar os livros por ordem crescente pelo respetivo ano de publicação.


DROP TABLE IF EXISTS goodbooks_keyspace.pergunta1;
CREATE TABLE goodbooks_keyspace.pergunta1 (
    book_id INT,
    goodreads_book_id INT,
    best_book_id INT,
    work_id INT,
    books_count INT,
    isbn TEXT,
    isbn13 TEXT,
    authors TEXT,
    original_publication_year INT,
    original_title TEXT,
    title TEXT,
    language_code TEXT,
    average_rating DECIMAL,
    ratings_count INT,
    work_ratings_count INT,
    work_text_reviews_count INT,
    ratings_1 INT,
    ratings_2 INT,
    ratings_3 INT,
    ratings_4 INT,
    ratings_5 INT,
    image_url TEXT,
    small_image_url TEXT,
    tag_id INT,
    tag_name TEXT,
    book_tag_count INT,
    ratings_user_id INT,
    user_rating INT,
    to_read_user_id INT,
    PRIMARY KEY ((original_publication_year), book_id)
) WITH CLUSTERING ORDER BY (book_id ASC);


INSERT INTO goodbooks_keyspace.pergunta1 (book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn, isbn13, authors, original_publication_year, original_title, title, language_code, average_rating, ratings_count, work_ratings_count, work_text_reviews_count, ratings_1, ratings_2, ratings_3, ratings_4, ratings_5, image_url, small_image_url, tag_id, tag_name, book_tag_count, ratings_user_id, user_rating, to_read_user_id)
SELECT book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn, isbn13, authors, original_publication_year, original_title, title, language_code, average_rating, ratings_count, work_ratings_count, work_text_reviews_count, ratings_1, ratings_2, ratings_3, ratings_4, ratings_5, image_url, small_image_url, tag_id, tag_name, book_tag_count, ratings_user_id, user_rating, to_read_user_id
FROM goodbooks_keyspace.books_all;


SELECT *
FROM goodbooks_keyspace.pergunta1
ORDER BY original_publication_year ASC, book_id ASC;



-- Pergunta 2 - Para cada livro com classificação inferior a quatro, listar o título que lhe corresponde.

                   
DROP TABLE IF EXISTS goodbooks_keyspace.pergunta2;
CREATE TABLE goodbooks_keyspace.pergunta2 (
  book_id INT,
  title TEXT,
  ratings_user_id INT,
  user_rating INT,
  PRIMARY KEY (book_id, user_rating, ratings_user_id)
);

INSERT INTO goodbooks_keyspace.pergunta2 (book_id, title, ratings_user_id, user_rating)
SELECT book_id, title, ratings_user_id, user_rating
FROM goodbooks_keyspace.books_all
WHERE user_rating > 0 AND user_rating < 4;

SELECT DISTINCT book_id, title
FROM goodbooks_keyspace.pergunta2;

                   

-- Pergunta 3 - Quantos livros existem sobre o utilizador user_id=8?


DROP TABLE IF EXISTS goodbooks_keyspace.pergunta3;
CREATE TABLE goodbooks_keyspace.pergunta3 (
    book_id INT,
    ratings_user_id INT,
    PRIMARY KEY (ratings_user_id, book_id)
);

INSERT INTO goodbooks_keyspace.pergunta3 (book_id, ratings_user_id)
SELECT book_id, ratings_user_id
FROM goodbooks_keyspace.books_all;

SELECT COUNT(*)
FROM goodbooks_keyspace.pergunta3
WHERE ratings_user_id = 8;



-- Pergunta 4 - Listar os vários livros por ordem do respetivo autor.


DROP TABLE IF EXISTS goodbooks_keyspace.pergunta4;
CREATE TABLE goodbooks_keyspace.pergunta4 (
    book_id INT,
    goodreads_book_id INT,
    best_book_id INT,
    work_id INT,
    books_count INT,
    isbn TEXT,
    isbn13 TEXT,
    authors TEXT,
    original_publication_year INT,
    original_title TEXT,
    title TEXT,
    language_code TEXT,
    average_rating DECIMAL,
    ratings_count INT,
    work_ratings_count INT,
    work_text_reviews_count INT,
    ratings_1 INT,
    ratings_2 INT,
    ratings_3 INT,
    ratings_4 INT,
    ratings_5 INT,
    image_url TEXT,
    small_image_url TEXT,
    tag_id INT,
    tag_name TEXT,
    book_tag_count INT,
    ratings_user_id INT,
    user_rating INT,
    to_read_user_id INT,
    PRIMARY KEY ((authors), book_id)
) WITH CLUSTERING ORDER BY (book_id ASC);


INSERT INTO goodbooks_keyspace.pergunta4 (book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn, isbn13, authors, original_publication_year, original_title, title, language_code, average_rating, ratings_count, work_ratings_count, work_text_reviews_count, ratings_1, ratings_2, ratings_3, ratings_4, ratings_5, image_url, small_image_url, tag_id, tag_name, book_tag_count, ratings_user_id, user_rating, to_read_user_id)
SELECT book_id, goodreads_book_id, best_book_id, work_id, books_count, isbn, isbn13, authors, original_publication_year, original_title, title, language_code, average_rating, ratings_count, work_ratings_count, work_text_reviews_count, ratings_1, ratings_2, ratings_3, ratings_4, ratings_5, image_url, small_image_url, tag_id, tag_name, book_tag_count, ratings_user_id, user_rating, to_read_user_id
FROM goodbooks_keyspace.books_all;


SELECT *
FROM goodbooks_keyspace.pergunta4
ORDER BY authors ASC, book_id ASC;


-- Pergunta 5 - Book_id, obra original e avaliação média de todos os livros com classificação superior a 4.5 estrelas.


DROP TABLE IF EXISTS goodbooks_keyspace.pergunta5;
CREATE TABLE goodbooks_keyspace.pergunta5 (
    book_id INT,
    original_title TEXT,
    average_rating DECIMAL,
    PRIMARY KEY (average_rating, book_id)
) WITH CLUSTERING ORDER BY (book_id ASC);


INSERT INTO goodbooks_keyspace.pergunta5 (book_id, original_title, average_rating)
SELECT book_id, original_title, average_rating
FROM goodbooks_keyspace.books_all;


SELECT book_id, original_title, average_rating
FROM goodbooks_keyspace.pergunta5
WHERE average_rating > 4.5;


-- Pergunta 6 - Mostrar autor e o livro original que contenha mais de 4 milhões de avaliações.


DROP TABLE IF EXISTS goodbooks_keyspace.pergunta6;
CREATE TABLE goodbooks_keyspace.pergunta6 (
    book_id INT,
    authors TEXT,
    original_title TEXT,
    ratings_count INT,
    PRIMARY KEY (ratings_count, book_id)
) WITH CLUSTERING ORDER BY (book_id ASC);


INSERT INTO goodbooks_keyspace.pergunta6 (book_id, authors, original_title, ratings_count)
SELECT book_id, authors, original_title, ratings_count
FROM goodbooks_keyspace.books_all;


SELECT authors, original_title
FROM goodbooks_keyspace.pergunta6
WHERE ratings_count > 4000000;









