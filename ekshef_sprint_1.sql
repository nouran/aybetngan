SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `ekshef1.0` DEFAULT CHARACTER SET utf8 ;
USE `ekshef1.0` ;

-- -----------------------------------------------------
-- Table `ekshef1.0`.`certifications`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`certifications` (
  `CERTIFICATE_NAME` TEXT NULL DEFAULT NULL ,
  `CERTIFICATE_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`CERTIFICATE_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`gender`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`gender` (
  `GENDER_NAME` TEXT NULL DEFAULT NULL ,
  `GENDER_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`GENDER_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`city`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`city` (
  `CITY_NAME` TEXT NULL DEFAULT NULL ,
  `CITY_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`CITY_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`specialties`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`specialties` (
  `SPECIALITY_NAME` TEXT NULL DEFAULT NULL ,
  `SPECIALITY_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`SPECIALITY_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`doctors`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`doctors` (
  `CITY_ID` INT(11) NULL DEFAULT NULL ,
  `GENDER_ID` INT(11) NULL DEFAULT NULL ,
  `DR_NAME` TEXT NULL DEFAULT NULL ,
  `DR_ADDRESS` TEXT NULL DEFAULT NULL ,
  `DR_PHONE` DECIMAL(8,0) NULL DEFAULT NULL ,
  `DR_PRICE` FLOAT(8,2) NULL DEFAULT NULL ,
  `DR_ABOUT` TEXT NULL DEFAULT NULL ,
  `DR_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `SPECIALITY_ID` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`DR_ID`) ,
  INDEX `FK_GENDER_IS` (`GENDER_ID` ASC) ,
  INDEX `FK_SATTLED_IN` (`CITY_ID` ASC) ,
  INDEX `FK_SPECIALIZED_IN` (`SPECIALITY_ID` ASC) ,
  CONSTRAINT `FK_GENDER_IS`
    FOREIGN KEY (`GENDER_ID` )
    REFERENCES `ekshef1.0`.`gender` (`GENDER_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SATTLED_IN`
    FOREIGN KEY (`CITY_ID` )
    REFERENCES `ekshef1.0`.`city` (`CITY_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SPECIALIZED_IN`
    FOREIGN KEY (`SPECIALITY_ID` )
    REFERENCES `ekshef1.0`.`specialties` (`SPECIALITY_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`certified_with`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`certified_with` (
  `CERTIFICATE_ID` INT(11) NOT NULL ,
  `DR_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`CERTIFICATE_ID`, `DR_ID`) ,
  INDEX `FK_CERTIFIED_WITH_DR` (`DR_ID` ASC) ,
  CONSTRAINT `FK_CERTIFIED_WITH_DR`
    FOREIGN KEY (`DR_ID` )
    REFERENCES `ekshef1.0`.`doctors` (`DR_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CERTIFIED_WITH`
    FOREIGN KEY (`CERTIFICATE_ID` )
    REFERENCES `ekshef1.0`.`certifications` (`CERTIFICATE_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`insurances`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`insurances` (
  `INSURANCE_NAME` TEXT NULL DEFAULT NULL ,
  `INSURANCE_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`INSURANCE_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`insurance_plans`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`insurance_plans` (
  `PLAN_NAME` TEXT NULL DEFAULT NULL ,
  `PLAN_ID` INT(11) NOT NULL ,
  `INSURANCE_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`PLAN_ID`, `INSURANCE_ID`) ,
  INDEX `FK_PROVIDED_BY_COMPANY` (`INSURANCE_ID` ASC) ,
  CONSTRAINT `FK_PROVIDED_BY_COMPANY`
    FOREIGN KEY (`INSURANCE_ID` )
    REFERENCES `ekshef1.0`.`insurances` (`INSURANCE_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`universties`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`universties` (
  `UNIVERSITY_NAME` TEXT NULL DEFAULT NULL ,
  `UNIVERSIT_ID` INT(11) NOT NULL AUTO_INCREMENT ,
  PRIMARY KEY (`UNIVERSIT_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`studied_in`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`studied_in` (
  `UNIVERSITY_ID` INT(11) NOT NULL ,
  `DR_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`UNIVERSITY_ID`, `DR_ID`) ,
  INDEX `FK_DR_STUDIED_IN` (`DR_ID` ASC) ,
  CONSTRAINT `FK_UNINVERSITY_STUDIED_IN`
    FOREIGN KEY (`UNIVERSITY_ID` )
    REFERENCES `ekshef1.0`.`universties` (`UNIVERSIT_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DR_STUDIED_IN`
    FOREIGN KEY (`DR_ID` )
    REFERENCES `ekshef1.0`.`doctors` (`DR_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ekshef1.0`.`subsribed_to`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ekshef1.0`.`subsribed_to` (
  `DR_ID` INT(11) NOT NULL ,
  `PLAN_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`DR_ID`, `PLAN_ID`) ,
  INDEX `FK_SUBSCRIBED_TO_INSURANCE_PLANS` (`DR_ID` ASC) ,
  INDEX `FK_DOCTOR_SUBCRIPE_TO` (`DR_ID` ASC) ,
  INDEX `FK_SUBCRIPE_TO_INSURANCE_PLANS` (`PLAN_ID` ASC) ,
  CONSTRAINT `FK_DOCTOR_SUBCRIPE_TO`
    FOREIGN KEY (`DR_ID` )
    REFERENCES `ekshef1.0`.`doctors` (`DR_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SUBCRIPE_TO_INSURANCE_PLANS`
    FOREIGN KEY (`PLAN_ID` )
    REFERENCES `ekshef1.0`.`insurance_plans` (`PLAN_ID` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
