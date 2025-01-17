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

package com.albedo.java.modules.tool.feign.factory;

import com.albedo.java.modules.tool.feign.RemoteEmailService;
import com.albedo.java.modules.tool.feign.fallback.RemoteEmailServiceFallbackImpl;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Component
public class RemoteEmailServiceFallbackFactory implements FallbackFactory<RemoteEmailService> {

	@Override
	public RemoteEmailService create(Throwable throwable) {
		RemoteEmailServiceFallbackImpl remoteEmailServiceFallback = new RemoteEmailServiceFallbackImpl();
		remoteEmailServiceFallback.setCause(throwable);
		return remoteEmailServiceFallback;
	}

}
