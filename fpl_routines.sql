CREATE DATABASE  IF NOT EXISTS `fpl` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fpl`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: fpl
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'fpl'
--
/*!50003 DROP PROCEDURE IF EXISTS `getFixtures` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getFixtures`(
    IN requested_gameweek varchar(45)
)
BEGIN
SELECT f.id, f.home_team, ht.strength AS home_team_strength, f.away_team,  at.strength AS away_team_strength
FROM fixtures AS f
INNER JOIN teams AS ht ON f.home_team=ht.id
INNER JOIN teams AS at ON f.away_team=at.id
WHERE gameweek = requested_gameweek;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPlayers`(
    IN requested_position int
)
BEGIN
SELECT p.id, p.name, p.team, p.form, p.influence, p.creativity, p.threat, p.ict_index, p.xG, p.xA, p.xGI, p.xGC
FROM fpl.players AS p
WHERE p.availability = 'a' AND p.position = requested_position;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upsertFixtureData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upsertFixtureData`(
    IN new_id int,
    IN new_gw int,
    IN new_h_team int,
    IN new_a_team int
)
BEGIN
	INSERT INTO fixtures (id, gameweek, home_team, away_team)
	VALUES (new_id, new_gw, new_h_team, new_a_team)
    ON DUPLICATE KEY UPDATE 
		id = VALUES(id),
		gameweek = VALUES(gameweek),
		home_team = VALUES(home_team),
		away_team = VALUES(away_team);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upsertGameweekData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upsertGameweekData`(
    IN new_id int,
    IN new_name varchar(45),
    IN new_is_next varchar(45)
)
BEGIN
	INSERT INTO gameweeks (id, name, is_next)
	VALUES (new_id, new_name, new_is_next)
    ON DUPLICATE KEY UPDATE 
		id = VALUES(id),
		name = VALUES(name),
		is_next = VALUES(is_next);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upsertPlayerData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upsertPlayerData`(
    IN new_id int,
    IN new_name varchar(45),
    IN new_team int,
    IN new_pos int,
    IN new_available varchar(45),
    IN new_price int,
    IN new_form varchar(45),
    IN new_i varchar(45),
    IN new_c varchar(45),
    IN new_t varchar(45),
    IN new_ict varchar(45),
    IN new_xg varchar(45),
    IN new_xa varchar(45),
    IN new_xgi varchar(45),
    IN new_xgc varchar(45)
)
BEGIN
	INSERT INTO players (id, name, team, position, availability, price, form, influence, creativity, threat, ict_index, xG, xA, xGI, xGC)
	VALUES (new_id, new_name, new_team, new_pos, new_available, new_price, new_form, new_i, new_c, new_t, new_ict, new_xg, new_xa, new_xgi, new_xgc)
    ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		name = VALUES(name),
		team = VALUES(team),
		position = VALUES(position),
		availability = VALUES(availability),
		price = VALUES(price),
		form = VALUES(form),
		influence = VALUES(influence),
		creativity = VALUES(creativity),
		threat = VALUES(threat),
		ict_index = VALUES(ict_index),
		xG = VALUES(xG),
		xA = VALUES(xA),
		xGI = VALUES(xGI),
		xGC = VALUES(xGC);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upsertPrediction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upsertPrediction`(
    IN new_player int,
    IN new_gameweek int,
    IN new_fixture int,
    IN new_prediction varchar(45),
    IN new_confidence_blank varchar(45),
    IN new_confidence_return varchar(45)
)
BEGIN
	INSERT INTO predictions (player, gameweek, fixture, prediction, confidence_blank, confidence_return)
	VALUES (new_player, new_gameweek, new_fixture, new_prediction, new_confidence_blank, new_confidence_return)
    ON DUPLICATE KEY UPDATE 
		player = VALUES(player),
		gameweek = VALUES(gameweek),
		fixture = VALUES(fixture),
		prediction = VALUES(prediction),
		confidence_blank = VALUES(confidence_blank),
		confidence_return = VALUES(confidence_return);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upsertTeamData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upsertTeamData`(
    IN new_id int,
    IN new_name varchar(45),
    IN new_form varchar(45),
    IN new_strength int,
    IN new_ovr_strength_h int,
    IN new_ovr_strength_a int,
    IN new_atk_strength_h int,
    IN new_atk_strength_a int,
    IN new_def_strength_h int,
    IN new_def_strength_a int
)
BEGIN
	INSERT INTO teams (id, name, form, strength, overall_strength_home, overall_strength_away, attack_strength_home, attack_strength_away, defence_strength_home, defence_strength_away)
	VALUES (new_id, new_name, new_form, new_strength, new_ovr_strength_h, new_ovr_strength_a, new_atk_strength_h, new_atk_strength_a, new_def_strength_h, new_def_strength_a)
    ON DUPLICATE KEY UPDATE
		id = VALUES(id),
		name = VALUES(name),
		form = VALUES(form),
		strength = VALUES(strength),
		overall_strength_home = VALUES(overall_strength_home),
		overall_strength_away = VALUES(overall_strength_away),
		attack_strength_home = VALUES(attack_strength_home),
		attack_strength_away = VALUES(attack_strength_away),
		defence_strength_home = VALUES(defence_strength_home),
		defence_strength_away = VALUES(defence_strength_away);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-20 15:49:09
