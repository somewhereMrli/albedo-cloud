/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.gen.domain.dto;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.DataDto;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;

/**
 * 生成方案Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class SchemeDto extends DataDto<String> {

	/**
	 * @Fields CATEGORY_CURD : 增删改查（单表）
	 */
	public static final String CATEGORY_CURD = "curd";

	/**
	 * @Fields CATEGORY_CURD_MANY : 增删改查（一对多）
	 */
	public static final String CATEGORY_CURD_MANY = "curd_many";

	/**
	 * @Fields CATEGORY_SERVICE : 仅持久层（common/domain）
	 */
	public static final String CATEGORY_SERVICE = "common";

	/**
	 * @Fields CATEGORY_CURD : 数据层（domain）
	 */
	public static final String CATEGORY_ENITY = "domain";

	/**
	 * @Fields CATEGORY_CURD : 树结构表（一体）
	 */
	public static final String CATEGORY_TREETABLE = "treeTable";

	private static final long serialVersionUID = 1L;

	/**
	 * 名称
	 */
	private String name;

	/**
	 * 分类
	 */
	private String category;

	/**
	 * 视图类型 弹窗视图0 普通表格 1
	 */
	private Integer viewType;

	/**
	 * 生成包路径
	 */
	private String packageName;

	/**
	 * 生成模块名
	 */
	private String moduleName;

	/**
	 * 生成子模块名
	 */
	private String subModuleName;

	/**
	 * 生成功能名
	 */
	private String functionName;

	/**
	 * 生成功能名（简写）
	 */
	private String functionNameSimple;

	/**
	 * 生成功能作者
	 */
	private String functionAuthor;

	/**
	 * 业务表名
	 */
	@NotEmpty
	private String tableId;

	/**
	 * 业务表名
	 */
	private TableDto tableDto;

	@JsonIgnore
	/**
	 * flase：保存方案； ture：保存方案并生成代码
	 */
	private Boolean genCode = false;

	@JsonIgnore
	/**
	 * 是否替换现有文件 true：替换文件 ；false：不替换；
	 */
	private Boolean replaceFile = false;

	/**
	 * true 使用弹窗视图
	 *
	 * @return
	 */
	public boolean getModalView() {
		return CommonConstants.YES.equals(viewType);
	}

}
