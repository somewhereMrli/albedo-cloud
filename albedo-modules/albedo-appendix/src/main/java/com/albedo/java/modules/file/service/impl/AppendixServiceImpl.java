package com.albedo.java.modules.file.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.domain.IdDo;
import com.albedo.java.common.core.domain.vo.AppendixDto;
import com.albedo.java.common.core.domain.vo.AppendixVo;
import com.albedo.java.common.core.domain.vo.EchoVo;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.modules.file.domain.AppendixDo;
import com.albedo.java.modules.file.repository.AppendixRepository;
import com.albedo.java.modules.file.service.AppendixService;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.conditions.query.LbqWrapper;
import com.albedo.java.plugins.database.mybatis.service.impl.DataServiceImpl;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Multimap;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 业务实现类
 * 业务附件
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
@Slf4j
@Service

@Transactional(readOnly = true)
public class AppendixServiceImpl extends DataServiceImpl<AppendixRepository, AppendixDo, AppendixDto> implements AppendixService {


	@Override
	@Transactional(readOnly = true)
	public <T extends IdDo<T, Long> & EchoVo> void echoAppendix(IPage<T> page, String... bizTypes) {
		if (page == null) {
			return;
		}
		echoAppendix(page.getRecords(), bizTypes);
	}

	@Override
	public <T extends IdDo<T, Long> & EchoVo> void echoAppendix(List<T> list, String... bizTypes) {
		if (CollUtil.isEmpty(list)) {
			return;
		}
		List<Long> ids = list.stream().map(IdDo::getId).collect(Collectors.toList());

		Multimap<AppendixService.AppendixBizKey, AppendixVo> map = listByBizIds(ids, bizTypes);

		Set<String> bizTypeSet = CollUtil.newHashSet();
		map.forEach((biz, item) -> bizTypeSet.add(biz.getBizType()));

		list.forEach(item -> {
			bizTypeSet.forEach(bizType -> {
				Collection<AppendixVo> colls = map.get(buildBiz(item.getId(), bizType));
				item.getEchoMap().put(bizType, colls);
			});
		});
	}

	@Override
	@Transactional(readOnly = true)
	public Multimap<AppendixBizKey, AppendixVo> listByBizId(Long bizId, String... bizType) {
		ArgumentAssert.notNull(bizId, "请传入业务id");
		LbqWrapper<AppendixDo> wrap = Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId).in(AppendixDo::getBizType, bizType);
		List<AppendixDo> list = list(wrap);
		return MapHelper.iterableToMultiMap(list,
			item -> AppendixBizKey.builder().bizId(item.getBizId()).bizType(item.getBizType()).build(),
			item -> BeanUtil.toBean(item, AppendixVo.class));
	}

	@Override
	@Transactional(readOnly = true)
	public Multimap<AppendixBizKey, AppendixVo> listByBizIds(List<Long> bizIds, String... bizType) {
		ArgumentAssert.notEmpty(bizIds, "请传入业务id");
		LbqWrapper<AppendixDo> wrap = Wraps.<AppendixDo>lbQ().in(AppendixDo::getBizId, bizIds).in(AppendixDo::getBizType, bizType);
		List<AppendixDo> list = list(wrap);
		return MapHelper.iterableToMultiMap(list,
			item -> AppendixBizKey.builder().bizId(item.getBizId()).bizType(item.getBizType()).build(),
			item -> BeanUtil.toBean(item, AppendixVo.class));
	}

	@Override
	@Transactional(readOnly = true)
	public List<AppendixVo> listByBizIdAndBizType(Long bizId, String bizType) {
		ArgumentAssert.notNull(bizId, "请传入业务id");
		LbqWrapper<AppendixDo> wrap = Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId)
			.eq(AppendixDo::getBizType, bizType);
		return BeanUtil.toBeanList(list(wrap), AppendixVo.class);
	}

	@Override
	@Transactional(readOnly = true)
	public AppendixVo getByBiz(Long bizId, String bizType) {
		ArgumentAssert.notNull(bizId, "请传入业务id");
		ArgumentAssert.notEmpty(bizType, "请传入功能点");
		LbqWrapper<AppendixDo> wrap = Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId)
			.eq(AppendixDo::getBizType, bizType);
		List<AppendixDo> list = list(wrap);
		if (CollUtil.isEmpty(list)) {
			return null;
		}
		return BeanUtil.toBean(list.get(0), AppendixVo.class);
	}


	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean save(Long bizId, AppendixDto saveVo) {
		if (bizId != null) {
			remove(Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId));
		}
		if (saveVo == null) {
			return true;
		}
		AppendixDo commonFile = BeanUtil.toBean(saveVo, AppendixDo.class);
		commonFile.setBizId(bizId);
		save(commonFile);
		return true;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean save(Long bizId, List<AppendixDto> list) {
		if (bizId != null) {
			remove(Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId));
		}
		if (CollUtil.isEmpty(list)) {
			return false;
		}
		List<AppendixDo> commonFiles = BeanUtil.toBeanList(list, AppendixDo.class);
		commonFiles.forEach(item -> item.setBizId(bizId));
		saveBatch(commonFiles);
		return true;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean save(Long bizId, String bizType, List<AppendixDto> list) {
		removeByBizId(bizId, bizType);
		if (CollUtil.isEmpty(list)) {
			return false;
		}
		List<AppendixDo> commonFiles = BeanUtil.toBeanList(list, AppendixDo.class);
		commonFiles.forEach(item -> {
			item.setBizId(bizId);
			item.setBizType(bizType);
		});
		saveBatch(commonFiles);
		return true;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByBizId(List<Long> objectIds) {
		if (CollUtil.isEmpty(objectIds)) {
			return false;
		}
		return remove(Wraps.<AppendixDo>lbQ().in(AppendixDo::getBizId, objectIds));
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByBizId(Long... objectIds) {
		if (ArrayUtil.isEmpty(objectIds)) {
			return false;
		}
		return remove(Wraps.<AppendixDo>lbQ().in(AppendixDo::getBizId, objectIds));
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByBizId(Long bizId, String bizType) {
		ArgumentAssert.isFalse(bizId == null && StrUtil.isEmpty(bizType), "请传入对象id或功能点");
		return remove(Wraps.<AppendixDo>lbQ().eq(AppendixDo::getBizId, bizId).eq(AppendixDo::getBizType, bizType));
	}

}
