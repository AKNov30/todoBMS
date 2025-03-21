/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 100017
 Source Host           : 127.0.0.1:3306
 Source Schema         : todo

 Target Server Type    : MySQL
 Target Server Version : 100017
 File Encoding         : 65001

 Date: 16/08/2023 09:15:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for serial
-- ----------------------------
DROP TABLE IF EXISTS `serial`;
CREATE TABLE `serial`  (
  `name` varchar(50) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `serial_no` int NULL DEFAULT NULL,
  `node_id` char(1) CHARACTER SET tis620 COLLATE tis620_thai_ci NULL DEFAULT NULL,
  `hos_guid` varchar(38) CHARACTER SET tis620 COLLATE tis620_thai_ci NULL DEFAULT NULL,
  `hos_guid_ext` varchar(64) CHARACTER SET tis620 COLLATE tis620_thai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  INDEX `ix_hos_guid_ext`(`hos_guid_ext` ASC) USING BTREE,
  INDEX `ix_hos_guid`(`hos_guid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = tis620 COLLATE = tis620_thai_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of serial
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL,
  `user_email` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `user_password` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_fname` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `user_lname` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = tis620 COLLATE = tis620_thai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_todo_list
-- ----------------------------
DROP TABLE IF EXISTS `user_todo_list`;
CREATE TABLE `user_todo_list`  (
  `user_todo_list_id` int NOT NULL,
  `user_todo_list_title` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `user_todo_list_desc` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `user_todo_list_completed` varchar(20) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `user_todo_list_last_update` datetime NOT NULL,
  `user_id` int NOT NULL,
  `user_todo_type_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`user_todo_list_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = tis620 COLLATE = tis620_thai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_todo_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_todo_type
-- ----------------------------
DROP TABLE IF EXISTS `user_todo_type`;
CREATE TABLE `user_todo_type`  (
  `user_todo_type_id` int NOT NULL,
  `user_todo_type_name` varchar(250) CHARACTER SET tis620 COLLATE tis620_thai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_todo_type_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = tis620 COLLATE = tis620_thai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_todo_type
-- ----------------------------
INSERT INTO `user_todo_type` VALUES (1, 'Pascal');
INSERT INTO `user_todo_type` VALUES (2, 'Dart');
INSERT INTO `user_todo_type` VALUES (3, 'Pythons');
INSERT INTO `user_todo_type` VALUES (4, 'Javass');
INSERT INTO `user_todo_type` VALUES (5, 'JavaScript');
INSERT INTO `user_todo_type` VALUES (6, 'C++');
INSERT INTO `user_todo_type` VALUES (7, 'C#');
INSERT INTO `user_todo_type` VALUES (8, 'PHP');
INSERT INTO `user_todo_type` VALUES (9, 'React JS');
INSERT INTO `user_todo_type` VALUES (10, 'React Native');
INSERT INTO `user_todo_type` VALUES (11, 'Node JS');
INSERT INTO `user_todo_type` VALUES (12, 'Swift UI');
INSERT INTO `user_todo_type` VALUES (13, 'Objective-C');
INSERT INTO `user_todo_type` VALUES (14, 'Kotlin');
INSERT INTO `user_todo_type` VALUES (15, 'TypeScript');
INSERT INTO `user_todo_type` VALUES (16, 'Value');
INSERT INTO `user_todo_type` VALUES (17, 'Next JS');
INSERT INTO `user_todo_type` VALUES (18, 'Visual Basic .NET');
INSERT INTO `user_todo_type` VALUES (19, 'SQL');

-- ----------------------------
-- Function structure for get_serialnumber
-- ----------------------------
DROP FUNCTION IF EXISTS `get_serialnumber`;
delimiter ;;
CREATE FUNCTION `get_serialnumber`(param1 varchar(150))
 RETURNS int(11)
begin   declare serial_exist int;   declare xserial_no  int;  SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;   if param1='' then      select 'test' into param1;   end if;    select count(serial_no) into serial_exist from serial where name = param1;   if serial_exist = 0 then   insert into serial (name,serial_no) values (param1,0);   end if;   update serial set serial_no = last_insert_id(serial_no + 1) where name = param1;   return last_insert_id();   end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for get_serialnumber_check_exists
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_serialnumber_check_exists`;
delimiter ;;
CREATE PROCEDURE `get_serialnumber_check_exists`(in aserial_name varchar(150),in atable_name varchar(200),in akey_name varchar(150),out aid int(11))
BEGIN
  declare xserial_no  integer;  
  declare xcount  integer;  
  
  repeat
  select get_serialnumber(aserial_name) into xserial_no;
  SET @query = CONCAT('select count(*) into @xcount from ', atable_name, ' WHERE ',akey_name,'=',xserial_no);
  prepare stmt from @query;
  execute stmt;
  
  until @xcount = 0 end repeat;
  set aid = xserial_no;
  #RETURN 0;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
