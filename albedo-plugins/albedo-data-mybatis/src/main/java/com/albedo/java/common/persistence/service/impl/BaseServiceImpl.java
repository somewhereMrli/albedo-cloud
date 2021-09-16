/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.common.persistence.service.BaseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Service基类
 *
 * @author somewhere
 * @version 2014-05-16
 */
public abstract class BaseServiceImpl<Repository extends BaseRepository<T>, T> extends ServiceImpl<Repository, T> implements BaseService<T> {
	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());
	@Autowired
	public Repository repository;

}
