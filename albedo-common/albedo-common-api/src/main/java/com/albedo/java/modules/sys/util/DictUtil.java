package com.albedo.java.modules.sys.util;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.feign.RemoteDictService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 数据字典工具类 copyright 2014 albedo all right reserved author somewhere created on
 * 2015年1月27日 上午9:52:55
 * @author Li Jie
 */
@Slf4j
public class DictUtil {
	public static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);
	public static RemoteDictService remoteDictService = SpringContextHolder.getBean(RemoteDictService.class);

	public static List<Dict> getDictList() {
		Cache cache = cacheManager.getCache(CacheNameConstants.DICT_DETAILS);
		if (cache != null && cache.get(CacheNameConstants.DICT_ALL) != null) {
			return (List<Dict>) cache.get(CacheNameConstants.DICT_ALL).get();
		}
		try {
			String dictListStr = remoteDictService.findAllOrderBySort(SecurityConstants.FROM_IN).getData();
			if (ObjectUtil.isNotEmpty(dictListStr)) {
				List<Dict> dictList = Json.parseArray(dictListStr, Dict.class);
				cache.put(CacheNameConstants.DICT_ALL, dictList);
				return dictList;
			}
		} catch (Exception e) {
			log.warn("{}", e);
		}
		return null;
	}

	public static List<Dict> getDictListByParentCode(String code) {
		Optional<Dict> first = getDictList().stream().filter(dict -> dict.getCode().equals(code)).findFirst();
		return getDictList().stream().filter(dict -> first.get().getId().equals(dict.getParentId())).collect(Collectors.toList());
	}

	public static Map<String, List<SelectVo>> getSelectResultListByCodes(String... codes) {
		return getSelectResultListByCodes(DictUtil.getDictList(), codes);
	}

	public static Map<String, List<SelectVo>> getSelectResultListByCodes(List<Dict> dictList, String... codes) {
		Map<String, List<SelectVo>> map = Maps.newHashMap();
		if (ObjectUtil.isEmpty(dictList)) {
			return map;
		}
		List<Dict> dictCodes = Lists.newArrayList();
		if (ObjectUtil.isNotEmpty(codes)) {
			for (String codeItem : codes) {
				for (Dict dict : dictList) {
					//命中的数据字段
					if (codeItem.equals(dict.getCode())) {
						dictCodes.add(dict);
						break;
					}
				}
//                if(Globals.UA_SYS_CITY.equals(codeItem)){
//                    map.put(Globals.UA_SYS_CITY, repository.findCitys());
//                }
			}
		} else {
			dictCodes = dictList;
		}
		dictCodes.forEach(dict -> {
			List<SelectVo> dictTempList = getDictList(dictList, dict);
			if (CollUtil.isNotEmpty(dictTempList)) {
				map.put(dict.getCode(), dictTempList);
			}
		});
//        if(!map.containsKey(Globals.UA_SYS_CITY) && PublicUtil.isEmpty(codeList)){
//            map.put(Globals.UA_SYS_CITY, repository.findCitys());
//        }

		return map;
	}

	private static List<SelectVo> getDictList(List<Dict> dictList, Dict dict) {
		List<SelectVo> list = Lists.newLinkedList();
		if (CollUtil.isNotEmpty(dictList)) {
			for (Dict item : dictList) {
				if (CommonConstants.YES.equals(item.getAvailable()) && StringUtil.isNotEmpty(item.getParentId()) && item.getParentId().equals(dict.getId())) {
					list.add(new SelectVo(item.getVal(), item.getName(), item.getVersion()));
				}
			}
		}
		return list;
	}

}
