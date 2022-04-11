/*
 *  Copyright (c) 2019-2020, somowhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules;


import com.albedo.java.common.config.annotation.EnableAlbedoSwagger2;
import com.albedo.java.common.feign.annotation.EnableAlbedoFeignClients;
import com.albedo.java.common.security.annotation.EnableAlbedoResourceServer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import java.net.InetAddress;

/**
 * @author somowhere
 * @date 2018年06月21日
 * 文件系统
 */
@EnableAlbedoSwagger2
@EnableAlbedoResourceServer
@EnableAlbedoFeignClients
@EnableDiscoveryClient
@SpringBootApplication
@Slf4j
public class AlbedoFileServerApplication {
	static String SERVER_PORT = "server.port";
	static String SPRING_APPLICATION_NAME = "spring.application.name";
	static String APPLICATION_VERSION = "application.version";

	public static void main(String[] args) throws Exception {
		SpringApplication app = new SpringApplication(AlbedoFileServerApplication.class);
		final ApplicationContext applicationContext = app.run(args);
		Environment env = applicationContext.getEnvironment();
		log.info(
			"\n----------------------------------------------------------\n\t"
				+ "Application '{} v{}' is running! Access URLs:\n\t" + "Local: \t\thttp://localhost:{}\n\t"
				+ "Doc: \t\thttp://localhost:{}/doc.html\n\t"
				+ "External: \thttp://{}:{}\n\t"
				+ "\n----------------------------------------------------------",
			env.getProperty(SPRING_APPLICATION_NAME), env.getProperty(APPLICATION_VERSION), env.getProperty(SERVER_PORT), env.getProperty(SERVER_PORT),
			InetAddress.getLocalHost().getHostAddress(), env.getProperty(SERVER_PORT));
	}
}
