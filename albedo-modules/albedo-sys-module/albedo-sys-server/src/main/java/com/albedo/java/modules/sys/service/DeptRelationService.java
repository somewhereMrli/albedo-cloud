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

import com.albedo.java.modules.sys.domain.DeptRelationDo;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.plugins.database.mybatis.service.BaseService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface DeptRelationService extends BaseService<DeptRelationDo> {

	/**
	 * 新建部门关系
	 *
	 * @param deptDto 部门
	 */
	void saveDeptRelation(DeptDto deptDto);

	/**
	 * 通过ID删除部门关系
	 *
	 * @param id
	 */
	void removeDeptRelationById(Long id);

	/**
	 * 更新部门关系
	 *
	 * @param relation
	 */
	void updateDeptRelation(DeptRelationDo relation);

}
