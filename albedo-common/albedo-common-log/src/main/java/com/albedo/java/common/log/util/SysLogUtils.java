/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.log.util;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.URLUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.RequestHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.modules.sys.domain.LogOperate;
import lombok.experimental.UtilityClass;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;

/**
 * 系统日志工具类
 *
 * @author somewhere
 */
@UtilityClass
public class SysLogUtils {

	public LogOperate getSysLogOperate() {
		HttpServletRequest request = RequestHolder.getHttpServletRequest();
		LogOperate logOperate = new LogOperate();
		logOperate.setCreatedBy(getUserId());
		logOperate.setCreatedDate(LocalDateTime.now());
		logOperate.setUsername(getUsername());
		logOperate.setIpAddress(WebUtil.getIp(request));
		logOperate.setIpLocation(AddressUtil.getRegion(logOperate.getIpAddress()));
		logOperate.setUserAgent(request.getHeader(HttpHeaders.USER_AGENT));
		UserAgent userAgent = UserAgentUtil.parse(logOperate.getUserAgent());
		logOperate.setBrowser(userAgent.getBrowser().getName());
		logOperate.setOs(userAgent.getOs().getName());
		logOperate.setRequestUri(URLUtil.getPath(request.getRequestURI()));
		return logOperate;
	}

	public LogLogin getSysLogLogin() {
		HttpServletRequest request = RequestHolder.getHttpServletRequest();
		String userAgentStr = request.getHeader(HttpHeaders.USER_AGENT);
		UserAgent userAgent = UserAgentUtil.parse(userAgentStr);
		String tempIp = WebUtil.getIp(request);
		return LogLogin.builder()
			.ipAddress(tempIp)
			.ipLocation(AddressUtil.getRegion(tempIp))
			.username(getUsername())
			.createdBy(getUserId())
			.createdDate(LocalDateTime.now())
			.loginDate(LocalDateTimeUtil.format(LocalDateTime.now(), DatePattern.NORM_DATE_FORMATTER))
			.userAgent(userAgentStr)
			.browser(userAgent.getBrowser().getName())
			.os(userAgent.getOs().getName())
			.requestUri(URLUtil.getPath(request.getRequestURI())).build();
	}

	/**
	 * 获取用户名称
	 *
	 * @return username
	 */
	private String getUsername() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null) {
			return null;
		}
		return authentication.getName();
	}

	/**
	 * 获取用户Id
	 *
	 * @return userId
	 */
	private Long getUserId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || authentication.getPrincipal() == null) {
			return null;
		}
		return (Long) ReflectUtil.getFieldValue(authentication.getPrincipal(), "id");
	}

}
