/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : albedo-cloud

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 26/12/2020 11:33:13
*/
DROP
DATABASE IF EXISTS `albedo-cloud`;

CREATE
DATABASE  `albedo-cloud` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

USE
`albedo-cloud`;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`
(
    `id`                 varchar(32) NOT NULL,
    `parent_id`          varchar(32)                                       DEFAULT NULL,
    `parent_ids`         varchar(2000)                                     DEFAULT NULL COMMENT '父菜单IDs',
    `name`               varchar(50)                                       DEFAULT NULL COMMENT '部门名称',
    `sort`               int                                               DEFAULT NULL COMMENT '排序',
    `leaf`               bit(1)                                            DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) NOT NULL,
    `created_date`       timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP (3) COMMENT '创建时间',
    `last_modified_by`   varchar(50)                                       DEFAULT NULL,
    `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '修改时间',
    `version`            int         NOT NULL,
    `description`        varchar(100)                                      DEFAULT NULL COMMENT '描述',
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept`
VALUES ('1', '-1', NULL, '总部', 30, b'0', '1', '1', '2020-05-16 02:26:57.020', '1', '2020-12-26 10:44:22.996', 14, '',
        '0');
INSERT INTO `sys_dept`
VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f,',
        'ddd', 1, b'1', '1', '1', '2020-05-16 03:05:18.140', '1', '2020-05-16 03:05:23.939', 0, NULL, '1');
INSERT INTO `sys_dept`
VALUES ('6304292a4ecb1448c33447adc0c35f08', '1', '1,', '运营部', 30, b'1', '1', '1', '2020-05-16 03:03:46.542', '1',
        '2020-05-16 05:27:11.787', 2, '', '0');
INSERT INTO `sys_dept`
VALUES ('701903b72179df2c79d383f621eab9c8', '1', '1,', 'AI部', 30, b'1', '1', '1', '2020-05-16 03:04:11.395', '1',
        '2020-12-26 10:44:23.011', 2, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '-1', NULL, 'test', 1, b'0', '1', '1', '2020-05-16 03:05:05.919', '1',
        '2020-05-16 03:05:23.939', 1, NULL, '1');
INSERT INTO `sys_dept`
VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', '-1', NULL, '平台', 30, b'1', '1', '1', '2020-05-16 02:28:08.383', '1',
        '2020-05-16 03:04:55.462', 2, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('db32c981785f619401518127c48b6247', '1', '1,', '测试部', 30, b'1', '1', '1', '2020-05-16 03:03:57.184', '1',
        '2020-05-16 03:03:57.184', 0, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('f52e1e844bf0fbadf5213214fb621e27', '1', '1,', '开发部', 30, b'1', '1', '1', '2020-05-16 03:03:23.518', '1',
        '2020-05-21 03:09:24.277', 3, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`
(
    `ancestor`   varchar(32) NOT NULL COMMENT '祖先节点',
    `descendant` varchar(32) NOT NULL COMMENT '后代节点',
    `del_flag`   char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
    KEY          `idx1` (`ancestor`) USING BTREE,
    KEY          `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept_relation`
VALUES ('1', '1', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', 'f52e1e844bf0fbadf5213214fb621e27', '0');
INSERT INTO `sys_dept_relation`
VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation`
VALUES ('6304292a4ecb1448c33447adc0c35f08', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation`
VALUES ('701903b72179df2c79d383f621eab9c8', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f', '1');
INSERT INTO `sys_dept_relation`
VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', 'c095173c3aebcd7ff9c6177fbf7a8b69', '0');
INSERT INTO `sys_dept_relation`
VALUES ('db32c981785f619401518127c48b6247', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation`
VALUES ('f52e1e844bf0fbadf5213214fb621e27', 'f52e1e844bf0fbadf5213214fb621e27', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`
(
    `id`                 varchar(32)  NOT NULL COMMENT '编号',
    `name`               varchar(100) NOT NULL COMMENT '标签名',
    `val`                varchar(100)                                      DEFAULT NULL COMMENT '数据值',
    `code`               varchar(100) NOT NULL COMMENT '类型',
    `parent_id`          varchar(32)                                       DEFAULT NULL COMMENT '父菜单ID',
    `parent_ids`         varchar(2000)                                     DEFAULT NULL COMMENT '父菜单IDs',
    `sort`               int          NOT NULL COMMENT '排序（升序）',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
    `leaf`               bit(1)                                            DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `created_by`         varchar(50)  NOT NULL,
    `created_date`       timestamp(3) NOT NULL                             DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50)                                       DEFAULT NULL,
    `last_modified_date` timestamp(3) NOT NULL                             DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '更新时间',
    `version`            int          NOT NULL                             DEFAULT '0',
    `description`        varchar(100)                                      DEFAULT NULL COMMENT '描述',
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    KEY                  `sys_dict_value` (`val`) USING BTREE,
    KEY                  `sys_dict_label` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict`
VALUES ('05d01334ecdbe94b856038a32a42512b', '任务分组', NULL, 'quartz_job_group', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-08-15 16:33:54.745', '1',
        '2020-12-26 11:18:00.722', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line',
        'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30,
        '1', b'1', '1', '2019-08-11 11:17:28.210', '1', '2020-12-26 11:18:00.726', 1, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, '1', b'1', '1',
        '2019-07-14 06:00:03.000', '1', '2020-12-26 11:18:00.732', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '其他', '0', 'sys_business_type_0', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, '1', b'1', '1',
        '2019-08-07 16:49:39.000', '1', '2020-12-26 11:18:00.736', 4, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0fdd548394368b4969136f32c435fd98', '菜单', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, '1', b'1', '1',
        '2019-07-14 06:04:44.000', '1', '2020-12-26 11:18:00.739', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, '1', b'0', '1', '2018-07-09 06:16:14.000', '1',
        '2020-12-26 10:44:33.571', 13, '', '0');
INSERT INTO `sys_dict`
VALUES ('13276f100593667c3bd40ab8fea734b4', '立即执行', '1', 'quartz_misfire_policy_1', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, '1', b'1', '1',
        '2019-08-15 10:24:19.706', '1', '2020-12-26 11:18:00.743', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('181dd29afa852bd47a5ae8dd2e02a623', '正常', '1', 'sys_status_1', '952c07b027bf0be298a9243af701b8c5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, '1', b'1', '1',
        '2019-08-14 11:28:01.693', '1', '2020-12-26 11:18:00.747', 1, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, '1',
        b'0', '1', '2019-06-02 17:17:44.000', '1', '2020-12-26 11:18:00.751', 19, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, '1', b'1', '1',
        '2019-07-14 04:01:51.000', '1', '2020-12-26 10:44:33.586', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', '6', 'sys_business_type_6', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70, '1', b'1', '1',
        '2019-08-07 16:52:15.681', '1', '2020-12-26 11:18:00.753', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, '1', b'1', '1',
        '2018-07-09 06:15:40.000', '1', '2020-12-26 11:18:00.754', 7, '', '0');
INSERT INTO `sys_dict`
VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', '0', 'sys_operate_type_0', '6b8211aef2fec451b0398b19857443a7',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, '1', b'1', '1',
        '2019-08-07 16:48:21.644', '1', '2020-12-26 11:18:00.761', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('356f3304462386a8827d44b9e6c9482c', '运行中', '1', 'quartz_job_status_1', 'c7243dfd9599957c281be8be786708d5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 10, '1', b'1', '1',
        '2020-05-16 10:14:46.614', '1', '2020-12-26 11:18:00.765', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('3e949b67e0c5be3357bdcce9705f7433', '放弃执行', '3', 'quartz_misfire_policy_3', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, '1', b'1', '1',
        '2019-08-15 10:24:54.175', '1', '2020-12-26 11:18:00.767', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, '1', b'1', '1',
        '2019-06-02 17:26:40.000', '1', '2020-12-26 11:18:00.770', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, '1', b'1', '1',
        '2019-07-14 05:59:13.000', '1', '2020-12-26 11:18:00.776', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4ebd555fb352328cb2db93e15d3243ad', '系统', 'SYSTEM', 'quartz_job_group_system',
        '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 30,
        '1', b'1', '1', '2019-08-15 16:34:47.139', '1', '2020-12-26 11:18:00.778', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', '1', 'sys_business_type_1', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, '1', b'1', '1',
        '2019-08-07 16:50:20.634', '1', '2020-12-26 11:18:00.780', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, '1', b'1', '1',
        '2019-07-14 05:53:55.000', '1', '2020-12-26 11:18:00.782', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', '1', 'sys_operate_type_1', '6b8211aef2fec451b0398b19857443a7',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20, '1', b'1', '1',
        '2019-08-07 16:48:40.344', '1', '2020-12-26 11:18:00.783', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-08-07 15:37:09.613', '1',
        '2020-12-26 11:18:00.788', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '目录', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, '1', b'1', '1',
        '2019-07-14 06:04:10.000', '1', '2020-12-26 11:18:00.793', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', '7', 'sys_business_type_7', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80, '1', b'1', '1',
        '2019-08-07 16:52:36.997', '1', '2020-12-26 11:18:00.799', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', '4', 'sys_business_type_4', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50, '1', b'1', '1',
        '2019-08-07 16:51:33.286', '1', '2020-12-26 11:18:00.803', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', '3', 'sys_business_type_3', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40, '1', b'1', '1',
        '2019-08-07 16:50:45.270', '1', '2020-12-26 11:18:00.806', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line',
        'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30,
        '1', b'1', '1', '2019-08-11 11:17:50.132', '1', '2020-12-26 11:18:00.808', 1, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, '1', b'1', '1',
        '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict`
VALUES ('94e00baf14b640d793c133fb7bfa4c9a', '默认', 'DEFAULT', 'quartz_job_group_default',
        '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 30,
        '1', b'1', '1', '2019-08-15 16:34:28.547', '1', '2020-12-26 11:18:00.811', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('952c07b027bf0be298a9243af701b8c5', '状态', NULL, 'sys_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-08-14 11:26:50.424', '1',
        '2020-12-26 11:18:00.817', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, '1', b'1', '1',
        '2019-07-14 05:52:44.000', '1', '2020-12-26 11:18:00.820', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-07-14 05:50:08.000', '1',
        '2020-12-26 11:18:00.824', 17, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', '5', 'sys_business_type_5', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60, '1', b'1', '1',
        '2019-08-07 16:51:45.855', '1', '2020-12-26 11:18:00.826', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, '1', b'1', '1',
        '2019-07-14 06:01:11.000', '1', '2020-12-26 11:18:00.827', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('c7243dfd9599957c281be8be786708d5', '任务状态', NULL, 'quartz_job_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2020-05-16 10:13:18.543', '1',
        '2020-12-26 11:18:00.828', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('cb3d07975904460c94e9e2b30755c04b', '计划执行错误策略', NULL, 'quartz_misfire_policy',
        'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1',
        '2019-08-15 10:23:54.460', '1', '2020-12-26 11:18:00.830', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, '1', b'0', '1',
        '2019-07-14 01:13:12.000', '1', '2020-12-26 10:52:49.425', 24, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('decc4b5f8996c755ba6e5a097486e362', '已暂停', '0', 'quartz_job_status_0', 'c7243dfd9599957c281be8be786708d5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 20, '1', b'1', '1',
        '2020-05-16 10:15:08.604', '1', '2020-12-26 11:18:00.832', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-08-07 15:33:35.000', '1',
        '2020-12-26 11:18:00.836', 18, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-07-14 06:01:48.000', '1',
        '2020-12-26 11:18:00.840', 14, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', '2', 'sys_business_type_2', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, '1', b'1', '1',
        '2019-08-07 16:50:32.457', '1', '2020-12-26 11:18:00.845', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('ef0368c6fd52ee8f1f4270869da00f18', '按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, '1', b'1', '1',
        '2019-08-07 13:55:24.531', '1', '2020-12-26 11:18:00.848', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, '1', b'0', '1', '2019-08-11 11:16:52.095', '1',
        '2020-12-26 11:18:00.854', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f35adf75d9ab0ca5cec43815b7db5274', '执行一次', '2', 'quartz_misfire_policy_2', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, '1', b'1', '1',
        '2019-08-15 10:24:39.273', '1', '2020-12-26 11:18:00.862', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', '2', 'sys_operate_type_2', '6b8211aef2fec451b0398b19857443a7',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30, '1', b'1', '1',
        '2019-08-07 16:49:00.766', '1', '2020-12-26 11:18:00.866', 3, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('fafe8843b2f4091f8096dc0df09c300c', '失败', '0', 'sys_status_0', '952c07b027bf0be298a9243af701b8c5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, '1', b'1', '1',
        '2019-08-14 11:28:11.000', '1', '2020-12-26 11:18:00.870', 3, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate`
(
    `id`            bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
    `title`         varchar(255)                                                  DEFAULT '' COMMENT '日志标题',
    `log_type`      varchar(255)                                                  DEFAULT NULL COMMENT '日志类型',
    `username`      varchar(255)                                                  DEFAULT NULL COMMENT '用户名',
    `service_id`    varchar(32)                                                   DEFAULT NULL COMMENT '服务ID',
    `ip_address`    varchar(255)                                                  DEFAULT NULL COMMENT 'IP地址',
    `ip_location`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
    `browser`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  DEFAULT '' COMMENT '浏览器类型',
    `os`            varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  DEFAULT '' COMMENT '操作系统',
    `user_agent`    varchar(1000)                                                 DEFAULT NULL COMMENT '用户代理',
    `request_uri`   varchar(255)                                                  DEFAULT NULL COMMENT '请求URI',
    `method`        varchar(255)                                                  DEFAULT NULL COMMENT '请求方法',
    `params`        text COMMENT '操作提交的数据',
    `time`          mediumtext COMMENT '执行时间',
    `operator_type` varchar(20)                                                   DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    `business_type` varchar(20)                                                   DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    `exception`     text COMMENT '异常信息',
    `created_by`    varchar(64)                                                   DEFAULT NULL COMMENT '创建者',
    `created_date`  timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP (3) COMMENT '创建时间',
    `description`   varchar(100)                                                  DEFAULT NULL COMMENT '描述',
    `del_flag`      char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    KEY             `sys_log_create_by` (`created_by`) USING BTREE,
    KEY             `sys_log_request_uri` (`request_uri`) USING BTREE,
    KEY             `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1176 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作日志表';

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`
(
    `id`                 varchar(32) NOT NULL COMMENT '菜单ID',
    `name`               varchar(32) NOT NULL COMMENT '菜单名称',
    `type`               char(1)                                           DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
    `permission`         varchar(32)                                       DEFAULT NULL COMMENT '菜单权限标识',
    `path`               varchar(128)                                      DEFAULT NULL COMMENT '前端URL',
    `parent_id`          varchar(32)                                       DEFAULT NULL COMMENT '父菜单ID',
    `parent_ids`         varchar(2000)                                     DEFAULT NULL COMMENT '父菜单IDs',
    `icon`               varchar(32)                                       DEFAULT NULL COMMENT '图标',
    `component`          varchar(64)                                       DEFAULT NULL COMMENT 'VUE页面',
    `hidden`             bit(1)                                            DEFAULT b'0' COMMENT '隐藏',
    `iframe`             bit(1)                                            DEFAULT b'0' COMMENT '是否外链',
    `cache`              bit(1)                                            DEFAULT b'0' COMMENT '缓存',
    `leaf`               bit(1)                                            DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `sort`               int                                               DEFAULT '1' COMMENT '排序值',
    `created_by`         varchar(50) NOT NULL,
    `created_date`       timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP (3) COMMENT '创建时间',
    `last_modified_by`   varchar(50)                                       DEFAULT NULL,
    `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '更新时间',
    `description`        varchar(255)                                      DEFAULT NULL COMMENT '描述',
    `version`            int         NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu`
VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', '1', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/log/index', b'0', b'0', b'0', b'1', 30, '1',
        '2019-08-06 07:16:06.000', '1', '2020-05-18 08:54:34.755', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', '2', 'quartz_job_edit', NULL,
        'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-15 01:36:03.602', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('0a160cff2d071eeec3db97f0cb0b30d6', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-26 00:35:47.308', '1', '2020-05-26 01:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('0b934688321b1db735c3bf6ec3e7cdc7', 'test', '2', 'test', 'test', '-1', NULL, 'date', NULL, b'0', b'0', b'0',
        b'1', 999, '1', '2020-05-15 08:47:36.261', '1', '2020-05-16 12:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('0be8161ca1f378dcc23fb786e69859a9', '分布式任务', '1', NULL, 'http://albedo-gateway:5005/xxl-job-admin/', '1000',
        '1000,', 'Steve-Jobs', 'tool/xxljob/index', b'0', b'1', b'0', b'1', 60, '1', '2020-09-20 14:18:06.700', '1',
        '2020-09-20 14:34:41.994', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', '2', 'sys_userOnline_view', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-08 00:05:28.000', '1', '2020-05-17 08:55:59.725', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('1000', '系统管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', b'0', b'0', b'0', 10, '',
        '2018-09-28 23:29:53.000', '1', '2020-09-20 14:34:41.977', NULL, 40, '0');
INSERT INTO `sys_menu`
VALUES ('10bd98f30a42427dd7ef75418ad3da6b', '邮件工具', '1', NULL, 'email', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'email', 'tool/email/index', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-18 08:56:56.008', '1', '2020-05-19 17:17:42.461', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1100', '用户管理', '1', 'sys_user_view', 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', b'0', b'0',
        b'0', 10, '', '2017-11-03 13:24:37.000', '1', '2020-05-20 21:19:27.618', NULL, 16, '0');
INSERT INTO `sys_menu`
VALUES ('1101', '用户编辑', '2', 'sys_user_edit', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2017-11-09 01:52:09.000', '1', '2020-05-20 21:19:27.630', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1102', '用户锁定', '2', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 01:52:48.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1103', '用户删除', '2', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 01:54:01.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', '2', 'quartz_job_view', NULL,
        '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-15 01:35:56.085', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('1200', '菜单管理', '1', 'sys_menu_view', 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', b'0', b'0', b'0',
        40, '', '2017-11-09 01:57:27.000', '1', '2020-05-17 08:56:34.959', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('1201', '菜单编辑', '2', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:15:53.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1202', '菜单锁定', '2', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:16:23.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1203', '菜单删除', '2', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:16:43.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1300', '角色管理', '1', 'sys_role_view', 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', b'0', b'0', b'0',
        20, '', '2017-11-09 02:13:37.000', '1', '2020-05-17 08:56:34.949', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('1301', '角色编辑', '2', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:14:18.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1302', '角色锁定', '2', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:14:41.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1303', '角色删除', '2', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-09 02:14:59.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1304', '角色查看', '2', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2018-04-20 22:22:55.000', '1', '2020-05-16 12:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', '2', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 08:50:46.973', '1', '2020-05-18 01:23:57.541', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('133f1408f5e3187d3e1a00b0260b7165', '字典可用', '2', 'sys_dict_lock', NULL, '2200', '1000,2200,', NULL, NULL, b'0',
        NULL, b'0', b'1', 999, '1', '2020-05-16 08:24:57.559', '1', '2020-05-17 08:55:19.915', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1400', '部门管理', '1', 'sys_dept_view', 'dept', '1000', '1000,', 'dept', 'sys/dept/index', b'0', b'0', b'0', b'0',
        30, '', '2018-01-21 05:17:19.000', '1', '2020-05-17 08:56:34.955', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('1401', '部门编辑', '2', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-21 06:56:16.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1402', '部门锁定', '2', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-21 06:56:59.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1403', '部门删除', '2', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-21 06:57:28.000', NULL, '2020-05-16 12:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('17a713e918513ecd42d3e915d1fc79c1', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2020-05-26 01:15:07.791', '1', '2020-05-30 07:36:27.004', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', '2', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-15 01:36:47.091', '1', '2020-05-17 04:24:22.873',
        NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', '2', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, b'0',
        b'0', b'0', b'1', 10, '1', '2019-08-08 08:27:34.000', '1', '2020-05-16 12:06:35.180', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('1ae562534a64d4473899e52497c40b2e', '二级菜单1', '1', NULL, 'menu1', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu1/index', b'0', b'0', b'0', b'0', 10, '1',
        '2020-05-19 02:10:06.354', '1', '2020-05-26 01:13:50.580', NULL, 9, '0');
INSERT INTO `sys_menu`
VALUES ('2000', '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '',
        '2017-11-08 12:56:00.000', '1', '2020-12-26 10:44:28.702', NULL, 45, '0');
INSERT INTO `sys_menu`
VALUES ('2100', '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0',
        b'0', 40, '', '2017-11-21 06:06:22.000', '1', '2020-05-18 01:23:57.530', NULL, 12, '0');
INSERT INTO `sys_menu`
VALUES ('2101', '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '', '2017-11-21 12:37:37.000', '1', '2020-05-18 01:23:57.545', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('2200', '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0',
        b'0', 50, '', '2017-11-30 03:30:52.000', '1', '2020-05-17 08:56:34.943', NULL, 11, '0');
INSERT INTO `sys_menu`
VALUES ('2201', '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2017-11-30 03:30:11.000', '1', '2020-05-17 08:55:19.918', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('2202', '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-05-12 13:34:55.000', '1', '2020-05-17 04:24:22.800', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('2245134851ecd3537c454ba8a3ef915c', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-26 01:12:05.954', '1', '2020-05-26 01:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '2', 'quartz_jobLog_clean', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 80,
        '1', '2019-08-16 07:12:26.285', '1', '2020-05-17 06:40:21.370', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '1', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96',
        '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 30, '1',
        '2019-07-22 04:27:35.000', '1', '2020-05-19 02:39:42.026', NULL, 21, '0');
INSERT INTO `sys_menu`
VALUES ('2500', '接口文档', '1', NULL, 'http://albedo-gateway:9999/doc.html#/home', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'swagger', 'tool/swagger/index', b'0', b'1', b'0', b'1', 20, '',
        '2018-06-27 01:50:32.000', '1', '2020-09-20 14:33:30.267', NULL, 12, '0');
INSERT INTO `sys_menu`
VALUES ('2600', '令牌管理', '1', NULL, 'persistent-token', '2000', '2000,', 'dev', 'monitor/persistent-token/index', b'1',
        b'0', b'0', b'0', 20, '', '2018-09-04 20:58:41.000', '1', '2020-06-03 20:53:57.431', NULL, 15, '0');
INSERT INTO `sys_menu`
VALUES ('2601', '令牌删除', '2', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 1,
        '', '2018-09-04 20:59:50.000', '1', '2020-06-03 20:53:57.444', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', '2', 'test_testTreeBook_edit', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-12 05:32:06.856', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', '2', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-15 01:36:47.085',
        '1', '2020-05-17 03:10:40.648', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('29fa5859c9418ab919e172b7d21162de', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2020-05-26 01:15:02.872', '1', '2020-05-30 07:36:26.994', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', '2', 'test_testTreeBook_del', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2019-08-12 05:32:06.859', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2c0688c2ad9259b9a7e7088a2f6ade4e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'views/test/test-book/index', b'0', NULL, b'0', b'0', 80, '1', '2020-05-26 00:36:39.119',
        '1', '2020-05-26 01:12:05.946', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', '2', 'quartz_jobLog_del', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 70,
        '1', '2019-08-16 07:12:07.842', '1', '2020-05-17 06:40:08.708', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', '2', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 01:35:56.092', '1', '2020-05-16 12:06:35.180',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', '2', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 01:36:03.606', '1', '2020-05-16 12:06:35.180',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('310c04e534c9af92935c54b4e1357447', 'tes', '1', 'te', 'te', '54cd27f34ca7e9a8848b92377468965d',
        '54cd27f34ca7e9a8848b92377468965d,', 'app', 'te', b'0', b'0', b'0', b'1', 999, '1', '2020-05-15 09:17:11.736',
        '1', '2020-05-16 12:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 30, '1', '2019-08-15 01:35:56.081', '1', '2020-05-16 12:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('32814c16f6d56b0e7249e9b28bc2dcc5', '数据源删除', '2', 'gen_datasourceConf_del', NULL,
        '675dd35e5eba2fd1ced476302c459ac9', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, 'system',
        '2020-09-20 09:11:12.784', 'system', '2020-09-20 09:11:12.784', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', '2', 'quartz_jobLog_export', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 40, '1', '2019-08-15 01:36:42.000', '1', '2020-05-17 04:43:17.758', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', '1', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/configuration/index', b'0', b'0', b'0', b'1', 50, '1',
        '2019-08-06 08:46:50.000', '1', '2020-05-18 08:54:41.694', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', '2', 'sys_logLogin_export', NULL,
        'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, b'0', b'0', b'0', b'1', 40,
        '1', '2019-08-16 00:26:02.000', '1', '2020-05-18 05:55:26.858', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('3716e80de2d2c7cae1e3b247abe314a1', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '66ea0b88495c98d0ca8cbd51c84f9d87', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, 'system',
        '2020-06-07 12:20:23.543', 'system', '2020-06-07 12:20:23.543', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('3956b4690e4f49cfb1e065384c1dc0b9', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        NULL, 'icon-right-square', 'views/test/test-tree-book/index', b'0', NULL, b'0', b'0', 90, '1',
        '2020-05-26 00:35:47.300', '1', '2020-05-26 01:12:00.658', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', '2', 'quartz_jobLog_view', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 20, '1', '2019-08-15 01:36:42.000', '1', '2020-05-17 04:43:17.732', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'codeConsole', 'gen/index', b'0', b'0', b'0', b'0', 10, '1',
        '2019-07-21 03:00:48.000', '1', '2020-09-20 09:28:37.322', NULL, 49, '0');
INSERT INTO `sys_menu`
VALUES ('48ffd1c39241ab2b4c206155bb2ae8b4', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2020-05-26 01:15:07.785', '1', '2020-05-30 07:36:26.964', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('4f5c94e30f3a64e8e1f1bf10e7247e7e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'test/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-05-26 01:15:07.782', '1',
        '2020-05-30 07:36:34.943', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('511c942a5770b6bfa10fbdb3e2fa9d10', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-26 01:12:00.674', '1', '2020-05-26 01:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '2', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-26 04:03:03.000', '1', '2020-05-19 02:39:42.037', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('5404c3df9f771dbc0237578814bbe44b', 'Yaml编辑器', '1', NULL, 'yaml', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1',
        '2020-05-16 12:22:43.364', '1', '2020-05-16 12:22:43.364', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '2', 'sys_logLogin_view', NULL,
        'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-16 00:26:02.349', '1', '2020-05-18 05:55:26.848', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('54cd27f34ca7e9a8848b92377468965d', 'test', '1', 'test', 'tes', '-1', NULL, 'Steve-Jobs', 'tes', b'1', b'0',
        b'1', b'0', 999, '1', '2020-05-15 09:16:52.599', '1', '2020-05-16 12:07:50.836', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('5b39ca5a25c772105c71f8c51d1f19d4', '三级菜单1', '1', NULL, 'menu1-1', '1ae562534a64d4473899e52497c40b2e',
        'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-1', b'0', b'0',
        b'0', b'1', 30, '1', '2020-05-19 02:11:16.436', '1', '2020-05-26 01:13:50.586', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('5d94bc2151ec9572966e5e768824752d', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-26 00:35:47.304', '1', '2020-05-26 01:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '2', 'quartz_jobLog_del', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 80, '1', '2019-08-15 01:36:42.000', '1', '2020-05-17 04:43:17.702', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('618ee4b9660265a85a8b61277de2a579', '富文本', '1', NULL, 'editor', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-16 12:16:40.552', '1', '2020-05-16 12:16:50.233', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '2', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-16 07:10:59.000',
        '1', '2020-05-17 03:11:01.548', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('64b61b8966e1c74d9b309069b2f622d1', '图标库', '1', NULL, 'icons', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1',
        '2020-05-16 12:14:28.945', '1', '2020-05-16 12:15:00.712', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('66ea0b88495c98d0ca8cbd51c84f9d87', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'test/test-book/index', b'0', b'0', b'0', b'0', 30, 'system', '2020-06-07 12:20:23.527',
        'system', '2020-06-07 12:20:23.527', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('675dd35e5eba2fd1ced476302c459ac9', '数据源', '1', NULL, 'datasource-conf', '413892fe8d52c1163d6659f51299dc96',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', 'database', 'gen/datasource-conf/index',
        b'0', b'0', b'0', b'0', 5, 'system', '2020-09-20 09:11:12.765', '1', '2020-09-20 09:27:40.167', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs',
        'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-08 00:03:52.000', '1',
        '2020-05-17 08:55:59.718', NULL, 10, '0');
INSERT INTO `sys_menu`
VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 60, '1', '2019-08-15 01:36:47.081', '1', '2020-05-17 08:56:34.966', NULL, 22, '0');
INSERT INTO `sys_menu`
VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '2', 'quartz_jobLog_view', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 50,
        '1', '2019-08-16 07:11:30.986', '1', '2020-05-17 04:43:44.992', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('7754b1457826c48290bc189bb1289740', '支付宝工具', '1', NULL, 'alipay', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'alipay', 'tool/alipay/index', b'0', b'0', b'0', b'1', 40, '1',
        '2020-05-18 08:58:06.876', '1', '2020-05-19 17:17:53.063', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('795b4d5cf0eb3ed80e24cbab39727b9d', 'Markdown', '1', NULL, 'markdown', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1',
        '2020-05-16 12:21:46.675', '1', '2020-05-16 12:22:53.122', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL,
        b'0', b'0', b'0', b'1', 30, '1', '2019-08-09 00:44:25.617', '1', '2020-06-03 20:53:57.448', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '2', 'quartz_jobLog_clean', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-16 04:55:37.892', '1', '2020-05-17 04:43:17.774', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('84f55c785ae71eb65e7325e148818041', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-26 01:12:00.667', '1', '2020-05-26 01:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('862fa87cbc10766da4de286804e01d13', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2020-05-26 01:15:02.877', '1', '2020-05-30 07:36:26.973', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('86c0be7a1d82ebf1db2678e76a89da32', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '66ea0b88495c98d0ca8cbd51c84f9d87', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, 'system',
        '2020-06-07 12:20:23.535', 'system', '2020-06-07 12:20:23.535', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('8ce9f148e5720ace1b7cf24e0985c47e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'test/test-book/index', b'0', NULL, b'0', b'0', 90, '1', '2020-05-26 01:12:05.950', '1',
        '2020-05-26 01:15:07.779', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '1', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96',
        NULL, 'dev', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-12 05:32:06.849', '1',
        '2020-05-16 12:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '2', 'sys_userOnline_del', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-08 00:06:33.448', '1', '2020-05-17 08:55:59.728', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '2', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', b'0',
        b'0', b'1', 30, '1', '2019-08-08 08:27:59.697', '1', '2020-05-16 12:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '2', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-15 01:36:47.088',
        '1', '2020-05-17 03:11:35.820', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '1', 'gen_table_edit', 'edit', '413892fe8d52c1163d6659f51299dc96',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', NULL, 'gen/table/edit', b'1', b'0', b'0',
        b'1', 20, '1', '2019-07-22 04:24:02.000', '1', '2020-05-19 02:39:42.048', NULL, 10, '0');
INSERT INTO `sys_menu`
VALUES ('9f02e346b5350366968f217daef3f1b7', '图表库', '1', NULL, 'Echarts', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1',
        '2020-05-16 12:12:39.827', '1', '2020-05-16 12:15:09.128', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '1', '', 'table', '413892fe8d52c1163d6659f51299dc96',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', 'list', 'gen/table/index', b'0', b'0',
        b'0', b'0', 10, '1', '2019-07-21 03:02:02.000', '1', '2020-09-20 09:28:37.336', NULL, 24, '0');
INSERT INTO `sys_menu`
VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '1', NULL, 'log-login', '2000', '2000,', 'log',
        'monitor//log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2019-08-16 00:26:02.345', '1',
        '2020-05-18 05:55:36.150', NULL, 8, '1');
INSERT INTO `sys_menu`
VALUES ('afdc5bea209c6e212a152fb1d73ac973', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '66ea0b88495c98d0ca8cbd51c84f9d87', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, 'system',
        '2020-06-07 12:20:23.540', 'system', '2020-06-07 12:20:23.540', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('b6bcb9fa8a3726bfbffb955dc9f56b91', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-26 01:12:05.958', '1', '2020-05-26 01:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('b8eafb6c3a8bf0919230f0bfa59d86b6', '二级菜单2', '1', NULL, 'menu2', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu2/index', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-19 02:14:32.907', '1', '2020-05-19 02:15:14.535', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '2', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-22 04:30:18.000', '1', '2020-05-19 02:39:42.072', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '2', 'quartz_jobLog_export', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 60,
        '1', '2019-08-16 07:13:16.742', '1', '2020-05-17 04:43:54.409', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('ba860cfe687fd01fd492c683907936aa', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2020-05-26 01:15:02.874', '1', '2020-05-30 07:36:27.013', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '2', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 23:47:39.828', '1', '2020-09-20 09:28:37.349', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('bceaa6c321109b9becd91e3eac3647c0', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2020-05-26 01:15:07.788', '1', '2020-05-30 07:36:26.983', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('bd62904371247f56594741ff8e9bded9', '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL,
        b'0', b'0', b'0', b'1', 80, '1', '2019-08-08 08:50:02.000', '1', '2020-05-16 12:06:35.180', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务监控', '1', 'sys_monitor_view', 'http://albedo-gateway:5001', '2000',
        '2000,', 'codeConsole', '', b'0', b'0', b'0', b'1', 40, '1', '2019-08-06 08:21:10.000', '1',
        '2020-12-26 10:40:29.747', NULL, 9, '0');
INSERT INTO `sys_menu`
VALUES ('c206444a1d18c7b505dea8ed5a617669', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'1', b'0',
        80, '1', '2020-05-26 01:12:00.664', '1', '2020-05-26 01:15:02.864', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 30, '1', '2019-08-15 01:36:03.593', '1', '2020-05-16 12:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c7bc1d64972e77c15ed42d5cf21d9ec5', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-26 00:35:47.314', '1', '2020-05-26 01:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c8b84044eac87a2e2ed0e10da9e095d2', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-26 00:36:39.128', '1', '2020-05-26 01:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '1', NULL, 'job-log', '2000', '2000,', 'log',
        'quartz/job-log/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-15 01:36:42.000', '1',
        '2020-05-17 04:43:26.449', NULL, 14, '1');
INSERT INTO `sys_menu`
VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '2', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-08-11 23:48:09.000', '1', '2020-05-19 02:39:42.095', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 08:51:38.454', '1', '2020-05-18 01:23:57.546', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('d4ceb3697e8e2384824ac3093cccb5e0', '数据源编辑', '2', 'gen_datasourceConf_edit', NULL,
        '675dd35e5eba2fd1ced476302c459ac9', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, 'system',
        '2020-09-20 09:11:12.778', 'system', '2020-09-20 09:11:12.778', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('d5642a62bb1dc261baaf7dc883bba7e1', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-26 01:12:05.961', '1', '2020-05-26 01:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '2', 'quartz_job_view', NULL,
        'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-15 01:36:03.598', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('d9d87cf8ed7c29ed2eda06d5dec4dcda', '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0',
        b'0', b'0', b'0', 80, '1', '2020-05-16 11:57:28.521', '1', '2020-05-17 04:38:57.307', NULL, 26, '0');
INSERT INTO `sys_menu`
VALUES ('da5709484a056154e0e89891eea6d6ac', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-26 00:36:39.124', '1', '2020-05-26 01:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('dab11e5104d690be6991002ae4da0cbd', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        NULL, 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1',
        '2020-05-26 01:15:02.868', '1', '2020-05-30 07:36:34.931', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '2', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-08-11 23:55:37.000', '1', '2020-05-19 02:39:42.099', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '2', 'test_testTreeBook_view', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-12 05:32:06.853', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '2', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-22 04:29:14.000', '1', '2020-05-19 02:39:42.102', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '2', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-16 00:26:02.357', '1', '2020-05-18 05:55:26.867',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '2', 'quartz_job_edit', NULL,
        '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-15 01:35:56.089', '1', '2020-05-16 12:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '2', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-22 04:24:45.000', '1', '2020-09-20 09:28:37.353', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('eb17cee437ea6b630dad59fff2a059ca', '多级菜单', '0', NULL, '/nested', '-1', NULL, 'dev', 'Layout', b'0', b'0', b'0',
        b'0', 100, '1', '2020-05-19 02:09:23.393', '1', '2020-05-26 01:13:50.571', NULL, 13, '0');
INSERT INTO `sys_menu`
VALUES ('ef2382c0cc2d99ee73444e684237a88a', '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0',
        b'0', b'0', 30, '1', '2019-08-06 06:58:12.000', '1', '2020-09-20 14:33:30.208', NULL, 50, '0');
INSERT INTO `sys_menu`
VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '2', 'sys_userOnline_logout', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-12 01:57:51.502', '1', '2020-05-17 08:55:59.729', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('f6d6b0be40b21899380fd7983d371c3a', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-26 00:36:39.132', '1', '2020-05-26 01:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('f88f4f338734f70af948d078439980aa', '数据源查看', '2', 'gen_datasourceConf_view', NULL,
        '675dd35e5eba2fd1ced476302c459ac9', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, 'system',
        '2020-09-20 09:11:12.771', 'system', '2020-09-20 09:11:12.771', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('f9ad900ea905f0d388d9d2da66a42aef', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-26 01:12:00.671', '1', '2020-05-26 01:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('fe4c7938e146ec223e99d426aaa87109', '三级菜单2', '1', NULL, 'menu1-2', '1ae562534a64d4473899e52497c40b2e',
        'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-2', b'0', b'0',
        b'0', b'1', 30, '1', '2020-05-19 02:13:18.819', '1', '2020-05-26 01:13:50.588', NULL, 3, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_oauth_client_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_oauth_client_detail`;
CREATE TABLE `sys_oauth_client_detail`
(
    `client_id`               varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端ID',
    `resource_ids`            varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '资源ID',
    `client_secret`           varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '客户端密钥',
    `scope`                   varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '作用域',
    `authorized_grant_types`  varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '授权方式',
    `web_server_redirect_uri` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '重定向地址',
    `authorities`             varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '权限',
    `access_token_validity`   int                                                     DEFAULT NULL COMMENT '请求令牌有效时间',
    `refresh_token_validity`  int                                                     DEFAULT NULL COMMENT '刷新令牌有效时间',
    `additional_information`  varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '扩展信息',
    `autoapprove`             varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  DEFAULT NULL COMMENT '是否自动放行',
    PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='终端信息表';

-- ----------------------------
-- Records of sys_oauth_client_detail
-- ----------------------------
BEGIN;
INSERT INTO `sys_oauth_client_detail`
VALUES ('albedo', NULL, 'albedo', 'server', 'password,refresh_token,authorization_code,client_credentials',
        'http://localhost:4040/sso1/login,http://localhost:4041/sso1/login', NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail`
VALUES ('app', NULL, 'app', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail`
VALUES ('daemon', NULL, 'daemon', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail`
VALUES ('gen', NULL, 'gen', 'server', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
INSERT INTO `sys_oauth_client_detail`
VALUES ('swagger', NULL, 'swagger', 'all', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NOT NULL,
    `name`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NOT NULL COMMENT '名称',
    `level`              int                                                             DEFAULT NULL COMMENT '角色级别',
    `data_scope`         char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `created_date`       timestamp(3)                                           NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci          DEFAULT NULL,
    `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (3),
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci         DEFAULT NULL COMMENT '描述',
    `version`            int                                                    NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role`
VALUES ('1', '超级管理员', 1, '1', '1', '', '2017-10-30 06:45:51.000', '1', '2020-12-26 10:44:18.591', NULL, 76, '0');
INSERT INTO `sys_role`
VALUES ('2', '机构管理员', 2, '2', '1', '', '2018-11-12 11:42:26.000', '1', '2020-05-15 02:01:14.154', NULL, 18, '0');
INSERT INTO `sys_role`
VALUES ('262da20a182dd09e70422cbca05503b7', 'tets', 3, '5', '1', '1', '2020-05-15 02:21:30.869', '1',
        '2020-05-15 02:28:55.628', NULL, 0, '1');
INSERT INTO `sys_role`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '部门管理员', 3, '3', '1', '1', '2020-05-15 02:02:13.389', '1',
        '2020-05-26 02:13:04.474', NULL, 3, '0');
INSERT INTO `sys_role`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '普通管理员', 4, '4', '1', '1', '2020-05-15 02:00:50.813', '1',
        '2020-05-15 02:30:26.577', '普通管理', 6, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`
(
    `id`      varchar(32) NOT NULL,
    `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
    `dept_id` varchar(32) DEFAULT NULL COMMENT '部门ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept`
VALUES ('34481e9777757dd6ffe1c799749b4db5', '2', '5');
INSERT INTO `sys_role_dept`
VALUES ('5c5c58ad79db6edea88100e6491e5e30', '2', '4');
INSERT INTO `sys_role_dept`
VALUES ('64af22db5dbe5cf69de8fa7f2d917922', '2', '3');
INSERT INTO `sys_role_dept`
VALUES ('6df08d485dfd5e6eb79917860e1bee88', '1', '8');
INSERT INTO `sys_role_dept`
VALUES ('c3b5457350bb7a9be8201fa3f88d3c2c', '262da20a182dd09e70422cbca05503b7', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`
(
    `role_id` varchar(32) NOT NULL COMMENT '角色ID',
    `menu_id` varchar(32) NOT NULL COMMENT '菜单ID',
    PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu`
VALUES ('1', '0be8161ca1f378dcc23fb786e69859a9');
INSERT INTO `sys_role_menu`
VALUES ('1', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu`
VALUES ('1', '1000');
INSERT INTO `sys_role_menu`
VALUES ('1', '10bd98f30a42427dd7ef75418ad3da6b');
INSERT INTO `sys_role_menu`
VALUES ('1', '1100');
INSERT INTO `sys_role_menu`
VALUES ('1', '1101');
INSERT INTO `sys_role_menu`
VALUES ('1', '1102');
INSERT INTO `sys_role_menu`
VALUES ('1', '1103');
INSERT INTO `sys_role_menu`
VALUES ('1', '1200');
INSERT INTO `sys_role_menu`
VALUES ('1', '1201');
INSERT INTO `sys_role_menu`
VALUES ('1', '1202');
INSERT INTO `sys_role_menu`
VALUES ('1', '1203');
INSERT INTO `sys_role_menu`
VALUES ('1', '1300');
INSERT INTO `sys_role_menu`
VALUES ('1', '1301');
INSERT INTO `sys_role_menu`
VALUES ('1', '1302');
INSERT INTO `sys_role_menu`
VALUES ('1', '1303');
INSERT INTO `sys_role_menu`
VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu`
VALUES ('1', '133f1408f5e3187d3e1a00b0260b7165');
INSERT INTO `sys_role_menu`
VALUES ('1', '1400');
INSERT INTO `sys_role_menu`
VALUES ('1', '1401');
INSERT INTO `sys_role_menu`
VALUES ('1', '1402');
INSERT INTO `sys_role_menu`
VALUES ('1', '1403');
INSERT INTO `sys_role_menu`
VALUES ('1', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu`
VALUES ('1', '1ae562534a64d4473899e52497c40b2e');
INSERT INTO `sys_role_menu`
VALUES ('1', '2000');
INSERT INTO `sys_role_menu`
VALUES ('1', '2100');
INSERT INTO `sys_role_menu`
VALUES ('1', '2101');
INSERT INTO `sys_role_menu`
VALUES ('1', '2200');
INSERT INTO `sys_role_menu`
VALUES ('1', '2201');
INSERT INTO `sys_role_menu`
VALUES ('1', '2202');
INSERT INTO `sys_role_menu`
VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu`
VALUES ('1', '2500');
INSERT INTO `sys_role_menu`
VALUES ('1', '2600');
INSERT INTO `sys_role_menu`
VALUES ('1', '2601');
INSERT INTO `sys_role_menu`
VALUES ('1', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu`
VALUES ('1', '32814c16f6d56b0e7249e9b28bc2dcc5');
INSERT INTO `sys_role_menu`
VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu`
VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu`
VALUES ('1', '5404c3df9f771dbc0237578814bbe44b');
INSERT INTO `sys_role_menu`
VALUES ('1', '5b39ca5a25c772105c71f8c51d1f19d4');
INSERT INTO `sys_role_menu`
VALUES ('1', '618ee4b9660265a85a8b61277de2a579');
INSERT INTO `sys_role_menu`
VALUES ('1', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu`
VALUES ('1', '64b61b8966e1c74d9b309069b2f622d1');
INSERT INTO `sys_role_menu`
VALUES ('1', '66ea0b88495c98d0ca8cbd51c84f9d87');
INSERT INTO `sys_role_menu`
VALUES ('1', '675dd35e5eba2fd1ced476302c459ac9');
INSERT INTO `sys_role_menu`
VALUES ('1', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu`
VALUES ('1', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu`
VALUES ('1', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu`
VALUES ('1', '7754b1457826c48290bc189bb1289740');
INSERT INTO `sys_role_menu`
VALUES ('1', '795b4d5cf0eb3ed80e24cbab39727b9d');
INSERT INTO `sys_role_menu`
VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu`
VALUES ('1', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu`
VALUES ('1', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu`
VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu`
VALUES ('1', '9f02e346b5350366968f217daef3f1b7');
INSERT INTO `sys_role_menu`
VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b8eafb6c3a8bf0919230f0bfa59d86b6');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu`
VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu`
VALUES ('1', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu`
VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd4ceb3697e8e2384824ac3093cccb5e0');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd9d87cf8ed7c29ed2eda06d5dec4dcda');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu`
VALUES ('1', 'eb17cee437ea6b630dad59fff2a059ca');
INSERT INTO `sys_role_menu`
VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'f88f4f338734f70af948d078439980aa');
INSERT INTO `sys_role_menu`
VALUES ('1', 'fe4c7938e146ec223e99d426aaa87109');
INSERT INTO `sys_role_menu`
VALUES ('2', '1000');
INSERT INTO `sys_role_menu`
VALUES ('2', '1100');
INSERT INTO `sys_role_menu`
VALUES ('2', '1101');
INSERT INTO `sys_role_menu`
VALUES ('2', '1102');
INSERT INTO `sys_role_menu`
VALUES ('2', '1200');
INSERT INTO `sys_role_menu`
VALUES ('2', '1201');
INSERT INTO `sys_role_menu`
VALUES ('2', '1202');
INSERT INTO `sys_role_menu`
VALUES ('2', '1203');
INSERT INTO `sys_role_menu`
VALUES ('2', '1300');
INSERT INTO `sys_role_menu`
VALUES ('2', '1301');
INSERT INTO `sys_role_menu`
VALUES ('2', '1302');
INSERT INTO `sys_role_menu`
VALUES ('2', '1303');
INSERT INTO `sys_role_menu`
VALUES ('2', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu`
VALUES ('2', '1400');
INSERT INTO `sys_role_menu`
VALUES ('2', '1401');
INSERT INTO `sys_role_menu`
VALUES ('2', '1402');
INSERT INTO `sys_role_menu`
VALUES ('2', '1403');
INSERT INTO `sys_role_menu`
VALUES ('2', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu`
VALUES ('2', '2000');
INSERT INTO `sys_role_menu`
VALUES ('2', '2100');
INSERT INTO `sys_role_menu`
VALUES ('2', '2101');
INSERT INTO `sys_role_menu`
VALUES ('2', '2200');
INSERT INTO `sys_role_menu`
VALUES ('2', '2201');
INSERT INTO `sys_role_menu`
VALUES ('2', '2202');
INSERT INTO `sys_role_menu`
VALUES ('2', '2600');
INSERT INTO `sys_role_menu`
VALUES ('2', '2601');
INSERT INTO `sys_role_menu`
VALUES ('2', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu`
VALUES ('2', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu`
VALUES ('2', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu`
VALUES ('2', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu`
VALUES ('2', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu`
VALUES ('2', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu`
VALUES ('2', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu`
VALUES ('2', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu`
VALUES ('2', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1100');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1101');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1102');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1103');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1300');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1301');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1302');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1303');
INSERT INTO `sys_role_menu`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1000');
INSERT INTO `sys_role_menu`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1100');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NOT NULL DEFAULT '1' COMMENT '主键ID',
    `username`           varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NOT NULL COMMENT '用户名',
    `password`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `nickname`           varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT '昵称',
    `phone`              varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT '简介',
    `email`              varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT '邮箱',
    `avatar`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin          DEFAULT NULL COMMENT '头像',
    `dept_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT '部门ID',
    `qq_open_id`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT 'QQ openid',
    `wx_open_id`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin           DEFAULT NULL COMMENT '微信openid',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `created_date`       timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP (3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci          DEFAULT NULL,
    `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci         DEFAULT NULL COMMENT '描述',
    `version`            int                                                    NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin               DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    KEY                  `user_wx_openid` (`wx_open_id`) USING BTREE,
    KEY                  `user_qq_openid` (`qq_open_id`) USING BTREE,
    KEY                  `user_idx1_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user`
VALUES ('1', 'admin', '$2a$10$6z14VGdfVnlWY2K1pvdzJOHkvjLmOuBrJXXeZ0mGIqB60Qd6WYDoC', 'albedo', '17034642999',
        '22@ss.com', '', '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 22:15:18.000', '1',
        '2020-12-26 10:44:13.918', '11', 47, '0');
INSERT INTO `sys_user`
VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', 'test1', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13254642311', '13@qqx.om', NULL, '1', NULL, NULL, '1', '1', '2020-05-13 00:51:46.703', '1',
        '2020-05-30 07:42:57.177', NULL, 6, '0');
INSERT INTO `sys_user`
VALUES ('4c2796f3667e3e5907a04623d7fd8de4', 'ttttt', '$2a$10$KYuAjYBhucUG4GbYQTuRO.YOl6JJlGdEdD5zGLkfrSumnjEF59S7G',
        '1', '13245678975', '1@e.com', '', 'c095173c3aebcd7ff9c6177fbf7a8b69', NULL, NULL, '1', '1',
        '2020-05-30 07:41:21.126', '4c2796f3667e3e5907a04623d7fd8de4', '2020-05-31 18:35:26.113', NULL, 7, '0');
INSERT INTO `sys_user`
VALUES ('5168fcfd16b8bad9fb38edfab4409023', 'www', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL,
        '13258465211', 'qq@ee.com', NULL, '1', NULL, NULL, '1', '1', '2020-05-13 01:22:11.393', '1',
        '2020-05-30 07:42:57.181', NULL, 18, '0');
INSERT INTO `sys_user`
VALUES ('51e995c64ed5982b9ce8ad5d559f100c', 'dddd', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        'dd', '13258465214', '1@1.com', NULL, '1', NULL, NULL, '1', '1', '2020-05-28 18:08:17.639', '1',
        '2020-05-30 07:42:57.184', NULL, 0, '0');
INSERT INTO `sys_user`
VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13258462101', '837158@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-08 05:32:17.000', '1',
        '2020-05-30 07:42:57.186', '11', 26, '0');
INSERT INTO `sys_user`
VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13258462222', 'ww@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-08 05:35:13.000', '1',
        '2020-05-30 07:42:57.187', NULL, 50, '0');
INSERT INTO `sys_user`
VALUES ('db351fa51ba2fb6db590d8d8a673a243', 'test3', '$2a$10$J4IpQRDNuzNWAwKsu3Q/xeH/wtCB.bF3aG1NhVcGTLzxD2975f/y.',
        NULL, '13245632453', '1@13.com', NULL, '1', NULL, NULL, '1', '1', '2020-06-03 22:16:52.382', '1',
        '2020-06-03 22:16:52.382', NULL, 0, '0');
INSERT INTO `sys_user`
VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', 'ttt', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL,
        '13254732131', '2113@ed.bom', NULL, '1', NULL, NULL, '1', '1', '2020-05-13 01:06:21.381', '1',
        '2020-05-30 07:42:57.190', NULL, 1, '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
    `user_id` varchar(32) NOT NULL COMMENT '用户ID',
    `role_id` varchar(32) NOT NULL COMMENT '角色ID',
    PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role`
VALUES ('1', '1');
INSERT INTO `sys_user_role`
VALUES ('1', '2');
INSERT INTO `sys_user_role`
VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', '2');
INSERT INTO `sys_user_role`
VALUES ('4c2796f3667e3e5907a04623d7fd8de4', '2');
INSERT INTO `sys_user_role`
VALUES ('5168fcfd16b8bad9fb38edfab4409023', '2');
INSERT INTO `sys_user_role`
VALUES ('51e995c64ed5982b9ce8ad5d559f100c', '4647a907ad1dd30b28cbdaa229b67fc1');
INSERT INTO `sys_user_role`
VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO `sys_user_role`
VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');
INSERT INTO `sys_user_role`
VALUES ('db351fa51ba2fb6db590d8d8a673a243', '2');
INSERT INTO `sys_user_role`
VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', '2');
COMMIT;

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config`
(
    `id`                      bigint NOT NULL COMMENT 'ID',
    `app_id`                  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '应用ID',
    `charset`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '编码',
    `format`                  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类型 固定格式json',
    `gateway_url`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '网关地址',
    `notify_url`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '异步回调',
    `private_key`             text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '私钥',
    `public_key`              text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '公钥',
    `return_url`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '回调地址',
    `sign_type`               varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签名方式',
    `sys_service_provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付宝配置类';

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
BEGIN;
INSERT INTO `tool_alipay_config`
VALUES (1, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do',
        'http://api.auauz.net/api/aliPay/notify',
        'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==',
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB',
        'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088102176044281');
COMMIT;

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config`
(
    `id`        bigint NOT NULL COMMENT 'ID',
    `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收件人',
    `host`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮件服务器SMTP地址',
    `pass`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
    `port`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '端口',
    `user`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '发件者用户名',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮箱配置';

-- ----------------------------
-- Records of tool_email_config
-- ----------------------------
BEGIN;
COMMIT;

SET
FOREIGN_KEY_CHECKS = 1;
