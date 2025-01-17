-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: albedo-config
-- ------------------------------------------------------
-- Server version	8.0.28
DROP DATABASE IF EXISTS `albedo-config`;

CREATE DATABASE  `albedo-config` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `albedo-config`;
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
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
                             `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                             `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                             `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                             `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
                             `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                             `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
                             `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
                             `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
                             `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
                             `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin,
                             `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` VALUES (1,'application-dev.yml','DEFAULT_GROUP','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n    database: 1\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: true\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-auth: auth\n      albedo-sys: sys\n      albedo-gen: gen\n      albedo-file: file','087ea0405b803bb9e3e3cd6557054b91','2019-12-14 10:14:03','2023-02-06 11:41:39','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','通用配置','null','null','yaml','null',''),(2,'application-prod.yml','DEFAULT_GROUP','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: ${application.mysql.driverClassName}\n    username: ${application.mysql.username}\n    password: ${application.mysql.password}\n    url: ${application.mysql.url}\n    dynamic:\n      p6spy: ${application.database.p6spy}\n      seata: ${application.database.isSeata}\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: false\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: ${aplication.swagger.gateway}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-sys-biz: sys\n      albedo-gen: gen','3d8b61be7cc84ab66709cf24c6b37764','2020-09-20 16:51:14','2023-02-06 11:41:51','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(5,'albedo-auth-dev.yml','DEFAULT_GROUP','logging:\n  level:\n    ROOT: INFO\n# 数据源\nspring:\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n    suffix: .ftl\n    template-loader-path: classpath:/templates/\n','bd555b846c04c59e006a9f29172537e9','2019-12-13 17:53:57','2022-06-09 10:49:10','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','null','null','null','yaml','null',''),(6,'albedo-auth-prod.yml','DEFAULT_GROUP','# 数据源\nspring:\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n    suffix: .ftl\n    template-loader-path: classpath:/templates/\n','5f2ff1bf723e8dde67147bfa61d9abd1','2020-09-20 16:52:24','2022-06-09 11:06:38','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(7,'albedo-gateway-dev.yml','DEFAULT_GROUP','spring:\n  cloud:\n    gateway:\n      locator:\n        enabled: true\n      routes:\n        # 认证中心\n        - id: albedo-auth\n          uri: lb://albedo-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeGatewayFilter\n            # 前端密码解密\n            - PasswordDecoderFilter\n        #系统管理 模块\n        - id: albedo-sys\n          uri: lb://albedo-sys\n          predicates:\n            - Path=/sys/**\n          filters:\n            # 限流配置\n            - name: RequestRateLimiter\n              args:\n                key-resolver: \'#{@remoteAddrKeyResolver}\'\n                redis-rate-limiter.replenishRate: 100\n                redis-rate-limiter.burstCapacity: 200\n        # 代码生成模块\n        - id: albedo-gen\n          uri: lb://albedo-gen\n          predicates:\n            - Path=/gen/**\n        # 文件调度模块\n        - id: albedo-file\n          uri: lb://albedo-file\n          predicates:\n            - Path=/file/**\n        \n        # 固定路由转发配置 无修改\n        - id: openapi\n          uri: lb://albedo-gateway\n          predicates:\n            - Path=/v3/api-docs/**\n          filters:\n            - RewritePath=/v3/api-docs/(?<path>.*), /$\\{path}/$\\{path}/v3/api-docs\n\napplication:\n  gateway:\n    encode-key: \'somewhere-albedo\'\n    ignore-clients:\n      - test\n      - client\n','b0a2f710ced8d41c2230f66eaddd3f2e','2019-12-13 17:54:26','2022-06-09 14:05:38','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','null','null','null','yaml','null',''),(8,'albedo-gateway-prod.yml','DEFAULT_GROUP','spring:\n  cloud:\n    gateway:\n      locator:\n        enabled: true\n      routes:\n        # 认证中心\n        - id: albedo-auth\n          uri: lb://albedo-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeGatewayFilter\n            # 前端密码解密\n            - PasswordDecoderFilter\n        #系统管理 模块\n        - id: albedo-sys-server\n          uri: lb://albedo-sys-server\n          predicates:\n            - Path=/sys/**\n          filters:\n            # 限流配置\n            - name: RequestRateLimiter\n              args:\n                key-resolver: \'#{@remoteAddrKeyResolver}\'\n                redis-rate-limiter.replenishRate: 100\n                redis-rate-limiter.burstCapacity: 200\n        # 代码生成模块\n        - id: albedo-gen\n          uri: lb://albedo-gen\n          predicates:\n            - Path=/gen/**\n        # 文件模块\n        - id: albedo-file-server\n          uri: lb://albedo-file-server\n          predicates:\n            - Path=/file/**\n\napplication:\n  gateway:\n    encode-key: \'somewhere-albedo\'\n    ignore-clients:\n      - test\n  swagger:\n    ignore-providers:\n      - albedo-auth\n      - albedo-gen\n','93ee32ac41e4f48fc9232d58759206a8','2020-09-20 16:52:59','2022-01-26 15:16:50','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(9,'albedo-sys-dev.yml','DEFAULT_GROUP','security:\n  oauth2:\n    client:\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\n      scope: server\n    # 通用放行URL，服务个性化，请在对应配置文件覆盖\n    ignore:\n      urls:\n        - /v3/api-docs      \n        - /actuator/**\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n','43e66f0d1d46365e3df8e300c3f388ef','2019-12-13 17:56:02','2022-06-20 16:43:55','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','null','null','null','yaml','null',''),(10,'albedo-sys-prod.yml','DEFAULT_GROUP','dubbo:\n  cloud:\n    # The subscribed services in consumer side\n    subscribed-services: albedo-auth\n# 直接放行URL\nignore:\n  urls:\n    - /v2/**\n    - /actuator/**\n    - /user/info/*\n    - /menu/gen\n    - /dict/all\n    - /log-operate/\nsecurity:\n  oauth2:\n    client:\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\n      scope: server\n\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true\n\n\n\n','fe3498bba491b92b445d721e2f3d7062','2019-12-13 17:56:30','2021-12-31 11:41:20','nacos','127.0.0.1','','7372cf74-38e6-4887-b026-b4018fb48dc0','null','null','null','yaml','null',''),(15,'albedo-gen-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: ENC(FGKBtFgGcI+XAg5c+7EAJg==)\n      client-secret: ENC(PE5+ODGIk7rfbiaZXHVhow==)\n      scope: server\n\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-gen?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n\n','6aade78821c2c26c17a1a4af4bfe4c29','2019-12-13 17:54:43','2022-06-09 14:48:40','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(16,'albedo-gen-prod.yml','DEFAULT_GROUP','spring:\n  cloud:\n    gateway:\n      locator:\n        enabled: true\n      routes:\n        # 认证中心\n        - id: albedo-auth\n          uri: lb://albedo-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - ValidateCodeGatewayFilter\n            # 前端密码解密\n            - PasswordDecoderFilter\n        #系统管理 模块\n        - id: albedo-sys\n          uri: lb://albedo-sys\n          predicates:\n            - Path=/sys/**\n          filters:\n            # 限流配置\n            - name: RequestRateLimiter\n              args:\n                key-resolver: \'#{@remoteAddrKeyResolver}\'\n                redis-rate-limiter.replenishRate: 100\n                redis-rate-limiter.burstCapacity: 200\n        # 代码生成模块\n        - id: albedo-gen\n          uri: lb://albedo-gen\n          predicates:\n            - Path=/gen/**\n        # 任务调度模块\n        - id: albedo-quartz\n          uri: lb://albedo-quartz\n          predicates:\n            - Path=/quartz/**\n        # 文件模块\n        - id: albedo-file\n          uri: lb://albedo-file\n          predicates:\n            - Path=/file/**\n\napplication:\n  gateway:\n    encode-key: \'somewhere-albedo\'\n    ignore-clients:\n      - test\n\n  swagger:\n    ignore-providers:\n      - albedo-auth\n      - albedo-gen\n      - swagger\n','1c69c3a0a35548896ce6f58a4384a7e1','2020-09-20 16:53:22','2021-12-15 14:01:03','nacos','127.0.0.1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(20,'albedo-monitor-dev.yml','DEFAULT_GROUP','spring:\r\n  # 安全配置\r\n  security:\r\n    user:\r\n      name: ENC(ToJTk3p6JF+h0gsHeHVRoQ==)     # albedo\r\n      password: ENC(sGfB6KY7Zq0BTfwbWYxnWw==) # albedo\r\n','c9e2b0633b44d33b37beb14a7f3dc501','2019-12-13 17:54:58','2019-12-13 17:54:58',NULL,'0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0',NULL,NULL,NULL,'yaml',NULL,''),(21,'albedo-monitor-prod.yml','DEFAULT_GROUP','spring:\n  # 安全配置\n  security:\n    user:\n      name: ENC(ToJTk3p6JF+h0gsHeHVRoQ==)     # albedo\n      password: ENC(sGfB6KY7Zq0BTfwbWYxnWw==) # albedo\n','a71b77b1b47f810aed0dc5756faeacb6','2020-09-20 16:53:49','2020-09-20 16:53:49',NULL,'0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0',NULL,NULL,NULL,'yaml',NULL,''),(30,'albedo-quartz-dev.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: ENC(FGKBtFgGcI+XAg5c+7EAJg==)\n      client-secret: ENC(PE5+ODGIk7rfbiaZXHVhow==)\n      scope: server\n\n# 数据源配置\nspring:\n  resources:\n    static-locations: classpath:/static/,classpath:/views/\n\napplication:\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    database: albedo-quartz\n    username: root\n    password: 111111\n    url: jdbc:mysql://${application.mysql.ip}:${application.mysql.port}/${application.mysql.database}?serverTimezone=Asia/Shanghai&characterEncoding=utf8&useUnicode=true&useSSL=false&autoReconnect=true&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n  \n\n','eb3c3b00fc32e376cef2c9ffb70abb30','2019-12-13 17:55:19','2021-12-15 13:42:49','nacos','127.0.0.1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(31,'albedo-quartz-prod.yml','DEFAULT_GROUP','## spring security 配置\nsecurity:\n  oauth2:\n    client:\n      client-id: ENC(FGKBtFgGcI+XAg5c+7EAJg==)\n      client-secret: ENC(PE5+ODGIk7rfbiaZXHVhow==)\n      scope: server\n\n# 数据源配置\nspring:\n  resources:\n    static-locations: classpath:/static/,classpath:/views/\n\napplication:\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    database: albedo-quartz\n    username: root\n    password: 111111\n    url: jdbc:mysql://${application.mysql.ip}:${application.mysql.port}/${application.mysql.database}?serverTimezone=Asia/Shanghai&characterEncoding=utf8&useUnicode=true&useSSL=false&autoReconnect=true&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n  \n\n','eb3c3b00fc32e376cef2c9ffb70abb30','2020-09-20 16:54:17','2021-12-15 13:42:15','nacos','127.0.0.1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(40,'albedo-file-dev.yml','DEFAULT_GROUP','security:\n  oauth2:\n    client:\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\n      scope: server\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\napplication:\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n','4afd1a782e0722f601838ee9afb32be1','2021-12-15 13:35:45','2022-06-10 09:38:09','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(105,'albedo-tenant-dev.yml','DEFAULT_GROUP','security:\n  oauth2:\n    client:\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\n      scope: server\n\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n','46385d6e39e75639fbde0736777d7731','2021-12-31 11:24:03','2022-06-10 10:10:58','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','',''),(119,'albedo-sys-server-dev.yml','DEFAULT_GROUP','security:\n  oauth2:\n    client:\n      client-id: ENC(WJRDLZlPlWkmLu/d+gkeAw==)\n      client-secret: ENC(gyOtaeY+fxP8/Rkd3PKm8Q==)\n      scope: server\n    # 通用放行URL，服务个性化，请在对应配置文件覆盖\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n        - /user/info/*\n        - /menu/gen\n        - /dict/all\n        - /log-operate\n# 数据源\nspring:\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n    url: jdbc:mysql://albedo-mysql:3306/albedo-cloud?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&allowMultiQueries=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true\n','ae49c47537fcf2b9bcb0d94389c59ec8','2022-06-09 15:07:51','2022-06-09 15:08:06','nacos','0:0:0:0:0:0:0:1','','7372cf74-38e6-4887-b026-b4018fb48dc0','','','','yaml','','');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` VALUES (1,34,'application-dev.yml','DEFAULT_GROUP','','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    ROOT: DEBUG\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n    database: 1\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n# spring security 配置\nsecurity:\n  oauth2:\n    # 通用放行URL，服务个性化，请在对应配置文件覆盖\n    ignore:\n      urls:\n        - /v3/api-docs\n        - /actuator/**\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: true\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-auth: auth\n      albedo-sys: sys\n      albedo-gen: gen\n      albedo-file: file','7365c7af38b066fceb2b55b040c4cc90','2023-02-01 17:44:39','2023-02-01 17:44:40','nacos','0:0:0:0:0:0:0:1','U','7372cf74-38e6-4887-b026-b4018fb48dc0',''),(2,35,'application-prod.yml','DEFAULT_GROUP','','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    ROOT: INFO\n    com.albedo.java: DEBUG\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: ${application.mysql.driverClassName}\n    username: ${application.mysql.username}\n    password: ${application.mysql.password}\n    url: ${application.mysql.url}\n    dynamic:\n      p6spy: ${application.database.p6spy}\n      seata: ${application.database.isSeata}\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n# spring security 配置\nsecurity:\n  oauth2:\n    # 通用放行URL，服务个性化，请在对应配置文件覆盖\n    ignore:\n      urls:\n        - /v2/api-docs\n        - /actuator/**\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: false\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: ${aplication.swagger.gateway}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-sys-biz: sys\n      albedo-gen: gen','63118e4e80b57ae8ca8c1fa2efedd768','2023-02-01 17:45:14','2023-02-01 17:45:15','nacos','0:0:0:0:0:0:0:1','U','7372cf74-38e6-4887-b026-b4018fb48dc0',''),(1,36,'application-dev.yml','DEFAULT_GROUP','','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    ROOT: DEBUG\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n    database: 1\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n# spring security 配置\nsecurity:\n  oauth2:\n    # 通用放行URL，服务个性化，请在对应配置文件覆盖\n    ignore:\n      urls:\n        - /v3/api-docs\n        - /actuator/**\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: true\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-auth: auth\n      albedo-sys: sys\n      albedo-gen: gen\n      albedo-file: file','ef431b648c63d96441dd909b8d21d2f6','2023-02-03 17:05:52','2023-02-03 17:05:52','nacos','0:0:0:0:0:0:0:1','U','7372cf74-38e6-4887-b026-b4018fb48dc0',''),(1,37,'application-dev.yml','DEFAULT_GROUP','','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    ROOT: DEBUG\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n    database: 1\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: true\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-auth: auth\n      albedo-sys: sys\n      albedo-gen: gen\n      albedo-file: file','fc852f689edabaf12e790c921d3ade18','2023-02-06 11:41:39','2023-02-06 11:41:39','nacos','0:0:0:0:0:0:0:1','U','7372cf74-38e6-4887-b026-b4018fb48dc0',''),(2,38,'application-prod.yml','DEFAULT_GROUP','','# 加解密根密码\njasypt:\n  encryptor:\n    password: albedo #根密码\n\nlogging:\n  config: classpath:logback-spring.xml\n  level:\n    ROOT: INFO\n    com.albedo.java: DEBUG\n    com.albedo.java.plugins.database.interceptor.TenantLineInnerInterceptor: INFO\n# Spring 相关\nspring:\n  cache:\n    type: redis\n  redis:\n    host: albedo-redis\n  datasource:\n    type: com.zaxxer.hikari.HikariDataSource\n    driver-class-name: ${application.mysql.driverClassName}\n    username: ${application.mysql.username}\n    password: ${application.mysql.password}\n    url: ${application.mysql.url}\n    dynamic:\n      p6spy: ${application.database.p6spy}\n      seata: ${application.database.isSeata}\n  cloud:\n    sentinel:\n      eager: true\n      transport:\n        dashboard: albedo-sentinel:8858\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \' *\'\n  endpoint:\n    health:\n      show-details: always\n  logfile:\n    enabled: true\n\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n      useGzipDecoder: true\n\n# mybaits-plus配置\nmybatis-plus:\n  mapper-locations: classpath*:/mapper/*/*Mapper.xml\n  global-config:\n    banner: false\n    db-config:\n      id-type: input\n      insert-strategy: NOT_NULL\n      update-strategy: NOT_NULL\n      table-underline: true\n      logic-delete-value: 1\n      logic-not-delete-value: 0\n  configuration:\n    map-underscore-to-camel-case: true\n    default-enum-type-handler: com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler\n\n\n# ===================================================================\n# Albedo specific properties\n# ===================================================================\n\napplication:\n  developMode: true\n  logPath: logs\n  rabbitmq:\n    enabled: false\n    ip: albedo-mysql\n    port: 5672\n    username: albedo\n    password: albedo\n  mysql:\n    ip: albedo-mysql\n    port: 3306\n    driverClassName: com.mysql.cj.jdbc.Driver\n    username: root\n    password: 111111\n  database:\n    tenantDatabasePrefix: albedo-cloud-base\n    multiTenantType: DATASOURCE_COLUMN\n    tenantIdColumn: tenant_code\n    ignore-tables:\n      - sys_tenant\n    ignore-mapper-ids:\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTableColumnList\n      - com.albedo.java.modules.gen.repository.TableRepository.findTablePk\n    isNotWrite: false\n    p6spy: true\n    isBlockAttack: false  # 是否启用 攻击 SQL 阻断解析器\n    isSeata: false\n    id-type: HU_TOOL\n    hutoolId:\n      workerId: 0\n      dataCenterId: 0\n    cache-id:\n      time-bits: 31\n      worker-bits: 22\n      seq-bits: 10\n      epochStr: \'2020 -\n        09 - 15\'\n      boost-power: 3\n      padding-factor: 50\n  file:\n    storageType: LOCAL #  FAST_DFS LOCAL MIN_IO ALI_OSS HUAWEI_OSS QINIU_OSS\n    delFile: false\n    local:\n      storage-path: D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\     # 文件存储路径 ~/data/projects/uploadfile/file/  （ 某些版本的 window 需要改成  D:\\\\data\\\\projects\\\\uploadfile\\\\file\\\\  ）\n      endpoint: http://127.0.0.1/file/   # 文件访问 （部署nginx后，配置nginx的ip，并配置nginx静态代理storage-path地址的静态资源）\n      inner-uri-prefix: null  #  内网的url前缀\n    ali:\n      # 请填写自己的阿里云存储配置\n      uriPrefix: \"http://albedo-admin-cloud.oss-cn-beijing.aliyuncs.com/\"\n      bucket-name: \"albedo-admin-cloud\"\n      endpoint: \"oss-cn-beijing.aliyuncs.com\"\n      access-key-id: \"填写你的id\"\n      access-key-secret: \"填写你的秘钥\"\n    minIo:\n      endpoint: \"http://127.0.0.1:9000/\"\n      accessKey: \"aledo\"\n      secretKey: \"aledo\"\n      bucket: \"dev\"\n    huawei:\n      uriPrefix: \"dev.obs.cn-southwest-2.myhuaweicloud.com\"\n      endpoint: \"obs.cn-southwest-2.myhuaweicloud.com\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      location: \"cn-southwest-2\"\n      bucket: \"dev\"\n    qiNiu:\n      zone: \"z0\"\n      accessKey: \"1\"\n      secretKey: \"2\"\n      bucket: \"albedo_admin\"\n#密码加密传输，前端公钥加密，后端私钥解密\n  rsa:\n    public-key: MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAN4UOrkIuLpL0o7WItgIUkP/RFBsurMPQ7fTaOKwT+S9tWly0xMmJzSl9Kdh8MpWcyz+5nUSb7SgGWxiE3qIL2sCAwEAAQ==\n    private-key: MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEA3hQ6uQi4ukvSjtYi2AhSQ/9EUGy6sw9Dt9No4rBP5L21aXLTEyYnNKX0p2HwylZzLP7mdRJvtKAZbGITeogvawIDAQABAkBnojsRE//Yd/+nRkh2VdPGBX5kpYiufKYWR6K/fpWZ4QrASv5sIuD2Cqfp5e8K6fZ4DW/CSUMKGq6Vq6xZVeLJAiEA/BazblQTEeGFsQydEmaBA1CWupPOAFO2xg7c/5s1sI8CIQDhhlRtXfjqcUWhj4Um1t8pFBkFHiN8RC1hufaZs9OJZQIgEuLogoWOADLzPzaAthYz6DmrcUMNlfyvntsSN5w7Q4UCIQCu7raAWvsgRxqe1iePV+6j+33o1VbrJisZedkJok48bQIgWVX940QICkAUhYRJgX9uj7oWOAyE1V8ambte6SHBHhs=\n  cors: #By default CORS are not enabled. Uncomment to enable.\n    allowed-origins: \"*\"\n    allowed-methods: \"*\"\n    allowed-headers: \"*\"\n    exposed-headers: \"Authorization,Link,X-Total-Count\"\n    allow-credentials: true\n    max-age: 1800\n  swagger:\n    enabled: false\n    title: Albedo Swagger API\n    license: Powered By somewhere\n    licenseUrl: https://github.com/somowhere\n    terms-of-service-url: https://github.com/somowhere\n    contact:\n      email: somewhere0813@gmail.com\n      url: https://github.com/somowhere\n    gateway: http://${GATEWAY_HOST:albedo-gateway}:${GATEWAY-PORT:9999}\n    token-url: ${aplication.swagger.gateway}/auth/oauth2/token\n    scope: server\n    services:\n      albedo-sys-biz: sys\n      albedo-gen: gen','3cf0a32ab556937d698c48afd15362fb','2023-02-06 11:41:51','2023-02-06 11:41:51','nacos','0:0:0:0:0:0:0:1','U','7372cf74-38e6-4887-b026-b4018fb48dc0','');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
INSERT INTO `tenant_info` VALUES (1,'1','7372cf74-38e6-4887-b026-b4018fb48dc0','albedo-cloud','albedo-cloud','nacos',1640236263415,1640236263415);
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-06 14:59:43
