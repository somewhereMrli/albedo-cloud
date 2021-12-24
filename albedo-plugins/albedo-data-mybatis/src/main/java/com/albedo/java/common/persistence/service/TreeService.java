package com.albedo.java.plugins.database.mybatis.service;

import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.core.basic.domain.TreeEntity;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import java.util.List;

/**
 * TreeService
 *
 * @param <T>
 * @param <D>
 * @author somewhere
 */
public interface TreeService<T extends TreeEntity, D extends TreeDto> extends DataService<T, D, String> {
	/**
	 * countByParentId
	 *
	 * @param parentId
	 * @return
	 */
	Long countByParentId(String parentId);

	/**
	 * getTreeWrapper
	 *
	 * @param query
	 * @param <Q>
	 * @return
	 */
	<Q> QueryWrapper<T> getTreeWrapper(Q query);

	/**
	 * findTreeNode
	 *
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	<Q> List<TreeNode> findTreeNode(Q queryCriteria);

	/**
	 * findTreeList
	 *
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	<Q> List<T> findTreeList(Q queryCriteria);

	/**
	 * findAllByParentIdsLike
	 *
	 * @param parentIds
	 * @return
	 */
	List<T> findAllByParentIdsLike(String parentIds);

}
