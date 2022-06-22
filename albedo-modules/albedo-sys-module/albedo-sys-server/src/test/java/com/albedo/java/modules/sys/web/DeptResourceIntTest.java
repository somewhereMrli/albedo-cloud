package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.service.DeptService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DeptResource REST web.
 *
 * @see DeptResource
 */
@Slf4j
public class DeptResourceIntTest extends SimulationRuntimeIntegrationTest {


	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
	private static final String DEFAULT_NAME = "NAME1";
	private static final String UPDATED_NAME = "NAME2";
	private static final Long DEFAULT_ANOTHER_PARENT_ID = 22L;
	//    private static final String DEFAULT_PARENT_ID = "PARENT_ID1";
	private static final Long UPDATED_PARENT_ID = 33L;
	private static final Integer DEFAULT_SORT = 10;
	private static final Integer UPDATED_SORT = 20;
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";
	private String DEFAULT_API_URL;
	@Resource
	private DeptService deptService;

	private MockMvc restDeptMockMvc;
	@Resource
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Resource
	private GlobalExceptionHandler globalExceptionHandler;
	@Resource
	private ApplicationProperties applicationProperties;

	private DeptDto dept;

	private DeptDto anotherDept = new DeptDto();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/dept/";
		MockitoAnnotations.openMocks(this);
		final DeptResource deptResource = new DeptResource(deptService);
		this.restDeptMockMvc = MockMvcBuilders.standaloneSetup(deptResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	/**
	 * Create a Dept.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an domain which has a required relationship to the Dept domain.
	 */
	public DeptDto createDto() {
		DeptDto dept = new DeptDto();
		dept.setName(DEFAULT_NAME);
		dept.setSort(DEFAULT_SORT);
		dept.setDescription(DEFAULT_DESCRIPTION);
		return dept;
	}

	@BeforeEach
	public void initTest() {
		dept = createDto();
		// Initialize the database

		anotherDept.setName(DEFAULT_ANOTHER_NAME);
		anotherDept.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		anotherDept.setSort(DEFAULT_SORT);
		anotherDept.setDescription(DEFAULT_DESCRIPTION);
		deptService.saveOrUpdate(anotherDept);

		dept.setParentId(anotherDept.getId());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDept() throws Exception {
		List<DeptDo> databaseSizeBeforeCreate = deptService.list();

		// Create the Dept
		restDeptMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(dept))).andExpect(status().isOk());

		// Validate the Dept in the database
		List<DeptDo> deptDoList = deptService.list();
		assertThat(deptDoList).hasSize(databaseSizeBeforeCreate.size() + 1);
		DeptDo testDeptDo = deptService.getOne(Wrappers.<DeptDo>query().lambda().eq(DeptDo::getName, dept.getName()));
		assertThat(testDeptDo.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testDeptDo.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testDeptDo.getParentId()).isEqualTo(anotherDept.getId());
		assertThat(testDeptDo.getParentIds()).contains(String.valueOf(anotherDept.getId()));
		assertThat(testDeptDo.isLeaf()).isEqualTo(true);
		assertThat(testDeptDo.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testDeptDo.getDelFlag()).isEqualTo(DeptDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);

		// Get the dept
		restDeptMockMvc.perform(get(DEFAULT_API_URL + "{id}", dept.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.parentId").value(anotherDept.getId()))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingDept() throws Exception {
		restDeptMockMvc.perform(get("/sys/dept/ddd/unknown")).andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);
		int databaseSizeBeforeUpdate = deptService.list().size();

		// Update the dept
		DeptDo updatedDeptDo = deptService.getById(dept.getId());

		DeptDto managedDeptVM = new DeptDto();
		managedDeptVM.setName(UPDATED_NAME);
		managedDeptVM.setSort(UPDATED_SORT);
		managedDeptVM.setParentId(UPDATED_PARENT_ID);
		managedDeptVM.setDescription(UPDATED_DESCRIPTION);

		managedDeptVM.setId(updatedDeptDo.getId());
		restDeptMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDeptVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Dept in the database
		List<DeptDo> deptDoList = deptService.list();
		assertThat(deptDoList).hasSize(databaseSizeBeforeUpdate);
		DeptDo testDeptDo = deptService.getById(updatedDeptDo.getId());
		assertThat(testDeptDo.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDeptDo.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testDeptDo.getParentId()).isEqualTo(UPDATED_PARENT_ID);
		// assertThat(testDept.getParentIds()).contains(UPDATED_PARENT_ID);
		assertThat(testDeptDo.isLeaf()).isEqualTo(true);
		assertThat(testDeptDo.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testDeptDo.getDelFlag()).isEqualTo(DeptDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);
		long databaseSizeBeforeDelete = deptService.count();

		// Delete the dept
		restDeptMockMvc.perform(delete(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(dept.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = deptService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testDeptEquals() throws Exception {
		TestUtil.equalsVerifier(DeptDo.class);
		DeptDo deptDo1 = new DeptDo();
		deptDo1.setId(1L);
		deptDo1.setName("Dept1");
		DeptDo deptDo2 = new DeptDo();
		deptDo2.setId(deptDo1.getId());
		deptDo2.setName(deptDo1.getName());
		assertThat(deptDo1).isEqualTo(deptDo2);
		deptDo2.setId(2L);
		deptDo2.setName("Dept2");
		assertThat(deptDo1).isNotEqualTo(deptDo2);
		deptDo1.setId(null);
		assertThat(deptDo1).isNotEqualTo(deptDo2);
	}

}
