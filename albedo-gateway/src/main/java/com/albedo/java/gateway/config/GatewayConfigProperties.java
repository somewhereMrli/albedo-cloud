package com.albedo.java.gateway.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;

/**
 * @author somewhere
 * @date 2020/10/4
 * <p>
 * 网关配置文件
 */
@Data
@ConfigurationProperties("application.gateway")
public class GatewayConfigProperties {

	/**
	 * 网关解密登录前端密码 秘钥
	 */
	private String encodeKey;

	/**
	 * 网关不需要校验验证码的客户端
	 */
	private List<String> ignoreClients;

}
