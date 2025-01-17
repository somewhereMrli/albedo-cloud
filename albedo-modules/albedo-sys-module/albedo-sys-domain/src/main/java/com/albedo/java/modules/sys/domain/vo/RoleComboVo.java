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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.domain.IdDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import lombok.Data;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author somewhere
 * @date 2019/2/1 角色Dto
 */
@Data
public class RoleComboVo implements Serializable {

	private Long id;

	private Integer level;

	private String name;

	public RoleComboVo(RoleDo roleDo) {
		this.id = roleDo.getId();
		this.name = roleDo.getName();
		this.level = roleDo.getLevel();
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		IdDo idEntity = (IdDo) o;
		if (idEntity.getId() == null || getId() == null) {
			return false;
		}
		return Objects.equals(getId(), idEntity.getId());
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(getId());
	}

}
