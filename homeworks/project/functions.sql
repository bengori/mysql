-- FUNCTIONS
-- функции для представлений: подсчет количества отзывов, количества изданий и количества экранизаций по конкретному автору

-- подсчет количества отзывов по автору
DROP function IF EXISTS comments_count;
DELIMITER $$
CREATE FUNCTION comments_count (authors_id_in INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE cnt_comments INT;
    SET cnt_comments = (
        SELECT
			COUNT(comments.`text`) AS comments_count    
		FROM authors AS a
		LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=a.id
		LEFT JOIN comments ON comments.literatures_id=literatures_has_authors.literatures_id
        WHERE a.id=authors_id_in
    );
RETURN cnt_comments;
END$$
DELIMITER ;
-- подсчет количества изданий по автору
DROP function IF EXISTS editions_count;
DELIMITER $$
CREATE FUNCTION editions_count (authors_id_in INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE cnt_editions INT;
    SET cnt_editions = (
        SELECT  
			COUNT(editions.ISBN) AS editions_count    
		FROM authors as a
		LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=a.id
		LEFT JOIN editions ON editions.literatures_id=literatures_has_authors.literatures_id
        WHERE a.id=authors_id_in
    );
RETURN cnt_editions;
END$$
DELIMITER ;

-- подсчет количества экранизаций по автору
DROP function IF EXISTS films_count;
DELIMITER $$
CREATE FUNCTION films_count (authors_id_in INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE cnt_films INT;
    SET cnt_films = (
        SELECT  
			COUNT(films.`name`) AS films_count    
		FROM authors
		LEFT JOIN films ON films.authors_id=authors.id
		WHERE authors.id=authors_id_in
    );
RETURN cnt_films;
END$$
DELIMITER ;

-- функция по посчету количества оценок произведений автора
DROP function IF EXISTS rating_count;
DELIMITER $$
CREATE FUNCTION rating_count (authors_id_in INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE cnt_rating INT;
    SET cnt_rating = (
        SELECT
			count(rating.literatures_id) as count_rating
		FROM literatures
		LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
		LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
        LEFT JOIN rating ON rating.literatures_id = literatures.id
        WHERE authors.id=authors_id_in
        group by authors.id
	);
RETURN cnt_rating;
END$$
DELIMITER ;

-- функция по подсчету средней оценки по автору
DROP function IF EXISTS avg_rating_value;
DELIMITER $$
CREATE FUNCTION avg_rating_value (authors_id_in INT)
RETURNS FLOAT READS SQL DATA
BEGIN
    DECLARE cnt_rating INT;
    DECLARE sum_rating INT;
    SET cnt_rating = (
        SELECT
			count(rating.literatures_id) as count_rating
		FROM literatures
		LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
		LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
        LEFT JOIN rating ON rating.literatures_id = literatures.id
        WHERE authors.id=authors_id_in
        group by authors.id
	);
SET sum_rating = (
        SELECT
			sum(rating.value_rating) as sum_rating
		FROM literatures
		LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
		LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
        LEFT JOIN rating ON rating.literatures_id = literatures.id
        WHERE authors.id=authors_id_in
        group by authors.id
	);
RETURN ROUND((sum_rating/cnt_rating),2);
END$$
DELIMITER ;

SELECT rating_count(59);
SELECT rating_count(55);
SELECT avg_rating_value(59);
SELECT avg_rating_value(55);
