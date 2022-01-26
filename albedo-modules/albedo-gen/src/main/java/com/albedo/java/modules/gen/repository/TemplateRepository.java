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

package com.albedo.java.modules.gen.repository;

import com.albedo.java.modules.gen.domain.Template;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the Authority domain.
 *
 * @author somewhere
 */
@Repository
public interface TemplateRepository extends BaseRepository<Template> {

}
