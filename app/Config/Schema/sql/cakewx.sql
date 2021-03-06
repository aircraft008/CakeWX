# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.0.41)
# Database: zaiwx_init
# Generation Time: 2014-07-01 18:34:30 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cx_feedback
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_feedback`;

CREATE TABLE `cx_feedback` (
  `Id` int(11) unsigned NOT NULL auto_increment,
  `FName` varchar(100) default NULL,
  `FPhone` varchar(100) default NULL,
  `FMessage` text,
  `FCreatedate` datetime default NULL,
  `FIP` varchar(100) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table cx_languages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_languages`;

CREATE TABLE `cx_languages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `native` varchar(255) collate utf8_unicode_ci NOT NULL,
  `alias` varchar(255) collate utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL default '1',
  `weight` int(11) default NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table cx_schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_schema_migrations`;

CREATE TABLE `cx_schema_migrations` (
  `id` int(11) NOT NULL auto_increment,
  `class` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `cx_schema_migrations` WRITE;
/*!40000 ALTER TABLE `cx_schema_migrations` DISABLE KEYS */;

INSERT INTO `cx_schema_migrations` (`id`, `class`, `type`, `created`)
VALUES
	(1,'InitMigrations','Migrations','2014-05-05 07:36:36'),
	(2,'ConvertVersionToClassNames','Migrations','2014-05-05 07:36:36'),
	(3,'IncreaseClassNameLength','Migrations','2014-05-05 07:36:36'),
	(4,'FirstMigrationSettings','Settings','2014-05-05 07:36:36'),
	(5,'FirstMigrationWebchat','Webchat','2014-05-05 07:36:36');

/*!40000 ALTER TABLE `cx_schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cx_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_settings`;

CREATE TABLE `cx_settings` (
  `id` int(20) NOT NULL auto_increment,
  `key` varchar(64) collate utf8_unicode_ci NOT NULL,
  `value` text collate utf8_unicode_ci NOT NULL,
  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `description` varchar(255) collate utf8_unicode_ci NOT NULL,
  `input_type` varchar(255) collate utf8_unicode_ci NOT NULL default 'text',
  `editable` tinyint(1) NOT NULL default '1',
  `weight` int(11) default NULL,
  `params` text collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `cx_settings` WRITE;
/*!40000 ALTER TABLE `cx_settings` DISABLE KEYS */;

INSERT INTO `cx_settings` (`id`, `key`, `value`, `title`, `description`, `input_type`, `editable`, `weight`, `params`)
VALUES
	(5,'Croogo.stvsd','1','','','',0,1,''),
	(6,'Site.title','开源免费的微信公众号管理系统','','','',0,2,''),
	(7,'Site.name','在微信商业版','','','',0,3,''),
	(8,'Site.keywords','','','','',0,4,''),
	(9,'Site.description','','','','',0,5,'');

/*!40000 ALTER TABLE `cx_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cx_tperson
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_tperson`;

CREATE TABLE `cx_tperson` (
  `Id` varchar(38) NOT NULL,
  `FMemberId` varchar(38) NOT NULL,
  `FPassWord` varchar(200) NOT NULL,
  `FullName` varchar(200) default NULL,
  `FEName` varchar(200) default NULL,
  `FSex` int(50) default NULL,
  `FBirthday` datetime default NULL,
  `FEMail` varchar(500) default NULL,
  `FMobileNumber` varchar(100) default NULL,
  `FPhone` varchar(500) default NULL,
  `FAddress` varchar(500) default NULL,
  `FCity` varchar(200) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FIsActive` tinyint(1) default NULL,
  `FIsAuth` tinyint(1) default NULL,
  `FIsAdmin` tinyint(4) default '0',
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `FMemberId` (`FMemberId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cx_tperson` WRITE;
/*!40000 ALTER TABLE `cx_tperson` DISABLE KEYS */;

INSERT INTO `cx_tperson` (`Id`, `FMemberId`, `FPassWord`, `FullName`, `FEName`, `FSex`, `FBirthday`, `FEMail`, `FMobileNumber`, `FPhone`, `FAddress`, `FCity`, `FCreatedate`, `FUpdatedate`, `FIsActive`, `FIsAuth`, `FIsAdmin`)
VALUES
	('5366cf0b-7474-4c3a-8af9-21354d223f93','admin','78c904ab41b548ba68731d8ac78cec32fecdcb19','系统管理员',NULL,NULL,NULL,'niancode@gmail.com','13301372150','',NULL,'北京','2014-05-05 07:36:43','2014-05-05 07:36:43',1,1,1);

/*!40000 ALTER TABLE `cx_tperson` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cx_wcdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata`;

CREATE TABLE `cx_wcdata` (
  `Id` varchar(38) NOT NULL,
  `FWebchat` varchar(38) NOT NULL,
  `FDefaultType` tinyint(1) default NULL,
  `FDefaultContent` text,
  `FDefaultId` varchar(38) default NULL,
  `FFollowType` tinyint(1) default NULL,
  `FFollowContent` text,
  `FFollowId` varchar(38) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FSignText` varchar(500) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_cates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_cates`;

CREATE TABLE `cx_wcdata_cates` (
  `Id` varchar(38) NOT NULL default '',
  `FWebchat` varchar(38) NOT NULL,
  `FOwnerId` varchar(38) default NULL COMMENT '所属店铺',
  `FParentId` varchar(38) default NULL COMMENT '父菜单',
  `FName` varchar(100) NOT NULL,
  `FType` varchar(200) NOT NULL default '0',
  `FOrder` int(11) default '0',
  `FTwj` text COMMENT '数据',
  `FCreatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_kds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_kds`;

CREATE TABLE `cx_wcdata_kds` (
  `Id` varchar(38) NOT NULL,
  `FWebchat` varchar(38) NOT NULL,
  `FKey` varchar(200) NOT NULL,
  `FType` int(11) default NULL,
  `FTwj` text,
  `FWbContent` text,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FKeyMacth` tinyint(1) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_mus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_mus`;

CREATE TABLE `cx_wcdata_mus` (
  `Id` varchar(38) NOT NULL,
  `FWebchat` varchar(38) NOT NULL,
  `FOwnerMenu` varchar(200) default NULL,
  `FName` varchar(200) default NULL,
  `FOrder` int(11) default NULL,
  `FKeysOrLink` varchar(200) default NULL,
  `FIsActive` tinyint(1) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_orders`;

CREATE TABLE `cx_wcdata_orders` (
  `Id` int(11) NOT NULL auto_increment,
  `FOrderId` varchar(100) NOT NULL,
  `FWebchat` varchar(38) NOT NULL,
  `FType` tinyint(1) default '0',
  `FCreatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_places
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_places`;

CREATE TABLE `cx_wcdata_places` (
  `Id` varchar(38) NOT NULL default '',
  `FWebchat` varchar(38) NOT NULL,
  `FType` tinyint(1) default '0' COMMENT '类型：1物业公司，0个人',
  `FName` varchar(100) NOT NULL,
  `FBackPicUrl` varchar(1000) default NULL COMMENT '小区背景图',
  `FSignPicUrl` varchar(1000) default NULL COMMENT '小区标志图',
  `FMemo` text COMMENT '店铺简介',
  `FQqQun` varchar(11) default NULL COMMENT '小区QQ群',
  `FWxQun` varchar(11) default NULL COMMENT '小区微信群',
  `FPhone` varchar(100) default NULL,
  `FAddress` varchar(500) default NULL,
  `FAdLng` varchar(100) default NULL COMMENT '经度',
  `FAdLat` varchar(100) default NULL COMMENT '纬度',
  `FCreatedate` datetime default NULL,
  `FIsActive` tinyint(1) default '1' COMMENT '是否有效',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_sent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_sent`;

CREATE TABLE `cx_wcdata_sent` (
  `Id` int(11) NOT NULL auto_increment,
  `FWebchat` varchar(38) NOT NULL,
  `FMsgId` varchar(200) default NULL,
  `FType` tinyint(1) default NULL,
  `FSentMsg` text COMMENT 'json',
  `FCreatedate` datetime default NULL,
  `FStatus` tinyint(1) default NULL,
  `FError` varchar(200) default NULL,
  `FSentCount` int(11) default NULL,
  `FErrorCount` int(11) default NULL,
  `FTotalCount` int(11) default NULL,
  `FilterCount` int(11) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_stores
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_stores`;

CREATE TABLE `cx_wcdata_stores` (
  `Id` varchar(38) NOT NULL default '',
  `FWebchat` varchar(38) NOT NULL,
  `FType` tinyint(1) default '0' COMMENT '0为单店铺',
  `FStore` varchar(100) default NULL COMMENT 'cy001为餐饮店，gs001为果蔬店，cs001为超市，00为其他',
  `FName` varchar(100) NOT NULL,
  `FBackPicUrl` varchar(1000) default NULL COMMENT '店铺背景图',
  `FSignPicUrl` varchar(1000) default NULL COMMENT '店铺标志图',
  `FMemo` text COMMENT '店铺简介',
  `FQQ` varchar(11) default NULL,
  `FPhone` varchar(100) default NULL,
  `FAddress` varchar(500) default NULL,
  `FAdLng` varchar(100) default NULL COMMENT '经度',
  `FAdLat` varchar(100) default NULL COMMENT '纬度',
  `FOrderPrefix` varchar(100) default NULL,
  `FStopMemo` text COMMENT '暂停营业提示语',
  `FSendPrice` varchar(100) default '0' COMMENT '起送价格',
  `FDevCost` varchar(100) default '0' COMMENT '外送费',
  `FDevDistance` varchar(100) default '1' COMMENT '外送距离',
  `FDevArea` text COMMENT '外送区域',
  `FPay` tinyint(1) default '0' COMMENT '0为货到付款，1为在线支付，2为微信支付',
  `FIsDrLimit` tinyint(1) default '0' COMMENT '是否开启配送限制，0不开启，1为开启',
  `FDrTime` varchar(100) default NULL COMMENT '提前多少分钟下单',
  `FIsCoupons` tinyint(1) default '0' COMMENT '是否启用优惠券',
  `FMcouponPrice` varchar(100) default NULL COMMENT '最大优惠券面值',
  `FIsDiscount` tinyint(1) default '0' COMMENT '是否启用折扣',
  `FDiscount` int(11) default '0' COMMENT '折扣',
  `FRdPhone` varchar(100) default NULL COMMENT '短信订单提醒',
  `FIsRdPhone` tinyint(1) default '0' COMMENT '是否启用短信提醒',
  `FIsRdMail` tinyint(1) default '0' COMMENT '是否启用邮箱提醒',
  `FRdMail` varchar(100) default NULL COMMENT '邮箱订单提醒',
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FStatus` tinyint(1) default '1' COMMENT '营业状态，0为不营业，1为正常营业',
  `FIsActive` tinyint(1) default '1' COMMENT '店铺是否有效',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_tw
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_tw`;

CREATE TABLE `cx_wcdata_tw` (
  `Id` varchar(38) NOT NULL,
  `FWebchat` varchar(38) NOT NULL,
  `FTitle` varchar(200) NOT NULL,
  `FUrl` varchar(1000) default NULL,
  `FUpyunUrl` varchar(1000) default NULL,
  `FMemo` varchar(500) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FType` tinyint(1) default NULL,
  `FAuthor` varchar(100) default NULL,
  `FContent` text,
  `FLink` varchar(1000) default NULL,
  `FReLink` varchar(1000) default NULL,
  `FTwj` text,
  `FTwType` varchar(100) default NULL COMMENT '图文类型',
  `FLevelType` varchar(100) default NULL COMMENT '二级类型',
  `FCate` int(11) default '0',
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_tw_events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_tw_events`;

CREATE TABLE `cx_wcdata_tw_events` (
  `Id` varchar(38) NOT NULL,
  `FOwnerId` varchar(38) NOT NULL,
  `FMaxPersonCount` int(11) default NULL,
  `FPersonCount` int(11) default NULL,
  `FAddress` varchar(500) default NULL,
  `FStartdate` datetime default NULL,
  `FCreatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_tw_persons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_tw_persons`;

CREATE TABLE `cx_wcdata_tw_persons` (
  `Id` varchar(38) NOT NULL,
  `FEventId` varchar(38) NOT NULL,
  `FMemo` text,
  `FState` int(11) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_tw_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_tw_product`;

CREATE TABLE `cx_wcdata_tw_product` (
  `Id` varchar(38) NOT NULL,
  `FOwnerId` varchar(38) NOT NULL,
  `FOrigPrice` float default NULL,
  `FPrice` float default NULL,
  `FPicUrl` varchar(1000) default NULL,
  `FState` tinyint(1) default '1',
  `FStartdate` datetime default NULL,
  `FCreatedate` datetime default NULL,
  `FAddress` varchar(1000) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcdata_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcdata_users`;

CREATE TABLE `cx_wcdata_users` (
  `FOpenId` varchar(100) NOT NULL default '',
  `FWebchat` varchar(38) NOT NULL,
  `FSubscribe` tinyint(1) default NULL,
  `FNickname` varchar(500) default NULL,
  `FSex` varchar(100) default NULL,
  `FLanguage` varchar(100) default NULL,
  `FCity` varchar(100) default NULL,
  `FProvince` varchar(100) default NULL,
  `FCountry` varchar(100) default NULL,
  `FHeadimgurl` varchar(2000) default NULL,
  `FSubscribe_time` int(11) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  `FMemo` text,
  PRIMARY KEY  (`FOpenId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_wcsess
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_wcsess`;

CREATE TABLE `cx_wcsess` (
  `Id` int(38) NOT NULL auto_increment,
  `FData` text NOT NULL,
  `FExpires` int(11) default NULL,
  `FWebchat` varchar(38) default NULL,
  `FCreatedate` datetime default NULL,
  `FUpdatedate` datetime default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cx_webchat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cx_webchat`;

CREATE TABLE `cx_webchat` (
  `Id` varchar(38) NOT NULL,
  `FPerson` varchar(38) NOT NULL,
  `FWxopenId` varchar(200) default NULL,
  `FWxId` varchar(200) default NULL,
  `FName` varchar(200) default NULL,
  `FCreatedate` datetime default NULL,
  `FOffdate` datetime default NULL,
  `FIcon` varchar(500) default NULL,
  `FStatus` tinyint(1) default NULL,
  `FIsActive` tinyint(1) default NULL,
  `FWxType` varchar(200) default NULL,
  `FWxApi` varchar(200) default NULL,
  `FWxToken` varchar(200) default NULL,
  `FWxAppId` varchar(200) default NULL,
  `FWxAppSecret` varchar(200) default NULL,
  `FAddress` varchar(200) default NULL,
  PRIMARY KEY  (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
