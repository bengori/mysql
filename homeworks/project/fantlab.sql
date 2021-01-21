-- MySQL Workbench Synchronization
-- Generated: 2021-01-21 02:04
-- Model: New Model
-- Version: 2.0
-- Project: сайт Лаборатория фантастики fantlab.ru
-- Author: Наталия
-- скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `fantlab`.`authors` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`country_id` INT(10) UNSIGNED NOT NULL,
	`firstname` VARCHAR(145) NOT NULL,
	`lastname` VARCHAR(145) NOT NULL,
	`birthday` DATE DEFAULT NULL,
	`deathdate` DATE DEFAULT NULL,
	`penname` VARCHAR(245) DEFAULT NULL COMMENT 'псевдонимы',
	`biography` TEXT DEFAULT NULL,
	`web` VARCHAR(145) DEFAULT NULL COMMENT 'сайт и ссылки(блог, например)',
	PRIMARY KEY (`id`),
	FULLTEXT INDEX `firstname` (`lastname`, `firstname`) INVISIBLE,
	FULLTEXT INDEX `lastname` (`lastname`, `firstname`) VISIBLE,
	INDEX `birthday` (`birthday` ASC) VISIBLE,
	INDEX `fk_authors_country1_idx` (`country_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_country1`
	FOREIGN KEY (`country_id`)
	REFERENCES `fantlab`.`country` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'авторы';

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`cycle_types_id` INT(10) UNSIGNED NOT NULL,
	`agereader_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(145) NOT NULL,
	`note` TEXT DEFAULT NULL,
	`description` TEXT DEFAULT NULL,
	PRIMARY KEY (`id`),
	FULLTEXT INDEX `name` (`name`) INVISIBLE,
	INDEX `fk_cycles_cycle_types1_idx` (`cycle_types_id` ASC) VISIBLE,
	INDEX `fk_cycles_agereader1_idx` (`agereader_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_cycle_types1`
	FOREIGN KEY (`cycle_types_id`)
	REFERENCES `fantlab`.`cycle_types` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_agereader1`
	FOREIGN KEY (`agereader_id`)
	REFERENCES `fantlab`.`agereader` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'циклы, журналы, анталогии, сборники';

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`agereader_id` INT(10) UNSIGNED NOT NULL,
	`language_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(145) NOT NULL,
	`created_at` YEAR NOT NULL COMMENT 'год издания',
	`note` TEXT DEFAULT NULL,
	PRIMARY KEY (`id`),
	FULLTEXT INDEX `name` (`name`) VISIBLE,
	INDEX `fk_literatures_agereader1_idx` (`agereader_id` ASC) VISIBLE,
	INDEX `fk_literatures_language1_idx` (`language_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_agereader1`
	FOREIGN KEY (`agereader_id`)
	REFERENCES `fantlab`.`agereader` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_language1`
	FOREIGN KEY (`language_id`)
	REFERENCES `fantlab`.`language` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'произведения';

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_authors` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`authors_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `authors_id`),
	INDEX `fk_literatures_has_authors_authors1_idx` (`authors_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_authors_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_authors_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_authors_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`genre` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'жанр/поджанр';

CREATE TABLE IF NOT EXISTS `fantlab`.`characteristic` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'общие характеристики';

CREATE TABLE IF NOT EXISTS `fantlab`.`placeaction` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'место действия';

CREATE TABLE IF NOT EXISTS `fantlab`.`timeaction` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'время действия';

CREATE TABLE IF NOT EXISTS `fantlab`.`story` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'сюжетные ходы';

CREATE TABLE IF NOT EXISTS `fantlab`.`linearity` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'линейность сюжета';

CREATE TABLE IF NOT EXISTS `fantlab`.`agereader` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(145) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'возраст читателя';

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_placeaction` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`placeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `placeaction_id`),
	INDEX `fk_literatures_has_placeaction_placeaction1_idx` (`placeaction_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_placeaction_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_placeaction_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_placeaction_placeaction1`
	FOREIGN KEY (`placeaction_id`)
	REFERENCES `fantlab`.`placeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_story` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`story_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `story_id`),
	INDEX `fk_literatures_has_story_story1_idx` (`story_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_story_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_story_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_story_story1`
	FOREIGN KEY (`story_id`)
	REFERENCES `fantlab`.`story` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_linearity` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`linearity_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `linearity_id`),
	INDEX `fk_literatures_has_linearity_linearity1_idx` (`linearity_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_linearity_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_linearity_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_linearity_linearity1`
	FOREIGN KEY (`linearity_id`)
	REFERENCES `fantlab`.`linearity` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_timeaction` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`timeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `timeaction_id`),
	INDEX `fk_literatures_has_timeaction_timeaction1_idx` (`timeaction_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_timeaction_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_timeaction_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_timeaction_timeaction1`
	FOREIGN KEY (`timeaction_id`)
	REFERENCES `fantlab`.`timeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_characteristic` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`characteristic_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `characteristic_id`),
	INDEX `fk_literatures_has_characteristic_characteristic1_idx` (`characteristic_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_characteristic_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_characteristic_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_characteristic_characteristic1`
	FOREIGN KEY (`characteristic_id`)
	REFERENCES `fantlab`.`characteristic` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_placeaction` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`placeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `placeaction_id`),
	INDEX `fk_cycles_has_placeaction_placeaction1_idx` (`placeaction_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_placeaction_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_placeaction_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_placeaction_placeaction1`
	FOREIGN KEY (`placeaction_id`)
	REFERENCES `fantlab`.`placeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_story` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`story_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `story_id`),
	INDEX `fk_cycles_has_story_story1_idx` (`story_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_story_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_story_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_story_story1`
	FOREIGN KEY (`story_id`)
	REFERENCES `fantlab`.`story` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_linearity` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`linearity_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `linearity_id`),
	INDEX `fk_cycles_has_linearity_linearity1_idx` (`linearity_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_linearity_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_linearity_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_linearity_linearity1`
	FOREIGN KEY (`linearity_id`)
	REFERENCES `fantlab`.`linearity` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_timeaction` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`timeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `timeaction_id`),
	INDEX `fk_cycles_has_timeaction_timeaction1_idx` (`timeaction_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_timeaction_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_timeaction_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_timeaction_timeaction1`
	FOREIGN KEY (`timeaction_id`)
	REFERENCES `fantlab`.`timeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_characteristic` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`characteristic_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `characteristic_id`),
	INDEX `fk_cycles_has_characteristic_characteristic1_idx` (`characteristic_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_characteristic_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_characteristic_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_characteristic_characteristic1`
	FOREIGN KEY (`characteristic_id`)
	REFERENCES `fantlab`.`characteristic` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycle_types` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'виды циклов: антологии, журналы, циклы, сборники';

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_genre` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`genre_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `genre_id`),
	INDEX `fk_authors_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
	INDEX `fk_authors_has_genre_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_genre_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_genre_genre1`
	FOREIGN KEY (`genre_id`)
	REFERENCES `fantlab`.`genre` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_placeaction` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`placeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `placeaction_id`),
	INDEX `fk_authors_has_placeaction_placeaction1_idx` (`placeaction_id` ASC) VISIBLE,
	INDEX `fk_authors_has_placeaction_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_placeaction_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_placeaction_placeaction1`
	FOREIGN KEY (`placeaction_id`)
	REFERENCES `fantlab`.`placeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_story` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`story_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `story_id`),
	INDEX `fk_authors_has_story_story1_idx` (`story_id` ASC) VISIBLE,
	INDEX `fk_authors_has_story_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_story_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_story_story1`
	FOREIGN KEY (`story_id`)
	REFERENCES `fantlab`.`story` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_linearity` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`linearity_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `linearity_id`),
	INDEX `fk_authors_has_linearity_linearity1_idx` (`linearity_id` ASC) VISIBLE,
	INDEX `fk_authors_has_linearity_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_linearity_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_linearity_linearity1`
	FOREIGN KEY (`linearity_id`)
	REFERENCES `fantlab`.`linearity` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_characteristic` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`characteristic_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `characteristic_id`),
	INDEX `fk_authors_has_characteristic_characteristic1_idx` (`characteristic_id` ASC) VISIBLE,
	INDEX `fk_authors_has_characteristic_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_characteristic_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_characteristic_characteristic1`
	FOREIGN KEY (`characteristic_id`)
	REFERENCES `fantlab`.`characteristic` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_timeaction` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`timeaction_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `timeaction_id`),
	INDEX `fk_authors_has_timeaction_timeaction1_idx` (`timeaction_id` ASC) VISIBLE,
	INDEX `fk_authors_has_timeaction_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_timeaction_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_timeaction_timeaction1`
	FOREIGN KEY (`timeaction_id`)
	REFERENCES `fantlab`.`timeaction` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`authors_has_agereader` (
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`agereader_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`authors_id`, `agereader_id`),
	INDEX `fk_authors_has_agereader_agereader1_idx` (`agereader_id` ASC) VISIBLE,
	INDEX `fk_authors_has_agereader_authors1_idx` (`authors_id` ASC) VISIBLE,
	CONSTRAINT `fk_authors_has_agereader_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_authors_has_agereader_agereader1`
	FOREIGN KEY (`agereader_id`)
	REFERENCES `fantlab`.`agereader` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_literatures` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `literatures_id`),
	INDEX `fk_cycles_has_literatures_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_literatures_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_literatures_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_literatures_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`editions` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`city` VARCHAR(45) NOT NULL,
	`publisher` VARCHAR(145) NOT NULL,
	`year` YEAR NOT NULL,
	`series` VARCHAR(45) DEFAULT NULL,
	`print` INT(11) NOT NULL,
	`ISBN` CHAR(13) NOT NULL COMMENT '10 или 13 цифр: x-xxx-xxxxx-x, xxx-x-xxx-xxxxx-x. Может быть несколько у одной книги. Сделаю допущение у одного издания один ISBN',
	`cover_type` ENUM('твердая', 'мягкая') NOT NULL,
	`format` VARCHAR(45) NOT NULL,
	`pages` INT(11) NOT NULL,
	`description` TEXT DEFAULT NULL,
	`content` TEXT DEFAULT NULL,
	`note` TEXT DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE,
	INDEX `fk_editions_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_editions_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'издания';

CREATE TABLE IF NOT EXISTS `fantlab`.`media` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`authors_id` INT(10) UNSIGNED DEFAULT NULL,
	`editions_id` INT(10) UNSIGNED DEFAULT NULL,
	`prise_id` INT(10) UNSIGNED DEFAULT NULL,
	`articles_id` INT(10) UNSIGNED DEFAULT NULL,
	`file` VARCHAR(45) DEFAULT NULL,
	`size` BIGINT(19) UNSIGNED DEFAULT NULL,
	`metadata` JSON DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_media_authors1_idx` (`authors_id` ASC) VISIBLE,
	INDEX `fk_media_editions1_idx` (`editions_id` ASC) VISIBLE,
	INDEX `fk_media_prise1_idx` (`prise_id` ASC) VISIBLE,
	INDEX `fk_media_articles1_idx` (`articles_id` ASC) VISIBLE,
	UNIQUE INDEX `idx_authors` (`id` ASC, `authors_id` ASC) INVISIBLE,
	UNIQUE INDEX `idx_editions` (`id` ASC, `editions_id` ASC) INVISIBLE,
	UNIQUE INDEX `idx_prise` (`id` ASC, `prise_id` ASC) INVISIBLE,
	UNIQUE INDEX `idx_articles` (`id` ASC, `articles_id` ASC) VISIBLE,
	CONSTRAINT `fk_media_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_media_editions1`
	FOREIGN KEY (`editions_id`)
	REFERENCES `fantlab`.`editions` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_media_prise1`
	FOREIGN KEY (`prise_id`)
	REFERENCES `fantlab`.`prise` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_media_articles1`
	FOREIGN KEY (`articles_id`)
	REFERENCES `fantlab`.`articles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'обложки изданий';

CREATE TABLE IF NOT EXISTS `fantlab`.`prise` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`country_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(145) NOT NULL,
	`presentation` DATE NOT NULL COMMENT 'первое вручение',
	`web` VARCHAR(145) DEFAULT NULL,
	`description` TEXT DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_prise_country1_idx` (`country_id` ASC) VISIBLE,
	CONSTRAINT `fk_prise_country1`
	FOREIGN KEY (`country_id`)
	REFERENCES `fantlab`.`country` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'награды и пермии (описание и ссылки)\n';

CREATE TABLE IF NOT EXISTS `fantlab`.`nomination` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`prise_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(145) NOT NULL,
	`year` YEAR NOT NULL,
	`note` VARCHAR(245) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_nomination_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	INDEX `fk_nomination_authors1_idx` (`authors_id` ASC) VISIBLE,
	INDEX `fk_nomination_prise1_idx` (`prise_id` ASC) VISIBLE,
	CONSTRAINT `fk_nomination_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_nomination_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_nomination_prise1`
	FOREIGN KEY (`prise_id`)
	REFERENCES `fantlab`.`prise` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'номинации список авторов и произведений';

CREATE TABLE IF NOT EXISTS `fantlab`.`articles` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(145) NOT NULL,
	`text_article` TEXT NOT NULL,
	`source` VARCHAR(145) DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_articles_authors1_idx` (`authors_id` ASC) VISIBLE,
	INDEX `fk_articles_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_articles_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_articles_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'статьи об авторах, произведениях';

CREATE TABLE IF NOT EXISTS `fantlab`.`films` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`authors_id` INT(10) UNSIGNED NOT NULL,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(245) NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `fk_films_authors1_idx` (`authors_id` ASC) VISIBLE,
	INDEX `fk_films_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_films_authors1`
	FOREIGN KEY (`authors_id`)
	REFERENCES `fantlab`.`authors` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_films_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'фильмы';

CREATE TABLE IF NOT EXISTS `fantlab`.`users` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`login` VARCHAR(45) NOT NULL,
	`name` VARCHAR(145) DEFAULT NULL COMMENT 'ФИО',
	`gender` ENUM('f', 'm') DEFAULT NULL,
	`birthday` DATE DEFAULT NULL,
	`email` VARCHAR(145) NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_visit` DATETIME DEFAULT NULL,
	`password` CHAR(65) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
	UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`messages` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`from_users_id` INT(10) UNSIGNED NOT NULL,
	`to_users_id` INT(10) UNSIGNED NOT NULL,
	`text` TEXT NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX `fk_messages_users1_idx` (`from_users_id` ASC) VISIBLE,
	INDEX `fk_messages_users2_idx` (`to_users_id` ASC) VISIBLE,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_messages_users1`
	FOREIGN KEY (`from_users_id`)
	REFERENCES `fantlab`.`users` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_messages_users2`
	FOREIGN KEY (`to_users_id`)
	REFERENCES `fantlab`.`users` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`comments` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`users_id` INT(10) UNSIGNED NOT NULL,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`text` TEXT NOT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX `fk_comments_users1_idx` (`users_id` ASC) VISIBLE,
	PRIMARY KEY (`id`),
	INDEX `fk_comments_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_comments_users1`
	FOREIGN KEY (`users_id`)
	REFERENCES `fantlab`.`users` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_comments_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`rating` (
	`users_id` INT(10) UNSIGNED NOT NULL,
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`value_rating` INT(2) NOT NULL COMMENT 'число от 1 до 10',
	INDEX `fk_rating_users1_idx` (`users_id` ASC) VISIBLE,
	INDEX `fk_rating_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_rating_users1`
	FOREIGN KEY (`users_id`)
	REFERENCES `fantlab`.`users` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_rating_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'оценка пользователя произведению\n';

CREATE TABLE IF NOT EXISTS `fantlab`.`literatures_has_genre` (
	`literatures_id` INT(10) UNSIGNED NOT NULL,
	`genre_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`literatures_id`, `genre_id`),
	INDEX `fk_literatures_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
	INDEX `fk_literatures_has_genre_literatures1_idx` (`literatures_id` ASC) VISIBLE,
	CONSTRAINT `fk_literatures_has_genre_literatures1`
	FOREIGN KEY (`literatures_id`)
	REFERENCES `fantlab`.`literatures` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_literatures_has_genre_genre1`
	FOREIGN KEY (`genre_id`)
	REFERENCES `fantlab`.`genre` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`cycles_has_genre` (
	`cycles_id` INT(10) UNSIGNED NOT NULL,
	`genre_id` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`cycles_id`, `genre_id`),
	INDEX `fk_cycles_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
	INDEX `fk_cycles_has_genre_cycles1_idx` (`cycles_id` ASC) VISIBLE,
	CONSTRAINT `fk_cycles_has_genre_cycles1`
	FOREIGN KEY (`cycles_id`)
	REFERENCES `fantlab`.`cycles` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
	CONSTRAINT `fk_cycles_has_genre_genre1`
	FOREIGN KEY (`genre_id`)
	REFERENCES `fantlab`.`genre` (`id`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `fantlab`.`country` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'список стран';

	CREATE TABLE IF NOT EXISTS `fantlab`.`language` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `languagecol_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'список языков';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
