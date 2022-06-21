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

package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.modules.gen.domain.SchemeDo;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeGenDto;
import com.albedo.java.modules.gen.domain.dto.SchemeQueryCriteria;
import com.albedo.java.modules.gen.domain.vo.SchemeFormDataVo;
import com.albedo.java.plugins.database.mybatis.service.DataCacheService;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
public interface SchemeService extends DataCacheService<SchemeDo, SchemeDto> {

	/**
	 * findAllListIdNot
	 *
	 * @param id
	 * @return java.util.List<com.albedo.java.modules.gen.domain.Scheme>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	List<SchemeDo> findAllListIdNot(String id);

	/**
	 * generateCode
	 *
	 * @param schemeDto
	 * @return java.lang.String
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	String generateCode(SchemeDto schemeDto);

	/**
	 * findFormData
	 *
	 * @param schemeDto
	 * @param loginId
	 * @return java.util.Map<java.lang.String, java.lang.Object>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	SchemeFormDataVo findFormData(SchemeDto schemeDto, String loginId);

	/**
	 * getSchemeVoPage 分页查询用户信息（含有角色信息）
	 *
	 * @param pageModel
	 * @param schemeQueryCriteria
	 * @return com.baomidou.mybatisplus.core.metadata.IPage
	 * @author somewhere
	 * @updateTime 2020/5/31 17:38
	 */
	IPage getSchemeVoPage(PageModel pageModel, SchemeQueryCriteria schemeQueryCriteria);

	/**
	 * previewCode
	 *
	 * @param id
	 * @param username
	 * @return java.util.Map<java.lang.String, java.lang.Object>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	Map<String, Object> previewCode(String id, String username);

	SchemeDto genMenu(SchemeGenDto schemeGenDto);
}
