/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : albedo-quartz

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 26/12/2020 11:39:07
*/
DROP
DATABASE IF EXISTS `albedo-quartz`;

CREATE
DATABASE  `albedo-quartz` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

USE
`albedo-quartz`;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`
(
    `sched_name`    varchar(120) NOT NULL,
    `trigger_name`  varchar(200) NOT NULL,
    `trigger_group` varchar(200) NOT NULL,
    `blob_data`     blob,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`
(
    `sched_name`    varchar(120) NOT NULL,
    `calendar_name` varchar(200) NOT NULL,
    `calendar`      blob         NOT NULL,
    PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`
(
    `sched_name`      varchar(120) NOT NULL,
    `trigger_name`    varchar(200) NOT NULL,
    `trigger_group`   varchar(200) NOT NULL,
    `cron_expression` varchar(200) NOT NULL,
    `time_zone_id`    varchar(80) DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_cron_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Singapore');
INSERT INTO `qrtz_cron_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Singapore');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`
(
    `sched_name`        varchar(120) NOT NULL,
    `entry_id`          varchar(95)  NOT NULL,
    `trigger_name`      varchar(200) NOT NULL,
    `trigger_group`     varchar(200) NOT NULL,
    `instance_name`     varchar(200) NOT NULL,
    `fired_time`        bigint       NOT NULL,
    `sched_time`        bigint       NOT NULL,
    `priority`          int          NOT NULL,
    `state`             varchar(16)  NOT NULL,
    `job_name`          varchar(200) DEFAULT NULL,
    `job_group`         varchar(200) DEFAULT NULL,
    `is_nonconcurrent`  varchar(1)   DEFAULT NULL,
    `requests_recovery` varchar(1)   DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`
(
    `sched_name`        varchar(120) NOT NULL,
    `job_name`          varchar(200) NOT NULL,
    `job_group`         varchar(200) NOT NULL,
    `description`       varchar(250) DEFAULT NULL,
    `job_class_name`    varchar(250) NOT NULL,
    `is_durable`        varchar(1)   NOT NULL,
    `is_nonconcurrent`  varchar(1)   NOT NULL,
    `is_update_data`    varchar(1)   NOT NULL,
    `requests_recovery` varchar(1)   NOT NULL,
    `job_data`          blob,
    PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_job_details`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL,
        'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0',
        0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720038636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0013770E05000007E40C1A0A2C2B39E048C078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000A7400013174000E302F3130202A202A202A202A203F7074000744454641554C547371007E00170000000174001573696D706C655461736B2E646F4E6F506172616D7374000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000130740001327800);
INSERT INTO `qrtz_job_details`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL,
        'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0',
        0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720038636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770E05000007E3080E0A1524389FD9807870740001317371007E0013770E05000007E405100F1C18171126C078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000127400013174000E302F3135202A202A202A202A203F7074000744454641554C547371007E00170000000274001D73696D706C655461736B2E646F506172616D732827616C6265646F272974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000130707800);
INSERT INTO `qrtz_job_details`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL,
        'com.albedo.java.modules.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0',
        0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F5045525449455373720029636F6D2E616C6265646F2E6A6176612E6D6F64756C65732E71756172747A2E646F6D61696E2E4A6F62000000000000000102000A4C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C0005656D61696C71007E00094C000567726F757071007E00094C000269647400134C6A6176612F6C616E672F496E74656765723B4C000C696E766F6B6554617267657471007E00094C000D6D697366697265506F6C69637971007E00094C00046E616D6571007E00094C000673746174757371007E00094C00077375625461736B71007E000978720038636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E4261736544617461456E7469747900000000000000010200064C000963726561746564427971007E00094C000B63726561746564446174657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000B6465736372697074696F6E71007E00094C000E6C6173744D6F646966696564427971007E00094C00106C6173744D6F6469666965644461746571007E000C4C000776657273696F6E71007E000A78720034636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E42617365456E7469747900000000000000010200014C000764656C466C616771007E000978720037636F6D2E616C6265646F2E6A6176612E636F6D6D6F6E2E70657273697374656E63652E646F6D61696E2E47656E6572616C456E74697479000000000000000102000078720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C00000000000000010200007870740001307400007372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E3080E0A15DB7870740001317371007E0013770E05000007E405100F0C320F60C48078737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000047400013174000E302F3230202A202A202A202A203F7074000744454641554C547371007E00170000000374004073696D706C655461736B2E646F4D756C7469706C65506172616D732827616C6265646F272C20747275652C20323030304C2C203331362E3530442C203130302974000133740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000130707800);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`
(
    `sched_name` varchar(120) NOT NULL,
    `lock_name`  varchar(40)  NOT NULL,
    PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_locks`
VALUES ('AlbedoScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks`
VALUES ('AlbedoScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`
(
    `sched_name`    varchar(120) NOT NULL,
    `trigger_group` varchar(200) NOT NULL,
    PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`
(
    `sched_name`        varchar(120) NOT NULL,
    `instance_name`     varchar(200) NOT NULL,
    `last_checkin_time` bigint       NOT NULL,
    `checkin_interval`  bigint       NOT NULL,
    PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_scheduler_state`
VALUES ('AlbedoScheduler', 'somewheredembp.lan1608949793289', 1608953947234, 15000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`
(
    `sched_name`      varchar(120) NOT NULL,
    `trigger_name`    varchar(200) NOT NULL,
    `trigger_group`   varchar(200) NOT NULL,
    `repeat_count`    bigint       NOT NULL,
    `repeat_interval` bigint       NOT NULL,
    `times_triggered` bigint       NOT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`
(
    `sched_name`    varchar(120) NOT NULL,
    `trigger_name`  varchar(200) NOT NULL,
    `trigger_group` varchar(200) NOT NULL,
    `str_prop_1`    varchar(512)   DEFAULT NULL,
    `str_prop_2`    varchar(512)   DEFAULT NULL,
    `str_prop_3`    varchar(512)   DEFAULT NULL,
    `int_prop_1`    int            DEFAULT NULL,
    `int_prop_2`    int            DEFAULT NULL,
    `long_prop_1`   bigint         DEFAULT NULL,
    `long_prop_2`   bigint         DEFAULT NULL,
    `dec_prop_1`    decimal(13, 4) DEFAULT NULL,
    `dec_prop_2`    decimal(13, 4) DEFAULT NULL,
    `bool_prop_1`   varchar(1)     DEFAULT NULL,
    `bool_prop_2`   varchar(1)     DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`
(
    `sched_name`     varchar(120) NOT NULL,
    `trigger_name`   varchar(200) NOT NULL,
    `trigger_group`  varchar(200) NOT NULL,
    `job_name`       varchar(200) NOT NULL,
    `job_group`      varchar(200) NOT NULL,
    `description`    varchar(250) DEFAULT NULL,
    `next_fire_time` bigint       DEFAULT NULL,
    `prev_fire_time` bigint       DEFAULT NULL,
    `priority`       int          DEFAULT NULL,
    `trigger_state`  varchar(16)  NOT NULL,
    `trigger_type`   varchar(8)   NOT NULL,
    `start_time`     bigint       NOT NULL,
    `end_time`       bigint       DEFAULT NULL,
    `calendar_name`  varchar(200) DEFAULT NULL,
    `misfire_instr`  smallint     DEFAULT NULL,
    `job_data`       blob,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    KEY              `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
    CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1608950690000, -1, 5,
        'PAUSED', 'CRON', 1608950684000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1608949800000, -1, 5,
        'PAUSED', 'CRON', 1608949794000, 0, NULL, 2, '');
INSERT INTO `qrtz_triggers`
VALUES ('AlbedoScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1608949800000, -1, 5,
        'PAUSED', 'CRON', 1608949794000, 0, NULL, 2, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`
(
    `id`                 int                                                    NOT NULL AUTO_INCREMENT COMMENT '任务ID',
    `name`               varchar(64)                                            NOT NULL DEFAULT '' COMMENT '任务名称',
    `group`              varchar(64)                                            NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
    `invoke_target`      varchar(500)                                           NOT NULL COMMENT '调用目标字符串',
    `cron_expression`    varchar(255)                                                    DEFAULT '' COMMENT 'cron执行表达式',
    `misfire_policy`     varchar(20)                                                     DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    `concurrent`         char(1)                                                         DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
    `sub_task`           varchar(100)                                                    DEFAULT NULL COMMENT '子任务id 多个用逗号隔开',
    `email`              varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci         DEFAULT NULL COMMENT '报警邮箱',
    `status`             char(1)                                                         DEFAULT '0' COMMENT '状态(1-运行中，0-暂停)',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `created_date`       datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci          DEFAULT NULL,
    `last_modified_date` datetime(3) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (3),
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci         DEFAULT NULL COMMENT '描述',
    `version`            int                                                    NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job`
VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '2', NULL, '0', '',
        '2019-08-14 10:21:36.000', '1', '2020-12-26 10:44:43.971', NULL, 10, '0');
INSERT INTO `sys_job`
VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', NULL, NULL, '0', '',
        '2019-08-14 10:21:36.950', '1', '2020-05-16 15:28:24.387', NULL, 18, '0');
INSERT INTO `sys_job`
VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)',
        '0/20 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:12:50.258',
        NULL, 4, '0');
INSERT INTO `sys_job`
VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', '2', '1', '1', NULL, '0', '1', '2020-05-16 15:06:05.098', '1',
        '2020-05-16 15:21:10.516', NULL, 1, '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`
(
    `id`              bigint       NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
    `job_name`        varchar(64)  NOT NULL COMMENT '任务名称',
    `job_group`       varchar(64)  NOT NULL COMMENT '任务组名',
    `cron_expression` varchar(255)                                            DEFAULT '' COMMENT 'cron执行表达式',
    `invoke_target`   varchar(500) NOT NULL COMMENT '调用目标字符串',
    `job_message`     varchar(500)                                            DEFAULT NULL COMMENT '日志信息',
    `status`          char(1)                                                 DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
    `start_time`      datetime(3) DEFAULT NULL COMMENT '开始时间',
    `end_time`        datetime(3) DEFAULT NULL COMMENT '结束时间',
    `create_time`     datetime(3) DEFAULT NULL COMMENT '创建时间',
    `exception_info`  varchar(3000)                                           DEFAULT '' COMMENT '异常信息',
    `description`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '描述',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

SET
FOREIGN_KEY_CHECKS = 1;
