/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : cilicili

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 04/01/2024 18:55:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for creation
-- ----------------------------
DROP TABLE IF EXISTS `creation`;
CREATE TABLE `creation`  (
  `uid` int UNSIGNED NOT NULL,
  `vid` int UNSIGNED NOT NULL,
  `createTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`uid`, `vid`) USING BTREE,
  INDEX `uid`(`uid` ASC, `vid` ASC) USING BTREE,
  INDEX `vid`(`vid` ASC) USING BTREE,
  CONSTRAINT `creation_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `creation_ibfk_2` FOREIGN KEY (`vid`) REFERENCES `video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of creation
-- ----------------------------
INSERT INTO `creation` VALUES (1, 1, '2024-01-04 18:54:57');

-- ----------------------------
-- Table structure for star
-- ----------------------------
DROP TABLE IF EXISTS `star`;
CREATE TABLE `star`  (
  `uid` int UNSIGNED NOT NULL,
  `vid` int UNSIGNED NOT NULL,
  `createDate` date NULL DEFAULT NULL,
  PRIMARY KEY (`uid`, `vid`) USING BTREE,
  INDEX `vid`(`vid` ASC, `uid` ASC) USING BTREE,
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `vid` FOREIGN KEY (`vid`) REFERENCES `video` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of star
-- ----------------------------
INSERT INTO `star` VALUES (1, 1, '2024-01-04');
INSERT INTO `star` VALUES (2, 2, '2024-01-04');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `phoneNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `verification` char(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `verificationTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `username`) USING BTREE,
  UNIQUE INDEX `EMAIL`(`email` ASC) USING BTREE,
  UNIQUE INDEX `USERNAME`(`username` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Ogawa Yota', 'T1q8aWio1U', 'yotaogawa5@hotmail.com', '(20) 2923 7574', NULL, NULL, NULL);
INSERT INTO `user` VALUES (2, 'Gladys Butler', 'xl85yhmVlu', 'gladysbutle@gmail.com', '20-429-6125', NULL, NULL, NULL);
INSERT INTO `user` VALUES (3, 'Mario Cooper', 'j5a4ZBB6jk', 'mcooper@gmail.com', '183-1608-1321', NULL, NULL, NULL);
INSERT INTO `user` VALUES (4, 'Ota Yuto', '1DZ0lWrhGW', 'otayut78@gmail.com', '330-927-5228', NULL, NULL, NULL);
INSERT INTO `user` VALUES (5, 'Willie Guzman', 'uhMf8Mgikk', 'wguzman224@outlook.com', '90-5251-2445', NULL, NULL, NULL);
INSERT INTO `user` VALUES (6, 'Tang Ting Fung', 'gJkIbbUFM9', 'tftang@icloud.com', '330-455-8956', NULL, NULL, NULL);
INSERT INTO `user` VALUES (7, 'Watanabe Airi', '4fhiKRGflT', 'awatanabe610@gmail.com', '838-608-6083', NULL, NULL, NULL);
INSERT INTO `user` VALUES (8, 'Loui Hok Yau', 'pff8fNQ6Ev', 'lohokyau@gmail.com', '52-922-5860', NULL, NULL, NULL);
INSERT INTO `user` VALUES (9, 'Chin Hok Yau', 'oKfU4LTMUk', 'chin1993@yahoo.com', '(1223) 09 5718', NULL, NULL, NULL);
INSERT INTO `user` VALUES (10, 'Angela Richardson', 'AQbH1yelAP', 'richa@gmail.com', '80-3316-5719', NULL, NULL, NULL);
INSERT INTO `user` VALUES (59, '2', '1', '1@qq.com', NULL, NULL, NULL, '2023-12-31 19:10:14');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `videoPath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `coverPath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `starNumber` int UNSIGNED NULL DEFAULT 0,
  `playNumber` int NULL DEFAULT 0,
  `videoTime` time NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES (1, '/flLvU7fL9Y.mp4', '/ot0QwTQ6uK.jpg', 'Mrs.', 'How we spend our days is, of course, how we spend our lives. In the Objects tab, you can use the List List, Detail Detail and ER Diagram ER Diagram buttons to change the object view. Always keep your eyes open. Keep watching. Because whatever you see can inspire you. If it scares you, it might be a good thing to try. Navicat provides powerful tools for working with queries: Query Editor for editing the query text directly, and Query Builder, Find Builder or Aggregate Builder for building queries visually. The Synchronize to Database function will give you a full picture of all database differences. A man’s best friends are his ten fingers. You can select any connections, objects or projects, and then select the corresponding buttons on the Information Pane. The repository database can be an existing MySQL, MariaDB, PostgreSQL, SQL Server, or Amazon RDS instance. If the plan doesn’t work, change the plan, but never the goal. Difficult circumstances serve as a textbook of life for people. The first step is as good as half over. Navicat Monitor can be installed on any local computer or virtual machine and does not require any software installation on the servers being monitored. SSH serves to prevent such vulnerabilities and allows you to access a remote server\'s shell without compromising security. You cannot save people, you can just love them. Difficult circumstances serve as a textbook of life for people. To get a secure connection, the first thing you need to do is to install OpenSSL Library and download Database Source. In other words, Navicat provides the ability for data in different databases and/or schemas to be kept up-to-date so that each repository contains the same information. I destroy my enemies when I make them my friends. A query is used to extract data from the database in a readable format according to the user\'s request. If the Show objects under schema in navigation pane option is checked at the Preferences window, all database objects are also displayed in the pane. Always keep your eyes open. Keep watching. Because whatever you see can inspire you. The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. Navicat Monitor can be installed on any local computer or virtual machine and does not require any software installation on the servers being monitored. To connect to a database or schema, simply double-click it in the pane. If your Internet Service Provider (ISP) does not provide direct access to its server, Secure Tunneling Protocol (SSH) / HTTP is another solution. SSH serves to prevent such vulnerabilities and allows you to access a remote server\'s shell without compromising security. Difficult circumstances serve as a textbook of life for people. The Main Window consists of several toolbars and panes for you to work on connections, database objects and advanced tools. Navicat provides powerful tools for working with queries: Query Editor for editing the query text directly, and Query Builder, Find Builder or Aggregate Builder for building queries visually. Such sessions are also susceptible to session hijacking, where a malicious user takes over your session once you have authenticated.', 0, 0, '00:03:22');
INSERT INTO `video` VALUES (2, '/cFL2eaUKLW.mp4', '/zo8Sp7E21N.jpg', 'Miss.', 'The reason why a great man is great is that he resolves to be a great man. You must be the change you wish to see in the world. Navicat Data Modeler enables you to build high-quality conceptual, logical and physical data models for a wide variety of audiences. A man’s best friends are his ten fingers. If the plan doesn’t work, change the plan, but never the goal. To successfully establish a new connection to local/remote server - no matter via SSL, SSH or HTTP, set the database login information in the General tab. Genius is an infinite capacity for taking pains. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e.g. tables, views, etc) will not be stored to Navicat Cloud. To get a secure connection, the first thing you need to do is to install OpenSSL Library and download Database Source. After comparing data, the window shows the number of records that will be inserted, updated or deleted in the target. Navicat provides a wide range advanced features, such as compelling code editing capabilities, smart code-completion, SQL formatting, and more. After comparing data, the window shows the number of records that will be inserted, updated or deleted in the target. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e.g. tables, views, etc) will not be stored to Navicat Cloud. To open a query using an external editor, control-click it and select Open with External Editor. You can set the file path of an external editor in Preferences. Export Wizard allows you to export data from tables, collections, views, or query results to any available formats. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. The Synchronize to Database function will give you a full picture of all database differences. Sometimes you win, sometimes you learn. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e.g. tables, views, etc) will not be stored to Navicat Cloud. It is used while your ISPs do not allow direct connections, but allows establishing HTTP connections. Sometimes you win, sometimes you learn. A man’s best friends are his ten fingers. A man’s best friends are his ten fingers. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. It wasn’t raining when Noah built the ark. Anyone who has ever made anything of importance was disciplined. You must be the change you wish to see in the world. I destroy my enemies when I make them my friends. The Navigation pane employs tree structure which allows you to take action upon the database and their objects through their pop-up menus quickly and easily. The reason why a great man is great is that he resolves to be a great man. After comparing data, the window shows the number of records that will be inserted, updated or deleted in the target. You can select any connections, objects or projects, and then select the corresponding buttons on the Information Pane. In the Objects tab, you can use the List List, Detail Detail and ER Diagram ER Diagram buttons to change the object view. Sometimes you win, sometimes you learn. Navicat is a multi-connections Database Administration tool allowing you to connect to MySQL, Oracle, PostgreSQL, SQLite, SQL Server, MariaDB and/or MongoDB databases, making database administration to multiple kinds of database so easy. Anyone who has never made a mistake has never tried anything new. If opportunity doesn’t knock, build a door. Navicat allows you to transfer data from one database and/or schema to another with detailed analytical process. All journeys have secret destinations of which the traveler is unaware. Flexible settings enable you to set up a custom key for comparison and synchronization. Creativity is intelligence having fun. Navicat Data Modeler is a powerful and cost-effective database design tool which helps you build high-quality conceptual, logical and physical data models. SQL Editor allows you to create and edit SQL text, prepare and execute selected queries. A comfort zone is a beautiful place, but nothing ever grows there. What you get by achieving your goals is not as important as what you become by achieving your goals. The past has no power over the present moment. Genius is an infinite capacity for taking pains. The first step is as good as half over. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e.g. tables, views, etc) will not be stored to Navicat Cloud. In a Telnet session, all communications, including username and password, are transmitted in plain-text, allowing anyone to listen-in on your session and steal passwords and other information. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files, and virtual group; your database passwords and data (e.g. tables, views, etc) will not be stored to Navicat Cloud. The Information Pane shows the detailed object information, project activities, the DDL of database objects, object dependencies, membership of users/roles and preview. Navicat allows you to transfer data from one database and/or schema to another with detailed analytical process. If the Show objects under schema in navigation pane option is checked at the Preferences window, all database objects are also displayed in the pane. A query is used to extract data from the database in a readable format according to the user\'s request. To get a secure connection, the first thing you need to do is to install OpenSSL Library and download Database Source. I may not have gone where I intended to go, but I think I have ended up where I needed to be. The Information Pane shows the detailed object information, project activities, the DDL of database objects, object dependencies, membership of users/roles and preview. I may not have gone where I intended to go, but I think I have ended up where I needed to be. Navicat Monitor can be installed on any local computer or virtual machine and does not require any software installation on the servers being monitored. Export Wizard allows you to export data from tables, collections, views, or query results to any available formats. Optimism is the one quality more associated with success and happiness than any other. The Information Pane shows the detailed object information, project activities, the DDL of database objects, object dependencies, membership of users/roles and preview. Monitored servers include MySQL, MariaDB and SQL Server, and compatible with cloud databases like Amazon RDS, Amazon Aurora, Oracle Cloud, Google Cloud and Microsoft Azure.', 0, 0, '00:03:22');

SET FOREIGN_KEY_CHECKS = 1;
