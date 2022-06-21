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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.modules.sys.domain.UserOnlineDo;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.albedo.java.modules.sys.repository.UserOnlineRepository;
import com.albedo.java.modules.sys.service.UserOnlineService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * <p>
 * token 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@Slf4j
public class UserOnlineServiceImpl extends BaseServiceImpl<UserOnlineRepository, UserOnlineDo>
	implements UserOnlineService {

	@Override
	public void deleteBySessionId(String sessionId) {
		repository.deleteById(sessionId);
	}

	@Override
	public void offlineBySessionId(String sessionId) {
		UserOnlineDo userOnlineDo = getById(sessionId);
		if (userOnlineDo != null) {
			userOnlineDo.setStatus(OnlineStatus.OFFLINE);
			repository.updateById(userOnlineDo);
		}
	}

	@Override
	public void saveByEvent(UserOnlineDo userOnlineDo) {
		this.remove(Wrappers.<UserOnlineDo>lambdaQuery().eq(UserOnlineDo::getUserId, userOnlineDo.getUserId()).or()
			.eq(UserOnlineDo::getSessionId, userOnlineDo.getSessionId()));
		saveOrUpdate(userOnlineDo);
	}

	@Override
	public void reset() {

	}

}
