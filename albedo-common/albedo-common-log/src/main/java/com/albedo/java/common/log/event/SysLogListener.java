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

package com.albedo.java.common.log.event;

import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.AddressUtils;
import com.albedo.java.modules.sys.domain.LogOperate;
import com.albedo.java.modules.sys.feign.RemoteLogOperateService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;


/**
 * @author somowhere
 * 异步监听日志事件
 */
@Slf4j
@AllArgsConstructor
public class SysLogListener {
	private final RemoteLogOperateService remoteLogOperateService;

	@Async
	@Order
	@EventListener(SysLogEvent.class)
	public void saveSysLog(SysLogEvent event) {
		if (log.isTraceEnabled()) {
			log.trace("{}", event);
		}
		LogOperate logOperate = (LogOperate) event.getSource();
		logOperate.setIpLocation(AddressUtils.getRealAddressByIp(logOperate.getIpAddress()));
		remoteLogOperateService.save(logOperate, SecurityConstants.FROM_IN);
	}
}
