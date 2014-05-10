CREATE DATABASE chat;

USE chat;

CREATE TABLE `messages` (
  `messageID` INT(10) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(20),
  `roomname` VARCHAR(30),
  `text` VARCHAR(200),
  `createdAt` VARCHAR(30),
  PRIMARY KEY  (`messageID`)
);
