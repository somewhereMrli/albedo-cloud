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

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.security.annotation.Inner;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.modules.sys.domain.dto.LogOperateQueryCriteria;
import com.albedo.java.modules.sys.service.LogOperateService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.google.common.collect.Lists;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Set;

/**
 * <p>
 * 操作日志表 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@AllArgsConstructor
@RequestMapping("/log-operate")
public class LogOperateResource {
	private final LogOperateService logOperateService;

	/**
	 * 插入日志
	 *
	 * @param logOperate 日志实体
	 * @return
	 */
	@Inner
	@PostMapping
	public Result<IPage> save(@Valid @RequestBody com.albedo.java.modules.sys.domain.LogOperate logOperate) {
		return Result.buildOkData(logOperateService.save(logOperate));
	}

	/**
	 * 简单分页查询
	 *
	 * @param pm 分页对象
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_logOperate_view')")
	public Result<IPage> getPage(PageModel pm, LogOperateQueryCriteria logOperateQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, logOperateQueryCriteria);
		return Result.buildOkData(logOperateService.page(pm, wrapper));
	}

	/**
	 * 删除操作日志
	 *
	 * @param ids ID
	 * @return success/false
	 */
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_logOperate_del')")
	@LogOperate(value = "操作日志删除")
	public Result removeById(@RequestBody Set<String> ids) {
		return Result.buildOkData(logOperateService.removeByIds(ids));
	}


	@LogOperate(value = "操作日志导出")
	@GetMapping(value = "/download")
	@PreAuthorize("@pms.hasPermission('sys_logOperate_export')")
	public void download(LogOperateQueryCriteria logOperateQueryCriteria, HttpServletResponse response) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(logOperateQueryCriteria);
		ExcelUtil<com.albedo.java.modules.sys.domain.LogOperate> util = new ExcelUtil(com.albedo.java.modules.sys.domain.LogOperate.class);
		util.exportExcel(logOperateService.list(wrapper), "操作日志", response);
	}

	@GetMapping(value = "/user")
	@ApiOperation("用户日志查询")
	public Result<Object> getUserLogs(PageModel pm, LogOperateQueryCriteria criteria) {
		criteria.setLogType(Lists.newArrayList(LogType.INFO.name(), LogType.WARN.name()));
		criteria.setUsername(SecurityUtil.getUser().getUsername());
		pm.addOrder(OrderItem.desc(com.albedo.java.modules.sys.domain.LogOperate.F_SQL_CREATED_DATE));
		QueryWrapper<com.albedo.java.modules.sys.domain.LogOperate> wrapper = QueryWrapperUtil.<com.albedo.java.modules.sys.domain.LogOperate>getWrapper(pm, criteria);

		return Result.buildOkData(logOperateService.page(pm, wrapper));
	}

}
