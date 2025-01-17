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

package com.albedo.java.modules.sys.service;

import com.albedo.java.modules.sys.domain.UserRoleDo;
import com.albedo.java.plugins.database.mybatis.service.BaseService;

/**
 * <p>
 * 用户角色表 服务类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface UserRoleService extends BaseService<UserRoleDo> {

	/**
	 * 根据用户Id删除该用户的角色关系
	 *
	 * @param userId 用户ID
	 * @return boolean
	 * @author 寻欢·李
	 * @date 2017年12月7日 16:31:38
	 */
	Boolean removeRoleByUserId(Long userId);

	/**
	 * 初始化超级管理员角色 权限
	 *
	 * @param userId 用户id
	 * @return 是否正确
	 */
	boolean initAdmin(Long userId);
}
