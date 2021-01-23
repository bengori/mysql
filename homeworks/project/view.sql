-- количество отзывов у каждого произведения
-- у одного произведения может быть несколько авторов (соавторство) 

SELECT
	literatures_has_authors.authors_id,
    CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.id AS literature_id,
    literatures.`name`,
    (SELECT count(id) FROM comments where comments.literatures_id = literatures.id) as count_comments
FROM literatures
LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id;	

-- количество отзывов у каждого произведения конкретного автора 
SELECT
	literatures_has_authors.authors_id,
    CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.id AS literature_id,
    literatures.`name`,
    (SELECT count(id) FROM comments where comments.literatures_id = literatures.id) as count_comments
FROM literatures
LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
LEFT JOIN authors ON literatures_has_authors.authors_id=authors.id
WHERE authors_id=34;

-- количество оценок у каждого произведения
SELECT 
	literatures.id,
    literatures.`name`,
    COUNT(value_rating) AS count_rating
FROM literatures 
LEFT JOIN rating ON rating.literatures_id=literatures.id group by literatures.id;

-- количество отзывов по произведениям всех авторов

SELECT 
	authors.id,
    CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures_has_authors.literatures_id,
    count(comments.`text`) AS comments_count
FROM authors
LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=authors.id
LEFT JOIN comments ON comments.literatures_id=literatures_has_authors.literatures_id
GROUP BY  literatures_has_authors.literatures_id;


-- средний рейтинг произведения (сумма оценок на их количество)

SELECT 
	literatures.id,
    literatures.`name`,
    ROUND(AVG(rating.value_rating),2) AS avg_rating
FROM literatures 
JOIN rating ON rating.literatures_id=literatures.id
GROUP BY literatures.id
ORDER BY avg_rating DESC;

-- самые популярные 10 произведений 

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


-- информация о классификации произведения id = 4

SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.`name`,
    literatures.created_at,
    genre.`name`,
    characteristic.`name`,
    placeaction.`name`,
    timeaction.`name`,
    story.`name`,
    linearity.`name`,
    agereader.`name`
FROM literatures
JOIN literatures_has_authors ON literatures_has_authors.literatures_id=literatures.id
JOIN authors ON literatures_has_authors.authors_id=authors.id
LEFT JOIN literatures_has_characteristic ON literatures_has_characteristic.literatures_id=literatures.id
LEFT JOIN characteristic ON characteristic.id=literatures_has_characteristic.characteristic_id
LEFT JOIN literatures_has_genre ON literatures_has_genre.literatures_id=literatures.id
LEFT JOIN genre ON genre.id=literatures_has_genre.genre_id
LEFT JOIN literatures_has_placeaction ON literatures_has_placeaction.literatures_id=literatures.id
LEFT JOIN placeaction ON placeaction.id=literatures_has_placeaction.placeaction_id
LEFT JOIN literatures_has_timeaction ON literatures_has_timeaction.literatures_id=literatures.id
LEFT JOIN timeaction ON timeaction.id=literatures_has_timeaction.timeaction_id
LEFT JOIN literatures_has_story ON literatures_has_story.literatures_id=literatures.id
LEFT JOIN story ON story.id=literatures_has_story.story_id
LEFT JOIN literatures_has_linearity ON literatures_has_linearity.literatures_id=literatures.id
LEFT JOIN linearity ON linearity.id=literatures_has_linearity.linearity_id
LEFT JOIN agereader ON agereader.id=literatures.agereader_id
WHERE literatures.id = 4;

-- информация о классификации произведений автора id = 57
 


-- представления и выборки, которые выводят сводную информацию о конкретном авторе, в том числе сводные сведения о нем, 10 наиболее популярных произведений, 
-- 10 последних по времени изданий, 10 серий (при наличии), награды, список фильмов (не более 10) и список статей не более 10

CREATE OR REPLACE VIEW authors_view AS
SELECT 
	a.id AS author_id,
    CONCAT(a.firstname,' ',a.lastname) AS authorname,
	YEAR(a.birthday) AS born,
    country.`name` as country,
    literatures.`name` AS literatures_name
FROM authors AS a
JOIN country
JOIN literatures
JOIN literatures_has_authors AS l
-- JOIN editions AS e
-- JOIN cycles AS c
-- JOIN prise AS p
-- JOIN films AS f
-- JOIN articles
ON a.country_id = country.id and a.id = l.authors_id and l.literatures_id = literatures.id;


SELECT * FROM authors_view;