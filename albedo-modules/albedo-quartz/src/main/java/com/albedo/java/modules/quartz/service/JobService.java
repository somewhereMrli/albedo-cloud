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

package com.albedo.java.modules.quartz.service;

import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.dto.JobDto;
import com.albedo.java.plugins.database.mybatis.service.DataService;

import java.util.Set;

/**
 * 任务调度Service 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
public interface JobService extends DataService<Job, JobDto> {

	/**
	 * 暂停任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int pauseJob(Job job);

	/**
	 * 恢复任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int resumeJob(Job job);

	/**
	 * 删除任务后，所对应的trigger也将被删除
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int deleteJob(Job job);

	/**
	 * 批量删除调度信息
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	void deleteJobByIds(Set<String> ids);

	/**
	 * 任务调度状态修改
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int changeStatus(Job job);

	/**
	 * 立即运行任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	void run(Job job);

	/**
	 * 校验cron表达式是否有效
	 *
	 * @param cronExpression 表达式
	 * @return 结果
	 */
	boolean checkCronExpressionIsValid(String cronExpression);

	/**
	 * updateStatus
	 *
	 * @param idList
	 * @throws
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	void updateStatus(Set<String> idList);

	/**
	 * concurrent
	 *
	 * @param idList
	 * @throws
	 * @author somewhere
	 * @updateTime 2020/5/31 17:32
	 */
	void concurrent(Set<String> idList);

	/**
	 * runByIds
	 *
	 * @param idList
	 * @throws
	 * @author somewhere
	 * @updateTime 2020/5/31 17:32
	 */
	void runByIds(Set<String> idList);

	/**
	 * runByIds
	 *
	 * @param idList
	 * @throws
	 * @author somewhere
	 * @updateTime 2020/5/31 17:32
	 */
	void runBySubIds(Set<String> idList);

}
