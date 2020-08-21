DROP DATABASE IF EXISTS `memome`;
CREATE DATABASE `memome`;
USE `memome`;

# member 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    loginId CHAR(20) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL UNIQUE,
    `email` CHAR(100) NOT NULL UNIQUE
      
);

SELECT *
FROM `member`;

# 게시판 테이블 생성
CREATE TABLE `board`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
    `name` CHAR(20) NOT NULL UNIQUE
    
);



# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL 
);

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
`name` = '자유';

INSERT INTO `board`
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

SELECT *
FROM `member`;

SELECT * 
FROM article
ORDER BY id DESC