package com.albedo.java.modules.tenant.strategy.impl;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.modules.tenant.domain.dto.TenantConnectDto;
import com.albedo.java.modules.tenant.repository.InitDbRepository;
import com.albedo.java.modules.tenant.strategy.InitSystemStrategy;
import com.albedo.java.plugins.database.properties.DatabaseProperties;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.util.Arrays;
import java.util.List;


/**
 * 初始化系统
 * <p>
 * 初始化规则：
 *
 * @author somewhere
 * @date 2019/10/25
 */
@Service("SCHEMA")
@Slf4j
@RequiredArgsConstructor
public class SchemaInitSystemStrategy implements InitSystemStrategy {
	/**
	 * 需要初始化的sql文件在classpath中的路径
	 */
	private static final String SQL_RESOURCE_PATH = "sqls/%s.sql";

	/**
	 * 需要初始化的库
	 * 可能不同的服务，会连接不同的库
	 */
	private static final List<String> INIT_DATABASE_LIST = Arrays.asList(CommonConstants.BASE_DATABASE);

	private final DataSource dataSource;
	private final InitDbRepository initDbMapper;
	private final DatabaseProperties databaseProperties;

	@Value("${application.mysql.database}")
	private String defaultDatabase;


	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean initConnect(TenantConnectDto tenantConnect) {
		String tenant = tenantConnect.getTenant();
		this.initDatabases(tenant);
		ScriptRunner runner = this.getScriptRunner();
		this.initTables(runner, tenant);
		this.initData(runner, tenant);
		// 切换为默认数据源
		this.resetDatabase(runner);

		return true;
	}

	@Override
	public boolean reset(String tenant) {
		ScriptRunner runner;
		try {
			runner = getScriptRunner();

			String tenantDatabasePrefix = databaseProperties.getTenantDatabasePrefix();

			useDb(tenant, runner, tenantDatabasePrefix);
			String dataScript = tenantDatabasePrefix + "_" + tenant;
			runner.runScript(Resources.getResourceAsReader(String.format(SQL_RESOURCE_PATH, dataScript)));
		} catch (Exception e) {
			log.error("重置数据失败", e);
			return false;
		}
		return true;
	}


	public void initDatabases(String tenant) {
		INIT_DATABASE_LIST.forEach((database) -> this.initDbMapper.createDatabase(StrUtil.join(StrUtil.UNDERLINE, database, tenant)));
	}

	public void initTables(ScriptRunner runner, String tenant) {
		try {
			for (String database : INIT_DATABASE_LIST) {
				this.useDb(tenant, runner, database);
				runner.runScript(Resources.getResourceAsReader(String.format(SQL_RESOURCE_PATH, database)));
			}
		} catch (Exception e) {
			log.error("初始化表失败", e);
			throw new BizException("初始化表失败", e);
		}
	}

	/**
	 * 角色表
	 * 菜单表
	 * 资源表
	 *
	 * @param tenant 租户编码
	 */
	public void initData(ScriptRunner runner, String tenant) {
		try {
			for (String database : INIT_DATABASE_LIST) {
				this.useDb(tenant, runner, database);
				String dataScript = database + "_data";
				runner.runScript(Resources.getResourceAsReader(String.format(SQL_RESOURCE_PATH, dataScript)));
			}
		} catch (Exception e) {
			log.error("初始化数据失败", e);
			throw new BizException("初始化数据失败", e);
		}
	}

	public void resetDatabase(ScriptRunner runner) {
		try {
			runner.runScript(new StringReader(StrUtil.format("use {};", this.defaultDatabase)));
		} catch (Exception e) {
			log.error("切换为默认数据源失败", e);
			throw new BizException("切换为默认数据源失败", e);
		}
	}

	public String useDb(String tenant, ScriptRunner runner, String database) {
		String db = StrUtil.join(StrUtil.UNDERLINE, database, tenant);
		runner.runScript(new StringReader(StrUtil.format("use {};", db)));
		return db;
	}

	@SuppressWarnings("AlibabaRemoveCommentedCode")
	public ScriptRunner getScriptRunner() {
		try {
			Connection connection = this.dataSource.getConnection();
			ScriptRunner runner = new ScriptRunner(connection);
			runner.setAutoCommit(false);
			//遇见错误是否停止
			runner.setStopOnError(true);
			/*
			 * 按照那种方式执行 方式一：true则获取整个脚本并执行； 方式二：false则按照自定义的分隔符每行执行；
			 */
			runner.setSendFullScript(true);
			// 设置是否输出日志，null不输出日志，不设置自动将日志输出到控制台
			// runner.setLogWriter(null);

			Resources.setCharset(StandardCharsets.UTF_8);

//            设置分隔符 runner.setDelimiter(";");
			runner.setFullLineDelimiter(false);
			return runner;
		} catch (Exception ex) {
			throw new BizException("获取连接失败", ex);
		}
	}


	@Override
	public boolean delete(List<Long> ids, List<String> tenantCodeList) {
		if (tenantCodeList.isEmpty()) {
			return true;
		}

		INIT_DATABASE_LIST.forEach(prefix -> tenantCodeList.forEach(tenant -> {
			String database = prefix + StrPool.UNDERSCORE + tenant;
			initDbMapper.dropDatabase(database);
		}));

		return true;
	}
}
