/*
Navicat MySQL Data Transfer

Source Server         : mylocalhost
Source Server Version : 50090
Source Host           : localhost:3306
Source Database       : examxx

Target Server Type    : MYSQL
Target Server Version : 50090
File Encoding         : 65001

Date: 2019-11-19 16:09:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for et_comment
-- ----------------------------
DROP TABLE IF EXISTS `et_comment`;
CREATE TABLE `et_comment` (
  `comment_id` int(10) NOT NULL auto_increment,
  `question_id` int(10) NOT NULL,
  `index_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `content_msg` mediumtext NOT NULL,
  `quoto_id` int(10) NOT NULL default '0',
  `re_id` int(10) NOT NULL default '0',
  `create_time` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`comment_id`),
  KEY `fk_q_id` (`question_id`),
  KEY `fk_u_id` (`user_id`),
  CONSTRAINT `fk_q_id` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_u_id` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_exam_paper
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_paper`;
CREATE TABLE `et_exam_paper` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) default '0',
  `pass_point` int(11) default '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL default '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL default '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `summary` varchar(100) default NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) default NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) default NULL COMMENT '创建人的账号',
  `paper_type` varchar(40) NOT NULL default '1' COMMENT '0 真题 1 模拟 2 专家',
  `field_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='试卷';

-- ----------------------------
-- Table structure for et_field
-- ----------------------------
DROP TABLE IF EXISTS `et_field`;
CREATE TABLE `et_field` (
  `field_id` int(5) NOT NULL auto_increment,
  `field_name` varchar(50) NOT NULL,
  `memo` varchar(100) default NULL,
  `state` decimal(1,0) NOT NULL default '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY  (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_group
-- ----------------------------
DROP TABLE IF EXISTS `et_group`;
CREATE TABLE `et_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `group_level_id` int(11) NOT NULL COMMENT '班组级别',
  `parent` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `group_level_id` (`group_level_id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班组';

-- ----------------------------
-- Table structure for et_knowledge_point
-- ----------------------------
DROP TABLE IF EXISTS `et_knowledge_point`;
CREATE TABLE `et_knowledge_point` (
  `point_id` int(5) NOT NULL auto_increment,
  `point_name` varchar(100) NOT NULL,
  `field_id` int(5) NOT NULL,
  `memo` varchar(100) default NULL,
  `state` decimal(1,0) default '1' COMMENT '1:正常 0：废弃',
  PRIMARY KEY  (`point_id`),
  KEY `fk_knowledge_field` (`field_id`),
  CONSTRAINT `et_knowledge_point_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `et_field` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_news
-- ----------------------------
DROP TABLE IF EXISTS `et_news`;
CREATE TABLE `et_news` (
  `id` int(11) NOT NULL auto_increment,
  `titile` varchar(100) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_expire` tinyint(1) NOT NULL default '0' COMMENT '是否过期',
  `type` tinyint(1) NOT NULL default '0' COMMENT '0 新闻， 1 系统信息',
  `group_id` int(11) NOT NULL default '-1' COMMENT '此系统属于哪个组',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `et_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_practice_paper
-- ----------------------------
DROP TABLE IF EXISTS `et_practice_paper`;
CREATE TABLE `et_practice_paper` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) default '0',
  `pass_point` int(11) default '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL default '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL default '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `summary` varchar(100) default NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) default NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) default NULL COMMENT '创建人的账号',
  PRIMARY KEY  (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试卷';

-- ----------------------------
-- Table structure for et_question
-- ----------------------------
DROP TABLE IF EXISTS `et_question`;
CREATE TABLE `et_question` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `question_type_id` int(11) NOT NULL COMMENT '题型',
  `duration` int(11) default NULL COMMENT '试题考试时间',
  `points` int(11) default NULL,
  `group_id` int(11) default NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL default '0' COMMENT '试题可见性',
  `create_time` timestamp NULL default NULL,
  `creator` varchar(20) NOT NULL default 'admin' COMMENT '创建者',
  `last_modify` timestamp NULL default CURRENT_TIMESTAMP,
  `answer` mediumtext NOT NULL,
  `expose_times` int(11) NOT NULL default '2',
  `right_times` int(11) NOT NULL default '1',
  `wrong_times` int(11) NOT NULL default '1',
  `difficulty` int(5) NOT NULL default '1',
  `analysis` mediumtext,
  `reference` varchar(1000) default NULL,
  `examing_point` varchar(5000) default NULL,
  `keyword` varchar(5000) default NULL,
  PRIMARY KEY  (`id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `et_question_ibfk_5` (`creator`),
  CONSTRAINT `et_question_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `et_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='试题';

-- ----------------------------
-- Table structure for et_question_2_point
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_point`;
CREATE TABLE `et_question_2_point` (
  `question_2_point_id` int(10) NOT NULL auto_increment,
  `question_id` int(10) default NULL,
  `point_id` int(10) default NULL,
  PRIMARY KEY  (`question_2_point_id`),
  KEY `fk_question_111` (`question_id`),
  KEY `fk_point_111` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `et_knowledge_point` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_question_2_tag
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_tag`;
CREATE TABLE `et_question_2_tag` (
  `question_tag_id` int(11) NOT NULL auto_increment,
  `question_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `creator` varchar(100) default NULL,
  PRIMARY KEY  (`question_tag_id`),
  KEY `fk_question_tag_tid` (`tag_id`),
  KEY `fk_question_tag_qid` (`question_id`),
  CONSTRAINT `fk_question_tag_qid` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_question_tag_tid` FOREIGN KEY (`tag_id`) REFERENCES `et_tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_question_type
-- ----------------------------
DROP TABLE IF EXISTS `et_question_type`;
CREATE TABLE `et_question_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `subjective` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='试题类型';

-- ----------------------------
-- Table structure for et_reference
-- ----------------------------
DROP TABLE IF EXISTS `et_reference`;
CREATE TABLE `et_reference` (
  `reference_id` int(5) NOT NULL auto_increment,
  `reference_name` varchar(200) NOT NULL,
  `memo` varchar(200) default NULL,
  `state` decimal(10,0) NOT NULL default '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY  (`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_role
-- ----------------------------
DROP TABLE IF EXISTS `et_role`;
CREATE TABLE `et_role` (
  `id` int(11) NOT NULL auto_increment,
  `authority` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for et_r_user_role
-- ----------------------------
DROP TABLE IF EXISTS `et_r_user_role`;
CREATE TABLE `et_r_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `et_r_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户_角色 关联表';

-- ----------------------------
-- Table structure for et_tag
-- ----------------------------
DROP TABLE IF EXISTS `et_tag`;
CREATE TABLE `et_tag` (
  `tag_id` int(11) NOT NULL auto_increment,
  `tag_name` varchar(100) NOT NULL,
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `creator` int(11) NOT NULL,
  `is_private` tinyint(1) NOT NULL default '0',
  `memo` varchar(500) default NULL,
  PRIMARY KEY  (`tag_id`),
  KEY `fk_tag_creator` (`creator`),
  CONSTRAINT `fk_tag_creator` FOREIGN KEY (`creator`) REFERENCES `et_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_user
-- ----------------------------
DROP TABLE IF EXISTS `et_user`;
CREATE TABLE `et_user` (
  `id` int(11) NOT NULL auto_increment COMMENT 'PK',
  `username` varchar(20) NOT NULL COMMENT '账号',
  `truename` varchar(10) default NULL COMMENT '真实姓名',
  `password` char(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(20) default NULL,
  `add_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `expire_date` timestamp NULL default NULL,
  `add_by` int(11) default NULL COMMENT '创建人',
  `enabled` tinyint(1) default '0' COMMENT '激活状态：0-未激活 1-激活',
  `field_id` int(10) NOT NULL,
  `last_login_time` timestamp NULL default NULL,
  `login_time` timestamp NULL default NULL,
  `province` varchar(20) default NULL,
  `company` varchar(40) default NULL,
  `department` varchar(40) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for et_user_exam_history
-- ----------------------------
DROP TABLE IF EXISTS `et_user_exam_history`;
CREATE TABLE `et_user_exam_history` (
  `id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
  `exam_paper_id` int(10) NOT NULL,
  `content` mediumtext,
  `create_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `answer_sheet` mediumtext,
  `duration` int(10) NOT NULL,
  `point_get` float(10,1) NOT NULL default '0.0',
  `submit_time` timestamp NULL default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for et_user_question_history_t
-- ----------------------------
DROP TABLE IF EXISTS `et_user_question_history_t`;
CREATE TABLE `et_user_question_history_t` (
  `user_question_hist_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `user_question_hist` mediumtext NOT NULL,
  `modify_time` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`user_question_hist_id`),
  UNIQUE KEY `idx_u_q_hist_userid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_c3p0
-- ----------------------------
DROP TABLE IF EXISTS `t_c3p0`;
CREATE TABLE `t_c3p0` (
  `a` char(1) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
