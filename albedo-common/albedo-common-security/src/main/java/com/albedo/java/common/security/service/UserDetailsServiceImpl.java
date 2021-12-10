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

package com.albedo.java.common.security.service;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.exception.AccessDeniedException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.enums.DataScopeType;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.feign.RemoteDeptService;
import com.albedo.java.modules.sys.feign.RemoteRoleService;
import com.albedo.java.modules.sys.feign.RemoteUserService;
import com.albedo.java.plugins.database.mybatis.datascope.DataScope;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.CacheManager;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户详细信息
 *
 * @author somowhere
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

	private final RemoteUserService remoteUserService;
	private final RemoteRoleService remoteRoleService;
	private final RemoteDeptService remoteDeptService;
	private final CacheManager cacheManager;

	/**
	 * 用户密码登录
	 *
	 * @param username 用户名
	 * @return
	 */
	@Override
	@SneakyThrows
	public UserDetails loadUserByUsername(String username) {
		UserDetails userDetails = getUserDetails(remoteUserService.getInfo(username, SecurityConstants.FROM_IN).getData());
		return userDetails;
	}

	/**
	 * 构建userdetails
	 *
	 * @param info 用户信息
	 * @return
	 */
	private UserDetails getUserDetails(UserInfo info) {
		if (info == null) {
			throw new UsernameNotFoundException("用户不存在");
		}

		Set<String> dbAuthsSet = new HashSet<>();
		if (ArrayUtil.isNotEmpty(info.getRoles())) {
			// 获取角色
			Arrays.stream(info.getRoles()).forEach(role -> dbAuthsSet.add(SecurityConstants.ROLE + role));
			// 获取资源
			dbAuthsSet.addAll(Arrays.asList(info.getPermissions()));

		}
		Collection<? extends GrantedAuthority> authorities
			= AuthorityUtils.createAuthorityList(dbAuthsSet.toArray(new String[0]));
		UserVo userVo = info.getUser();
		DataScope dataScope = new DataScope();
		dataScope.setUserId(userVo.getId());
		if (CollUtil.isNotEmpty(userVo.getRoleList())) {
			for (Role role : userVo.getRoleList()) {
				if (DataScopeType.ALL.eq(role.getDataScope())) {
					dataScope.setAll(true);
					break;
				} else if (DataScopeType.THIS_LEVEL_CHILDREN.eq(role.getDataScope())) {
					dataScope.getDeptIds().addAll(remoteDeptService.findDescendantIdList(userVo.getDeptId(), SecurityConstants.FROM_IN).getData());
				} else if (DataScopeType.THIS_LEVEL.eq(role.getDataScope())) {
					dataScope.getDeptIds().add(userVo.getDeptId());
				} else if (DataScopeType.SELF.eq(role.getDataScope())) {
					dataScope.setSelf(true);
					dataScope.setUserId(userVo.getId());
				} else if (DataScopeType.CUSTOMIZE.eq(role.getDataScope())) {
					dataScope.getDeptIds().addAll(remoteRoleService.findDeptIdsByRoleId(role.getId(), SecurityConstants.FROM_IN).getData());
				}
			}
		} else {
			throw new AccessDeniedException("没有角色权限");
		}
		// 构造security用户
		return new UserDetail(userVo.getId(), userVo.getDeptId(), userVo.getDeptName(), userVo.getUsername(), SecurityConstants.BCRYPT + userVo.getPassword(),
			userVo.isAvailable(), true, true, true, authorities, dataScope);
	}
}
