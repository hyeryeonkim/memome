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


# 부가정보테이블(임시 비밀번호 발송 여부, 개인정보 변경 외)
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(30) NOT NULL,
    `value` TEXT NOT NULL,
    `expireDate` DATETIME NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

