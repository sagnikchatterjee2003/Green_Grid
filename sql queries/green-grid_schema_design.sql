-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema green-grid
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema green-grid
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `green-grid` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `green-grid` ;

-- -----------------------------------------------------
-- Table `green-grid`.`zones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `green-grid`.`zones` (
  `zone_id` INT NOT NULL,
  `zone_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`zone_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `green-grid`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `green-grid`.`customers` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `zone_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `zone_id` (`zone_id` ASC) VISIBLE,
  CONSTRAINT `customers_ibfk_1`
    FOREIGN KEY (`zone_id`)
    REFERENCES `green-grid`.`zones` (`zone_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `green-grid`.`meters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `green-grid`.`meters` (
  `meter_id` INT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `installation_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`meter_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `meters_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `green-grid`.`customers` (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `green-grid`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `green-grid`.`billing` (
  `bill_id` VARCHAR(36) NOT NULL,
  `meter_id` INT NULL DEFAULT NULL,
  `billing_date` DATE NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `payment_status` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `meter_id` (`meter_id` ASC) VISIBLE,
  CONSTRAINT `billing_ibfk_1`
    FOREIGN KEY (`meter_id`)
    REFERENCES `green-grid`.`meters` (`meter_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `green-grid`.`consumption_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `green-grid`.`consumption_logs` (
  `log_id` VARCHAR(50) NOT NULL,
  `meter_id` INT NULL DEFAULT NULL,
  `reading_date` DATE NULL DEFAULT NULL,
  `reading_time` TIME NULL DEFAULT NULL,
  `units_consumed` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  INDEX `meter_id` (`meter_id` ASC) VISIBLE,
  CONSTRAINT `consumption_logs_ibfk_1`
    FOREIGN KEY (`meter_id`)
    REFERENCES `green-grid`.`meters` (`meter_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
