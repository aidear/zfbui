/*
SQLyog Ultimate v10.42 
MySQL - 5.5.38-0ubuntu0.12.04.1 : Database - cityon
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cityon` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cityon`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usertype` float unsigned DEFAULT '0' COMMENT '用户类型',
  `userid` char(30) NOT NULL DEFAULT '' COMMENT '用户登录ID',
  `pwd` char(54) NOT NULL DEFAULT '' COMMENT '用户密码',
  `uname` char(20) NOT NULL DEFAULT '' COMMENT '用户笔名',
  `tname` char(30) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `email` char(30) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `typeid` text COMMENT '负责频道（0表示全部）',
  `logintime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `loginip` varchar(20) NOT NULL DEFAULT '' COMMENT '登录IP',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `admintype` */

DROP TABLE IF EXISTS `admintype`;

CREATE TABLE `admintype` (
  `rank` float NOT NULL DEFAULT '1' COMMENT '组级别编号',
  `typename` varchar(30) NOT NULL DEFAULT '' COMMENT '组名称',
  `system` smallint(6) NOT NULL DEFAULT '0' COMMENT '是否为系统默认组',
  `purviews` text COMMENT '权限列表',
  PRIMARY KEY (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `advert` */

DROP TABLE IF EXISTS `advert`;

CREATE TABLE `advert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL DEFAULT '',
  `link` text,
  `img` varchar(200) DEFAULT NULL,
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `sequence` smallint(4) DEFAULT '1',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cat_path` varchar(200) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` int(10) unsigned NOT NULL DEFAULT '100',
  `add_time` datetime DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '全站配置信息自增id',
  `parent_id` smallint(5) NOT NULL DEFAULT '0' COMMENT '父节点id，取值于该表id字段的值',
  `code` varchar(30) NOT NULL COMMENT '全站配置信息列代码',
  `name` varchar(50) NOT NULL COMMENT '配置名称',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '该配置的类型，text，文本输入框；password，密码输入框；textarea，文本区域；select，单选；options循环生成多选；file,文件上传；manual，手动生成多选；group，是标题分组；hidden，不在页面显示',
  `store_range` varchar(255) NOT NULL DEFAULT '' COMMENT '当语言包中的code字段对应的是一个数组时，那该处就是该数组的索引，如$_LANG[''cfg_range''] [''cart_confirm''][1]；只有type字段为select,options时有值',
  `store_range_name` varchar(255) DEFAULT NULL COMMENT '与store_range一一对应',
  `store_dir` varchar(255) NOT NULL DEFAULT '' COMMENT '当type为file时才有值，文件上传后的保存目录',
  `value` varchar(255) DEFAULT NULL,
  `sort_order` tinyint(3) NOT NULL DEFAULT '1' COMMENT '显示顺序，数字越大越靠后',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='全站配置信息表';

/*Table structure for table `contact` */

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `zh_title` varchar(100) NOT NULL DEFAULT '',
  `en_title` varchar(100) NOT NULL DEFAULT '',
  `zh_name` varchar(100) NOT NULL DEFAULT '' COMMENT '姓名(中文)',
  `en_name` varchar(200) NOT NULL DEFAULT '' COMMENT '姓名(英文)',
  `zh_position` varchar(100) NOT NULL DEFAULT '' COMMENT '职位(中文)',
  `en_position` varchar(200) NOT NULL DEFAULT '' COMMENT '职位(英文)',
  `zh_address` text,
  `en_address` text,
  `zip` char(6) NOT NULL DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `tel` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `sequence` tinyint(3) NOT NULL DEFAULT '1',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `add_time` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `guestbook` */

DROP TABLE IF EXISTS `guestbook`;

CREATE TABLE `guestbook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `oicq` char(12) DEFAULT NULL,
  `weburl` varchar(100) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `reply` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

/*Table structure for table `join_us` */

DROP TABLE IF EXISTS `join_us`;

CREATE TABLE `join_us` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `zh_name` varchar(200) NOT NULL DEFAULT '' COMMENT '职位名称(中文)',
  `en_name` varchar(200) NOT NULL DEFAULT '' COMMENT '职位名称(英文)',
  `total` varchar(100) NOT NULL DEFAULT '' COMMENT '人数',
  `zh_position` varchar(60) NOT NULL DEFAULT '' COMMENT '工作地点(中文)',
  `en_position` varchar(60) NOT NULL DEFAULT '' COMMENT '工作地点(英文)',
  `zh_salary` varchar(100) NOT NULL DEFAULT '' COMMENT '薪水范围(中文)',
  `en_salary` varchar(100) DEFAULT '' COMMENT '薪水范围(英文)',
  `zh_experience` varchar(60) NOT NULL DEFAULT '' COMMENT '工作年限(中文)',
  `en_experience` varchar(60) NOT NULL DEFAULT '' COMMENT '工作年限(英文)',
  `edu` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '教育背景(1)',
  `zh_address` varchar(200) NOT NULL DEFAULT '' COMMENT '办公地点(中文)',
  `en_address` varchar(200) NOT NULL DEFAULT '' COMMENT '办公地点(英文)',
  `prescription` varchar(100) NOT NULL DEFAULT '' COMMENT 'prescrition',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Table structure for table `magazine` */

DROP TABLE IF EXISTS `magazine`;

CREATE TABLE `magazine` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `zh_issue` varchar(200) NOT NULL DEFAULT '' COMMENT '期数(中文)',
  `en_issue` varchar(200) NOT NULL DEFAULT '' COMMENT '期数(英文)',
  `zh_title` varchar(200) NOT NULL DEFAULT '' COMMENT '刊名(中文)',
  `en_title` varchar(200) NOT NULL DEFAULT '' COMMENT '刊名(英文)',
  `cover_pic` varchar(100) NOT NULL DEFAULT '' COMMENT '封面',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '删除',
  `sequence` tinyint(3) NOT NULL DEFAULT '1' COMMENT '排序',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `magazine_items` */

DROP TABLE IF EXISTS `magazine_items`;

CREATE TABLE `magazine_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `m_id` int(11) unsigned NOT NULL,
  `pic` varchar(100) NOT NULL DEFAULT '',
  `sequence` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `m_id` (`m_id`),
  CONSTRAINT `m_id` FOREIGN KEY (`m_id`) REFERENCES `magazine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Table structure for table `post` */

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zh_title` varchar(255) NOT NULL DEFAULT '',
  `en_title` varchar(255) NOT NULL,
  `zh_summary` text,
  `en_summary` text,
  `pic` varchar(200) DEFAULT NULL COMMENT '列表页图片',
  `m_pic` varchar(200) DEFAULT NULL COMMENT '手机端详细页顶部图片',
  `zh_content` text NOT NULL,
  `en_content` text,
  `zh_author` varchar(255) NOT NULL DEFAULT '',
  `en_author` varchar(255) NOT NULL DEFAULT '',
  `zh_date` varchar(255) NOT NULL DEFAULT '' COMMENT '日期(中文)',
  `en_date` varchar(255) NOT NULL DEFAULT '' COMMENT '日期(英文)',
  `zh_source` varchar(255) DEFAULT 'CityOn',
  `en_source` varchar(255) DEFAULT 'CityOn',
  `post_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `zh_tag` varchar(200) NOT NULL DEFAULT '' COMMENT '标签(中文)',
  `en_tag` varchar(200) NOT NULL DEFAULT '' COMMENT '标签(英文)',
  `show_subhead` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示（日期/来源）',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '(0-已删除；1-显示；2-审核中)',
  `order` int(10) unsigned NOT NULL DEFAULT '100',
  `add_time` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Table structure for table `region` */

DROP TABLE IF EXISTS `region`;

CREATE TABLE `region` (
  `region_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `region_name` varchar(120) NOT NULL DEFAULT '',
  `region_type` tinyint(1) NOT NULL DEFAULT '2',
  `agency_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `region_sn` varchar(20) NOT NULL,
  `zip` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  KEY `parent_id` (`parent_id`) USING BTREE,
  KEY `region_type` (`region_type`) USING BTREE,
  KEY `agency_id` (`agency_id`) USING BTREE,
  KEY `region_sn` (`region_sn`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=990101 DEFAULT CHARSET=utf8 COMMENT='地区表';

/*Table structure for table `site` */

DROP TABLE IF EXISTS `site`;

CREATE TABLE `site` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `code` varchar(60) NOT NULL COMMENT '代码',
  `zh_name` varchar(200) NOT NULL COMMENT '名称',
  `en_name` varchar(200) NOT NULL COMMENT '英文名称',
  `zh_keyword` varchar(200) DEFAULT NULL COMMENT '关键字',
  `en_keyword` varchar(200) DEFAULT NULL COMMENT '英文关键字',
  `zh_description` varchar(600) DEFAULT NULL COMMENT '中文描述',
  `en_description` varchar(600) DEFAULT NULL COMMENT '英文描述信息',
  `zh_content` text NOT NULL COMMENT '内容',
  `en_content` text NOT NULL COMMENT '英文内容',
  `m_pic` varchar(200) DEFAULT NULL COMMENT '手机端详细页顶部图片',
  `zh_author` varchar(60) DEFAULT NULL COMMENT '作者',
  `en_author` varchar(60) DEFAULT NULL COMMENT '英文作者',
  `zh_date` varchar(255) NOT NULL DEFAULT '' COMMENT '日期(中文)',
  `en_date` varchar(255) NOT NULL DEFAULT '' COMMENT '日期(英文)',
  `zh_source` varchar(100) DEFAULT NULL COMMENT '来源',
  `en_source` varchar(100) DEFAULT NULL COMMENT '英文来源',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `add_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Table structure for table `subscribe` */

DROP TABLE IF EXISTS `subscribe`;

CREATE TABLE `subscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL DEFAULT '',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `sys_acl` */

DROP TABLE IF EXISTS `sys_acl`;

CREATE TABLE `sys_acl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(60) NOT NULL,
  `resource_name` varchar(60) NOT NULL,
  `add_time` datetime NOT NULL,
  KEY `AclID` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

/*Table structure for table `sys_resource` */

DROP TABLE IF EXISTS `sys_resource`;

CREATE TABLE `sys_resource` (
  `module` varchar(60) NOT NULL,
  `controller` varchar(60) NOT NULL,
  `action` varchar(60) NOT NULL,
  `add_time` datetime NOT NULL,
  UNIQUE KEY `PR_action` (`module`,`controller`,`action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `cn_name` varchar(60) DEFAULT NULL,
  `parent_name` varchar(60) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
