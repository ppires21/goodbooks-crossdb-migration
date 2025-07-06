// Apagar tudo
MATCH (n)
DETACH DELETE n



LOAD CSV WITH HEADERS FROM 'file:///books.csv' AS row
CREATE (b:Book {
  book_id: toInteger(row.book_id),
  goodreads_book_id: toInteger(row.goodreads_book_id),
  best_book_id: toInteger(row.best_book_id),
  work_id: toInteger(row.work_id),
  books_count: toInteger(row.books_count),
  isbn: row.isbn,
  isbn13: row.isbn13,
  authors: row.authors,
  original_publication_year: toInteger(row.original_publication_year),
  original_title: row.original_title,
  title: row.title,
  language_code: row.language_code,
  average_rating: toFloat(row.average_rating),
  ratings_count: toInteger(row.ratings_count),
  work_ratings_count: toInteger(row.work_ratings_count),
  work_text_reviews_count: toInteger(row.work_text_reviews_count),
  ratings_1: toInteger(row.ratings_1),
  ratings_2: toInteger(row.ratings_2),
  ratings_3: toInteger(row.ratings_3),
  ratings_4: toInteger(row.ratings_4),
  ratings_5: toInteger(row.ratings_5),
  image_url: row.image_url,
  small_image_url: row.small_image_url
});

LOAD CSV WITH HEADERS FROM 'file:///tags.csv' AS row
CREATE (t:Tag {tag_id: toInteger(row.tag_id), tag_name: row.tag_name});

LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS row
MERGE (u:User {user_id: toInteger(row.user_id)});

LOAD CSV WITH HEADERS FROM 'file:///book_tags.csv' AS row
MATCH (b:Book {book_id: toInteger(row.book_id)}), (t:Tag {tag_id: toInteger(row.tag_id)})
CREATE (b)-[:HAS_TAG {count: toInteger(row.count)}]->(t);

LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS row
MATCH (u:User {user_id: toInteger(row.user_id)}), (b:Book {book_id: toInteger(row.book_id)})
MERGE (u)-[r:RATED]->(b)
ON CREATE SET r.rating = toInteger(row.rating);

LOAD CSV WITH HEADERS FROM 'file:///to_read.csv' AS row
MERGE (u:User {user_id: toInteger(row.user_id)})
MERGE (b:Book {book_id: toInteger(row.book_id)})
MERGE (u)-[:TO_READ]->(b);




-- Mostrar tudo
match (a) return a;


-- Pergunta 1 - Listar os livros por ordem crescente pelo respetivo ano de publicação - certo

MATCH (b:Book)
RETURN b
ORDER BY b.original_publication_year ASC;


-- Pergunta 2 - Para cada livro com classificação inferior a 4, listar o título que lhe corresponde 

MATCH (b:Book)<-[:RATED]-(u:User)		--PROBLEMA NAS RATED!!!
WHERE u.rating < 4
RETURN b.title;

-- Melhor

MATCH (b:Book)<-[r:RATED]-(u:User)
WHERE r.rating < 4
RETURN b;


-- Pergunta 3 - Quantas avaliações foram feitas pelo utilizador user_id = 8? - certo

MATCH (u:User {user_id: 8})-[r:RATED]->(b:Book)
WHERE r.rating > 0
RETURN COUNT(b);


-- Pergunta 4 - Listar os vários livros por ordem alfabética do nome do respetivo autor. - certo

MATCH (b:Book)
RETURN b
ORDER BY b.authors;


-- Pergunta 5- Book_id, obra original e avaliação média de todos os livros com classificação superior a 4.5 estrelas. - certo

MATCH (b:Book)
WHERE b.average_rating > 4.5
RETURN b.book_id, b.original_title, b.average_rating


-- Pergunta 6- Mostrar autores e o livro original que contenha mais de 4 milhões de avaliações. - certo

MATCH (b:Book)
WHERE b.ratings_count > 4000000
RETURN b.authors, b.original_title



