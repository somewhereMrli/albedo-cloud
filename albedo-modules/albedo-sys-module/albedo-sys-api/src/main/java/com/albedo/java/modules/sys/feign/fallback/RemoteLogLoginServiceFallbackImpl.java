/*
 *
 *  *  Copyright (c) 2019-2021, somewhere (somewhere0813@gmail.com).
 *  *  <p>
 *  *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  *  you may not use this file except in compliance with the License.
 *  *  You may obtain a copy of the License at
 *  *  <p>
 *  * https://www.gnu.org/licenses/lgpl.html
 *  *  <p>
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *
 */

package com.albedo.java.modules.sys.feign.fallback;

import com.albedo.java.common.core.exception.FeignBizException;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.modules.sys.domain.LogLoginDo;
import com.albedo.java.modules.sys.feign.RemoteLogLoginService;
import lombok.Setter;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Slf4j
@Component
public class RemoteLogLoginServiceFallbackImpl implements RemoteLogLoginService {

	@Setter
	private Throwable cause;

	/**
	 * 保存日志
	 *
	 * @param logLoginDo 日志实体
	 * @param from       内部调用标志
	 * @return succes、false
	 */
	@SneakyThrows
	@Override
	public Result<Boolean> save(LogLoginDo logLoginDo, String from) {
		log.error("feign 插入日志失败", cause);
		throw new FeignBizException(cause);
	}

}
