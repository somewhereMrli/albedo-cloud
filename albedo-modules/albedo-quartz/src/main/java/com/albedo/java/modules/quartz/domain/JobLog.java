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

package com.albedo.java.modules.quartz.domain;

import com.albedo.java.common.core.basic.domain.GeneralEntity;
import com.albedo.java.modules.quartz.domain.enums.JobLogStatus;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 任务调度日志Entity 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@TableName(value = "sys_job_log")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class JobLog extends GeneralEntity<JobLog> {

	/**
	 * F_JOBNAME job_name : 任务名称
	 */
	public static final String F_JOBNAME = "jobName";

	/**
	 * F_SQL_JOBNAME job_name : 任务名称
	 */
	public static final String F_SQL_JOBNAME = "job_name";

	/**
	 * F_JOBGROUP job_group : 任务组名
	 */
	public static final String F_JOBGROUP = "jobGroup";

	/**
	 * F_SQL_JOBGROUP job_group : 任务组名
	 */
	public static final String F_SQL_JOBGROUP = "job_group";

	/**
	 * F_INVOKETARGET invoke_target : 调用目标字符串
	 */
	public static final String F_INVOKETARGET = "invokeTarget";

	/**
	 * F_SQL_INVOKETARGET invoke_target : 调用目标字符串
	 */
	public static final String F_SQL_INVOKETARGET = "invoke_target";

	/**
	 * F_JOBMESSAGE job_message : 日志信息
	 */
	public static final String F_JOBMESSAGE = "jobMessage";

	/**
	 * F_SQL_JOBMESSAGE job_message : 日志信息
	 */
	public static final String F_SQL_JOBMESSAGE = "job_message";

	/**
	 * F_STATUS status : 执行状态（1正常 1失败）
	 */
	public static final String F_STATUS = "status";

	/**
	 * F_SQL_STATUS status : 执行状态（1正常 1失败）
	 */
	public static final String F_SQL_STATUS = "status";

	/**
	 * F_STARTTIME start_time : 开始时间
	 */
	public static final String F_STARTTIME = "startTime";

	/**
	 * F_SQL_STARTTIME start_time : 开始时间
	 */
	public static final String F_SQL_STARTTIME = "start_time";

	/**
	 * F_ENDTIME end_time : 结束时间
	 */
	public static final String F_ENDTIME = "endTime";

	/**
	 * F_SQL_ENDTIME end_time : 结束时间
	 */
	public static final String F_SQL_ENDTIME = "end_time";

	/**
	 * F_CREATETIME create_time : 创建时间
	 */
	public static final String F_CREATETIME = "createdDate";

	/**
	 * F_SQL_CREATETIME create_time : 创建时间
	 */
	public static final String F_SQL_CREATETIME = "create_time";

	/**
	 * F_EXCEPTIONINFO exception_info : 异常信息
	 */
	public static final String F_EXCEPTIONINFO = "exceptionInfo";

	/**
	 * F_SQL_EXCEPTIONINFO exception_info : 异常信息
	 */
	public static final String F_SQL_EXCEPTIONINFO = "exception_info";

	private static final long serialVersionUID = 1L;

	@TableId(value = GeneralEntity.F_SQL_ID, type = IdType.AUTO)
	protected Long id;

	@TableField(GeneralEntity.F_SQL_DESCRIPTION)
	protected String description;

	/**
	 * jobName 任务名称
	 */
	@NotBlank
	@Size(max = 64)
	@TableField(F_SQL_JOBNAME)
	private String jobName;

	/**
	 * jobGroup 任务组名
	 */
	@NotBlank
	@Size(max = 64)
	@TableField(F_SQL_JOBGROUP)
	private String jobGroup;

	/**
	 * cronExpression cron执行表达式
	 */
	@Size(max = 255)
	@TableField("cron_expression")
	private String cronExpression;

	/**
	 * invokeTarget 调用目标字符串
	 */
	@NotBlank
	@Size(max = 500)
	@TableField(F_SQL_INVOKETARGET)
	private String invokeTarget;

	/**
	 * jobMessage 日志信息
	 */
	@Size(max = 500)
	@TableField(F_SQL_JOBMESSAGE)
	private String jobMessage;

	/**
	 * status 执行状态(成功/失败)
	 */
	@Size(max = 1)
	@TableField("status")
	private JobLogStatus status;

	/**
	 * startTime 开始时间
	 */
	@TableField("start_time")
	private Date startTime;

	/**
	 * endTime 结束时间
	 */
	@TableField("end_time")
	private Date endTime;

	/**
	 * createdDate 创建时间
	 */
	@TableField("create_time")
	private Date createdDate;

	/**
	 * exceptionInfo 异常信息
	 */
	@Size(max = 3000)
	@TableField("exception_info")
	private String exceptionInfo;

	@Override
	public boolean equals(Object o) {
		return super.equals(o);
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}

}
