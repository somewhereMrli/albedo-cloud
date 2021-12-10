/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
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
public interface JobService extends DataService<Job, JobDto, String> {


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
}
