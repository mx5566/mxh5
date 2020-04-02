/*
 Navicat Premium Data Transfer

 Source Server         : mac-mysql-8.0
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : sdrms

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 02/04/2020 17:36:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rms_alipay_user
-- ----------------------------
DROP TABLE IF EXISTS `rms_alipay_user`;
CREATE TABLE `rms_alipay_user` (
  `alipay_id` int NOT NULL AUTO_INCREMENT,
  `alipay_public_secret` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `alipay_appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `alipay_bs_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `alipay_private_secret` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `backend_user_id` int NOT NULL,
  PRIMARY KEY (`alipay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_alipay_user
-- ----------------------------
BEGIN;
INSERT INTO `rms_alipay_user` VALUES (1, '中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国中国I\'m a chinese man, where are you from,please tell me ,thans you !!!', '2010', '杭州梦想', 'qwert', 1);
INSERT INTO `rms_alipay_user` VALUES (2, 'alipaypublic2', '2018', '上海梦想', 'alipayprivate2', 2);
COMMIT;

-- ----------------------------
-- Table structure for rms_backend_user
-- ----------------------------
DROP TABLE IF EXISTS `rms_backend_user`;
CREATE TABLE `rms_backend_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `user_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `is_super` tinyint(1) NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_backend_user
-- ----------------------------
BEGIN;
INSERT INTO `rms_backend_user` VALUES (1, 'mengxiang', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, 1, '18612348765', 'lhtzbj18@126.com', '/static/upload/mongodatastruct.png');
INSERT INTO `rms_backend_user` VALUES (3, '张三', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', 0, 1, '', '', '');
INSERT INTO `rms_backend_user` VALUES (5, '李四', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', 0, 0, '', '', '');
COMMIT;

-- ----------------------------
-- Table structure for rms_backend_user_rms_roles
-- ----------------------------
DROP TABLE IF EXISTS `rms_backend_user_rms_roles`;
CREATE TABLE `rms_backend_user_rms_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rms_backend_user_id` int NOT NULL,
  `rms_role_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for rms_course
-- ----------------------------
DROP TABLE IF EXISTS `rms_course`;
CREATE TABLE `rms_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `short_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `real_price` double NOT NULL DEFAULT '0',
  `img` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `seq` int NOT NULL DEFAULT '0',
  `creator_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for rms_game
-- ----------------------------
DROP TABLE IF EXISTS `rms_game`;
CREATE TABLE `rms_game` (
  `game_id` bigint NOT NULL AUTO_INCREMENT,
  `game_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '游戏名字',
  `game_type` int NOT NULL DEFAULT '1' COMMENT '类型：例如传奇类型或者等等',
  `game_icov` bigint NOT NULL DEFAULT '0' COMMENT 'icov的id',
  `game_per_num` bigint NOT NULL DEFAULT '0' COMMENT '下载用户数目',
  `game_status` tinyint NOT NULL DEFAULT '0' COMMENT '游戏状态',
  `game_weight` int NOT NULL DEFAULT '0' COMMENT '权重',
  `backend_user_id` int NOT NULL COMMENT '那个用户',
  `game_icov_str` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'icov地址',
  `game_description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `gamename` (`game_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_game
-- ----------------------------
BEGIN;
INSERT INTO `rms_game` VALUES (6, '棋牌世界6', 3, 1, 12, 2, 1, 1, '/static/upload/2019/8/15/224225144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (8, '棋牌世界7', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (12, '棋牌世界12', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (13, '棋牌世界13', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (15, '棋牌世界15', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (16, '棋牌世界16', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (17, '棋牌世界17', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (18, '棋牌世界18', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (20, '棋牌世界20', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (21, '棋牌世界21', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (22, '棋牌世界22', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (23, '棋牌世界23', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (24, '棋牌世界24', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (25, '棋牌世界25', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (26, '棋牌世界26', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (27, '棋牌世界27', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (28, '棋牌世界28', 1, 1, 12, 1, 1, 1, '/static/upload/2019/7/8/144157RSS_Default_32.png', '欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊，欢迎来到传奇世界了、你们这群大晒比啊');
INSERT INTO `rms_game` VALUES (29, '我的世界29', 2, 0, 1, 1, 12, 1, '/static/upload/2019/8/18/18349144157RSS_Default_32.png', '我的世界从此没有你');
INSERT INTO `rms_game` VALUES (31, '我的世界', 1, 0, 12, 1, 12, 1, '/static/upload/2019/8/18/2132144157RSS_Default_32.png', '我的世界没有你了byebye!!!!!!');
INSERT INTO `rms_game` VALUES (34, '我的世界12', 1, 0, 12, 1, 1, 1, '/static/upload/2019/8/18/212210144157RSS_Default_32.png', '123');
INSERT INTO `rms_game` VALUES (35, '我的世界125', 1, 0, 12, 1, 1, 1, '/static/upload/2019/8/18/212210144157RSS_Default_32.png', '123');
INSERT INTO `rms_game` VALUES (38, '我的世界23', 2, 0, 1, 1, 1, 1, '/static/upload/2019/8/18/21268144157RSS_Default_32.png', '1');
COMMIT;

-- ----------------------------
-- Table structure for rms_game_tab_rel
-- ----------------------------
DROP TABLE IF EXISTS `rms_game_tab_rel`;
CREATE TABLE `rms_game_tab_rel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tab_id` int NOT NULL,
  `game_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_game_tab_rel
-- ----------------------------
BEGIN;
INSERT INTO `rms_game_tab_rel` VALUES (17, 4, 34);
INSERT INTO `rms_game_tab_rel` VALUES (18, 4, 35);
INSERT INTO `rms_game_tab_rel` VALUES (22, 4, 38);
INSERT INTO `rms_game_tab_rel` VALUES (25, 4, 6);
INSERT INTO `rms_game_tab_rel` VALUES (26, 3, 6);
COMMIT;

-- ----------------------------
-- Table structure for rms_game_type
-- ----------------------------
DROP TABLE IF EXISTS `rms_game_type`;
CREATE TABLE `rms_game_type` (
  `game_type_id` int NOT NULL AUTO_INCREMENT,
  `game_type_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '类传奇',
  `game_type_weight` tinyint NOT NULL DEFAULT '0' COMMENT '权重',
  `game_type_status` tinyint NOT NULL DEFAULT '1' COMMENT 'status',
  PRIMARY KEY (`game_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_game_type
-- ----------------------------
BEGIN;
INSERT INTO `rms_game_type` VALUES (1, '棋牌类型', 23, 1);
INSERT INTO `rms_game_type` VALUES (2, 'arpg', 12, 2);
INSERT INTO `rms_game_type` VALUES (3, '格斗类', 12, 1);
COMMIT;

-- ----------------------------
-- Table structure for rms_image
-- ----------------------------
DROP TABLE IF EXISTS `rms_image`;
CREATE TABLE `rms_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `image_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `image_name_md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `image_info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `backend_user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_image
-- ----------------------------
BEGIN;
INSERT INTO `rms_image` VALUES (1, '/static/upload/mongodatastruct.png', '请问1', 'af62697c3e2b81d0b461a26290a33a7a', '12', 1);
INSERT INTO `rms_image` VALUES (2, '/static/upload/mongodatastruct.png', '请问2', 'b0691162a7e9e19eff1fb2eefafc390d', '12', 1);
INSERT INTO `rms_image` VALUES (3, '/static/upload/O1CN01eiw8cm1DVG3AfwSS1_!!0-item_pic.jpg_430x430q90.jpg', '请3', 'c56e90a38f2a90143f67bf72c02f14d4', '12', 1);
INSERT INTO `rms_image` VALUES (4, '/static/upload/mongodatastruct.png', '请问4', '9ded44ce856526f43d96c5123792bd6d', '12', 1);
INSERT INTO `rms_image` VALUES (5, '/static/upload/O1CN01eiw8cm1DVG3AfwSS1_!!0-item_pic.jpg_430x430q90.jpg', '请问5', 'cd6c59447f245b6b8825e842783a47bb', '12', 1);
INSERT INTO `rms_image` VALUES (6, '/static/upload/O1CN01eiw8cm1DVG3AfwSS1_!!0-item_pic.jpg_430x430q90.jpg', '请656', '273101f18444b155c4664deb7f77d8f7', '12', 1);
INSERT INTO `rms_image` VALUES (7, '/static/upload/mongodatastruct.png', '请问7', '10b34bc3691c30303272012bc03c0672', '12', 1);
INSERT INTO `rms_image` VALUES (8, '/static/upload/mongodatastruct.png', '请问8', '10b34bc3691c30303272012bc03c0672', '12', 1);
INSERT INTO `rms_image` VALUES (9, '/static/upload/mongodatastruct.png', '请问9', '10b34bc3691c30303272012bc03c0672', '12', 1);
INSERT INTO `rms_image` VALUES (10, '/static/upload/mongodatastruct.png', '请问10', '10b34bc3691c30303272012bc03c0672', '12', 1);
INSERT INTO `rms_image` VALUES (11, '/static/upload/mongodatastruct.png', '请问11', '10b34bc3691c30303272012bc03c0672', '12', 1);
INSERT INTO `rms_image` VALUES (12, '/static/upload/O1CN01eiw8cm1DVG3AfwSS1_!!0-item_pic.jpg_430x430q90.jpg', '请问12', 'ccf482332bde2a8099c99cae6f3ebab1', '12', 1);
INSERT INTO `rms_image` VALUES (45, '/static/upload/2019/7/5/1525453f2ccd5a73878562e8b0919f2662648d.jpg', 'test', '236b7ad9493c4478b19921e5ad5e54b3', 'test1', 1);
INSERT INTO `rms_image` VALUES (46, '/static/upload/2019/7/8/144157RSS_Default_32.png', 'ls', 'ae898330740ab9b0249513ba1ab3aae7', 'ls', 1);
COMMIT;

-- ----------------------------
-- Table structure for rms_log_user_login
-- ----------------------------
DROP TABLE IF EXISTS `rms_log_user_login`;
CREATE TABLE `rms_log_user_login` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `login_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `login_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_log_user_login
-- ----------------------------
BEGIN;
INSERT INTO `rms_log_user_login` VALUES (1, 'lintao', '127.0.0.1', '2019-04-27 22:13:02');
INSERT INTO `rms_log_user_login` VALUES (2, 'admin', '127.0.0.1:33658', '2019-04-27 15:16:00');
INSERT INTO `rms_log_user_login` VALUES (3, 'admin', '127.0.0.1:33674', '2019-04-27 15:18:04');
INSERT INTO `rms_log_user_login` VALUES (4, 'admin', '127.0.0.1:34229', '2019-04-27 15:30:46');
INSERT INTO `rms_log_user_login` VALUES (5, 'admin', '127.0.0.1:34525', '2019-04-27 15:33:38');
INSERT INTO `rms_log_user_login` VALUES (6, 'admin', '127.0.0.1:35819', '2019-04-28 14:17:34');
INSERT INTO `rms_log_user_login` VALUES (7, 'admin', '127.0.0.1:36395', '2019-04-28 14:20:59');
INSERT INTO `rms_log_user_login` VALUES (8, 'admin', '192.168.1.211:33968', '2019-04-28 14:46:15');
INSERT INTO `rms_log_user_login` VALUES (9, 'admin', '192.168.1.211:33970', '2019-04-28 14:47:14');
INSERT INTO `rms_log_user_login` VALUES (10, 'admin', '192.168.1.211:33966', '2019-04-28 14:50:07');
INSERT INTO `rms_log_user_login` VALUES (11, 'admin', '127.0.0.1:39418', '2019-04-28 14:59:45');
INSERT INTO `rms_log_user_login` VALUES (12, 'admin', '127.0.0.1:39418', '2019-04-28 15:00:41');
INSERT INTO `rms_log_user_login` VALUES (13, 'admin', '127.0.0.1:39418', '2019-04-28 15:04:47');
INSERT INTO `rms_log_user_login` VALUES (14, 'admin', '127.0.0.1:39418', '2019-04-28 15:07:23');
INSERT INTO `rms_log_user_login` VALUES (15, 'admin', '127.0.0.1:39788', '2019-04-28 15:07:39');
INSERT INTO `rms_log_user_login` VALUES (16, 'admin', '127.0.0.1:40219', '2019-04-28 15:14:10');
INSERT INTO `rms_log_user_login` VALUES (17, 'admin', '127.0.0.1:40686', '2019-04-28 15:28:47');
INSERT INTO `rms_log_user_login` VALUES (18, 'admin', '127.0.0.1:42696', '2019-04-28 15:43:40');
INSERT INTO `rms_log_user_login` VALUES (19, 'admin', '127.0.0.1:42696', '2019-04-28 15:44:09');
INSERT INTO `rms_log_user_login` VALUES (20, 'admin', '127.0.0.1:42696', '2019-04-28 15:46:03');
INSERT INTO `rms_log_user_login` VALUES (21, 'admin', '127.0.0.1:44642', '2019-04-29 12:04:29');
INSERT INTO `rms_log_user_login` VALUES (22, 'admin', '127.0.0.1:58891', '2019-04-29 14:05:34');
INSERT INTO `rms_log_user_login` VALUES (23, 'admin', '127.0.0.1:63541', '2019-04-29 14:44:59');
INSERT INTO `rms_log_user_login` VALUES (24, 'admin', '127.0.0.1:3622', '2019-04-30 14:25:40');
INSERT INTO `rms_log_user_login` VALUES (25, 'admin', '127.0.0.1:4432', '2019-04-30 14:32:49');
INSERT INTO `rms_log_user_login` VALUES (26, 'admin', '127.0.0.1:13349', '2019-04-30 15:48:42');
INSERT INTO `rms_log_user_login` VALUES (27, 'admin', '127.0.0.1:13975', '2019-04-30 16:02:25');
INSERT INTO `rms_log_user_login` VALUES (28, 'admin', '127.0.0.1:14060', '2019-04-30 16:04:27');
INSERT INTO `rms_log_user_login` VALUES (29, 'admin', '127.0.0.1:14066', '2019-04-30 16:08:56');
INSERT INTO `rms_log_user_login` VALUES (30, 'admin', '127.0.0.1:15063', '2019-04-30 16:13:19');
INSERT INTO `rms_log_user_login` VALUES (31, 'admin', '127.0.0.1:16297', '2019-04-30 16:27:21');
INSERT INTO `rms_log_user_login` VALUES (32, 'admin', '127.0.0.1:17263', '2019-05-01 02:26:12');
INSERT INTO `rms_log_user_login` VALUES (33, 'admin', '127.0.0.1:17497', '2019-05-01 02:30:16');
INSERT INTO `rms_log_user_login` VALUES (34, 'admin', '127.0.0.1:22781', '2019-05-01 03:25:56');
INSERT INTO `rms_log_user_login` VALUES (35, 'admin', '127.0.0.1:24249', '2019-05-01 03:39:17');
INSERT INTO `rms_log_user_login` VALUES (36, 'admin', '127.0.0.1:26163', '2019-05-01 03:58:25');
INSERT INTO `rms_log_user_login` VALUES (37, 'admin', '127.0.0.1:38769', '2019-05-01 06:09:03');
INSERT INTO `rms_log_user_login` VALUES (38, 'admin', '127.0.0.1:38883', '2019-05-01 06:10:07');
INSERT INTO `rms_log_user_login` VALUES (39, 'admin', '127.0.0.1:42327', '2019-05-01 06:44:31');
INSERT INTO `rms_log_user_login` VALUES (40, 'admin', '127.0.0.1:42559', '2019-05-01 06:46:43');
INSERT INTO `rms_log_user_login` VALUES (41, 'admin', '127.0.0.1:49819', '2019-05-01 07:58:03');
INSERT INTO `rms_log_user_login` VALUES (42, 'admin', '127.0.0.1:51763', '2019-05-01 08:17:18');
INSERT INTO `rms_log_user_login` VALUES (43, 'admin', '127.0.0.1:52903', '2019-05-01 08:28:19');
INSERT INTO `rms_log_user_login` VALUES (44, 'admin', '127.0.0.1:53579', '2019-05-01 08:35:24');
INSERT INTO `rms_log_user_login` VALUES (45, 'admin', '127.0.0.1:18419', '2019-05-01 14:34:15');
INSERT INTO `rms_log_user_login` VALUES (46, 'admin', '127.0.0.1:18875', '2019-05-01 14:39:32');
INSERT INTO `rms_log_user_login` VALUES (47, 'admin', '127.0.0.1:19136', '2019-05-01 14:41:20');
INSERT INTO `rms_log_user_login` VALUES (48, 'admin', '127.0.0.1:20443', '2019-05-01 14:53:45');
INSERT INTO `rms_log_user_login` VALUES (49, 'admin', '127.0.0.1:24177', '2019-05-01 15:30:47');
INSERT INTO `rms_log_user_login` VALUES (50, 'admin', '127.0.0.1:37499', '2019-05-02 13:07:56');
INSERT INTO `rms_log_user_login` VALUES (51, 'admin', '127.0.0.1:37894', '2019-05-02 13:10:57');
INSERT INTO `rms_log_user_login` VALUES (52, 'admin', '127.0.0.1:39518', '2019-05-02 13:24:03');
INSERT INTO `rms_log_user_login` VALUES (53, 'admin', '127.0.0.1:39619', '2019-05-02 13:24:49');
INSERT INTO `rms_log_user_login` VALUES (54, 'admin', '127.0.0.1:43228', '2019-05-02 13:52:40');
INSERT INTO `rms_log_user_login` VALUES (55, 'admin', '127.0.0.1:43537', '2019-05-02 13:55:15');
INSERT INTO `rms_log_user_login` VALUES (56, 'admin', '127.0.0.1:43913', '2019-05-02 13:57:37');
INSERT INTO `rms_log_user_login` VALUES (57, 'admin', '127.0.0.1:51057', '2019-05-02 15:02:28');
INSERT INTO `rms_log_user_login` VALUES (58, 'admin', '127.0.0.1:51833', '2019-05-02 15:04:05');
INSERT INTO `rms_log_user_login` VALUES (59, 'admin', '127.0.0.1:51979', '2019-05-02 15:05:08');
INSERT INTO `rms_log_user_login` VALUES (60, 'admin', '127.0.0.1:52752', '2019-05-02 15:11:44');
INSERT INTO `rms_log_user_login` VALUES (61, 'admin', '127.0.0.1:52942', '2019-05-02 15:13:05');
INSERT INTO `rms_log_user_login` VALUES (62, 'admin', '127.0.0.1:53142', '2019-05-02 15:14:34');
INSERT INTO `rms_log_user_login` VALUES (63, 'admin', '127.0.0.1:55175', '2019-05-02 15:31:40');
INSERT INTO `rms_log_user_login` VALUES (64, 'admin', '127.0.0.1:59198', '2019-05-02 16:02:17');
INSERT INTO `rms_log_user_login` VALUES (65, 'admin', '127.0.0.1:63718', '2019-05-02 16:37:30');
INSERT INTO `rms_log_user_login` VALUES (66, 'admin', '127.0.0.1:64078', '2019-05-02 16:40:22');
INSERT INTO `rms_log_user_login` VALUES (67, 'admin', '127.0.0.1:64965', '2019-05-03 04:33:04');
INSERT INTO `rms_log_user_login` VALUES (68, 'admin', '127.0.0.1:16650', '2019-05-03 07:37:55');
INSERT INTO `rms_log_user_login` VALUES (69, 'admin', '127.0.0.1:16808', '2019-05-03 07:39:14');
INSERT INTO `rms_log_user_login` VALUES (70, 'admin', '127.0.0.1:17954', '2019-05-03 07:48:53');
INSERT INTO `rms_log_user_login` VALUES (71, 'admin', '127.0.0.1:18379', '2019-05-03 07:52:25');
INSERT INTO `rms_log_user_login` VALUES (72, 'admin', '127.0.0.1:23647', '2019-05-03 10:36:20');
INSERT INTO `rms_log_user_login` VALUES (73, 'admin', '127.0.0.1:24020', '2019-05-03 10:42:35');
INSERT INTO `rms_log_user_login` VALUES (74, 'admin', '127.0.0.1:24068', '2019-05-03 10:43:54');
INSERT INTO `rms_log_user_login` VALUES (75, 'admin', '127.0.0.1:24123', '2019-05-03 10:45:23');
INSERT INTO `rms_log_user_login` VALUES (76, 'admin', '127.0.0.1:30345', '2019-05-03 12:14:33');
INSERT INTO `rms_log_user_login` VALUES (77, 'admin', '127.0.0.1:31824', '2019-05-03 12:19:19');
INSERT INTO `rms_log_user_login` VALUES (78, 'admin', '127.0.0.1:35698', '2019-05-03 12:57:53');
INSERT INTO `rms_log_user_login` VALUES (79, 'admin', '127.0.0.1:35819', '2019-05-03 12:58:48');
INSERT INTO `rms_log_user_login` VALUES (80, 'admin', '127.0.0.1:36023', '2019-05-03 13:00:23');
INSERT INTO `rms_log_user_login` VALUES (81, 'admin', '127.0.0.1:36217', '2019-05-03 13:02:00');
INSERT INTO `rms_log_user_login` VALUES (82, 'admin', '127.0.0.1:36673', '2019-05-03 13:05:54');
INSERT INTO `rms_log_user_login` VALUES (83, 'admin', '127.0.0.1:36756', '2019-05-03 13:06:34');
INSERT INTO `rms_log_user_login` VALUES (84, 'admin', '127.0.0.1:38812', '2019-05-03 13:34:51');
INSERT INTO `rms_log_user_login` VALUES (85, 'admin', '127.0.0.1:46416', '2019-05-03 14:25:45');
INSERT INTO `rms_log_user_login` VALUES (86, 'admin', '127.0.0.1:46813', '2019-05-03 14:29:10');
INSERT INTO `rms_log_user_login` VALUES (87, 'admin', '127.0.0.1:52251', '2019-05-03 15:13:26');
INSERT INTO `rms_log_user_login` VALUES (88, 'admin', '127.0.0.1:54915', '2019-05-03 15:35:35');
INSERT INTO `rms_log_user_login` VALUES (89, 'admin', '127.0.0.1:61382', '2019-05-04 10:53:41');
INSERT INTO `rms_log_user_login` VALUES (90, 'admin', '127.0.0.1:2114', '2019-05-04 11:48:38');
INSERT INTO `rms_log_user_login` VALUES (91, 'admin', '127.0.0.1:2316', '2019-05-04 12:04:11');
INSERT INTO `rms_log_user_login` VALUES (92, 'admin', '127.0.0.1:2316', '2019-05-04 12:11:32');
INSERT INTO `rms_log_user_login` VALUES (93, 'admin', '127.0.0.1:2316', '2019-05-04 12:15:52');
INSERT INTO `rms_log_user_login` VALUES (94, 'admin', '127.0.0.1:19519', '2019-05-04 14:55:47');
INSERT INTO `rms_log_user_login` VALUES (95, 'admin', '127.0.0.1:27340', '2019-05-04 16:14:36');
INSERT INTO `rms_log_user_login` VALUES (96, 'admin', '127.0.0.1:27340', '2019-05-04 16:23:38');
INSERT INTO `rms_log_user_login` VALUES (97, 'admin', '127.0.0.1:28882', '2019-05-05 14:41:33');
INSERT INTO `rms_log_user_login` VALUES (98, 'admin', '127.0.0.1:31218', '2019-05-05 15:35:54');
INSERT INTO `rms_log_user_login` VALUES (99, 'admin', '127.0.0.1:31316', '2019-05-05 15:39:09');
INSERT INTO `rms_log_user_login` VALUES (100, 'admin', '127.0.0.1:31376', '2019-05-05 15:40:18');
INSERT INTO `rms_log_user_login` VALUES (101, 'admin', '127.0.0.1:32381', '2019-05-06 14:36:19');
INSERT INTO `rms_log_user_login` VALUES (102, 'admin', '127.0.0.1:33852', '2019-05-06 15:07:12');
INSERT INTO `rms_log_user_login` VALUES (103, 'admin', '127.0.0.1:38047', '2019-05-07 14:32:16');
INSERT INTO `rms_log_user_login` VALUES (104, 'admin', '127.0.0.1:39420', '2019-05-07 14:47:08');
INSERT INTO `rms_log_user_login` VALUES (105, 'admin', '127.0.0.1:44412', '2019-05-07 15:40:03');
INSERT INTO `rms_log_user_login` VALUES (106, 'admin', '127.0.0.1:44455', '2019-05-07 15:41:57');
INSERT INTO `rms_log_user_login` VALUES (107, 'admin', '127.0.0.1:44602', '2019-05-07 15:46:22');
INSERT INTO `rms_log_user_login` VALUES (108, 'admin', '127.0.0.1:44941', '2019-05-07 15:55:54');
INSERT INTO `rms_log_user_login` VALUES (109, 'admin', '127.0.0.1:45011', '2019-05-07 15:57:15');
INSERT INTO `rms_log_user_login` VALUES (110, 'admin', '127.0.0.1:45432', '2019-05-08 14:28:56');
INSERT INTO `rms_log_user_login` VALUES (111, 'admin', '127.0.0.1:45583', '2019-05-08 14:31:52');
INSERT INTO `rms_log_user_login` VALUES (112, 'admin', '127.0.0.1:48192', '2019-05-08 15:21:33');
INSERT INTO `rms_log_user_login` VALUES (113, 'admin', '127.0.0.1:48524', '2019-05-08 15:28:09');
INSERT INTO `rms_log_user_login` VALUES (114, 'admin', '127.0.0.1:48663', '2019-05-08 15:36:27');
INSERT INTO `rms_log_user_login` VALUES (115, 'admin', '127.0.0.1:49012', '2019-05-08 15:54:44');
INSERT INTO `rms_log_user_login` VALUES (116, 'admin', '127.0.0.1:49051', '2019-05-08 15:57:14');
INSERT INTO `rms_log_user_login` VALUES (117, 'admin', '127.0.0.1:51582', '2019-05-09 14:54:23');
INSERT INTO `rms_log_user_login` VALUES (118, 'admin', '127.0.0.1:51637', '2019-05-09 14:56:06');
INSERT INTO `rms_log_user_login` VALUES (119, 'admin', '127.0.0.1:51792', '2019-05-09 14:59:44');
INSERT INTO `rms_log_user_login` VALUES (120, 'admin', '127.0.0.1:51886', '2019-05-09 15:01:49');
INSERT INTO `rms_log_user_login` VALUES (121, 'admin', '127.0.0.1:52138', '2019-05-09 15:08:49');
INSERT INTO `rms_log_user_login` VALUES (122, 'admin', '127.0.0.1:52191', '2019-05-09 15:10:30');
INSERT INTO `rms_log_user_login` VALUES (123, 'admin', '127.0.0.1:57142', '2019-05-10 14:33:56');
INSERT INTO `rms_log_user_login` VALUES (124, 'admin', '127.0.0.1:57974', '2019-05-10 14:53:32');
INSERT INTO `rms_log_user_login` VALUES (125, 'admin', '127.0.0.1:57988', '2019-05-10 14:54:33');
INSERT INTO `rms_log_user_login` VALUES (126, 'admin', '127.0.0.1:58116', '2019-05-10 14:56:18');
INSERT INTO `rms_log_user_login` VALUES (127, 'admin', '127.0.0.1:60200', '2019-05-10 15:36:59');
INSERT INTO `rms_log_user_login` VALUES (128, 'admin', '127.0.0.1:54320', '2019-05-12 14:49:04');
INSERT INTO `rms_log_user_login` VALUES (129, 'admin', '127.0.0.1:54320', '2019-05-12 14:49:09');
INSERT INTO `rms_log_user_login` VALUES (130, 'admin', '127.0.0.1:58926', '2019-05-14 15:00:12');
INSERT INTO `rms_log_user_login` VALUES (131, 'admin', '127.0.0.1:60911', '2019-05-15 14:52:07');
INSERT INTO `rms_log_user_login` VALUES (132, 'admin', '127.0.0.1:3605', '2019-05-16 15:40:45');
INSERT INTO `rms_log_user_login` VALUES (133, 'admin', '127.0.0.1:9506', '2019-05-21 15:09:12');
INSERT INTO `rms_log_user_login` VALUES (134, 'admin', '127.0.0.1:10139', '2019-05-21 15:15:15');
INSERT INTO `rms_log_user_login` VALUES (135, 'admin', '127.0.0.1:10188', '2019-05-21 15:16:10');
INSERT INTO `rms_log_user_login` VALUES (136, 'admin', '127.0.0.1:11684', '2019-05-23 14:55:36');
INSERT INTO `rms_log_user_login` VALUES (137, 'admin', '127.0.0.1:11698', '2019-05-23 14:58:05');
INSERT INTO `rms_log_user_login` VALUES (138, 'admin', '127.0.0.1:12555', '2019-05-23 15:08:06');
INSERT INTO `rms_log_user_login` VALUES (139, 'admin', '127.0.0.1:13186', '2019-05-23 15:21:49');
INSERT INTO `rms_log_user_login` VALUES (140, 'admin', '127.0.0.1:54303', '2019-07-05 03:49:15');
INSERT INTO `rms_log_user_login` VALUES (141, 'admin', '127.0.0.1:61270', '2019-07-05 06:50:54');
INSERT INTO `rms_log_user_login` VALUES (142, 'admin', '127.0.0.1:65188', '2019-07-05 07:00:37');
INSERT INTO `rms_log_user_login` VALUES (143, 'admin', '127.0.0.1:59194', '2019-07-05 07:26:10');
INSERT INTO `rms_log_user_login` VALUES (144, 'admin', '127.0.0.1:60723', '2019-07-05 07:29:07');
INSERT INTO `rms_log_user_login` VALUES (145, 'admin', '127.0.0.1:51089', '2019-07-05 07:45:26');
INSERT INTO `rms_log_user_login` VALUES (146, 'admin', '127.0.0.1:60496', '2019-07-05 08:08:21');
INSERT INTO `rms_log_user_login` VALUES (147, 'admin', '127.0.0.1:62433', '2019-07-05 10:14:24');
INSERT INTO `rms_log_user_login` VALUES (148, 'admin', '127.0.0.1:62691', '2019-07-05 10:15:01');
INSERT INTO `rms_log_user_login` VALUES (149, 'admin', '127.0.0.1:63738', '2019-07-05 10:17:34');
INSERT INTO `rms_log_user_login` VALUES (150, 'admin', '127.0.0.1:64863', '2019-07-08 02:51:06');
INSERT INTO `rms_log_user_login` VALUES (151, 'admin', '127.0.0.1:58262', '2019-07-08 06:23:49');
INSERT INTO `rms_log_user_login` VALUES (152, 'admin', '127.0.0.1:52210', '2019-07-08 09:28:10');
INSERT INTO `rms_log_user_login` VALUES (153, 'admin', '127.0.0.1:58440', '2019-07-08 09:57:56');
INSERT INTO `rms_log_user_login` VALUES (154, 'admin', '127.0.0.1:60354', '2019-07-08 10:06:33');
INSERT INTO `rms_log_user_login` VALUES (155, 'admin', '127.0.0.1:65455', '2019-07-08 10:29:43');
INSERT INTO `rms_log_user_login` VALUES (156, 'admin', '127.0.0.1:60915', '2019-07-09 03:12:29');
INSERT INTO `rms_log_user_login` VALUES (157, 'admin', '127.0.0.1:62706', '2019-07-09 04:33:08');
INSERT INTO `rms_log_user_login` VALUES (158, 'admin', '127.0.0.1:58896', '2019-07-09 10:01:11');
INSERT INTO `rms_log_user_login` VALUES (159, 'admin', '127.0.0.1:59633', '2019-07-09 10:04:11');
INSERT INTO `rms_log_user_login` VALUES (160, 'admin', '127.0.0.1:63276', '2019-07-09 10:19:23');
INSERT INTO `rms_log_user_login` VALUES (161, 'admin', '127.0.0.1:58042', '2019-07-10 01:53:52');
INSERT INTO `rms_log_user_login` VALUES (162, 'admin', '127.0.0.1:63915', '2019-07-10 02:18:05');
INSERT INTO `rms_log_user_login` VALUES (163, 'admin', '127.0.0.1:56112', '2019-07-10 02:54:05');
INSERT INTO `rms_log_user_login` VALUES (164, 'admin', '127.0.0.1:53216', '2019-07-10 06:00:14');
INSERT INTO `rms_log_user_login` VALUES (165, 'admin', '127.0.0.1:56526', '2019-07-10 09:29:15');
INSERT INTO `rms_log_user_login` VALUES (166, 'admin', '127.0.0.1:64009', '2019-07-11 07:52:28');
INSERT INTO `rms_log_user_login` VALUES (167, 'admin', '127.0.0.1:51227', '2019-07-11 08:07:35');
INSERT INTO `rms_log_user_login` VALUES (168, 'admin', '127.0.0.1:52829', '2019-07-11 08:13:57');
INSERT INTO `rms_log_user_login` VALUES (169, 'admin', '127.0.0.1:52829', '2019-07-11 08:16:38');
INSERT INTO `rms_log_user_login` VALUES (170, 'admin', '127.0.0.1:52829', '2019-07-11 08:20:09');
INSERT INTO `rms_log_user_login` VALUES (171, 'admin', '127.0.0.1:52829', '2019-07-11 08:20:18');
INSERT INTO `rms_log_user_login` VALUES (172, 'admin', '127.0.0.1:56956', '2019-07-11 08:31:19');
INSERT INTO `rms_log_user_login` VALUES (173, 'admin', '127.0.0.1:56956', '2019-07-11 08:31:59');
INSERT INTO `rms_log_user_login` VALUES (174, 'admin', '127.0.0.1:57352', '2019-07-11 08:32:45');
INSERT INTO `rms_log_user_login` VALUES (175, 'admin', '127.0.0.1:59353', '2019-07-11 08:41:18');
INSERT INTO `rms_log_user_login` VALUES (176, 'admin', '127.0.0.1:64669', '2019-07-11 09:03:42');
INSERT INTO `rms_log_user_login` VALUES (177, 'admin', '127.0.0.1:58442', '2019-07-12 06:56:58');
INSERT INTO `rms_log_user_login` VALUES (178, 'admin', '127.0.0.1:58666', '2019-07-12 06:59:15');
INSERT INTO `rms_log_user_login` VALUES (179, 'admin', '127.0.0.1:58896', '2019-07-12 07:01:26');
INSERT INTO `rms_log_user_login` VALUES (180, 'admin', '127.0.0.1:61811', '2019-07-12 07:27:36');
INSERT INTO `rms_log_user_login` VALUES (181, 'admin', '127.0.0.1:56233', '2019-07-12 09:10:57');
INSERT INTO `rms_log_user_login` VALUES (182, 'admin', '127.0.0.1:63036', '2019-07-12 10:17:14');
INSERT INTO `rms_log_user_login` VALUES (183, 'admin', '127.0.0.1:63197', '2019-07-12 10:18:48');
INSERT INTO `rms_log_user_login` VALUES (184, 'admin', '127.0.0.1:63283', '2019-07-12 10:19:33');
INSERT INTO `rms_log_user_login` VALUES (185, 'admin', '127.0.0.1:62349', '2019-07-15 02:29:04');
INSERT INTO `rms_log_user_login` VALUES (186, 'admin', '127.0.0.1:61545', '2019-07-15 07:13:37');
INSERT INTO `rms_log_user_login` VALUES (187, 'admin', '127.0.0.1:64192', '2019-07-15 09:56:46');
INSERT INTO `rms_log_user_login` VALUES (188, 'admin', '127.0.0.1:49795', '2019-07-16 01:49:35');
INSERT INTO `rms_log_user_login` VALUES (189, 'admin', '127.0.0.1:49250', '2019-07-19 06:06:46');
INSERT INTO `rms_log_user_login` VALUES (190, 'admin', '127.0.0.1:49749', '2019-07-19 06:26:56');
INSERT INTO `rms_log_user_login` VALUES (191, 'admin', '127.0.0.1:62823', '2019-07-19 06:58:05');
INSERT INTO `rms_log_user_login` VALUES (192, 'admin', '127.0.0.1:64048', '2019-07-19 07:22:11');
INSERT INTO `rms_log_user_login` VALUES (193, 'admin', '127.0.0.1:50381', '2019-07-19 07:46:52');
INSERT INTO `rms_log_user_login` VALUES (194, 'admin', '127.0.0.1:58009', '2019-07-19 08:26:19');
INSERT INTO `rms_log_user_login` VALUES (195, 'admin', '127.0.0.1:59693', '2019-07-19 08:41:31');
INSERT INTO `rms_log_user_login` VALUES (196, 'admin', '127.0.0.1:62894', '2019-07-25 01:40:09');
INSERT INTO `rms_log_user_login` VALUES (197, 'admin', '127.0.0.1:51819', '2019-07-25 10:28:10');
INSERT INTO `rms_log_user_login` VALUES (198, 'admin', '127.0.0.1:49416', '2019-07-26 07:11:00');
INSERT INTO `rms_log_user_login` VALUES (199, 'admin', '127.0.0.1:50724', '2019-07-26 07:34:15');
INSERT INTO `rms_log_user_login` VALUES (200, 'admin', '127.0.0.1:52308', '2019-07-26 07:45:32');
INSERT INTO `rms_log_user_login` VALUES (201, 'admin', '127.0.0.1:53372', '2019-07-26 07:54:49');
INSERT INTO `rms_log_user_login` VALUES (202, 'admin', '127.0.0.1:53445', '2019-07-26 07:55:18');
INSERT INTO `rms_log_user_login` VALUES (203, 'admin', '127.0.0.1:63630', '2019-07-26 09:20:39');
INSERT INTO `rms_log_user_login` VALUES (204, 'admin', '127.0.0.1:49576', '2019-07-29 07:47:02');
INSERT INTO `rms_log_user_login` VALUES (205, 'admin', '127.0.0.1:62921', '2019-07-29 09:36:12');
INSERT INTO `rms_log_user_login` VALUES (206, 'admin', '127.0.0.1:59310', '2019-07-29 09:45:30');
INSERT INTO `rms_log_user_login` VALUES (207, 'admin', '127.0.0.1:56000', '2019-07-30 02:29:23');
INSERT INTO `rms_log_user_login` VALUES (208, 'admin', '127.0.0.1:56037', '2019-07-30 02:30:48');
INSERT INTO `rms_log_user_login` VALUES (209, 'admin', '127.0.0.1:56611', '2019-07-30 02:37:27');
INSERT INTO `rms_log_user_login` VALUES (210, 'admin', '127.0.0.1:56084', '2019-07-30 05:04:03');
INSERT INTO `rms_log_user_login` VALUES (211, 'admin', '127.0.0.1:59783', '2019-07-30 08:37:36');
INSERT INTO `rms_log_user_login` VALUES (212, 'admin', '127.0.0.1:59853', '2019-07-30 08:38:17');
INSERT INTO `rms_log_user_login` VALUES (213, 'admin', '127.0.0.1:53559', '2019-07-30 09:39:33');
INSERT INTO `rms_log_user_login` VALUES (214, 'admin', '127.0.0.1:53521', '2019-07-31 04:36:22');
INSERT INTO `rms_log_user_login` VALUES (215, 'admin', '127.0.0.1:53722', '2019-07-31 04:38:41');
INSERT INTO `rms_log_user_login` VALUES (216, 'admin', '127.0.0.1:64554', '2019-07-31 06:29:44');
INSERT INTO `rms_log_user_login` VALUES (217, 'admin', '127.0.0.1:58737', '2019-08-02 01:39:26');
INSERT INTO `rms_log_user_login` VALUES (218, 'admin', '127.0.0.1:58759', '2019-08-02 01:41:32');
INSERT INTO `rms_log_user_login` VALUES (219, 'admin', '127.0.0.1:53242', '2019-08-04 02:47:12');
INSERT INTO `rms_log_user_login` VALUES (220, 'admin', '127.0.0.1:56105', '2019-08-05 06:20:19');
INSERT INTO `rms_log_user_login` VALUES (221, 'admin', '127.0.0.1:64897', '2019-08-05 07:31:55');
INSERT INTO `rms_log_user_login` VALUES (222, 'admin', '127.0.0.1:58897', '2019-08-05 08:38:08');
INSERT INTO `rms_log_user_login` VALUES (223, 'admin', '127.0.0.1:59354', '2019-08-05 08:47:28');
INSERT INTO `rms_log_user_login` VALUES (224, 'admin', '127.0.0.1:62987', '2019-08-05 09:17:01');
INSERT INTO `rms_log_user_login` VALUES (225, 'admin', '127.0.0.1:20692', '2019-08-05 12:56:41');
INSERT INTO `rms_log_user_login` VALUES (226, 'admin', '127.0.0.1:23206', '2019-08-05 13:26:18');
INSERT INTO `rms_log_user_login` VALUES (227, 'admin', '127.0.0.1:29721', '2019-08-05 14:58:25');
INSERT INTO `rms_log_user_login` VALUES (228, 'admin', '127.0.0.1:30948', '2019-08-05 15:11:34');
INSERT INTO `rms_log_user_login` VALUES (229, 'admin', '127.0.0.1:31253', '2019-08-05 15:19:08');
INSERT INTO `rms_log_user_login` VALUES (230, 'admin', '127.0.0.1:31637', '2019-08-05 15:27:48');
INSERT INTO `rms_log_user_login` VALUES (231, 'admin', '127.0.0.1:31637', '2019-08-05 15:30:24');
INSERT INTO `rms_log_user_login` VALUES (232, 'admin', '127.0.0.1:31637', '2019-08-05 15:33:03');
INSERT INTO `rms_log_user_login` VALUES (233, 'admin', '127.0.0.1:31637', '2019-08-05 15:36:39');
INSERT INTO `rms_log_user_login` VALUES (234, 'admin', '127.0.0.1:31637', '2019-08-05 15:42:38');
INSERT INTO `rms_log_user_login` VALUES (235, 'admin', '127.0.0.1:32113', '2019-08-05 15:43:11');
INSERT INTO `rms_log_user_login` VALUES (236, 'admin', '127.0.0.1:7727', '2019-08-14 13:17:16');
INSERT INTO `rms_log_user_login` VALUES (237, 'admin', '127.0.0.1:12731', '2019-08-14 14:46:00');
INSERT INTO `rms_log_user_login` VALUES (238, 'admin', '127.0.0.1:16173', '2019-08-15 12:44:09');
INSERT INTO `rms_log_user_login` VALUES (239, 'admin', '127.0.0.1:18683', '2019-08-15 13:31:20');
INSERT INTO `rms_log_user_login` VALUES (240, 'admin', '127.0.0.1:18716', '2019-08-15 13:32:03');
INSERT INTO `rms_log_user_login` VALUES (241, 'admin', '127.0.0.1:18865', '2019-08-15 13:35:23');
INSERT INTO `rms_log_user_login` VALUES (242, 'admin', '127.0.0.1:20631', '2019-08-15 14:18:48');
INSERT INTO `rms_log_user_login` VALUES (243, 'admin', '127.0.0.1:22559', '2019-08-15 14:49:12');
INSERT INTO `rms_log_user_login` VALUES (244, 'admin', '127.0.0.1:22781', '2019-08-15 14:55:24');
INSERT INTO `rms_log_user_login` VALUES (245, 'admin', '127.0.0.1:23646', '2019-08-16 11:54:54');
INSERT INTO `rms_log_user_login` VALUES (246, 'admin', '127.0.0.1:25367', '2019-08-16 12:22:49');
INSERT INTO `rms_log_user_login` VALUES (247, 'admin', '127.0.0.1:25429', '2019-08-16 12:25:46');
INSERT INTO `rms_log_user_login` VALUES (248, 'admin', '127.0.0.1:29729', '2019-08-16 13:22:36');
INSERT INTO `rms_log_user_login` VALUES (249, 'admin', '127.0.0.1:29767', '2019-08-16 13:23:12');
INSERT INTO `rms_log_user_login` VALUES (250, 'admin', '127.0.0.1:29831', '2019-08-16 13:23:45');
INSERT INTO `rms_log_user_login` VALUES (251, 'admin', '127.0.0.1:29913', '2019-08-16 13:24:16');
INSERT INTO `rms_log_user_login` VALUES (252, 'admin', '127.0.0.1:31259', '2019-08-16 13:35:24');
INSERT INTO `rms_log_user_login` VALUES (253, 'admin', '127.0.0.1:31394', '2019-08-16 13:36:28');
INSERT INTO `rms_log_user_login` VALUES (254, 'admin', '127.0.0.1:32172', '2019-08-16 13:43:07');
INSERT INTO `rms_log_user_login` VALUES (255, 'admin', '127.0.0.1:33437', '2019-08-16 13:52:48');
INSERT INTO `rms_log_user_login` VALUES (256, 'admin', '127.0.0.1:34774', '2019-08-16 14:03:56');
INSERT INTO `rms_log_user_login` VALUES (257, 'admin', '127.0.0.1:34822', '2019-08-16 14:04:16');
INSERT INTO `rms_log_user_login` VALUES (258, 'admin', '127.0.0.1:35235', '2019-08-16 14:07:48');
INSERT INTO `rms_log_user_login` VALUES (259, 'admin', '127.0.0.1:38504', '2019-08-16 14:29:31');
INSERT INTO `rms_log_user_login` VALUES (260, 'admin', '127.0.0.1:40509', '2019-08-16 14:46:29');
INSERT INTO `rms_log_user_login` VALUES (261, 'admin', '127.0.0.1:40979', '2019-08-16 14:50:27');
INSERT INTO `rms_log_user_login` VALUES (262, 'admin', '127.0.0.1:41100', '2019-08-16 14:51:22');
INSERT INTO `rms_log_user_login` VALUES (263, 'admin', '127.0.0.1:41320', '2019-08-16 14:53:07');
INSERT INTO `rms_log_user_login` VALUES (264, 'admin', '127.0.0.1:41607', '2019-08-16 14:55:29');
INSERT INTO `rms_log_user_login` VALUES (265, 'admin', '127.0.0.1:43731', '2019-08-16 15:11:50');
INSERT INTO `rms_log_user_login` VALUES (266, 'admin', '127.0.0.1:46249', '2019-08-16 15:57:22');
INSERT INTO `rms_log_user_login` VALUES (267, 'admin', '127.0.0.1:48803', '2019-08-17 11:55:05');
INSERT INTO `rms_log_user_login` VALUES (268, 'admin', '127.0.0.1:49158', '2019-08-17 12:10:43');
INSERT INTO `rms_log_user_login` VALUES (269, 'admin', '127.0.0.1:53982', '2019-08-17 13:00:59');
INSERT INTO `rms_log_user_login` VALUES (270, 'admin', '127.0.0.1:54378', '2019-08-17 13:05:04');
INSERT INTO `rms_log_user_login` VALUES (271, 'admin', '127.0.0.1:56115', '2019-08-17 13:28:31');
INSERT INTO `rms_log_user_login` VALUES (272, 'admin', '127.0.0.1:59558', '2019-08-17 15:23:33');
INSERT INTO `rms_log_user_login` VALUES (273, 'admin', '127.0.0.1:59648', '2019-08-17 15:25:43');
INSERT INTO `rms_log_user_login` VALUES (274, 'admin', '127.0.0.1:59730', '2019-08-17 15:27:38');
INSERT INTO `rms_log_user_login` VALUES (275, 'admin', '127.0.0.1:59811', '2019-08-17 15:29:46');
INSERT INTO `rms_log_user_login` VALUES (276, 'admin', '127.0.0.1:59854', '2019-08-17 15:30:50');
INSERT INTO `rms_log_user_login` VALUES (277, 'admin', '127.0.0.1:60359', '2019-08-17 15:44:28');
INSERT INTO `rms_log_user_login` VALUES (278, 'admin', '127.0.0.1:62206', '2019-08-18 02:04:18');
INSERT INTO `rms_log_user_login` VALUES (279, 'admin', '127.0.0.1:7411', '2019-08-18 03:57:36');
INSERT INTO `rms_log_user_login` VALUES (280, 'admin', '127.0.0.1:8118', '2019-08-18 04:03:10');
INSERT INTO `rms_log_user_login` VALUES (281, 'admin', '127.0.0.1:17435', '2019-08-18 05:45:32');
INSERT INTO `rms_log_user_login` VALUES (282, 'admin', '127.0.0.1:18597', '2019-08-18 05:58:47');
INSERT INTO `rms_log_user_login` VALUES (283, 'admin', '127.0.0.1:19114', '2019-08-18 06:04:58');
INSERT INTO `rms_log_user_login` VALUES (284, 'admin', '127.0.0.1:20465', '2019-08-18 06:24:10');
INSERT INTO `rms_log_user_login` VALUES (285, 'admin', '127.0.0.1:22374', '2019-08-18 06:29:56');
INSERT INTO `rms_log_user_login` VALUES (286, 'admin', '127.0.0.1:22822', '2019-08-18 06:33:21');
INSERT INTO `rms_log_user_login` VALUES (287, 'admin', '127.0.0.1:23336', '2019-08-18 06:38:38');
INSERT INTO `rms_log_user_login` VALUES (288, 'admin', '127.0.0.1:28927', '2019-08-18 07:30:40');
INSERT INTO `rms_log_user_login` VALUES (289, 'admin', '127.0.0.1:43343', '2019-08-18 10:13:41');
INSERT INTO `rms_log_user_login` VALUES (290, 'admin', '127.0.0.1:45882', '2019-08-18 10:32:34');
INSERT INTO `rms_log_user_login` VALUES (291, 'admin', '127.0.0.1:46014', '2019-08-18 10:33:23');
INSERT INTO `rms_log_user_login` VALUES (292, 'admin', '127.0.0.1:53462', '2019-08-18 11:57:24');
INSERT INTO `rms_log_user_login` VALUES (293, 'admin', '127.0.0.1:60213', '2019-08-18 13:02:20');
INSERT INTO `rms_log_user_login` VALUES (294, 'admin', '127.0.0.1:61148', '2019-08-18 13:20:30');
INSERT INTO `rms_log_user_login` VALUES (295, 'admin', '127.0.0.1:61360', '2019-08-18 13:25:51');
INSERT INTO `rms_log_user_login` VALUES (296, 'admin', '127.0.0.1:61649', '2019-08-18 13:29:37');
INSERT INTO `rms_log_user_login` VALUES (297, 'admin', '127.0.0.1:64022', '2019-08-18 14:32:28');
INSERT INTO `rms_log_user_login` VALUES (298, 'admin', '127.0.0.1:64098', '2019-08-18 14:34:18');
INSERT INTO `rms_log_user_login` VALUES (299, 'admin', '127.0.0.1:1972', '2019-08-19 12:28:15');
INSERT INTO `rms_log_user_login` VALUES (300, 'admin', '127.0.0.1:2452', '2019-08-19 12:40:04');
INSERT INTO `rms_log_user_login` VALUES (301, 'admin', '127.0.0.1:3469', '2019-08-19 13:10:23');
INSERT INTO `rms_log_user_login` VALUES (302, 'admin', '127.0.0.1:3469', '2019-08-19 13:13:36');
INSERT INTO `rms_log_user_login` VALUES (303, 'admin', '127.0.0.1:3656', '2019-08-19 13:15:17');
INSERT INTO `rms_log_user_login` VALUES (304, 'admin', '127.0.0.1:3874', '2019-08-19 13:19:50');
INSERT INTO `rms_log_user_login` VALUES (305, 'admin', '127.0.0.1:5816', '2019-08-19 13:44:08');
INSERT INTO `rms_log_user_login` VALUES (306, 'admin', '127.0.0.1:9426', '2019-08-19 15:00:59');
INSERT INTO `rms_log_user_login` VALUES (307, 'admin', '127.0.0.1:11828', '2019-08-20 12:58:06');
INSERT INTO `rms_log_user_login` VALUES (308, 'admin', '127.0.0.1:12234', '2019-08-20 13:03:34');
INSERT INTO `rms_log_user_login` VALUES (309, 'admin', '127.0.0.1:12372', '2019-08-20 13:06:05');
INSERT INTO `rms_log_user_login` VALUES (310, 'admin', '127.0.0.1:12372', '2019-08-20 13:10:02');
INSERT INTO `rms_log_user_login` VALUES (311, 'admin', '127.0.0.1:12372', '2019-08-20 13:10:43');
INSERT INTO `rms_log_user_login` VALUES (312, 'admin', '127.0.0.1:19668', '2019-08-21 11:37:54');
INSERT INTO `rms_log_user_login` VALUES (313, 'admin', '127.0.0.1:19852', '2019-08-21 12:14:56');
INSERT INTO `rms_log_user_login` VALUES (314, 'admin', '127.0.0.1:19873', '2019-08-21 12:17:56');
INSERT INTO `rms_log_user_login` VALUES (315, 'admin', '127.0.0.1:19885', '2019-08-21 12:18:46');
INSERT INTO `rms_log_user_login` VALUES (316, 'admin', '127.0.0.1:33163', '2019-08-21 15:16:53');
INSERT INTO `rms_log_user_login` VALUES (317, 'admin', '127.0.0.1:33163', '2019-08-21 15:20:25');
INSERT INTO `rms_log_user_login` VALUES (318, 'admin', '127.0.0.1:34265', '2019-08-21 15:26:30');
INSERT INTO `rms_log_user_login` VALUES (319, 'admin', '127.0.0.1:34343', '2019-08-21 15:27:10');
INSERT INTO `rms_log_user_login` VALUES (320, 'admin', '127.0.0.1:34982', '2019-08-21 15:32:47');
INSERT INTO `rms_log_user_login` VALUES (321, 'admin', '127.0.0.1:36685', '2019-08-22 11:45:37');
INSERT INTO `rms_log_user_login` VALUES (322, 'admin', '127.0.0.1:44678', '2019-08-22 13:03:57');
INSERT INTO `rms_log_user_login` VALUES (323, 'admin', '127.0.0.1:58639', '2019-08-23 13:24:29');
INSERT INTO `rms_log_user_login` VALUES (324, 'admin', '127.0.0.1:59400', '2019-08-23 13:56:28');
INSERT INTO `rms_log_user_login` VALUES (325, 'admin', '127.0.0.1:59400', '2019-08-23 13:59:29');
INSERT INTO `rms_log_user_login` VALUES (326, 'admin', '127.0.0.1:60429', '2019-08-23 14:52:58');
INSERT INTO `rms_log_user_login` VALUES (327, 'admin', '127.0.0.1:60448', '2019-08-23 14:53:38');
INSERT INTO `rms_log_user_login` VALUES (328, 'admin', '127.0.0.1:60490', '2019-08-23 14:55:08');
INSERT INTO `rms_log_user_login` VALUES (329, 'admin', '127.0.0.1:60622', '2019-08-23 14:58:12');
INSERT INTO `rms_log_user_login` VALUES (330, 'admin', '127.0.0.1:61530', '2019-08-23 15:07:33');
INSERT INTO `rms_log_user_login` VALUES (331, 'admin', '127.0.0.1:63027', '2019-08-23 15:50:28');
INSERT INTO `rms_log_user_login` VALUES (332, 'admin', '127.0.0.1:63661', '2019-08-25 13:28:01');
INSERT INTO `rms_log_user_login` VALUES (333, 'admin', '127.0.0.1:63937', '2019-08-25 13:30:55');
INSERT INTO `rms_log_user_login` VALUES (334, 'admin', '127.0.0.1:5193', '2019-08-25 14:23:45');
INSERT INTO `rms_log_user_login` VALUES (335, 'admin', '127.0.0.1:5642', '2019-08-25 14:27:58');
INSERT INTO `rms_log_user_login` VALUES (336, 'admin', '127.0.0.1:6066', '2019-08-25 14:34:06');
INSERT INTO `rms_log_user_login` VALUES (337, 'admin', '127.0.0.1:7476', '2019-08-27 12:56:47');
INSERT INTO `rms_log_user_login` VALUES (338, 'admin', '127.0.0.1:14409', '2019-08-28 12:21:34');
INSERT INTO `rms_log_user_login` VALUES (339, 'admin', '127.0.0.1:14409', '2019-08-28 12:26:31');
INSERT INTO `rms_log_user_login` VALUES (340, 'admin', '127.0.0.1:32321', '2019-08-28 14:48:47');
INSERT INTO `rms_log_user_login` VALUES (341, 'admin', '127.0.0.1:37761', '2019-08-29 12:34:34');
INSERT INTO `rms_log_user_login` VALUES (342, 'admin', '127.0.0.1:43049', '2019-08-29 13:24:09');
INSERT INTO `rms_log_user_login` VALUES (343, 'admin', '127.0.0.1:44395', '2019-08-29 14:15:09');
INSERT INTO `rms_log_user_login` VALUES (344, 'admin', '127.0.0.1:44439', '2019-08-29 14:16:35');
INSERT INTO `rms_log_user_login` VALUES (345, 'admin', '127.0.0.1:44498', '2019-08-29 14:18:35');
INSERT INTO `rms_log_user_login` VALUES (346, 'admin', '127.0.0.1:44622', '2019-08-29 14:19:41');
INSERT INTO `rms_log_user_login` VALUES (347, 'admin', '127.0.0.1:45190', '2019-08-29 14:25:42');
INSERT INTO `rms_log_user_login` VALUES (348, 'admin', '127.0.0.1:45948', '2019-08-29 14:32:14');
INSERT INTO `rms_log_user_login` VALUES (349, 'admin', '127.0.0.1:48009', '2019-08-29 14:49:24');
INSERT INTO `rms_log_user_login` VALUES (350, 'admin', '127.0.0.1:48571', '2019-08-29 14:54:12');
INSERT INTO `rms_log_user_login` VALUES (351, 'admin', '127.0.0.1:50146', '2019-08-30 12:12:16');
INSERT INTO `rms_log_user_login` VALUES (352, 'admin', '127.0.0.1:51325', '2019-08-30 12:21:44');
INSERT INTO `rms_log_user_login` VALUES (353, 'admin', '127.0.0.1:51703', '2019-08-30 12:25:35');
INSERT INTO `rms_log_user_login` VALUES (354, 'admin', '127.0.0.1:55218', '2019-08-30 12:53:43');
INSERT INTO `rms_log_user_login` VALUES (355, 'admin', '127.0.0.1:60543', '2019-08-30 13:35:18');
INSERT INTO `rms_log_user_login` VALUES (356, 'admin', '127.0.0.1:60611', '2019-08-30 13:36:05');
INSERT INTO `rms_log_user_login` VALUES (357, 'admin', '127.0.0.1:60980', '2019-08-30 13:39:11');
INSERT INTO `rms_log_user_login` VALUES (358, 'admin', '127.0.0.1:61168', '2019-08-30 13:40:48');
INSERT INTO `rms_log_user_login` VALUES (359, 'admin', '127.0.0.1:8132', '2019-08-30 15:15:12');
INSERT INTO `rms_log_user_login` VALUES (360, 'admin', '127.0.0.1:11800', '2019-08-30 15:44:06');
INSERT INTO `rms_log_user_login` VALUES (361, 'admin', '127.0.0.1:13521', '2019-08-30 15:56:50');
INSERT INTO `rms_log_user_login` VALUES (362, 'admin', '127.0.0.1:21573', '2019-08-31 13:05:12');
INSERT INTO `rms_log_user_login` VALUES (363, 'admin', '127.0.0.1:21842', '2019-08-31 13:15:56');
INSERT INTO `rms_log_user_login` VALUES (364, 'admin', '127.0.0.1:25246', '2019-08-31 13:47:23');
INSERT INTO `rms_log_user_login` VALUES (365, 'admin', '127.0.0.1:25401', '2019-08-31 13:48:40');
INSERT INTO `rms_log_user_login` VALUES (366, 'admin', '127.0.0.1:27553', '2019-08-31 14:06:50');
INSERT INTO `rms_log_user_login` VALUES (367, 'admin', '127.0.0.1:27706', '2019-08-31 14:08:02');
INSERT INTO `rms_log_user_login` VALUES (368, 'admin', '127.0.0.1:27795', '2019-08-31 14:08:45');
INSERT INTO `rms_log_user_login` VALUES (369, 'admin', '127.0.0.1:27981', '2019-08-31 14:10:15');
INSERT INTO `rms_log_user_login` VALUES (370, 'admin', '127.0.0.1:28197', '2019-08-31 14:12:05');
INSERT INTO `rms_log_user_login` VALUES (371, 'admin', '127.0.0.1:28288', '2019-08-31 14:12:48');
INSERT INTO `rms_log_user_login` VALUES (372, 'admin', '127.0.0.1:29714', '2019-08-31 14:22:37');
INSERT INTO `rms_log_user_login` VALUES (373, 'admin', '127.0.0.1:35138', '2019-08-31 15:06:38');
INSERT INTO `rms_log_user_login` VALUES (374, 'admin', '127.0.0.1:35460', '2019-08-31 15:09:05');
INSERT INTO `rms_log_user_login` VALUES (375, 'admin', '127.0.0.1:36290', '2019-08-31 15:16:06');
INSERT INTO `rms_log_user_login` VALUES (376, 'admin', '127.0.0.1:36639', '2019-08-31 15:19:05');
INSERT INTO `rms_log_user_login` VALUES (377, 'admin', '127.0.0.1:39467', '2019-08-31 15:43:51');
INSERT INTO `rms_log_user_login` VALUES (378, 'admin', '127.0.0.1:41824', '2019-09-01 13:51:27');
INSERT INTO `rms_log_user_login` VALUES (379, 'admin', '127.0.0.1:42734', '2019-09-01 14:19:50');
INSERT INTO `rms_log_user_login` VALUES (380, 'admin', '127.0.0.1:42759', '2019-09-01 14:20:49');
INSERT INTO `rms_log_user_login` VALUES (381, 'admin', '127.0.0.1:42818', '2019-09-01 14:22:37');
INSERT INTO `rms_log_user_login` VALUES (382, 'admin', '127.0.0.1:43437', '2019-09-01 14:33:46');
INSERT INTO `rms_log_user_login` VALUES (383, 'admin', '127.0.0.1:43490', '2019-09-01 14:47:02');
INSERT INTO `rms_log_user_login` VALUES (384, 'admin', '127.0.0.1:44012', '2019-09-01 14:54:57');
INSERT INTO `rms_log_user_login` VALUES (385, 'admin', '127.0.0.1:2612', '2019-09-02 12:51:16');
INSERT INTO `rms_log_user_login` VALUES (386, 'admin', '127.0.0.1:3110', '2019-09-02 12:55:45');
INSERT INTO `rms_log_user_login` VALUES (387, 'admin', '127.0.0.1:3198', '2019-09-02 12:56:41');
INSERT INTO `rms_log_user_login` VALUES (388, 'admin', '127.0.0.1:4836', '2019-09-02 13:15:32');
INSERT INTO `rms_log_user_login` VALUES (389, 'admin', '127.0.0.1:9681', '2019-09-02 14:04:59');
INSERT INTO `rms_log_user_login` VALUES (390, 'admin', '127.0.0.1:10407', '2019-09-02 14:12:07');
INSERT INTO `rms_log_user_login` VALUES (391, 'admin', '127.0.0.1:12151', '2019-09-02 22:27:07');
INSERT INTO `rms_log_user_login` VALUES (392, 'admin', '127.0.0.1:14696', '2019-09-02 22:52:02');
INSERT INTO `rms_log_user_login` VALUES (393, 'admin', '127.0.0.1:14999', '2019-09-02 22:55:55');
INSERT INTO `rms_log_user_login` VALUES (394, 'admin', '127.0.0.1:26384', '2019-11-11 14:43:47');
INSERT INTO `rms_log_user_login` VALUES (395, 'admin', '127.0.0.1:29531', '2019-11-11 15:08:59');
INSERT INTO `rms_log_user_login` VALUES (396, 'admin', '127.0.0.1:35889', '2019-11-11 16:32:53');
INSERT INTO `rms_log_user_login` VALUES (397, 'admin', '127.0.0.1:48184', '2019-11-11 18:02:27');
INSERT INTO `rms_log_user_login` VALUES (398, 'admin', '127.0.0.1:1224', '2019-11-11 21:52:38');
INSERT INTO `rms_log_user_login` VALUES (399, 'admin', '127.0.0.1:1491', '2019-11-11 21:57:30');
INSERT INTO `rms_log_user_login` VALUES (400, 'admin', '127.0.0.1:2954', '2019-11-11 22:20:11');
INSERT INTO `rms_log_user_login` VALUES (401, 'admin', '127.0.0.1:3149', '2019-11-11 22:22:15');
INSERT INTO `rms_log_user_login` VALUES (402, 'admin', '127.0.0.1:30601', '2019-11-14 10:57:33');
INSERT INTO `rms_log_user_login` VALUES (403, 'admin', '192.168.221.1:60995', '2020-02-21 15:38:31');
INSERT INTO `rms_log_user_login` VALUES (404, 'admin', '192.168.221.1:61108', '2020-02-21 15:41:37');
INSERT INTO `rms_log_user_login` VALUES (405, 'admin', '192.168.221.1:63655', '2020-02-24 15:39:03');
INSERT INTO `rms_log_user_login` VALUES (406, 'admin', '192.168.221.150:10793', '2020-02-24 16:27:26');
INSERT INTO `rms_log_user_login` VALUES (407, 'admin', '192.168.221.150:52988', '2020-02-24 16:31:21');
INSERT INTO `rms_log_user_login` VALUES (408, 'admin', '192.168.221.150:50437', '2020-02-24 17:51:43');
INSERT INTO `rms_log_user_login` VALUES (409, 'admin', '192.168.221.150:43505', '2020-02-25 15:30:37');
INSERT INTO `rms_log_user_login` VALUES (410, 'admin', '192.168.221.150:12837', '2020-02-25 15:30:56');
INSERT INTO `rms_log_user_login` VALUES (411, 'admin', '192.168.221.150:37051', '2020-02-25 15:31:16');
INSERT INTO `rms_log_user_login` VALUES (412, 'admin', '192.168.221.150:12837', '2020-02-25 15:31:26');
INSERT INTO `rms_log_user_login` VALUES (413, 'admin', '192.168.221.150:12837', '2020-02-25 15:31:39');
INSERT INTO `rms_log_user_login` VALUES (414, 'admin', '192.168.221.150:12837', '2020-02-25 15:31:50');
INSERT INTO `rms_log_user_login` VALUES (415, 'admin', '192.168.221.150:12837', '2020-02-25 15:32:46');
INSERT INTO `rms_log_user_login` VALUES (416, 'admin', '192.168.221.150:12837', '2020-02-25 15:33:27');
INSERT INTO `rms_log_user_login` VALUES (417, 'admin', '192.168.221.150:37051', '2020-02-25 15:35:52');
INSERT INTO `rms_log_user_login` VALUES (418, 'admin', '192.168.221.150:37051', '2020-02-25 15:36:14');
INSERT INTO `rms_log_user_login` VALUES (419, 'admin', '192.168.221.150:37051', '2020-02-25 15:37:40');
INSERT INTO `rms_log_user_login` VALUES (420, 'admin', '192.168.221.150:12837', '2020-02-25 15:37:57');
INSERT INTO `rms_log_user_login` VALUES (421, 'admin', '192.168.221.150:37051', '2020-02-25 15:38:27');
INSERT INTO `rms_log_user_login` VALUES (422, 'admin', '192.168.221.150:37051', '2020-02-25 15:39:22');
INSERT INTO `rms_log_user_login` VALUES (423, 'admin', '192.168.221.150:31618', '2020-02-25 15:48:49');
INSERT INTO `rms_log_user_login` VALUES (424, 'admin', '192.168.221.150:59785', '2020-02-25 15:49:14');
INSERT INTO `rms_log_user_login` VALUES (425, 'admin', '192.168.221.150:59785', '2020-02-25 15:49:47');
INSERT INTO `rms_log_user_login` VALUES (426, 'admin', '192.168.221.150:59785', '2020-02-25 15:50:01');
INSERT INTO `rms_log_user_login` VALUES (427, 'admin', '192.168.221.150:59785', '2020-02-25 15:50:11');
INSERT INTO `rms_log_user_login` VALUES (428, 'admin', '192.168.221.150:53731', '2020-02-25 17:17:47');
INSERT INTO `rms_log_user_login` VALUES (429, 'admin', '192.168.221.150:1244', '2020-02-25 20:43:58');
INSERT INTO `rms_log_user_login` VALUES (430, 'admin', '192.168.221.150:9530', '2020-02-25 21:32:38');
INSERT INTO `rms_log_user_login` VALUES (431, 'admin', '192.168.221.150:50187', '2020-02-25 22:46:07');
INSERT INTO `rms_log_user_login` VALUES (432, 'admin', '192.168.221.150:15663', '2020-02-29 01:30:25');
INSERT INTO `rms_log_user_login` VALUES (433, 'admin', '192.168.221.150:4212', '2020-03-04 23:51:03');
INSERT INTO `rms_log_user_login` VALUES (434, 'admin', '192.168.221.150:49915', '2020-03-05 00:21:15');
INSERT INTO `rms_log_user_login` VALUES (435, 'admin', '127.0.0.1:49472', '2020-03-26 17:22:08');
INSERT INTO `rms_log_user_login` VALUES (436, 'admin', '127.0.0.1:49474', '2020-03-26 17:23:04');
INSERT INTO `rms_log_user_login` VALUES (437, 'admin', '127.0.0.1:52780', '2020-03-29 22:56:02');
INSERT INTO `rms_log_user_login` VALUES (438, 'admin', '127.0.0.1:52827', '2020-03-29 23:01:28');
COMMIT;

-- ----------------------------
-- Table structure for rms_nav
-- ----------------------------
DROP TABLE IF EXISTS `rms_nav`;
CREATE TABLE `rms_nav` (
  `nav_id` int NOT NULL AUTO_INCREMENT,
  `nav_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '导航名',
  `nav_weight` tinyint NOT NULL DEFAULT '0' COMMENT '权重',
  `nav_status` tinyint NOT NULL DEFAULT '1' COMMENT 'status',
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_nav
-- ----------------------------
BEGIN;
INSERT INTO `rms_nav` VALUES (1, '游戏', 1, 1);
INSERT INTO `rms_nav` VALUES (2, '礼包', 2, 1);
INSERT INTO `rms_nav` VALUES (3, '资讯', 3, 1);
INSERT INTO `rms_nav` VALUES (4, '我的', 4, 1);
COMMIT;

-- ----------------------------
-- Table structure for rms_notice
-- ----------------------------
DROP TABLE IF EXISTS `rms_notice`;
CREATE TABLE `rms_notice` (
  `notice_id` bigint NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '公告标题',
  `notice_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `notice_weight` tinyint NOT NULL DEFAULT '0' COMMENT '权重',
  `notice_status` tinyint NOT NULL DEFAULT '1' COMMENT 'status',
  `notice_create_time` datetime NOT NULL,
  `notice_edit_time` datetime NOT NULL,
  `game_id` bigint NOT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_notice
-- ----------------------------
BEGIN;
INSERT INTO `rms_notice` VALUES (4, 'test3', '12', 13, 2, '2019-09-01 14:55:10', '2019-09-02 14:12:31', 6);
INSERT INTO `rms_notice` VALUES (5, '棋牌世界7', '12', 13, 2, '2019-09-02 21:34:52', '2019-09-02 22:29:41', 8);
INSERT INTO `rms_notice` VALUES (6, 'test2', '567', 14, 2, '2019-09-02 13:35:47', '2019-09-02 14:12:25', 6);
INSERT INTO `rms_notice` VALUES (7, 'aa', '09-需要利用富文本编辑器去编辑、类似于博客文章', 14, 2, '2019-09-02 14:03:43', '2019-09-02 22:45:51', 6);
COMMIT;

-- ----------------------------
-- Table structure for rms_resource
-- ----------------------------
DROP TABLE IF EXISTS `rms_resource`;
CREATE TABLE `rms_resource` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rtype` int NOT NULL DEFAULT '0',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `parent_id` int DEFAULT NULL,
  `seq` int NOT NULL DEFAULT '0',
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `url_for` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_resource
-- ----------------------------
BEGIN;
INSERT INTO `rms_resource` VALUES (7, 1, '权限管理', 8, 100, 'fa fa-balance-scale', '');
INSERT INTO `rms_resource` VALUES (8, 0, '系统菜单', NULL, 200, '', '');
INSERT INTO `rms_resource` VALUES (9, 1, '资源管理', 7, 100, '', 'ResourceController.Index');
INSERT INTO `rms_resource` VALUES (12, 1, '角色管理', 7, 100, '', 'RoleController.Index');
INSERT INTO `rms_resource` VALUES (13, 1, '用户管理', 7, 100, '', 'BackendUserController.Index');
INSERT INTO `rms_resource` VALUES (14, 1, '系统管理', 8, 90, 'fa fa-gears', '');
INSERT INTO `rms_resource` VALUES (21, 0, '业务菜单', NULL, 170, '', '');
INSERT INTO `rms_resource` VALUES (22, 1, '课程资源(空)', 21, 100, 'fa fa-book', '');
INSERT INTO `rms_resource` VALUES (23, 1, '日志管理', 14, 100, 'fa fa-building-o', 'LogController.Index');
INSERT INTO `rms_resource` VALUES (25, 2, '编辑', 9, 100, 'fa fa-pencil', 'ResourceController.Edit');
INSERT INTO `rms_resource` VALUES (26, 2, '编辑', 13, 100, 'fa fa-pencil', 'BackendUserController.Edit');
INSERT INTO `rms_resource` VALUES (27, 2, '删除', 9, 100, 'fa fa-trash', 'ResourceController.Delete');
INSERT INTO `rms_resource` VALUES (29, 2, '删除', 13, 100, 'fa fa-trash', 'BackendUserController.Delete');
INSERT INTO `rms_resource` VALUES (30, 2, '编辑', 12, 100, 'fa fa-pencil', 'RoleController.Edit');
INSERT INTO `rms_resource` VALUES (31, 2, '删除', 12, 100, 'fa fa-trash', 'RoleController.Delete');
INSERT INTO `rms_resource` VALUES (32, 2, '分配资源', 12, 100, 'fa fa-th', 'RoleController.Allocate');
INSERT INTO `rms_resource` VALUES (35, 1, ' 首页', NULL, 100, 'fa fa-dashboard', 'HomeController.Index');
INSERT INTO `rms_resource` VALUES (36, 0, '支付菜单', NULL, 100, '', '');
INSERT INTO `rms_resource` VALUES (37, 1, '支付宝', 36, 100, '', '');
INSERT INTO `rms_resource` VALUES (38, 1, '购买按钮', 37, 100, '', 'AlipayNewController.Index');
INSERT INTO `rms_resource` VALUES (39, 2, '购买', 38, 100, '', 'AlipayNewController.Native');
INSERT INTO `rms_resource` VALUES (40, 1, '商户支付宝管理', 37, 100, '', 'AlipayNewController.AlipayList');
INSERT INTO `rms_resource` VALUES (41, 2, '编辑', 40, 100, 'fa fa-pencil', 'AlipayNewController.Edit');
INSERT INTO `rms_resource` VALUES (42, 2, '删除', 40, 100, 'fa fa-trash', 'AlipayNewController.Delete');
INSERT INTO `rms_resource` VALUES (43, 0, '图片菜单', NULL, 100, 'fa fa-file-image-o', '');
INSERT INTO `rms_resource` VALUES (44, 1, '图片操作', 48, 100, 'fa fa-picture-o', 'ImageController.Index');
INSERT INTO `rms_resource` VALUES (45, 2, '上传', 44, 100, 'fa fa-upload', 'ImageController.UploadImage');
INSERT INTO `rms_resource` VALUES (46, 2, '移除', 44, 100, 'fa fa-times', 'ImageController.RemoveImages');
INSERT INTO `rms_resource` VALUES (48, 1, '图片', 43, 100, 'fa fa-picture-o', '');
INSERT INTO `rms_resource` VALUES (49, 2, '图片信息修改保存', 44, 100, 'fa fa-floppy-o', 'ImageController.BasicInfoSave');
INSERT INTO `rms_resource` VALUES (50, 1, '图片列表', 48, 100, 'fa fa-list', 'ImageController.ImageList');
INSERT INTO `rms_resource` VALUES (51, 2, '图片编辑', 50, 100, 'fa fa-pencil', 'ImageController.EditImage');
INSERT INTO `rms_resource` VALUES (52, 2, '图片删除', 50, 100, 'fa fa-trash', 'ImageController.RemoveImages');
INSERT INTO `rms_resource` VALUES (53, 2, '上传单图片', 44, 100, 'fa fa-upload', 'ImageController.UploadSingleImage');
INSERT INTO `rms_resource` VALUES (54, 0, '平台管理', NULL, 100, '', '');
INSERT INTO `rms_resource` VALUES (55, 1, '游戏管理', 54, 100, 'fa fa-gamepad', '');
INSERT INTO `rms_resource` VALUES (56, 1, '公告管理', 59, 100, '', 'GameNoticeController.Index');
INSERT INTO `rms_resource` VALUES (57, 1, '滚动播放管理', 59, 100, '', '');
INSERT INTO `rms_resource` VALUES (58, 1, '游戏分类标签管理', 59, 100, '', 'TabController.Index');
INSERT INTO `rms_resource` VALUES (59, 1, '平台操作', 54, 100, '', '');
INSERT INTO `rms_resource` VALUES (60, 1, '游戏列表', 55, 100, 'fa fa-align-justify', 'GameController.Index');
INSERT INTO `rms_resource` VALUES (61, 2, '游戏编辑', 60, 100, 'fa fa-pencil', 'GameController.EditGame');
INSERT INTO `rms_resource` VALUES (62, 2, '游戏删除', 60, 100, 'fa fa-trash', 'GameController.DelGame');
INSERT INTO `rms_resource` VALUES (63, 1, '游戏新增', 55, 100, 'fa fa-plus', 'GameController.AddGame');
INSERT INTO `rms_resource` VALUES (64, 2, '编辑', 58, 100, 'fa fa-pencil', 'TabController.Edit');
INSERT INTO `rms_resource` VALUES (65, 2, '删除', 58, 100, 'fa fa-trash', 'TabController.Delete');
INSERT INTO `rms_resource` VALUES (66, 1, '游戏类型管理', 59, 100, '', 'GameTypeController.Index');
INSERT INTO `rms_resource` VALUES (67, 2, '编辑', 66, 100, 'fa fa-pencil', 'GameTypeController.Edit');
INSERT INTO `rms_resource` VALUES (68, 2, '删除', 66, 100, 'fa fa-trash', 'GameTypeController.Delete');
INSERT INTO `rms_resource` VALUES (69, 1, '游戏导航管理', 59, 100, '', 'NavController.Index');
INSERT INTO `rms_resource` VALUES (70, 2, '编辑', 69, 100, 'fa fa-pencil', 'NavController.Edit');
INSERT INTO `rms_resource` VALUES (71, 2, '删除', 69, 100, 'fa fa-trash', 'NavController.Delete');
INSERT INTO `rms_resource` VALUES (72, 2, '编辑', 56, 100, 'fa fa-trash', 'GameNoticeController.Delete');
INSERT INTO `rms_resource` VALUES (73, 2, '删除', 56, 100, 'fa fa-pencil', 'GameNoticeController.Edit');
INSERT INTO `rms_resource` VALUES (74, 1, '游戏分类标签管理sub', 59, 100, '', 'TabTypeController.Index');
INSERT INTO `rms_resource` VALUES (75, 2, '编辑', 74, 100, 'fa fa-pencil', 'TabTypeController.Edit');
INSERT INTO `rms_resource` VALUES (76, 2, '删除', 74, 100, 'fa fa-trash', 'TabTypeController.Delete');
COMMIT;

-- ----------------------------
-- Table structure for rms_role
-- ----------------------------
DROP TABLE IF EXISTS `rms_role`;
CREATE TABLE `rms_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `seq` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_role
-- ----------------------------
BEGIN;
INSERT INTO `rms_role` VALUES (22, '超级管理员', 20);
INSERT INTO `rms_role` VALUES (24, '角色管理员', 10);
INSERT INTO `rms_role` VALUES (25, '课程资源管理员', 5);
COMMIT;

-- ----------------------------
-- Table structure for rms_role_backenduser_rel
-- ----------------------------
DROP TABLE IF EXISTS `rms_role_backenduser_rel`;
CREATE TABLE `rms_role_backenduser_rel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `backend_user_id` int NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_role_backenduser_rel
-- ----------------------------
BEGIN;
INSERT INTO `rms_role_backenduser_rel` VALUES (66, 25, 3, '2017-12-19 06:40:34');
INSERT INTO `rms_role_backenduser_rel` VALUES (70, 22, 1, '2020-03-26 17:22:55');
COMMIT;

-- ----------------------------
-- Table structure for rms_role_resource_rel
-- ----------------------------
DROP TABLE IF EXISTS `rms_role_resource_rel`;
CREATE TABLE `rms_role_resource_rel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `resource_id` int NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1567 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_role_resource_rel
-- ----------------------------
BEGIN;
INSERT INTO `rms_role_resource_rel` VALUES (429, 25, 21, '2017-12-19 06:40:04');
INSERT INTO `rms_role_resource_rel` VALUES (430, 25, 22, '2017-12-19 06:40:04');
INSERT INTO `rms_role_resource_rel` VALUES (448, 24, 8, '2017-12-19 06:40:16');
INSERT INTO `rms_role_resource_rel` VALUES (449, 24, 14, '2017-12-19 06:40:16');
INSERT INTO `rms_role_resource_rel` VALUES (450, 24, 23, '2017-12-19 06:40:16');
INSERT INTO `rms_role_resource_rel` VALUES (1510, 22, 35, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1511, 22, 36, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1512, 22, 37, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1513, 22, 38, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1514, 22, 39, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1515, 22, 40, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1516, 22, 41, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1517, 22, 42, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1518, 22, 43, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1519, 22, 48, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1520, 22, 44, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1521, 22, 45, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1522, 22, 46, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1523, 22, 49, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1524, 22, 53, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1525, 22, 50, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1526, 22, 51, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1527, 22, 52, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1528, 22, 54, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1529, 22, 55, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1530, 22, 60, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1531, 22, 61, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1532, 22, 62, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1533, 22, 63, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1534, 22, 59, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1535, 22, 56, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1536, 22, 72, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1537, 22, 73, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1538, 22, 57, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1539, 22, 58, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1540, 22, 64, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1541, 22, 65, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1542, 22, 66, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1543, 22, 67, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1544, 22, 68, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1545, 22, 69, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1546, 22, 70, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1547, 22, 71, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1548, 22, 74, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1549, 22, 75, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1550, 22, 76, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1551, 22, 21, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1552, 22, 22, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1553, 22, 8, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1554, 22, 14, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1555, 22, 23, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1556, 22, 7, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1557, 22, 9, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1558, 22, 25, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1559, 22, 27, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1560, 22, 12, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1561, 22, 30, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1562, 22, 31, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1563, 22, 32, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1564, 22, 13, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1565, 22, 26, '2019-11-11 16:08:14');
INSERT INTO `rms_role_resource_rel` VALUES (1566, 22, 29, '2019-11-11 16:08:14');
COMMIT;

-- ----------------------------
-- Table structure for rms_tab
-- ----------------------------
DROP TABLE IF EXISTS `rms_tab`;
CREATE TABLE `rms_tab` (
  `tab_id` int NOT NULL AUTO_INCREMENT,
  `tab_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `tab_weight` tinyint NOT NULL DEFAULT '0',
  `tab_status` tinyint NOT NULL DEFAULT '0',
  `tab_type_id` tinyint DEFAULT NULL,
  PRIMARY KEY (`tab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_tab
-- ----------------------------
BEGIN;
INSERT INTO `rms_tab` VALUES (3, '开服', 5, 1, 1);
INSERT INTO `rms_tab` VALUES (4, '最新', 2, 1, 1);
INSERT INTO `rms_tab` VALUES (5, '热门', 1, 1, 1);
INSERT INTO `rms_tab` VALUES (6, '排行', 4, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for rms_tab_type
-- ----------------------------
DROP TABLE IF EXISTS `rms_tab_type`;
CREATE TABLE `rms_tab_type` (
  `tab_type_id` tinyint NOT NULL,
  `tab_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类类型的明细',
  `tab_type_weight` tinyint NOT NULL DEFAULT '0',
  `tab_type_status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`tab_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of rms_tab_type
-- ----------------------------
BEGIN;
INSERT INTO `rms_tab_type` VALUES (1, '游戏主页', 10, 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
