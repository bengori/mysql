-- Рекомендации книг по прочитанной книге (другие книги автора или цикла, книги такого жанра)
DROP PROCEDURE IF EXISTS `books_offers`;
DELIMITER $$
CREATE PROCEDURE `books_offers`(IN literatures_id_in INT)
BEGIN
	SELECT 
		literatures_has_authors.literatures_id,
        literatures.`name`,
        CONCAT(authors.firstname,' ',authors.lastname) AS authors_name
	FROM literatures_has_authors
    JOIN literatures ON literatures.id=literatures_has_authors.literatures_id
    JOIN authors ON authors.id=literatures_has_authors.literatures_id
	WHERE authors_id = ANY (SELECT authors_id FROM literatures_has_authors WHERE literatures_has_authors.literatures_id = literatures_id_in) AND
		literatures_has_authors.literatures_id!=literatures_id_in 
	UNION
	SELECT
        literatures_has_genre.literatures_id,
        literatures.`name`,
        CONCAT(authors.firstname,' ',authors.lastname) AS authors_name
	FROM literatures_has_genre
	JOIN literatures ON literatures.id=literatures_has_genre.literatures_id
    JOIN literatures_has_authors ON literatures.id=literatures_has_authors.literatures_id
    JOIN authors ON authors.id=literatures_has_authors.literatures_id
	WHERE genre_id = ANY (SELECT genre_id FROM literatures_has_genre WHERE literatures_has_genre.literatures_id = literatures_id_in) AND
		literatures_has_genre.literatures_id!=literatures_id_in
	ORDER BY RAND()
	LIMIT 3;
END$$

DELIMITER ;

CALL books_offers(65);

-- определяем id автора, ищем по имени и фамилии
DROP PROCEDURE IF EXISTS `search_author_id`;
DELIMITER $$
CREATE PROCEDURE `search_authors_id` (IN lastname_firstname VARCHAR(145))
BEGIN
	SELECT 
		authors.id,
        authors.`firstname`,
        authors.`lastname`
	FROM authors
	WHERE MATCH (authors.lastname,authors.firstname) AGAINST (lastname_firstname)
    ORDER BY (MATCH (authors.lastname,authors.firstname) AGAINST (lastname_firstname)) DESC
	LIMIT 5;
END$$

DELIMITER ; 

CALL search_authors_id('anderson');


-- дата смерти автора должна быть позднее даты рождения
DROP TRIGGER IF EXISTS `before_update_authors`;
DELIMITER $$
CREATE TRIGGER `before_update_authors` BEFORE UPDATE ON `authors` FOR EACH ROW BEGIN
		IF NEW.deathdate < NEW.birthday THEN
		SET NEW.deathdate = OLD.deathdate;
    END IF;
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS `before_insert_authors`;
DELIMITER $$
CREATE TRIGGER `before_insert_authors` BEFORE INSERT ON `authors` FOR EACH ROW BEGIN
		IF NEW.deathdate < NEW.birthday THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error in fields `deathdate`. Value can not be < 'birthday'";
		END IF;
END$$

DELIMITER ;