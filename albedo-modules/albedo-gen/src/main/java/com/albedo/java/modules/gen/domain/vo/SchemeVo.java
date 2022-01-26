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

package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.vo.DataVo;
import lombok.*;

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
@EqualsAndHashCode(callSuper = true)
public class SchemeVo extends DataVo<String> {

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
	private String tableName;

}
