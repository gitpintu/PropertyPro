-- ============================================================
-- PropertyPro - MySQL Migration Script
-- Converted from phpMyAdmin dump
-- Run this in MySQL Workbench or CLI:
--   mysql -u root -p < propertypro_mysql.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS propertypro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE propertypro;

-- ============================================================
-- Table: seller_info
-- Stores seller accounts (replaces phpMyAdmin seller_info table)
-- NOTE: Passwords in existing data are SHA1 hashes.
--       New registrations via Spring Boot will use BCrypt.
--       Existing users will need to reset passwords after migration.
-- ============================================================
CREATE TABLE IF NOT EXISTS `seller_info` (
  `seller_id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `seller_fname`    VARCHAR(30)  NOT NULL,
  `seller_lname`    VARCHAR(20)  NOT NULL,
  `seller_email`    VARCHAR(30)  NOT NULL UNIQUE,
  `seller_number`   VARCHAR(13)  NOT NULL,
  `seller_password` VARCHAR(100) NOT NULL,   -- Extended from 50 to 100 for BCrypt
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: buyer_info
-- ============================================================
CREATE TABLE IF NOT EXISTS `buyer_info` (
  `buyer_id`        INT(11)      NOT NULL AUTO_INCREMENT,
  `buyer_fname`     VARCHAR(30)  NOT NULL,
  `buyer_lname`     VARCHAR(30)  NOT NULL,
  `buyer_email`     VARCHAR(50)  NOT NULL UNIQUE,  -- Extended for longer emails
  `buyer_number`    VARCHAR(13)  NOT NULL,
  `buyer_password`  VARCHAR(100) NOT NULL,          -- Extended for BCrypt
  PRIMARY KEY (`buyer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: property_type
-- ============================================================
CREATE TABLE IF NOT EXISTS `property_type` (
  `property_id`   INT(11)     NOT NULL AUTO_INCREMENT,
  `property_type` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed property types (same as original phpMyAdmin data)
INSERT INTO `property_type` (`property_id`, `property_type`) VALUES
  (1, 'land'),
  (2, 'home'),
  (3, 'home-rent')
ON DUPLICATE KEY UPDATE property_type = VALUES(property_type);

-- ============================================================
-- Table: seller_dashboard
-- ============================================================
CREATE TABLE IF NOT EXISTS `seller_dashboard` (
  `property_id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `seller_id`         INT(11)      NOT NULL,
  `property_name`     VARCHAR(30)  NOT NULL,
  `property_sqft`     VARCHAR(30)  NOT NULL,
  `property_location` VARCHAR(30)  NOT NULL,
  `property_price`    VARCHAR(30)  NOT NULL,
  `property_type`     VARCHAR(30)  NOT NULL,
  `image1`            VARCHAR(100) DEFAULT NULL,
  `image2`            VARCHAR(100) DEFAULT NULL,
  `image3`            VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  FOREIGN KEY (`seller_id`) REFERENCES seller_info(`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Table: buyer_book
-- Added auto-increment 'id' column (original table had no PK)
-- ============================================================
CREATE TABLE IF NOT EXISTS `buyer_book` (
  `id`            INT(11)     NOT NULL AUTO_INCREMENT,  -- Added PK
  `property_id`   INT(11)     NOT NULL,
  `buyer_name`    VARCHAR(30) NOT NULL,
  `buyer_email`   VARCHAR(30) NOT NULL,
  `buyer_message` VARCHAR(200),
  `buyer_number`  VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`property_id`) REFERENCES seller_dashboard(`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- MIGRATING EXISTING DATA
-- The existing passwords in phpMyAdmin were stored as SHA1.
-- Spring Boot uses BCrypt, which is incompatible.
-- Options:
--   1. Ask all existing users to reset their passwords (recommended)
--   2. Keep SHA1 temporarily and add a migration mechanism
--
-- For a fresh start, skip the INSERT statements below.
-- To migrate existing data, run these INSERTs and use option 2.
-- ============================================================

-- Existing seller data (SHA1 passwords - will need reset)
-- INSERT INTO `seller_info` VALUES
-- (1,'Milan','sethy','sethymilan862@gmail.com','7735213718','$SHA1_HASH_HERE'),
-- ...

-- ============================================================
-- VERIFY SETUP
-- ============================================================
-- SELECT * FROM property_type;
-- SHOW TABLES;
