/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.domain.vo.DataDto;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 业务表Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@Data
@ToString
public class TableDto extends DataDto<String> {

	public static final String F_NAME = "name";

	public static final String F_NAMESANDCOMMENTS = "nameAndTitle";

	public static final String CATEGORY_TREETABLE = "treeTable";

	private static final long serialVersionUID = 1L;

	// 名称
	/*** 编码 */
	@NotBlank
	private String name;

	/*** 描述 */
	private String comments;

	/*** 实体类名称 */
	@NotBlank
	private String className;

	/*** 数据源 */
	@NotBlank
	private String dsName;

	/*** 关联父表 */
	private String parentTable;

	/*** 关联父表外键 */
	private String parentTableFk;

	/*** 父表对象 */
	@JsonIgnore
	private TableDto parent;

	/*** 子表列表 */
	@JsonIgnore
	private List<TableDto> childList;

	private String nameAndTitle;

	/*** 按名称模糊查询 */
	private String nameLike;

	/*** 当前表主键列表 */
	private List<String> pkList;

	private String category;

	/**
	 * 当前表主键列表
	 */
	@JsonIgnore
	private List<TableColumnDto> pkColumnList;

	/*** 列 - 列表 */
	@JsonIgnore
	private List<TableColumnDto> columnList;

	/*** 表单提交列 - 列表 */
	@NotNull
	private List<TableColumnDto> columnFormList;

	public TableDto(String name, String comments) {
		this.name = name;
		this.comments = comments;
	}

	public TableDto() {
	}

	public TableDto(TableFromDto tableFromDto) {
		this.setId(tableFromDto.getId());
		this.setDsName(tableFromDto.getDsName());
		this.name = tableFromDto.getTableName();

	}

	public List<TableColumnDto> getPkColumnList() {
		if (CollUtil.isEmpty(pkColumnList) && CollUtil.isNotEmpty(columnList)) {
			if (pkColumnList == null) {
				pkColumnList = Lists.newArrayList();
			}
			for (TableColumnDto column : getColumnList()) {
				if (column.isPk()) {
					pkColumnList.add(column);
				}
			}
		}
		return pkColumnList;
	}

	public void setPkColumnList(List<TableColumnDto> pkColumnList) {
		this.pkColumnList = pkColumnList;
	}

	@JsonIgnore
	public boolean isCompositeId() {
		List<String> pkList = getPkList();
		return CollUtil.isNotEmpty(pkList) && pkList.size() > 1;
	}

	@JsonIgnore
	public boolean isNotCompositeId() {
		return !isCompositeId();
	}

	@SuppressWarnings("unchecked")
	public List<String> getPkList() {
		if (CollUtil.isEmpty(pkList) && CollUtil.isNotEmpty(getPkColumnList())) {
			pkList = CollUtil.extractToList(getPkColumnList(), "name");
		}
		return pkList;
	}

	public void setPkList(List<String> pkList) {
		this.pkList = pkList;
	}

	public String getNameLike() {
		return nameLike;
	}

	public void setNameLike(String nameLike) {
		this.nameLike = nameLike;
	}

	public List<TableColumnDto> getColumnList() {
		if (columnList == null) {
			columnList = Lists.newArrayList();
		}
		return columnList;
	}

	public void setColumnList(List<TableColumnDto> columnList) {
		this.columnList = columnList;
	}

	/**
	 * 获取列名和说明
	 *
	 * @return
	 */
	public String getNameAndTitle() {
		if (StringUtil.isEmpty(nameAndTitle)) {
			nameAndTitle = getName() + (comments == null ? "" : "  :  " + comments);
		}
		return nameAndTitle;
	}

	public void setNameAndComments(String nameAndTitle) {
		this.nameAndTitle = nameAndTitle;
	}

	public List<TableColumnDto> getColumnFormList() {
		if (CollUtil.isEmpty(columnFormList) && CollUtil.isNotEmpty(columnList)) {
			columnFormList = columnList;
		}
		return columnFormList;
	}

	public void setColumnFormList(List<TableColumnDto> columnFormList) {
		this.columnFormList = columnFormList;
	}

	/**
	 * 获取导入依赖包字符串
	 *
	 * @return
	 */
	@JsonIgnore
	public List<String> getImportList() {
		// 引用列表
		List<String> importList = Lists.newArrayList("com.baomidou.mybatisplus.annotation.*");
		if (CATEGORY_TREETABLE.equalsIgnoreCase(getCategory())) {
			importList.add("com.albedo.java.common.core.domain.TreeDo");
			initImport(importList);
			// 如果有子表，则需要导入List相关引用
			if (getChildList() != null && getChildList().size() > 0) {
				addNoRepeatList(importList, "java.util.List", "com.google.common.collect.Lists",
					"org.hibernate.annotations.FetchMode", "org.hibernate.annotations.Fetch",
					"org.hibernate.annotations.Where");
			}
		} else {
			importList.add("com.albedo.java.common.core.domain.IdDo");
			initImport(importList);
			// 如果有子表，则需要导入List相关引用
			if (getChildList() != null && getChildList().size() > 0) {
				addNoRepeatList(importList, "java.util.List", "com.google.common.collect.Lists");
			}
		}

		return importList;
	}

	private void initImport(List<String> importList) {
		for (TableColumnDto column : getColumnList()) {
			boolean isImport = column.getIsNotBaseField() || column.isQueryField() && "between".equals(column.getQueryType())
				&& (DataDto.F_CREATED_DATE.equals(column.getSimpleJavaField())
				|| DataDto.F_LAST_MODIFIED_DATE.equals(column.getSimpleJavaField()));
			if (isImport) {
				// 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
				if (StringUtil.indexOf(column.getJavaType(), StringUtil.C_DOT) != -1) {
					addNoRepeatList(importList, column.getJavaType());
				}
			}
			if (column.getIsNotBaseField()) {
				// 导入JSR303、Json等依赖包
				for (String ann : column.getAnnotationList()) {
					addNoRepeatList(importList, ann.substring(0, ann.indexOf(StringUtil.BRACKETS_START)));
				}
			}
			if (!column.isPk() && !column.isNullField() && column.getJavaType().endsWith(CommonConstants.TYPE_STRING)) {
				addNoRepeatList(importList, "javax.validation.constraints.NotBlank");
			}
			if (StringUtil.isNotEmpty(column.getDictType())) {
				addNoRepeatList(importList, "com.albedo.java.common.core.annotation.DictType");
			}
			if (column.getName().indexOf("mail") != -1) {
				addNoRepeatList(importList, "javax.validation.constraints.Email");
			}

		}
	}

	private void addNoRepeatList(List<String> list, String... val) {
		if (CollUtil.isNotEmpty(list)) {
			for (String s : val) {
				if (!list.contains(s)) {
					list.add(s);
				}
			}
		}
	}

	/**
	 * 是否存在父类
	 *
	 * @return
	 */
	public Boolean getParentExists() {
		return parent != null && StringUtil.isNotBlank(parentTable) && StringUtil.isNotBlank(parentTableFk);
	}

	@JsonIgnore
	public List<TableDto> getChildList() {
		return childList != null ? childList : Lists.newArrayList();
	}

	/**
	 * 是否存在子类
	 *
	 * @return
	 */
	public Boolean getChildeExists() {
		try {
			return CollUtil.isNotEmpty(childList);
		} catch (Exception e) {
			return false;
		}

	}

	/**
	 * 是否存在create_time列
	 *
	 * @return
	 */
	public Boolean getCreateTimeExists() {
		for (TableColumnDto c : columnList) {
			if ("created_time".equals(c.getName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否存在update_time列
	 *
	 * @return
	 */
	public Boolean getUpdateTimeExists() {
		for (TableColumnDto c : columnList) {
			if ("update_time".equals(c.getName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否存在status列
	 *
	 * @return
	 */
	public Boolean getStatusExists() {
		for (TableColumnDto c : columnList) {
			if ("status".equals(c.getName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 获取主键类型
	 *
	 * @return
	 */
	public String getPkJavaType() {
		String type = "";
		if (isCompositeId()) {
			type = StringUtil.toAppendStr(getClassName(), "Id");
		} else {
			for (TableColumnDto column : getColumnList()) {
				if (column.isPk()) {
					type = column.getJavaType();
					break;
				}
			}
		}
		return type;
	}

	/**
	 * 获取主键sqlname
	 *
	 * @return
	 */
	public String getPkSqlName() {
		String name = "";
		if (isNotCompositeId()) {
			for (TableColumnDto column : getColumnList()) {
				if (column.isPk()) {
					name = column.getName();
					break;
				}
			}
		}
		return name;
	}

	/**
	 * 获取主键sqlname
	 *
	 * @return
	 */
	public String getPkSize() {
		String name = "";
		if (isNotCompositeId()) {
			for (TableColumnDto column : getColumnList()) {
				if (column.isPk()) {
					name = column.getSize();
					break;
				}
			}
		}
		return name;
	}

	/**
	 * 获取主键column
	 *
	 * @return
	 */
	public TableColumnDto getPkColumn() {
		if (isNotCompositeId()) {
			for (TableColumnDto column : getColumnList()) {
				if (column.isPk()) {
					return column;
				}
			}
		}
		return null;
	}

}
