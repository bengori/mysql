-- SELECT-ы
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

-- количество отзывов по произведениям всех авторов (если произведение в сооавторстве отзывы дублируются)

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


-- информация о классификации произведения id = 4

SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.`name` AS literatures_name,
    literatures.created_at AS created_at,
    genre.`name` AS genre,
    characteristic.`name` AS characteristic,
    placeaction.`name` AS placeaction,
    timeaction.`name` AS timeaction,
    story.`name` AS story,
    linearity.`name` AS linearity,
    agereader.`name` AS agereader
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

-- информация о классификации произведений автора id = 22
 
SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    genre.`name` AS genre,
    characteristic.`name` AS characteristic,
    placeaction.`name` AS placeaction,
    timeaction.`name` AS timeaction,
    story.`name` AS story,
    linearity.`name` AS linearity,
    agereader.`name` AS agereader
FROM authors
LEFT JOIN authors_has_characteristic ON authors_has_characteristic.authors_id=authors.id
LEFT JOIN characteristic ON characteristic.id=authors_has_characteristic.characteristic_id
LEFT JOIN authors_has_genre ON authors_has_genre.authors_id=authors.id
LEFT JOIN genre ON genre.id=authors_has_genre.genre_id
LEFT JOIN authors_has_placeaction ON authors_has_placeaction.authors_id=authors.id
LEFT JOIN placeaction ON placeaction.id=authors_has_placeaction.placeaction_id
LEFT JOIN authors_has_timeaction ON authors_has_timeaction.authors_id=authors.id
LEFT JOIN timeaction ON timeaction.id=authors_has_timeaction.timeaction_id
LEFT JOIN authors_has_story ON authors_has_story.authors_id=authors.id
LEFT JOIN story ON story.id=authors_has_story.story_id
LEFT JOIN authors_has_linearity ON authors_has_linearity.authors_id=authors.id
LEFT JOIN linearity ON linearity.id=authors_has_linearity.linearity_id
LEFT JOIN authors_has_agereader ON authors_has_agereader.authors_id=authors.id
LEFT JOIN agereader ON agereader.id=authors_has_agereader.agereader_id
WHERE authors.id = 22;

-- список статей автора с id=71 

SELECT 
	CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.id AS literatures_id,
    literatures.`name` AS literatures_name,
    articles.`name` AS articles_name    
FROM authors 
JOIN articles ON articles.authors_id=authors.id
JOIN literatures ON literatures.id=articles.literatures_id
WHERE authors.id=71;

-- награды  автора id=17
SELECT
	authors.id AS authors_id,
    CONCAT(authors.firstname,' ',authors.lastname) AS authors_name,
    literatures.`name` AS literatures_name,
    prise.`name` AS prise_name,
    country.`name` AS country,
    nomination.`name` AS nomination_name,
    nomination.`year` AS nomination_year
FROM authors
LEFT JOIN nomination ON nomination.authors_id=authors.id
LEFT JOIN prise ON prise.id=nomination.prise_id
LEFT JOIN literatures ON literatures.id=nomination.literatures_id
LEFT JOIN country ON country.id=prise.country_id
WHERE authors.id=22;


-- медиа автора id=32 (его фото) и медиа его изданий 
SELECT 
	media.id AS media_id,
	media.`file`,
	media.size,
	media.metadata,
	media.created_at
FROM media
WHERE authors_id=32 OR editions_id IN
(SELECT 
	editions.id
FROM editions
LEFT JOIN literatures_has_authors ON literatures_has_authors.literatures_id=editions.literatures_id
LEFT JOIN authors ON authors.id=literatures_has_authors.authors_id
where authors.id=32);


-- запрос-выборка количество отзывов по произведениям авторов
SELECT  
	a.id AS author_id,
    CONCAT(a.firstname,' ',a.lastname) AS authorname, -- ФИО
	COUNT(comments.`text`) AS comments_count    
FROM authors AS a
LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=a.id
LEFT JOIN comments ON comments.literatures_id=literatures_has_authors.literatures_id
GROUP BY a.id;

-- запрос-выборка количества изданий по произведениям авторов
SELECT  
	a.id AS authors_id,
    COUNT(editions.ISBN) AS editions_count    
FROM authors as a
LEFT JOIN literatures_has_authors ON literatures_has_authors.authors_id=a.id
LEFT JOIN editions ON editions.literatures_id=literatures_has_authors.literatures_id
GROUP BY a.id;

-- запрос-выборка количества экранизаций по произведениям авторов
SELECT  
	authors.id AS authors_id,
    COUNT(films.`name`) AS films_count    
FROM authors
LEFT JOIN films ON films.authors_id=authors.id
GROUP BY authors.id;
