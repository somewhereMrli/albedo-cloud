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
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.feign.RemoteMenuService;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Slf4j
@Component
public class RemoteMenuServiceFallbackImpl implements RemoteMenuService {

	@Setter
	private Throwable cause;

	@Override
	public Result<Boolean> saveByGenScheme(GenSchemeDto schemeDto, String from) {
		log.error("feign saveByGenScheme信息失败:{}", schemeDto, cause);
		throw new FeignBizException(cause);
	}
}
