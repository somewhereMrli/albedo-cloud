/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.util;

import com.albedo.java.common.core.constant.CommonConstants;
import org.springframework.boot.SpringApplication;
import org.springframework.core.env.Environment;

import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * Utility class to load a Spring profile to be used as default when there is no
 * <code>spring.profiles.active</code> set in the environment or as command line argument.
 * If the value is not available in <code>application.yml</code> then <code>dev</code>
 * profile will be used as default.
 *
 * @author somewhere
 */
public final class DefaultProfileUtil {

	public static final String SPRING_PROFILE_DEFAULT = "spring.profiles.default";

	public static final String SPRING_WEB_ROOT_PREFIX = "spring.web.root.prefix";

	private DefaultProfileUtil() {
	}

	/**
	 * Resolve path prefix to static resources.
	 */
	public static String resolvePathPrefix(Class<?> clz) {
		String fullExecutablePath = clz.getResource("").getPath();
		String rootPath = Paths.get(StringUtil.DOT).toUri().normalize().getPath();
		String extractedPath = fullExecutablePath.replace(rootPath, "");
		int extractionEndIndex = extractedPath.indexOf("target/");
		if (extractionEndIndex <= 0) {
			return "";
		}
		return extractedPath.substring(0, extractionEndIndex);
	}

	/**
	 * Set a default to use when no profile is configured.
	 *
	 * @param app the spring application
	 */
	public static void addDefaultProfile(SpringApplication app) {

		Map<String, Object> defProperties = new HashMap<>(100);
		/*
		 * The default profile to use when no other profiles are defined This cannot be
		 * set in the <code>application.yml</code> file. See
		 * https://github.com/spring-projects/spring-boot/issues/1219
		 */
		defProperties.put(SPRING_PROFILE_DEFAULT, CommonConstants.SPRING_PROFILE_DEVELOPMENT);

		if (!app.getSources().isEmpty()) {
			defProperties.put(SPRING_WEB_ROOT_PREFIX,
				DefaultProfileUtil.resolvePathPrefix((Class<?>) app.getSources().toArray()[0]));

		}

		app.setDefaultProperties(defProperties);
	}

	/**
	 * Get the profiles that are applied else get default profiles.
	 */
	public static String[] getActiveProfiles(Environment env) {
		String[] profiles = env.getActiveProfiles();
		if (profiles.length == 0) {
			return env.getDefaultProfiles();
		}
		return profiles;
	}

}
