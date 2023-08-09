-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema studyERD
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Member` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Member` (
  `MEMBER_ID` INT NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  `CITY` VARCHAR(45) NULL,
  `STREET` VARCHAR(45) NULL,
  `ZIPCODE` VARCHAR(45) NULL,
  PRIMARY KEY (`MEMBER_ID`),
  UNIQUE INDEX `MEMBER_ID_UNIQUE` (`MEMBER_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Delivery` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Delivery` (
  `DELIVERY_ID` INT NOT NULL,
  `CITY` VARCHAR(45) NULL,
  `STREET` VARCHAR(45) NULL,
  `ZIPCODE` VARCHAR(45) NULL,
  PRIMARY KEY (`DELIVERY_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Orders` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `ORDER_ID` INT NOT NULL,
  `MEMBER_ID` INT NOT NULL DEFAULT FK,
  `DELIVERY_ID` INT NOT NULL DEFAULT FK,
  `ORDERDATE` DATE NULL,
  PRIMARY KEY (`ORDER_ID`),
  UNIQUE INDEX `ORDER_ID_UNIQUE` (`ORDER_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `ITEM_ID` INT NOT NULL,
  `NAME` VARCHAR(45) NULL,
  `PRICE` INT NULL,
  `STOCKQUANTITY` INT NULL,
  PRIMARY KEY (`ITEM_ID`),
  UNIQUE INDEX `ITEM_ID_UNIQUE` (`ITEM_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OrderItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`OrderItem` (
  `ORDER_ITEM_ID` INT NOT NULL,
  `ORDER_ID` INT NOT NULL,
  `Item_ITEM_ID` INT NOT NULL,
  `ORDERPRICE` INT NULL,
  `COUNT` INT NULL,
  PRIMARY KEY (`ORDER_ITEM_ID`),
  UNIQUE INDEX `ORDER_ITEM_ID_UNIQUE` (`ORDER_ITEM_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `CATEGORY_ID` INT NOT NULL,
  `NAME` VARCHAR(45) NULL,
  PRIMARY KEY (`CATEGORY_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CategoryItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CategoryItem` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CategoryItem` (
  `CATEGORY_ID` INT NOT NULL,
  `ITEM_ID` INT NOT NULL,
  PRIMARY KEY (`ITEM_ID`, `CATEGORY_ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
