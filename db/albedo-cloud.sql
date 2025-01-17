/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : albedo-cloud

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 11/04/2022 14:02:54
*/

DROP DATABASE IF EXISTS `albedo-cloud`;

CREATE DATABASE  `albedo-cloud` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `albedo-cloud`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: albedo-cloud
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_appendix`
--

DROP TABLE IF EXISTS `sys_appendix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_appendix` (
                              `id` bigint NOT NULL COMMENT 'ID',
                              `biz_id` bigint NOT NULL DEFAULT '0' COMMENT '业务id',
                              `biz_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '业务类型',
                              `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件类型',
                              `bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '桶',
                              `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '文件相对地址',
                              `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '原始文件名',
                              `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '文件类型',
                              `size` bigint DEFAULT '0' COMMENT '大小',
                              `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                              `created_by` bigint NOT NULL,
                              `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                              `last_modified_by` bigint DEFAULT NULL,
                              `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                              `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                              `version` int NOT NULL,
                              `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='业务附件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_appendix`
--

LOCK TABLES `sys_appendix` WRITE;
/*!40000 ALTER TABLE `sys_appendix` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_appendix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
                          `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                          `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
                          `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门名称',
                          `sort` int DEFAULT NULL COMMENT '排序',
                          `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
                          `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
                          `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                          `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                          `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                          `version` int NOT NULL,
                          `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='部门管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES ('1','-1',NULL,'总部',30,_binary '\0','1','1','2020-05-15 18:26:57.020','1','2021-12-23 02:14:44.459',16,'','0','0000'),('2','1','1,','运营部',30,_binary '','1','1','2020-05-15 19:03:46.542','1','2021-12-23 02:14:44.467',2,'','0','0000'),('3','1','1,','AI部',30,_binary '','1','1','2020-05-15 19:04:11.395','1','2021-12-23 02:14:44.468',3,NULL,'0','0000'),('4','-1',NULL,'test',1,_binary '\0','1','1','2020-05-15 19:05:05.919','1','2021-12-23 02:14:44.469',1,NULL,'1','0000'),('5','-1',NULL,'平台',30,_binary '','1','1','2020-05-15 18:28:08.383','1','2021-12-23 02:14:44.471',2,NULL,'0','0000'),('6','1','1,','测试部',30,_binary '','1','1','2020-05-15 19:03:57.184','1','2021-12-23 02:14:44.473',2,NULL,'0','0000'),('7','1','1,','开发部',30,_binary '','1','1','2020-05-15 19:03:23.518','1','2021-12-23 02:14:44.490',3,NULL,'0','0000');
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept_relation`
--

DROP TABLE IF EXISTS `sys_dept_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept_relation` (
                                   `ancestor` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '祖先节点',
                                   `descendant` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '后代节点',
                                   `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                                   `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                                   PRIMARY KEY (`ancestor`,`descendant`) USING BTREE,
                                   KEY `idx1` (`ancestor`) USING BTREE,
                                   KEY `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept_relation`
--

LOCK TABLES `sys_dept_relation` WRITE;
/*!40000 ALTER TABLE `sys_dept_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_dept_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict` (
                          `id` bigint NOT NULL COMMENT '编号',
                          `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
                          `val` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '数据值',
                          `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
                          `parent_id` bigint DEFAULT NULL COMMENT '父菜单ID',
                          `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
                          `sort` int NOT NULL COMMENT '排序（升序）',
                          `available` bit(1) DEFAULT b'1' COMMENT '是否显示1 是0否',
                          `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
                          `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                          `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                          `last_modified_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
                          `version` int NOT NULL DEFAULT '0',
                          `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          PRIMARY KEY (`id`) USING BTREE,
                          KEY `sys_dict_value` (`val`) USING BTREE,
                          KEY `sys_dict_label` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='字典表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES (0,'所在机构及以下数据','THIS_LEVEL_CHILDREN','sys_data_scope_2',199,'1,',20,_binary '',_binary '','1','2019-07-13 21:53:55.000','1','2021-11-22 06:52:37.391',10,NULL,'0','0000'),(1,'数据字典','','base',-1,NULL,1,_binary '',_binary '\0','1','2018-07-08 22:16:14.000','1','2021-12-08 03:07:00.622',17,'','1','0000'),(2,'是否标识','','sys_flag',455,'1,',10,_binary '',_binary '\0','1','2019-06-02 09:17:44.000','1','2021-11-22 06:49:12.709',21,NULL,'0','0000'),(3,'是','1','sys_flag_yes',2,'1,',10,_binary '',_binary '','1','2018-07-08 22:15:40.000','1','2021-11-22 06:49:12.709',12,'','0','0000'),(4,'否','0','sys_flag_no',2,'1,',30,_binary '',_binary '','1','2019-06-02 09:26:40.000','1','2021-11-22 06:49:12.709',8,NULL,'0','0000'),(111,'编辑','EDIT','sys_business_type_edit',4555,'1,',20,_binary '',_binary '','1','2019-08-07 08:50:20.634','1','2021-11-22 06:52:56.329',6,NULL,'0','0000'),(199,'数据范围','','sys_data_scope',455,'1,',30,_binary '',_binary '\0','1','2019-07-13 21:50:08.000','1','2021-11-22 06:49:12.709',20,NULL,'0','0000'),(222,'运行中','1','quartz_job_status_1',344,'1,',10,_binary '',_binary '','1','2020-05-16 02:14:46.614','1','2021-11-25 08:40:23.140',2,NULL,'1','0000'),(223,'导入','IMPORT','sys_business_type_import',4555,'1,',60,_binary '',_binary '','1','2019-08-07 08:51:45.855','1','2021-11-22 06:52:56.320',5,NULL,'0','0000'),(233,'其他','OTHER','sys_business_type_other',4555,'1,',90,_binary '',_binary '','1','2020-05-17 05:45:33.764','1','2021-11-22 06:52:56.317',1,NULL,'0','0000'),(333,'放弃执行','3','quartz_misfire_policy_3',445,'1,',30,_binary '',_binary '','1','2019-08-15 02:24:54.175','1','2021-11-25 08:40:12.635',4,NULL,'1','0000'),(334,'按明细设置','CUSTOMIZE','sys_data_scope_5',199,'1,',50,_binary '',_binary '','1','2019-07-13 22:01:11.000','1','2021-11-22 06:52:43.388',9,NULL,'0','0000'),(344,'任务状态',NULL,'quartz_job_status',1,'1,',30,_binary '',_binary '\0','1','2020-05-16 02:13:18.543','1','2021-11-25 08:40:31.975',6,NULL,'1','0000'),(345,'失败','0','sys_status_0',1177,'1,',30,_binary '',_binary '','1','2019-08-14 03:28:11.000','1','2021-11-22 06:51:06.891',3,NULL,'0','0000'),(444,'所在机构数据','THIS_LEVEL','sys_data_scope_3',199,'1,',30,_binary '',_binary '','1','2019-07-13 21:59:13.000','1','2021-11-22 06:52:39.790',10,NULL,'0','0000'),(445,'计划执行错误策略',NULL,'quartz_misfire_policy',1,'1,',30,_binary '',_binary '\0','1','2019-08-15 02:23:54.460','1','2021-11-25 08:40:17.971',11,NULL,'1','0000'),(455,'系统数据','sys','sys',-1,'1,',30,_binary '',_binary '\0','1','2019-07-13 17:13:12.000','1','2021-11-22 06:49:12.709',30,NULL,'0','0000'),(555,'系统','SYSTEM','quartz_job_group_system',55345,'1,',20,_binary '',_binary '','1','2019-08-15 08:34:47.139','1','2021-11-22 06:53:49.574',5,NULL,'0','0000'),(666,'生成代码','GEN_CODE','sys_business_type_gen_code',4555,'1,',80,_binary '',_binary '','1','2019-08-07 08:52:36.997','1','2021-11-22 06:52:56.322',6,NULL,'0','0000'),(777,'目录','0','sys_menu_type_0',66555,'1,',10,_binary '',_binary '','1','2019-07-13 22:04:10.000','1','2021-11-22 06:52:05.625',7,NULL,'0','0000'),(888,'操作人类别',NULL,'sys_operator_type',455,'1,',30,_binary '',_binary '\0','1','2019-08-07 07:37:09.613','1','2021-11-22 06:49:12.709',13,NULL,'0','0000'),(999,'后台用户','MANAGE','sys_operate_type_manage',888,'1,',20,_binary '',_binary '','1','2019-08-07 08:48:40.344','1','2021-11-22 06:51:23.856',6,NULL,'0','0000'),(1122,'导出','EXPORT','sys_business_type_export',4555,'1,',50,_binary '',_binary '','1','2019-08-07 08:51:33.286','1','2021-11-22 06:52:56.328',5,NULL,'0','0000'),(1133,'离线','OFFLINE','sys_online_status_off_line',9967,'1,',30,_binary '',_binary '','1','2019-08-11 03:17:50.132','1','2021-11-25 01:35:25.921',3,NULL,'1','0000'),(1144,'删除','DELETE','sys_business_type_delete',4555,'1,',40,_binary '',_binary '','1','2019-08-07 08:50:45.270','1','2021-11-22 06:52:56.329',5,NULL,'0','0000'),(1155,'test','test','test',-1,NULL,30,_binary '',_binary '','1','2019-07-13 19:59:38.000','1','2021-11-22 06:49:12.709',0,NULL,'1','0000'),(1166,'默认','DEFAULT','quartz_job_group_default',55345,'1,',10,_binary '',_binary '','1','2019-08-15 08:34:28.547','1','2021-11-22 06:53:49.576',5,NULL,'0','0000'),(1177,'状态',NULL,'sys_status',455,'1,',30,_binary '',_binary '\0','1','2019-08-14 03:26:50.424','1','2021-11-22 06:49:12.709',6,NULL,'0','0000'),(4447,'按钮','2','sys_menu_type_2',66555,'1,',30,_binary '',_binary '','1','2019-08-07 05:55:24.531','1','2021-11-22 06:52:12.939',8,NULL,'0','0000'),(4453,'强退','FORCE_LOGOUT','sys_business_type_force_logout',4555,'1,',70,_binary '',_binary '','1','2019-08-07 08:52:15.681','1','2021-11-22 06:52:56.327',5,NULL,'0','0000'),(4534,'其他','OTHER','sys_operate_type_other',888,'1,',10,_binary '',_binary '','1','2019-08-07 08:48:21.644','1','2021-11-22 06:51:17.223',6,NULL,'0','0000'),(4555,'业务操作类型',NULL,'sys_business_type',455,'1,',30,_binary '',_binary '\0','1','2019-08-07 07:33:35.000','1','2021-11-22 06:49:12.709',37,NULL,'0','0000'),(4564,'执行一次','2','quartz_misfire_policy_2',445,'1,',20,_binary '',_binary '','1','2019-08-15 02:24:39.273','1','2021-11-25 08:39:53.801',5,NULL,'1','0000'),(4623,'立即执行','1','quartz_misfire_policy_1',445,'1,',10,_binary '',_binary '','1','2019-08-15 02:24:19.706','1','2021-11-25 08:39:47.020',5,NULL,'1','0000'),(5555,'已暂停','0','quartz_job_status_0',344,'1,',20,_binary '',_binary '','1','2020-05-16 02:15:08.604','1','2021-11-25 08:40:27.853',2,NULL,'1','0000'),(6663,'锁定','LOCK','sys_business_type_lock',4555,'1,',30,_binary '',_binary '','1','2019-08-07 08:50:32.457','1','2021-11-22 06:52:56.319',6,NULL,'0','0000'),(7654,'手机端用户','MOBILE','sys_operate_type_moblie',888,'1,',30,_binary '',_binary '','1','2019-08-07 08:49:00.766','1','2021-11-22 06:51:21.205',6,NULL,'0','0000'),(9967,'在线状态',NULL,'sys_online_status',455,'1,',30,_binary '',_binary '\0','1','2019-08-11 03:16:52.095','1','2021-11-25 01:35:36.574',5,NULL,'1','0000'),(11888,'全部','ALL','sys_data_scope_1',199,'1,',10,_binary '',_binary '','1','2019-07-13 21:52:44.000','1','2021-11-22 06:52:35.489',10,NULL,'0','0000'),(40654,'仅本人数据','SELF','sys_data_scope_4',199,'1,',40,_binary '',_binary '','1','2019-07-13 22:00:03.000','1','2021-11-22 06:52:41.740',8,NULL,'0','0000'),(44223,'菜单','1','sys_menu_type_1',66555,'1,',20,_binary '',_binary '','1','2019-07-13 22:04:44.000','1','2021-11-22 06:52:09.706',7,NULL,'0','0000'),(55345,'任务分组',NULL,'quartz_job_group',455,'1,',30,_binary '',_binary '\0','1','2019-08-15 08:33:54.745','1','2021-11-22 06:49:12.709',10,NULL,'0','0000'),(55634,'在线','ONLINE','sys_online_status_on_line',9967,'1,',30,_binary '',_binary '','1','2019-08-11 03:17:28.210','1','2021-11-25 01:35:32.195',3,NULL,'1','0000'),(55734,'查看','VIEW','sys_business_type_view',4555,'1,',10,_binary '',_binary '','1','2019-08-07 08:49:39.000','1','2021-11-22 06:52:56.315',8,NULL,'0','0000'),(64456,'登录','LOGIN','sys_business_type_login',4555,'1,',100,_binary '\0',_binary '','1','2020-05-27 03:41:37.787','1','2021-11-22 06:52:56.318',1,NULL,'0','0000'),(65765,'业务数据','biz','biz',-1,'1,',30,_binary '',_binary '','1','2019-07-13 20:01:51.000','1','2021-11-22 06:49:12.709',6,NULL,'0','0000'),(66555,'菜单类型','','sys_menu_type',455,'1,',30,_binary '',_binary '\0','1','2019-07-13 22:01:48.000','1','2021-11-22 06:49:12.709',15,NULL,'0','0000'),(74563,'正常','1','sys_status_1',1177,'1,',30,_binary '',_binary '','1','2019-08-14 03:28:01.693','1','2021-11-22 06:51:09.036',2,NULL,'0','0000');
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_file`
--

DROP TABLE IF EXISTS `sys_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_file` (
                          `id` bigint NOT NULL COMMENT 'ID',
                          `biz_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '业务类型',
                          `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件类型',
                          `storage_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '存储类型\nLOCAL FAST_DFS MIN_IO ALI \n',
                          `bucket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '桶',
                          `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '文件相对地址',
                          `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件访问地址',
                          `unique_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '唯一文件名',
                          `file_md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件md5',
                          `original_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '原始文件名',
                          `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '文件类型',
                          `suffix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '后缀',
                          `size` bigint DEFAULT '0' COMMENT '大小',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          `created_by` bigint NOT NULL,
                          `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                          `last_modified_by` bigint DEFAULT NULL,
                          `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                          `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `version` int NOT NULL,
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='增量文件上传日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_file`
--

LOCK TABLES `sys_file` WRITE;
/*!40000 ALTER TABLE `sys_file` DISABLE KEYS */;
INSERT INTO `sys_file` VALUES (1467023162330841088,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/a5b549c113b94f849b412742723bd1b9.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/a5b549c113b94f849b412742723bd1b9.jpg','a5b549c113b94f849b412742723bd1b9.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 06:49:12.511',1,'2021-12-08 02:30:22.838',NULL,0,'1'),(1467023384859639808,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/c904f1e9ea7549c6943535ddc52695a5.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/c904f1e9ea7549c6943535ddc52695a5.jpg','c904f1e9ea7549c6943535ddc52695a5.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 06:50:05.583',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467024571344355328,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/d3ee9280828b4f29b3a4ad2ae27de921.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/d3ee9280828b4f29b3a4ad2ae27de921.jpg','d3ee9280828b4f29b3a4ad2ae27de921.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 06:54:48.462',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467024702038867968,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/2f15a9e12b654e6da0d697747997036f.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/2f15a9e12b654e6da0d697747997036f.jpg','2f15a9e12b654e6da0d697747997036f.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 06:55:19.623',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467024956737978368,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/11d4d77207a6470bbdc9a838b5e92634.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/11d4d77207a6470bbdc9a838b5e92634.jpg','11d4d77207a6470bbdc9a838b5e92634.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 06:56:20.348',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467027979442847744,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/1202170e9efa4a32b587a501a03f79d6.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/1202170e9efa4a32b587a501a03f79d6.jpg','1202170e9efa4a32b587a501a03f79d6.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:08:21.011',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467028392086863872,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/ae4a01d7c2aa46008980cb52d9d5fb77.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/ae4a01d7c2aa46008980cb52d9d5fb77.jpg','ae4a01d7c2aa46008980cb52d9d5fb77.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:09:59.391',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467029366637592576,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/a13e42026b014bf5940548da97d21a8e.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/a13e42026b014bf5940548da97d21a8e.jpg','a13e42026b014bf5940548da97d21a8e.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:13:51.747',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467033048376672256,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/ac22b263cddf4dadb0886d579602f8fc.jpg','https://static.tangyh.top/file/dev/0000/USER_AVATAR/2021/12/04/ac22b263cddf4dadb0886d579602f8fc.jpg','ac22b263cddf4dadb0886d579602f8fc.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:28:29.541',1,'2021-12-08 02:30:26.026',NULL,0,'1'),(1467034144696434688,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/139e2822c6cb4635b333af4e2f3f1fff.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/139e2822c6cb4635b333af4e2f3f1fff.jpg','139e2822c6cb4635b333af4e2f3f1fff.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:32:50.912',1,'2021-12-08 02:35:00.362',NULL,0,'1'),(1467034290523996160,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/d685c34ab657404aa1f562fb5e25ba4a.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/d685c34ab657404aa1f562fb5e25ba4a.jpg','d685c34ab657404aa1f562fb5e25ba4a.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:33:25.696',1,'2021-12-08 02:34:58.515',NULL,0,'1'),(1467034373625741312,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/8c1aef8043d0495ba73929239e96d3de.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/8c1aef8043d0495ba73929239e96d3de.jpg','8c1aef8043d0495ba73929239e96d3de.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:33:45.510',1,'2021-12-08 02:34:55.786',NULL,0,'1'),(1467034699288281088,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/4f8c39bcacb74ff0a0a15a465b562a31.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/4f8c39bcacb74ff0a0a15a465b562a31.jpg','4f8c39bcacb74ff0a0a15a465b562a31.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:35:03.154',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467035096501452800,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/7f1b6dbcce2d4830a6ed5a09a5367a96.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/7f1b6dbcce2d4830a6ed5a09a5367a96.jpg','7f1b6dbcce2d4830a6ed5a09a5367a96.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:36:37.856',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467035309022642176,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/125725a79c9c433d9a78b68e472edb54.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/125725a79c9c433d9a78b68e472edb54.jpg','125725a79c9c433d9a78b68e472edb54.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:37:28.526',1,'2021-12-08 02:35:03.808',NULL,0,'1'),(1467035384608194560,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/252822ef2f7b42ef9b2fe7856b1b4af1.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/252822ef2f7b42ef9b2fe7856b1b4af1.jpg','252822ef2f7b42ef9b2fe7856b1b4af1.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:37:46.547',1,'2021-12-08 03:26:55.356',NULL,0,'1'),(1467035692767903744,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/756e5d2cce154afc85dccd953d9f71ed.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/756e5d2cce154afc85dccd953d9f71ed.jpg','756e5d2cce154afc85dccd953d9f71ed.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:39:00.013',1,'2021-12-08 03:26:55.356',NULL,0,'1'),(1467035880945352704,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/8651019de0b546e8bea62d78545ab0dc.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/8651019de0b546e8bea62d78545ab0dc.jpg','8651019de0b546e8bea62d78545ab0dc.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:39:44.882',1,'2021-12-08 03:26:55.356',NULL,0,'1'),(1467036516415963136,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/a83b05ddeda14db3a80eac1a017ab0e5.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/a83b05ddeda14db3a80eac1a017ab0e5.jpg','a83b05ddeda14db3a80eac1a017ab0e5.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:42:16.391',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1467036966729023488,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/370dd47b2f1942ffb26a81b30f92fdd8.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/370dd47b2f1942ffb26a81b30f92fdd8.jpg','370dd47b2f1942ffb26a81b30f92fdd8.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:44:03.752',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1467037132164956160,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/9c7e6aa57824469196b2cd5fc11ed4b8.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/9c7e6aa57824469196b2cd5fc11ed4b8.jpg','9c7e6aa57824469196b2cd5fc11ed4b8.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:44:43.197',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1467037699943694336,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/87d2d42bc8ed44758cfa3340efad27c2.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/87d2d42bc8ed44758cfa3340efad27c2.jpg','87d2d42bc8ed44758cfa3340efad27c2.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:46:58.565',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1467039487262457856,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/97e69d2762be4a24aff43085894b3505.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/97e69d2762be4a24aff43085894b3505.jpg','97e69d2762be4a24aff43085894b3505.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 07:54:04.695',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1467044287936987136,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/04/946d98eb4c0b4b6da1eccc1b648f023d.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/04/946d98eb4c0b4b6da1eccc1b648f023d.jpg','946d98eb4c0b4b6da1eccc1b648f023d.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-04 08:13:09.254',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1468419790770012160,'BASE_FILE','DOC','LOCAL','dev','0000/BASE_FILE/2021/12/08/1ec3372296b24002bae2542cb02ab7dd.txt','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/1ec3372296b24002bae2542cb02ab7dd.txt','1ec3372296b24002bae2542cb02ab7dd.txt',NULL,'200个免费节点.txt','text/plain','txt',121456,'0000',1,'2021-12-08 03:18:54.691',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1468420594188943360,'BASE_FILE','DOC','LOCAL','dev','0000/BASE_FILE/2021/12/08/dd32fe8cf00b4509a79d37ec865d89cf.txt','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/dd32fe8cf00b4509a79d37ec865d89cf.txt','dd32fe8cf00b4509a79d37ec865d89cf.txt',NULL,'200个免费节点.txt','text/plain','txt',121456,'0000',1,'2021-12-08 03:22:06.246',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1468421198781087744,'BASE_FILE','DOC','LOCAL','dev','0000/BASE_FILE/2021/12/08/f316089dbe3e42b7a629be446c1c7238.txt','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/f316089dbe3e42b7a629be446c1c7238.txt','f316089dbe3e42b7a629be446c1c7238.txt',NULL,'200个免费节点.txt','text/plain','txt',121456,'0000',1,'2021-12-08 03:24:30.388',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1468421746632687616,'BASE_FILE','DOC','LOCAL','dev','0000/BASE_FILE/2021/12/08/f02fba0a4d6f47b285606311e6a059a2.txt','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/f02fba0a4d6f47b285606311e6a059a2.txt','f02fba0a4d6f47b285606311e6a059a2.txt',NULL,'200个免费节点.txt','text/plain','txt',121456,'0000',1,'2021-12-08 03:26:41.010',1,'2021-12-08 03:26:52.882',NULL,0,'1'),(1468421845593096192,'BASE_FILE','DOC','LOCAL','dev','0000/BASE_FILE/2021/12/08/7d697a6b334b463db51a630ffe741573.txt','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/7d697a6b334b463db51a630ffe741573.txt','7d697a6b334b463db51a630ffe741573.txt',NULL,'200个免费节点.txt','text/plain','txt',121456,'0000',1,'2021-12-08 03:27:04.604',1,'2021-12-08 03:27:04.605',NULL,0,'0'),(1468421845609873408,'BASE_FILE','IMAGE','LOCAL','dev','0000/BASE_FILE/2021/12/08/0a63a34fd90543a88cf43ee4b3626723.jpg','http://127.0.0.1:8061/file/dev/0000/BASE_FILE/2021/12/08/0a63a34fd90543a88cf43ee4b3626723.jpg','0a63a34fd90543a88cf43ee4b3626723.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-08 03:27:04.608',1,'2021-12-08 03:27:04.609',NULL,0,'0'),(1469157645930725376,'USER_AVATAR','IMAGE','LOCAL','dev','0000/USER_AVATAR/2021/12/10/d1b42710b67f4e80a710a687fd4d8412.jpg','http://127.0.0.1:8061/file/dev/0000/USER_AVATAR/2021/12/10/d1b42710b67f4e80a710a687fd4d8412.jpg','d1b42710b67f4e80a710a687fd4d8412.jpg',NULL,'31921638496726_.pic.jpg','image/jpeg','jpg',816277,'0000',1,'2021-12-10 04:10:53.062',1,'2021-12-10 04:10:53.075',NULL,0,'0');
/*!40000 ALTER TABLE `sys_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log_login`
--

DROP TABLE IF EXISTS `sys_log_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_log_login` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                               `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '日志标题',
                               `user_id` bigint DEFAULT NULL COMMENT '用户ID',
                               `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
                               `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录人昵称',
                               `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
                               `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
                               `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
                               `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
                               `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户代理',
                               `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求URI',
                               `params` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '操作提交的数据',
                               `login_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录时间',
                               `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                               `created_by` bigint DEFAULT NULL COMMENT '创建者',
                               `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                               `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                               `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '0-正常，1-删除',
                               PRIMARY KEY (`id`) USING BTREE,
                               KEY `sys_log_create_by` (`created_by`) USING BTREE,
                               KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
                               KEY `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1606 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='登录日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
--
-- Table structure for table `sys_log_operate`
--

DROP TABLE IF EXISTS `sys_log_operate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_log_operate` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
                                 `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '日志标题',
                                 `log_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志类型',
                                 `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
                                 `service_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '服务ID',
                                 `ip_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'IP地址',
                                 `ip_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
                                 `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
                                 `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
                                 `user_agent` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户代理',
                                 `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求URI',
                                 `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '请求方法',
                                 `params` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '操作提交的数据',
                                 `time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '执行时间',
                                 `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                 `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                                 `business_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                 `exception` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '异常信息',
                                 `created_by` bigint DEFAULT NULL COMMENT '创建者',
                                 `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                                 `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                                 `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                                 PRIMARY KEY (`id`) USING BTREE,
                                 KEY `sys_log_create_by` (`created_by`) USING BTREE,
                                 KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
                                 KEY `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2489 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
                          `id` bigint NOT NULL COMMENT '菜单ID',
                          `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
                          `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
                          `permission` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单权限标识',
                          `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '前端URL',
                          `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单ID',
                          `parent_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父菜单IDs',
                          `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
                          `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'VUE页面',
                          `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
                          `iframe` bit(1) DEFAULT b'0' COMMENT '是否外链',
                          `cache_` bit(1) DEFAULT b'0' COMMENT '缓存',
                          `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
                          `sort` int DEFAULT '1' COMMENT '排序值',
                          `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                          `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                          `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
                          `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `version` int NOT NULL,
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (330,'生成方案编辑','2','gen_scheme_edit',NULL,'9999','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-07-21 05:29:14.000','1','2021-11-22 07:20:28.451',NULL,0,'0','0000'),(334,'服务监控','1','sys_monitor_view','monitor','2000','2000,','codeConsole','monitor/service/index',_binary '\0',_binary '\0',_binary '\0',_binary '',40,'1','2019-08-05 09:21:10.000','1','2021-11-19 10:29:35.734',NULL,5,'0','0000'),(335,'生成方案查看','2','gen_scheme_view',NULL,'9999','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-11 00:48:09.000','1','2021-11-22 07:20:28.453',NULL,0,'0','0000'),(336,'操作日志查看','2','sys_logOperate_view',NULL,'2100','2000,2100,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-07 09:51:38.454','1','2021-11-19 10:29:35.736',NULL,0,'0','0000'),(337,'数据源编辑','2','gen_datasourceConf_edit',NULL,'8877','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',40,'1','2020-09-20 01:11:12.778','1','2021-11-22 07:30:14.383',NULL,0,'0','0000'),(338,'组件管理','0',NULL,'/components','-1',NULL,'zujian','Layout',_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2020-05-15 12:57:28.521','1','2021-11-19 10:29:35.739',NULL,1,'0','0000'),(339,'生成方案代码','2','gen_scheme_code',NULL,'9999','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-11 00:55:37.000','1','2021-11-22 07:20:28.443',NULL,0,'0','0000'),(440,'三级菜单2','1',NULL,'menu1-2','9000','','dev','nested/menu1/menu1-2',_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2020-05-18 03:13:18.819','1','2021-11-22 07:34:11.433',NULL,0,'0','0000'),(445,'业务表删除','2','gen_table_del',NULL,'7000','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-07-21 05:24:45.000','1','2021-11-22 07:20:53.409',NULL,0,'0','0000'),(446,'多级菜单','0',NULL,'/nested','-1',NULL,'dev','Layout',_binary '\0',_binary '\0',_binary '\0',_binary '\0',100,'1','2020-05-18 03:09:23.393','1','2021-11-19 10:29:35.745',NULL,9,'0','0000'),(447,'系统工具','0',NULL,'/admin','-1',NULL,'sys-tools','Layout',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2019-08-05 07:58:12.000','1','2021-11-19 10:29:35.750',NULL,2,'0','0000'),(448,'在线用户强退','2','sys_userOnline_logout',NULL,'7766','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-11 02:57:51.502','1','2021-11-22 07:21:25.665',NULL,0,'0','0000'),(449,'数据源查看','2','gen_datasourceConf_view',NULL,'8877','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',20,'1','2020-09-20 01:11:12.771','1','2021-11-22 07:30:14.384',NULL,0,'0','0000'),(1000,'系统管理','0',NULL,'/perm','-1',NULL,'menu','Layout',_binary '\0',_binary '\0',_binary '\0',_binary '\0',10,'1','2018-09-28 00:29:53.000','1','2021-12-26 03:31:40.144',NULL,4,'0','0000'),(1100,'用户管理','1','sys_user_view','user','1000','1000,','peoples','sys/user/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',10,'1','2017-11-02 14:24:37.000','1','2021-12-26 03:31:40.146',NULL,0,'0','0000'),(1101,'用户编辑','2','sys_user_edit',NULL,'1100','1000,1100,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2017-11-08 01:52:09.000','1','2021-12-26 03:31:40.147',NULL,0,'0','0000'),(1102,'用户锁定','2','sys_user_lock',NULL,'1100',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 01:52:48.000',NULL,'2021-12-26 03:31:40.148',NULL,0,'0','0000'),(1103,'用户删除','2','sys_user_del',NULL,'1100',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 01:54:01.000',NULL,'2021-12-26 03:31:40.149',NULL,0,'0','0000'),(1166,'富文本','1',NULL,'editor','338','','fwb','components/Editor',_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2020-05-15 13:16:40.552','1','2021-11-22 07:33:24.892',NULL,0,'0','0000'),(1200,'菜单管理','1','sys_menu_view','menu','1000','1000,','menu','sys/menu/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2017-11-08 01:57:27.000','1','2021-12-26 03:31:40.151',NULL,0,'0','0000'),(1201,'菜单编辑','2','sys_menu_edit',NULL,'1200',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:15:53.000',NULL,'2021-12-26 03:31:40.152',NULL,0,'0','0000'),(1202,'菜单锁定','2','sys_menu_lock',NULL,'1200',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:16:23.000',NULL,'2021-12-26 03:31:40.154',NULL,0,'0','0000'),(1203,'菜单删除','2','sys_menu_del',NULL,'1200',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:16:43.000',NULL,'2021-12-26 03:31:40.155',NULL,0,'0','0000'),(1300,'角色管理','1','sys_role_view','role','1000','1000,','role','sys/role/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2017-11-08 02:13:37.000','1','2021-12-26 03:31:40.156',NULL,0,'0','0000'),(1301,'角色编辑','2','sys_role_edit',NULL,'1300',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:14:18.000',NULL,'2021-12-26 03:31:40.158',NULL,0,'0','0000'),(1302,'角色锁定','2','sys_role_lock',NULL,'1300',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:14:41.000',NULL,'2021-12-26 03:31:40.159',NULL,0,'0','0000'),(1303,'角色删除','2','sys_role_del',NULL,'1300',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2017-11-08 02:14:59.000',NULL,'2021-12-26 03:31:40.161',NULL,0,'0','0000'),(1400,'部门管理','1','sys_dept_view','dept','1000','1000,','dept','sys/dept/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2018-01-20 05:17:19.000','1','2021-12-26 03:31:40.163',NULL,0,'0','0000'),(1401,'部门编辑','2','sys_dept_edit',NULL,'1400',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2018-01-20 06:56:16.000',NULL,'2021-12-26 03:31:40.164',NULL,0,'0','0000'),(1402,'部门锁定','2','sys_dept_lock',NULL,'1400',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2018-01-20 06:56:59.000',NULL,'2021-12-26 03:31:40.165',NULL,0,'0','0000'),(1403,'部门删除','2','sys_dept_del',NULL,'1400',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2018-01-20 06:57:28.000',NULL,'2021-12-26 03:31:40.166',NULL,0,'0','0000'),(2000,'系统监控','0',NULL,'/sys','-1',NULL,'system','Layout',_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2017-11-07 12:56:00.000','1','2021-11-19 10:29:35.780',NULL,0,'0','0000'),(2100,'操作日志','1',NULL,'log-operate','2000','2000,','log','monitor/log-operate/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',60,'1','2017-11-20 06:06:22.000','1','2021-11-19 10:29:35.781',NULL,1,'0','0000'),(2101,'操作日志删除','2','sys_logOperate_del',NULL,'2100','2000,2100,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2017-11-20 12:37:37.000','1','2021-11-19 10:29:35.782',NULL,0,'0','0000'),(2200,'字典管理','1','sys_dict_view','dict','1000','1000,','dictionary','sys/dict/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',50,'1','2017-11-29 03:30:52.000','1','2021-12-26 03:31:40.171',NULL,0,'0','0000'),(2201,'字典删除','2','sys_dict_del',NULL,'2200','1000,2200,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2017-11-29 03:30:11.000','1','2021-12-26 03:31:40.173',NULL,0,'0','0000'),(2202,'字典编辑','2','sys_dict_edit',NULL,'2200',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2018-05-11 14:34:55.000','1','2021-12-26 03:31:40.174',NULL,0,'0','0000'),(2500,'接口文档','1',NULL,'swagger2','447','','swagger','tool/swagger/index',_binary '\0',_binary '\0',_binary '\0',_binary '',20,'1','2018-06-26 02:50:32.000','1','2021-11-22 07:31:37.510',NULL,0,'0','0000'),(2600,'令牌管理','1',NULL,'persistent-token','2000','2000,','dev','monitor/persistent-token/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2018-09-03 21:58:41.000','1','2022-01-06 07:16:03.553',NULL,0,'1','0000'),(2601,'令牌删除','2','sys_persistentToken_del',NULL,'2600','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',1,'1','2018-09-03 21:59:50.000','1','2022-01-06 07:15:59.099',NULL,0,'1','0000'),(3333,'在线用户查看','2','sys_userOnline_view',NULL,'7766','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-07 01:05:28.000','1','2021-11-22 07:21:25.667',NULL,0,'0','0000'),(4422,'任务调度执行','2','quartz_job_run',NULL,'6655','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',20,'1','2019-08-15 08:10:59.000','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(4433,'支付宝工具','1',NULL,'alipay','447','','alipay','tool/alipay/index',_binary '\0',_binary '\0',_binary '\0',_binary '',40,'1','2020-05-17 09:58:06.876','1','2021-11-22 07:31:26.775',NULL,0,'0','0000'),(4444,'邮件工具','1',NULL,'email','447','','email','tool/email/index',_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2020-05-17 09:56:56.008','1','2021-11-22 07:31:26.773',NULL,0,'0','0000'),(4455,'任务调度查看','2','quartz_job_view',NULL,'6655','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',10,'1','2019-08-14 02:36:47.085','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(5544,'任务调度日志','2','quartz_jobLog_view',NULL,'6655','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',50,'1','2019-08-15 08:11:30.986','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(5555,'操作日志导出','2','sys_logOperate_export',NULL,'2100','2000,2100,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-07 09:50:46.973','1','2021-11-19 10:29:35.796',NULL,0,'0','0000'),(5566,'数据源删除','2','gen_datasourceConf_del',NULL,'8877','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',80,'1','2020-09-20 01:11:12.784','1','2021-11-22 07:30:14.380',NULL,0,'0','0000'),(5588,'令牌查看','2','sys_persistentToken_view',NULL,'2600','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-08 01:44:25.617','1','2022-01-06 07:15:59.053',NULL,0,'1','0000'),(6000,'图表库','1',NULL,'Echarts','338','','chart','components/Echarts',_binary '\0',_binary '\0',_binary '\0',_binary '',20,'1','2020-05-15 13:12:39.827','1','2021-11-22 07:33:36.828',NULL,0,'0','0000'),(6655,'任务调度','1',NULL,'job','1000','1000,','timing','quartz/job/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',60,'1','2019-08-14 02:36:47.081','1','2021-12-26 04:00:55.719',NULL,0,'1','0000'),(6666,'字典可用','2','sys_dict_lock',NULL,'2200','1000,2200,',NULL,NULL,_binary '\0',NULL,_binary '\0',_binary '',999,'1','2020-05-15 09:24:57.559','1','2021-12-26 03:31:40.179',NULL,0,'0','0000'),(6677,'代码生成','0',NULL,'/gen','447','','codeConsole','gen/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',10,'1','2019-07-20 04:00:48.000','1','2021-11-22 07:32:02.221',NULL,0,'0','0000'),(7000,'业务表','1','','table','6677','','list','gen/table/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',10,'1','2019-07-20 04:02:02.000','1','2021-11-22 07:32:49.229',NULL,0,'0','0000'),(7700,'业务表编辑','1','gen_table_edit','edit','6677','',NULL,'gen/table/edit',_binary '',_binary '\0',_binary '\0',_binary '',20,'1','2019-07-21 05:24:02.000','1','2021-11-22 07:20:53.411',NULL,1,'0','0000'),(7766,'在线用户','1','','user-online','2000','2000,','Steve-Jobs','monitor/user-online/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2019-08-07 01:03:52.000','1','2021-11-19 10:29:35.805',NULL,0,'0','0000'),(7777,'任务调度删除','2','quartz_job_del',NULL,'6655',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2019-08-14 02:36:47.091','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(7788,'生成方案菜单','2','gen_scheme_menu',NULL,'9999','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-07-25 05:03:03.000','1','2021-11-22 07:20:28.452',NULL,0,'0','0000'),(7799,'任务调度编辑','2','quartz_job_edit',NULL,'6655','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-14 02:36:47.088','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(8855,'Markdown','1',NULL,'markdown','338','','markdown','components/MarkDown',_binary '\0',_binary '\0',_binary '\0',_binary '',40,'1','2020-05-15 13:21:46.675','1','2021-11-22 07:33:22.311',NULL,0,'0','0000'),(8877,'数据源','1',NULL,'datasource-conf','6677','','database','gen/datasource-conf/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',5,'1','2020-09-20 01:11:12.765','1','2021-11-22 07:33:20.945',NULL,0,'0','0000'),(8888,'二级菜单1','1',NULL,'menu1','446','','dev','nested/menu1/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',10,'1','2020-05-18 03:10:06.354','1','2021-11-22 07:33:58.182',NULL,0,'0','0000'),(8899,'Yaml编辑器','1',NULL,'yaml','338','','dev','components/YamlEdit',_binary '\0',_binary '\0',_binary '\0',_binary '',50,'1','2020-05-15 13:22:43.364','1','2021-11-22 07:33:14.776',NULL,0,'0','0000'),(9000,'二级菜单2','1',NULL,'menu2','446','','dev','nested/menu2/index',_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2020-05-18 03:14:32.907','1','2021-11-22 07:34:07.276',NULL,0,'0','0000'),(9900,'三级菜单1','1',NULL,'menu1-1','9000','','dev','nested/menu1/menu1-1',_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2020-05-18 03:11:16.436','1','2021-11-22 07:34:09.295',NULL,0,'0','0000'),(9911,'生成方案删除','2','gen_scheme_del',NULL,'9999','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-07-21 05:30:18.000','1','2021-11-22 07:20:28.449',NULL,0,'0','0000'),(9922,'任务调度日志导出','2','quartz_jobLog_export',NULL,'6655','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',60,'1','2019-08-15 08:13:16.742','1','2021-12-26 04:00:46.281',NULL,0,'1','0000'),(9944,'业务表查看','2','gen_table_view',NULL,'7000','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-11 00:47:39.828','1','2021-11-22 07:20:53.413',NULL,0,'0','0000'),(9955,'用户导出','2','sys_user_export',NULL,'1100','1000,1100,',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',80,'1','2019-08-07 09:50:02.000','1','2021-12-26 03:31:40.170',NULL,0,'0','0000'),(9977,'在线用户删除','2','sys_userOnline_del',NULL,'7766','',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '',30,'1','2019-08-07 01:06:33.448','1','2021-11-22 07:21:25.663',NULL,0,'0','0000'),(9988,'图标库','1',NULL,'icons','338','','icon','components/Icons/index',_binary '\0',_binary '\0',_binary '\0',_binary '',10,'1','2020-05-15 13:14:28.945','1','2021-11-22 07:33:12.130',NULL,1,'0','0000'),(9999,'生成方案','1',NULL,'scheme','6677','','dev','gen/scheme/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2019-07-21 05:27:35.000','1','2021-11-22 07:33:01.113',NULL,2,'0','0000'),(1465206065929912320,'测试书籍','1',NULL,'test-book','446',NULL,'icon-right-square','test/test-book/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2021-11-29 06:28:42.987','1','2021-12-26 03:31:40.169',NULL,0,'0','0000'),(1465206065955078144,'测试书籍查看','2','test_testBook_view',NULL,'1465206065929912320',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2021-11-29 06:28:42.993','1','2021-12-26 03:31:40.167',NULL,0,'0','0000'),(1465206065976049664,'测试书籍编辑','2','test_testBook_edit',NULL,'1465206065929912320',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2021-11-29 06:28:42.998','1','2021-12-26 03:31:40.150',NULL,0,'0','0000'),(1465206065988632576,'测试书籍删除','2','test_testBook_del',NULL,'1465206065929912320',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2021-11-29 06:28:43.001','1','2021-12-26 03:31:40.143',NULL,0,'0','0000'),(1465216162739519488,'测试树书籍','1',NULL,'test-tree-book','446',NULL,'icon-right-square','test/test-tree-book/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',30,'1','2021-11-29 07:08:50.254','1','2021-12-26 03:31:40.142',NULL,0,'0','0000'),(1465216162764685312,'测试树书籍查看','2','test_testTreeBook_view',NULL,'1465216162739519488',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2021-11-29 07:08:50.259','1','2021-12-26 03:31:40.141',NULL,0,'0','0000'),(1465216162777268224,'测试树书籍编辑','2','test_testTreeBook_edit',NULL,'1465216162739519488',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2021-11-29 07:08:50.263','1','2021-12-26 03:31:40.140',NULL,0,'0','0000'),(1465216162798239744,'测试树书籍删除','2','test_testTreeBook_del',NULL,'1465216162739519488',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2021-11-29 07:08:50.268','1','2021-12-26 03:31:40.125',NULL,0,'0','0000'),(1465502605210812416,'登录日志','1',NULL,'log-login','2000',NULL,'log','monitor/log-login/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',50,'1','2021-11-30 02:07:03.460','1','2021-11-30 02:07:03.460',NULL,3,'0','0000'),(1465502605244366848,'登录日志查看','2','sys_logLogin_view',NULL,'1465502605210812416',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2021-11-30 02:07:03.469','1','2021-11-30 02:07:03.469',NULL,0,'0','0000'),(1465502605277921280,'登录日志导出','2','sys_logLogin_export',NULL,'1465502605210812416',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2021-11-30 02:07:03.477','1','2021-11-30 02:07:03.477',NULL,1,'0','0000'),(1465502605307281408,'登录日志删除','2','sys_logLogin_del',NULL,'1465502605210812416',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2021-11-30 02:07:03.484','1','2021-11-30 02:07:03.484',NULL,0,'0','0000'),(1468397111971151872,'附件管理','1',NULL,'appendix','1000',NULL,'documentation','sys/appendix/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',70,'1','2021-12-08 01:48:47.649','1','2022-01-06 07:08:00.496',NULL,2,'1','0000'),(1468397112000512000,'附件管理查看','2','sys_appendix_view',NULL,'1468397111971151872',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2021-12-08 01:48:47.657','1','2022-01-06 07:07:53.885',NULL,0,'1','0000'),(1468397112017289216,'附件管理添加','2','sys_appendix_add',NULL,'1468397111971151872',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2021-12-08 01:48:47.661','1','2022-01-06 07:07:53.951',NULL,1,'1','0000'),(1468397112029872128,'附件管理删除','2','sys_appendix_del',NULL,'1468397111971151872',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2021-12-08 01:48:47.664','1','2022-01-06 07:07:53.994',NULL,0,'1','0000'),(1468405431398301696,'文件管理','1',NULL,'file','1000',NULL,'app','sys/file/index',_binary '\0',_binary '\0',_binary '\0',_binary '\0',70,'1','2021-12-08 02:21:51.156','1','2021-12-26 03:31:40.117',NULL,1,'0','0000'),(1468405431419273216,'文件管理查看','2','sys_file_view',NULL,'1468405431398301696',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',20,'1','2021-12-08 02:21:51.161','1','2021-12-26 03:31:40.116',NULL,0,'0','0000'),(1468405431440244736,'文件管理编辑','2','sys_file_add',NULL,'1468405431398301696',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',40,'1','2021-12-08 02:21:51.166','1','2021-12-26 03:31:40.115',NULL,1,'0','0000'),(1468405431457021952,'文件管理删除','2','sys_file_del',NULL,'1468405431398301696',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',80,'1','2021-12-08 02:21:51.169','1','2021-12-26 03:31:40.112',NULL,0,'0','0000');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oauth_client_detail`
--

DROP TABLE IF EXISTS `sys_oauth_client_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oauth_client_detail` (
                                         `client_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端ID',
                                         `resource_ids` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '资源ID',
                                         `client_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '客户端密钥',
                                         `scope` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '作用域',
                                         `authorized_grant_types` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '授权方式',
                                         `web_server_redirect_uri` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '重定向地址',
                                         `authorities` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限',
                                         `access_token_validity` int DEFAULT NULL COMMENT '请求令牌有效时间',
                                         `refresh_token_validity` int DEFAULT NULL COMMENT '刷新令牌有效时间',
                                         `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '扩展信息',
                                         `autoapprove` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否自动放行',
                                         `tenant_code` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
                                         PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='终端信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oauth_client_detail`
--

LOCK TABLES `sys_oauth_client_detail` WRITE;
/*!40000 ALTER TABLE `sys_oauth_client_detail` DISABLE KEYS */;
INSERT INTO `sys_oauth_client_detail` VALUES ('albedo',NULL,'albedo','server','password,refresh_token,authorization_code,client_credentials','http://localhost:4040/sso1/login,http://localhost:4041/sso1/login',NULL,NULL,NULL,NULL,'true','0000'),('app',NULL,'app','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true','0000'),('daemon',NULL,'daemon','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true','0000'),('gen',NULL,'gen','server','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true','0000'),('swagger',NULL,'swagger','all','password,refresh_token',NULL,NULL,NULL,NULL,NULL,'true','0000');
/*!40000 ALTER TABLE `sys_oauth_client_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_parameter`
--

DROP TABLE IF EXISTS `sys_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_parameter` (
                               `id` bigint NOT NULL COMMENT 'ID',
                               `key_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数键',
                               `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数值',
                               `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数名称',
                               `state` bit(1) DEFAULT b'1' COMMENT '状态',
                               `readonly_` bit(1) DEFAULT b'0' COMMENT '内置',
                               `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                               `created_by` bigint NOT NULL,
                               `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                               `last_modified_by` bigint DEFAULT NULL,
                               `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                               `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                               `version` int NOT NULL,
                               `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE KEY `uk_key` (`tenant_code`,`key_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='参数配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_parameter`
--

LOCK TABLES `sys_parameter` WRITE;
/*!40000 ALTER TABLE `sys_parameter` DISABLE KEYS */;
INSERT INTO `sys_parameter` VALUES (1,'LoginPolicy','MANY','登录策略',_binary '',_binary '','0000',0,'2021-10-27 05:51:01.785',NULL,NULL,NULL,0,'0');
/*!40000 ALTER TABLE `sys_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
                          `id` bigint NOT NULL,
                          `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
                          `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '编码',
                          `level` int DEFAULT NULL COMMENT '角色级别',
                          `data_scope` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
                          `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
                          `created_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                          `last_modified_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                          `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
                          `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `version` int NOT NULL,
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'ALL','1','','2017-10-29 07:45:51.000','1','2022-04-11 05:34:01.971',NULL,75,'0','0000'),(2,'机构管理员','manage',2,'CUSTOMIZE','1','0','2018-11-11 11:42:26.000','1','2022-04-11 05:34:04.691',NULL,22,'0','0000'),(5,'普通管理员','normal',4,'CUSTOMIZE','1','1','2020-05-14 03:00:50.813','1','2022-04-11 05:34:10.663','普通管理',8,'0','0000');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `role_id` bigint DEFAULT NULL COMMENT '角色ID',
                               `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
                               `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色与部门对应关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (1,1,8,'0000'),(78,2,5,'0000'),(79,2,4,'0000'),(80,2,3,'0000');
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
                               `role_id` bigint NOT NULL COMMENT '角色ID',
                               `menu_id` bigint NOT NULL COMMENT '菜单ID',
                               `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                               PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,330,'0000'),(1,334,'0000'),(1,335,'0000'),(1,336,'0000'),(1,337,'0000'),(1,338,'0000'),(1,339,'0000'),(1,440,'0000'),(1,445,'0000'),(1,446,'0000'),(1,447,'0000'),(1,448,'0000'),(1,449,'0000'),(1,1000,'0000'),(1,1100,'0000'),(1,1101,'0000'),(1,1102,'0000'),(1,1103,'0000'),(1,1166,'0000'),(1,1200,'0000'),(1,1201,'0000'),(1,1202,'0000'),(1,1203,'0000'),(1,1300,'0000'),(1,1301,'0000'),(1,1302,'0000'),(1,1303,'0000'),(1,1400,'0000'),(1,1401,'0000'),(1,1402,'0000'),(1,1403,'0000'),(1,2000,'0000'),(1,2100,'0000'),(1,2101,'0000'),(1,2200,'0000'),(1,2201,'0000'),(1,2202,'0000'),(1,2500,'0000'),(1,3333,'0000'),(1,4433,'0000'),(1,4444,'0000'),(1,5555,'0000'),(1,5566,'0000'),(1,6000,'0000'),(1,6666,'0000'),(1,6677,'0000'),(1,7000,'0000'),(1,7700,'0000'),(1,7766,'0000'),(1,7788,'0000'),(1,8855,'0000'),(1,8877,'0000'),(1,8888,'0000'),(1,8899,'0000'),(1,9000,'0000'),(1,9900,'0000'),(1,9911,'0000'),(1,9944,'0000'),(1,9955,'0000'),(1,9977,'0000'),(1,9988,'0000'),(1,9999,'0000'),(1,1465502605210812416,'0000'),(1,1465502605244366848,'0000'),(1,1465502605277921280,'0000'),(1,1465502605307281408,'0000'),(1,1468405431398301696,'0000'),(1,1468405431419273216,'0000'),(1,1468405431440244736,'0000'),(1,1468405431457021952,'0000'),(2,334,'0000'),(2,338,'0000'),(2,440,'0000'),(2,446,'0000'),(2,1000,'0000'),(2,1100,'0000'),(2,1101,'0000'),(2,1102,'0000'),(2,1103,'0000'),(2,1166,'0000'),(2,1200,'0000'),(2,1300,'0000'),(2,1400,'0000'),(2,2000,'0000'),(2,2200,'0000'),(2,6000,'0000'),(2,6655,'0000'),(2,8855,'0000'),(2,8888,'0000'),(2,8899,'0000'),(2,9000,'0000'),(2,9900,'0000'),(2,9955,'0000'),(2,9988,'0000'),(5,338,'0000'),(5,440,'0000'),(5,446,'0000'),(5,1000,'0000'),(5,1101,'0000'),(5,1102,'0000'),(5,1103,'0000'),(5,1166,'0000'),(5,1200,'0000'),(5,1400,'0000'),(5,2200,'0000'),(5,6000,'0000'),(5,6655,'0000'),(5,8855,'0000'),(5,8888,'0000'),(5,8899,'0000'),(5,9000,'0000'),(5,9900,'0000'),(5,9955,'0000'),(5,9988,'0000');
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant`
--

DROP TABLE IF EXISTS `sys_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant` (
                            `id` bigint NOT NULL COMMENT '主键ID',
                            `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '企业编码',
                            `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '企业名称',
                            `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '类型 \n#{CREATE:创建;REGISTER:注册}',
                            `connect_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '链接类型 \n#TenantConnectTypeEnum{LOCAL:本地;REMOTE:远程}',
                            `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '状态 \n#{NORMAL:正常;WAIT_INIT:待初始化;FORBIDDEN:禁用;WAITING:待审核;REFUSE:拒绝;DELETE:已删除}',
                            `readonly_` bit(1) DEFAULT b'0' COMMENT '内置',
                            `duty` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '责任人',
                            `expiration_time` datetime DEFAULT NULL COMMENT '有效期 \n为空表示永久',
                            `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'logo地址',
                            `describe_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '简介',
                            `created_by` bigint NOT NULL,
                            `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                            `last_modified_by` bigint DEFAULT NULL,
                            `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                            `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                            `version` int NOT NULL,
                            `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                            PRIMARY KEY (`id`) USING BTREE,
                            UNIQUE KEY `uk_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='企业';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant`
--

LOCK TABLES `sys_tenant` WRITE;
/*!40000 ALTER TABLE `sys_tenant` DISABLE KEYS */;
INSERT INTO `sys_tenant` VALUES (1,'0000','最后内置的运营&超级租户','CREATE','LOCAL','NORMAL',_binary '','最后',NULL,NULL,NULL,0,'2021-10-27 05:51:59.303',NULL,NULL,NULL,0,'0');
/*!40000 ALTER TABLE `sys_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant_datasource_conf`
--

DROP TABLE IF EXISTS `sys_tenant_datasource_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant_datasource_conf` (
                                            `id` bigint NOT NULL COMMENT 'ID',
                                            `tenant_id` bigint NOT NULL COMMENT '租户id',
                                            `datasource_config_id` bigint NOT NULL COMMENT '数据源id',
                                            `application` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '服务',
                                            `created_by` bigint NOT NULL,
                                            `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                                            `version` int NOT NULL,
                                            `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                                            PRIMARY KEY (`id`) USING BTREE,
                                            UNIQUE KEY `uk_tenan_application` (`tenant_id`,`datasource_config_id`,`application`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='租户数据源关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant_datasource_conf`
--

LOCK TABLES `sys_tenant_datasource_conf` WRITE;
/*!40000 ALTER TABLE `sys_tenant_datasource_conf` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_tenant_datasource_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
                          `id` bigint NOT NULL DEFAULT '1' COMMENT '主键ID',
                          `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
                          `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                          `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
                          `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '简介',
                          `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
                          `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
                          `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '性别 \n#Sex{W:女;M:男;N:未知}',
                          `dept_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部门ID',
                          `qq_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'QQ openid',
                          `wx_open_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信openid',
                          `available` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
                          `created_by` bigint NOT NULL,
                          `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
                          `last_modified_by` bigint DEFAULT NULL,
                          `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
                          `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
                          `version` int NOT NULL,
                          `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
                          `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                          PRIMARY KEY (`id`) USING BTREE,
                          KEY `user_wx_openid` (`wx_open_id`) USING BTREE,
                          KEY `user_qq_openid` (`qq_open_id`) USING BTREE,
                          KEY `user_idx1_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$6z14VGdfVnlWY2K1pvdzJOHkvjLmOuBrJXXeZ0mGIqB60Qd6WYDoC','albedo','17034642999','albedo@ss.com','default.jpg','W','1',NULL,'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ','1',1,'2018-04-19 23:15:18.000',1,'2021-12-25 01:46:31.267','11',90,'0','0000'),(2,'manage','$2a$10$rmMeskeLIFFqP39zH5a2duJ0pcDvePqdwrSQHFW.rBVszm3lE9E2y',NULL,'13254642311','13@qqx.om',NULL,'M','1',NULL,NULL,'1',1,'2020-05-12 01:51:46.703',1,'2021-12-04 05:15:51.645',NULL,16,'0','0000'),(3,'ttttt','$2a$10$KYuAjYBhucUG4GbYQTuRO.YOl6JJlGdEdD5zGLkfrSumnjEF59S7G','1','13245678975','1@e.com',NULL,'N','1',NULL,NULL,'1',1,'2020-05-29 08:41:21.126',1,'2021-12-04 05:15:52.453',NULL,12,'1','0000'),(4,'normal','$2a$10$tr91uxFhn2emY7sXqLqzz.66xrXGgLkzxyREnRhgWcNbxmlgUXJU6',NULL,'13258465211','qq@ee.com',NULL,'N','1',NULL,NULL,'1',1,'2020-05-12 02:22:11.393',1,'2021-12-04 05:15:53.372',NULL,25,'0','0000'),(5,'dddd','$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe','dd','13258465214','1@1.com',NULL,'N','1',NULL,NULL,'1',1,'2020-05-27 19:08:17.639',1,'2021-12-04 05:15:54.490',NULL,1,'1','0000'),(6,'dsafdf','$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',NULL,'13258462101','837158@qq.com',NULL,'N','1',NULL,NULL,'1',1,'2019-07-07 06:32:17.000',1,'2021-12-04 05:15:55.244','11',26,'1','0000'),(7,'test','$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',NULL,'13258462222','ww@qq.com',NULL,'N','1',NULL,NULL,'1',1,'2019-07-07 06:35:13.000',1,'2021-12-04 05:15:55.937',NULL,50,'1','0000'),(8,'ttt','$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',NULL,'13254732131','2113@ed.bom',NULL,'N','1',NULL,NULL,'1',1,'2020-05-12 02:06:21.381',1,'2021-12-04 05:15:56.571',NULL,1,'1','0000'),(9,'test','$2a$10$g74ZwJNgw52R/A6t7lQBzuMbBcBFzm.cKd7SqS5uNxkkecvN/MVte',NULL,'13265843021','33@d.com',NULL,'N','1',NULL,NULL,'1',1,'2021-12-02 12:03:08.829',1,'2022-04-11 05:32:50.274',NULL,3,'1','0000'),(1467013500122431488,'dddddd','$2a$10$K0C0WyfF4owq6M1c.p4G6OzJkCY8vWCBRrFeSlGy.3b9YdKVEdX7.',NULL,'13258465001','1@1x.com',NULL,'W','1',NULL,NULL,'1',1,'2021-12-04 06:10:48.872',1,'2021-12-04 06:10:48.879',NULL,1,'0','0000');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
                               `user_id` bigint NOT NULL COMMENT '用户ID',
                               `role_id` bigint NOT NULL COMMENT '角色ID',
                               `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                               PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1,'0000'),(2,2,'0000'),(3,2,'0000'),(4,5,'0000'),(9,5,'0000'),(1466377391856156672,5,'0000'),(1467013500122431488,5,'0000');
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tool_alipay_config`
--

DROP TABLE IF EXISTS `tool_alipay_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tool_alipay_config` (
                                    `id` bigint NOT NULL COMMENT 'ID',
                                    `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用ID',
                                    `charset` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '编码',
                                    `format` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型 固定格式json',
                                    `gateway_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网关地址',
                                    `notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '异步回调',
                                    `private_key` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '私钥',
                                    `public_key` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '公钥',
                                    `return_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回调地址',
                                    `sign_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签名方式',
                                    `sys_service_provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商户号',
                                    `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='支付宝配置类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tool_alipay_config`
--

LOCK TABLES `tool_alipay_config` WRITE;
/*!40000 ALTER TABLE `tool_alipay_config` DISABLE KEYS */;
INSERT INTO `tool_alipay_config` VALUES (1,'2016091700532697','utf-8','JSON','https://openapi.alipaydev.com/gateway.do','http://api.auauz.net/api/aliPay/notify','MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB','http://api.auauz.net/api/aliPay/return','RSA2','2088102176044281','');
/*!40000 ALTER TABLE `tool_alipay_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tool_email_config`
--

DROP TABLE IF EXISTS `tool_email_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tool_email_config` (
                                   `id` bigint NOT NULL COMMENT 'ID',
                                   `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收件人',
                                   `host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮件服务器SMTP地址',
                                   `pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
                                   `port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '端口',
                                   `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发件者用户名',
                                   `tenant_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '租户编码',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT COMMENT='邮箱配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tool_email_config`
--

LOCK TABLES `tool_email_config` WRITE;
/*!40000 ALTER TABLE `tool_email_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `tool_email_config` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-22 14:09:32
