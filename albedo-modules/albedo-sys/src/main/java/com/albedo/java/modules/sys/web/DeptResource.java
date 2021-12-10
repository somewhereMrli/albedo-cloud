/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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
package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.plugins.database.mybatis.datascope.DataScope;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 部门管理 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@RequestMapping("/dept")
@AllArgsConstructor
public class DeptResource extends BaseResource {

	private final DeptService deptService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_dept_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return Result.buildOkData(deptService.getOneDto(id));
	}


	/**
	 * 返回当前部门树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public Result tree(DeptQueryCriteria deptQueryCriteria) {
		DataScope dataScope = SecurityUtil.getDataScope();
		if (!dataScope.isAll()) {
			deptQueryCriteria.setDeptIds(dataScope.getDeptIds());
		}
		return Result.buildOkData(deptService.findTreeNode(deptQueryCriteria));
	}

	/**
	 * 部门树列表信息
	 *
	 * @return 分页对象
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_view')")
	@LogOperate(value = "部门管理查看")
	public Result<IPage<DeptVo>> findTreeList(DeptQueryCriteria deptQueryCriteria) {
		DataScope dataScope = SecurityUtil.getDataScope();
		if (!dataScope.isAll()) {
			deptQueryCriteria.setDeptIds(dataScope.getDeptIds());
		}
		return Result.buildOkData(deptService.findTreeList(deptQueryCriteria));
	}

	/**
	 * 添加
	 *
	 * @param deptDto 实体
	 * @return success/false
	 */
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_edit')")
	@LogOperate(value = "部门管理编辑")
	public Result save(@Valid @RequestBody DeptDto deptDto) {
		deptService.saveOrUpdate(deptDto);
		return Result.buildOk("操作成功");
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@LogOperate(value = "用户管理锁定/解锁")
	@PreAuthorize("@pms.hasPermission('sys_dept_lock')")
	public Result lockOrUnLock(@RequestBody Set<Long> ids) {
		deptService.lockOrUnLock(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * 删除
	 *
	 * @param ids ID
	 * @return success/false
	 */
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_del')")
	@LogOperate(value = "部门管理删除")
	public Result removeById(@RequestBody Set<Long> ids) {
		return Result.buildByFlag(deptService.removeByIds(ids));
	}


	/**
	 * 删除
	 *
	 * @param deptId ID
	 * @return success/false
	 */
	@Inner
	@GetMapping("/descendant-ids/{deptId}")
	public Result<List<String>> findDescendantIdList(@PathVariable("deptId") Long deptId) {
		return Result.buildOkData(deptService.findDescendantIdList(deptId));
	}
}
