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
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `idMedical` INT NOT NULL,
  `Overtime_rate` FLOAT NOT NULL,
  PRIMARY KEY (`idMedical`),
  UNIQUE INDEX `idMedical_UNIQUE` (`idMedical` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `idSpecialist` INT NOT NULL,
  PRIMARY KEY (`idSpecialist`),
  UNIQUE INDEX `idSpecialist_UNIQUE` (`idSpecialist` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `idDoctor` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  `Salary` FLOAT NOT NULL,
  `Medical_idMedical` INT NOT NULL,
  `Specialist_idSpecialist` INT NOT NULL,
  PRIMARY KEY (`idDoctor`),
  UNIQUE INDEX `idDoctor_UNIQUE` (`idDoctor` ASC) VISIBLE,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  INDEX `fk_Doctor_Medical_idx` (`Medical_idMedical` ASC) VISIBLE,
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_idSpecialist` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Medical`
    FOREIGN KEY (`Medical_idMedical`)
    REFERENCES `mydb`.`Medical` (`idMedical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_idSpecialist`)
    REFERENCES `mydb`.`Specialist` (`idSpecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`idPatient`),
  UNIQUE INDEX `idPatient_UNIQUE` (`idPatient` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Time` VARCHAR(45) NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  `Doctor_idDoctor` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  UNIQUE INDEX `idAppointment_UNIQUE` (`idAppointment` ASC) VISIBLE,
  INDEX `fk_Appointment_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_idDoctor` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_idDoctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` BLOB NOT NULL,
  `Method` ENUM('card', 'cash') NOT NULL,
  PRIMARY KEY (`idPayment`),
  UNIQUE INDEX `idPayment_UNIQUE` (`idPayment` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` FLOAT NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  UNIQUE INDEX `idBill_UNIQUE` (`idBill` ASC) VISIBLE,
  INDEX `fk_Bill_Patient1_idx` (`Patient_idPatient` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill_has_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_Payment` (
  `Bill_idBill` INT NOT NULL,
  `Payment_idPayment` INT NOT NULL,
  PRIMARY KEY (`Bill_idBill`, `Payment_idPayment`),
  INDEX `fk_Bill_has_Payment_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  INDEX `fk_Bill_has_Payment_Bill1_idx` (`Bill_idBill` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_Payment_Bill1`
    FOREIGN KEY (`Bill_idBill`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_Payment_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
