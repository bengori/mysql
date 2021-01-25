-- VIEW
-- представление общая информация об авторах
CREATE OR REPLACE VIEW authors_view_all AS
SELECT 
	a.id AS author_id,
    CONCAT(a.firstname,' ',a.lastname) AS authorname, -- ФИО
	CONCAT(YEAR(a.birthday),'-',(IF (YEAR(a.deathdate),YEAR(a.deathdate),' '))) AS years, -- годы жизни
    country.`name` as country,
    comments_count(a.id) AS comments_cnt,
    editions_count(a.id) AS editions_cnt,
    films_count(a.id) AS films_cnt,
    avg_rating_value(a.id) AS avg_rating,
    rating_count(a.id) AS rating_count
FROM authors AS a
LEFT JOIN country ON a.country_id = country.id
WHERE a.id=a.id;

SELECT * FROM authors_view_all;

-- представление 10 последних по времени изданий
CREATE OR REPLACE VIEW new_editions AS
SELECT  
	CONCAT(a.firstname,' ',a.lastname) AS authors_name,
    literatures.`name` AS literatures_name,
    literatures.created_at AS literatures_created,
    editions.`year` AS year_print
FROM authors as a
LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=a.id
LEFT JOIN literatures ON literatures.id=literatures_has_authors.literatures_id
LEFT JOIN editions ON editions.literatures_id=literatures_has_authors.literatures_id
GROUP BY a.id
ORDER BY year_print DESC
LIMIT 10;

SELECT * FROM new_editions;

-- представление самые популярные 10 произведений 
CREATE OR REPLACE VIEW top_literatures AS
SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.`name`,
    literatures.created_at,
    ROUND(AVG(rating.value_rating),2) AS avg_rating
FROM literatures 
JOIN rating ON rating.literatures_id=literatures.id
LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
GROUP BY literatures.id
ORDER BY avg_rating DESC
LIMIT 10;

SELECT * FROM top_literatures;

-- лучшие авторы по средней оценке
CREATE OR REPLACE VIEW top_authors AS
SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    avg_rating_value(authors.id) AS avg_rating,
    rating_count(authors.id) AS rating_count 
FROM literatures 
JOIN rating ON rating.literatures_id=literatures.id
LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
GROUP BY literatures.id
ORDER BY avg_rating DESC
LIMIT 10;

-- представление самые рецензируемые авторы
CREATE OR REPLACE VIEW top_comments AS
SELECT 
	authors.id AS authors_id,
    CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    count(comments.`text`) AS comments_count,
    avg_rating_value(authors.id) AS avg_rating
FROM authors
LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=authors.id
LEFT JOIN comments ON comments.literatures_id=literatures_has_authors.literatures_id
GROUP BY  authors.id
ORDER BY comments_count DESC
LIMIT 10;