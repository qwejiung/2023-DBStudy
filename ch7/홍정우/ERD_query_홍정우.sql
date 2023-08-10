-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Member` (
  `Member_ID` INT NOT NULL,
  `LastName` VARCHAR(45) NULL,
  `FirstName` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Street` VARCHAR(45) NULL,
  `Zipcode` VARCHAR(45) NULL,
  PRIMARY KEY (`Member_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `Order_ID` INT NOT NULL,
  `OrderDate` DATE NULL,
  `Member_ID` INT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Member_ID_idx` (`Member_ID` ASC) VISIBLE,
  CONSTRAINT `Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `mydb`.`Member` (`Member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `Category_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Category_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `Item_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Price` INT NULL,
  `StockQuantity` INT NULL,
  `Category_ID` INT NULL,
  PRIMARY KEY (`Item_ID`),
  INDEX `Category_ID_idx` (`Category_ID` ASC) VISIBLE,
  CONSTRAINT `Category_ID`
    FOREIGN KEY (`Category_ID`)
    REFERENCES `mydb`.`Category` (`Category_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderItem` (
  `Order_ID` INT NOT NULL,
  `Item_ID` INT NOT NULL,
  `OrderPrice` INT NULL,
  `Count` INT NULL,
  PRIMARY KEY (`Order_ID`, `Item_ID`),
  INDEX `Item_ID_idx` (`Item_ID` ASC) VISIBLE,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `mydb`.`Orders` (`Order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Item_ID`
    FOREIGN KEY (`Item_ID`)
    REFERENCES `mydb`.`Item` (`Item_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delivery` (
  `Delivery_ID` INT NOT NULL,
  `Order_ID` INT NULL,
  PRIMARY KEY (`Delivery_ID`),
  INDEX `Order_ID_idx` (`Order_ID` ASC) VISIBLE,
  CONSTRAINT `Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `mydb`.`Orders` (`Order_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
