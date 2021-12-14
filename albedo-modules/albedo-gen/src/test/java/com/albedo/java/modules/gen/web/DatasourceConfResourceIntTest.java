/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.feign.handle.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.gen.domain.DatasourceConf;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfDto;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfQueryCriteria;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DatasourceConfResource REST controller.
 *
 * @see DatasourceConfResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoGenApplication.class)
@Slf4j
public class DatasourceConfResourceIntTest {

	/**
	 * DEFAULT_NAME name  :  名称
	 */
	private static final String DEFAULT_NAME = "A";
	/**
	 * UPDATED_NAME name  :  名称
	 */
	private static final String UPDATED_NAME = "B";
	/**
	 * DEFAULT_URL url  :  url
	 */
	private static final String DEFAULT_URL = "A";
	/**
	 * UPDATED_URL url  :  url
	 */
	private static final String UPDATED_URL = "B";
	/**
	 * DEFAULT_USERNAME username  :  用户名
	 */
	private static final String DEFAULT_USERNAME = "A";
	/**
	 * UPDATED_USERNAME username  :  用户名
	 */
	private static final String UPDATED_USERNAME = "B";
	/**
	 * DEFAULT_PASSWORD password  :  密码
	 */
	private static final String DEFAULT_PASSWORD = "A";
	/**
	 * UPDATED_PASSWORD password  :  密码
	 */
	private static final String UPDATED_PASSWORD = "B";
	/**
	 * DEFAULT_DESCRIPTION description  :  备注
	 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/**
	 * UPDATED_DESCRIPTION description  :  备注
	 */
	private static final String UPDATED_DESCRIPTION = "B";
	private String DEFAULT_API_URL;
	@Autowired
	private DatasourceConfService datasourceConfService;

	private MockMvc restDatasourceConfMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private DatasourceConfDto datasourceConfDto;

	private DatasourceConfDto anotherDatasourceConfDto = new DatasourceConfDto();

	/**
	 * Create an entity for this test.
	 * <p>
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an entity which requires the current entity.
	 */
	public static DatasourceConfDto createEntity() {
		DatasourceConfDto datasourceConfDto = ClassUtil.createObj(DatasourceConfDto.class, Lists.newArrayList(
				DatasourceConfDto.F_NAME
				, DatasourceConfDto.F_URL
				, DatasourceConfDto.F_USERNAME
				, DatasourceConfDto.F_PASSWORD
				, DatasourceConfDto.F_DESCRIPTION
			),

			DEFAULT_NAME

			, DEFAULT_URL

			, DEFAULT_USERNAME

			, DEFAULT_PASSWORD


			, DEFAULT_DESCRIPTION


		);
		return datasourceConfDto;
	}

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/gen/datasource-conf/";
		MockitoAnnotations.initMocks(this);
		final DatasourceConfResource datasourceConfResource = new DatasourceConfResource(datasourceConfService);
		this.restDatasourceConfMockMvc = MockMvcBuilders.standaloneSetup(datasourceConfResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(TestUtil.createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	@BeforeEach
	public void initTest() {
		datasourceConfDto = createEntity();
	}

	@Test
	@Transactional
	public void createDatasourceConf() throws Exception {
		int databaseSizeBeforeCreate = datasourceConfService.list().size();
		// Create the DatasourceConf
		restDatasourceConfMockMvc.perform(post(DEFAULT_API_URL)
				.param(PageModel.F_DESC, DatasourceConf.F_SQL_CREATED_DATE)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(datasourceConfDto)))
			.andExpect(status().isOk());
		;
		// Validate the DatasourceConf in the database
		List<DatasourceConf> datasourceConfList = datasourceConfService.list(
			Wrappers.<DatasourceConf>query().lambda().orderByAsc(
				DatasourceConf::getCreatedDate
			)
		);
		assertThat(datasourceConfList).hasSize(databaseSizeBeforeCreate + 1);
		DatasourceConf testDatasourceConf = datasourceConfList.get(datasourceConfList.size() - 1);
		assertThat(testDatasourceConf.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testDatasourceConf.getUrl()).isEqualTo(DEFAULT_URL);
		assertThat(testDatasourceConf.getUsername()).isEqualTo(DEFAULT_USERNAME);
		assertThat(testDatasourceConf.getPassword()).isEqualTo(DEFAULT_PASSWORD);
		assertThat(testDatasourceConf.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
	}

	@Test
	@Transactional
	public void checkUrlIsRequired() throws Exception {
		int databaseSizeBeforeTest = datasourceConfService.list().size();
		// set the field null
		datasourceConfDto.setUrl(null);

		// Create the DatasourceConf, which fails.

		restDatasourceConfMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(datasourceConfDto)))
			.andExpect(status().isBadRequest());

		List<DatasourceConf> datasourceConfList = datasourceConfService.list();
		assertThat(datasourceConfList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional
	public void checkUsernameIsRequired() throws Exception {
		int databaseSizeBeforeTest = datasourceConfService.list().size();
		// set the field null
		datasourceConfDto.setUsername(null);

		// Create the DatasourceConf, which fails.

		restDatasourceConfMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(datasourceConfDto)))
			.andExpect(status().isBadRequest());

		List<DatasourceConf> datasourceConfList = datasourceConfService.list();
		assertThat(datasourceConfList).hasSize(databaseSizeBeforeTest);
	}


	@Test
	@Transactional
	public void getAllDatasourceConfs() throws Exception {
		// Initialize the database
		datasourceConfService.saveOrUpdate(datasourceConfDto);

		// Get all the datasourceConfList
		restDatasourceConfMockMvc.perform(get(DEFAULT_API_URL))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(datasourceConfDto.getId())))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].password").value(hasItem(DEFAULT_PASSWORD)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	@Test
	@Transactional
	public void getDatasourceConf() throws Exception {
		// Initialize the database
		datasourceConfService.saveOrUpdate(datasourceConfDto);

		// Get the datasourceConf
		restDatasourceConfMockMvc.perform(get(DEFAULT_API_URL + "{id}", datasourceConfDto.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.id").value(datasourceConfDto.getId()))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.password").value(DEFAULT_PASSWORD))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
		;
	}

	@Test
	@Transactional
	public void getAllDatasourceConfsByNameSearch() throws Exception {
		// Initialize the database
		datasourceConfService.saveOrUpdate(datasourceConfDto);

		DatasourceConfQueryCriteria datasourceConfQueryCriteria = new DatasourceConfQueryCriteria();
		datasourceConfQueryCriteria.setName(DEFAULT_NAME);
		// Get all the datasourceConfList where name equals to DEFAULT_NAME
		defaultDatasourceConfShouldBeFound(datasourceConfQueryCriteria);

		datasourceConfQueryCriteria.setName(UPDATED_NAME);
		// Get all the datasourceConfList where name equals to UPDATED_NAME
		defaultDatasourceConfShouldNotBeFound(datasourceConfQueryCriteria);
	}

	/**
	 * Executes the search, and checks that the default entity is returned
	 */
	private void defaultDatasourceConfShouldBeFound(DatasourceConfQueryCriteria datasourceConfQueryCriteria) throws Exception {
		restDatasourceConfMockMvc.perform(get(DEFAULT_API_URL + "?" + TestUtil.convertObjectToUrlParams(datasourceConfQueryCriteria)))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records").isArray())
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(datasourceConfDto.getId())))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].password").value(hasItem(DEFAULT_PASSWORD)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	/**
	 * Executes the search, and checks that the default entity is not returned
	 */
	private void defaultDatasourceConfShouldNotBeFound(DatasourceConfQueryCriteria datasourceConfQueryCriteria) throws Exception {
		restDatasourceConfMockMvc.perform(get(DEFAULT_API_URL + "?" + TestUtil.convertObjectToUrlParams(datasourceConfQueryCriteria)))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records").isArray())
			.andExpect(jsonPath("$.data.records").isEmpty());
	}


	@Test
	@Transactional
	public void getNonExistingDatasourceConf() throws Exception {
		// Get the datasourceConf
		restDatasourceConfMockMvc.perform(get(DEFAULT_API_URL + "{id}", Long.MAX_VALUE))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
	}

	@Test
	@Transactional
	public void updateDatasourceConf() throws Exception {
		// Initialize the database
		datasourceConfService.saveOrUpdate(datasourceConfDto);

		int databaseSizeBeforeUpdate = datasourceConfService.list().size();

		// Update the datasourceConf
		DatasourceConf updatedDatasourceConf = datasourceConfService.getById(datasourceConfDto.getId());
		// Disconnect from session so that the updates on updatedDatasourceConf are not directly saved in db
		ClassUtil.updateObj(updatedDatasourceConf, Lists.newArrayList(
				DatasourceConf.F_NAME
				, DatasourceConf.F_URL
				, DatasourceConf.F_USERNAME
				, DatasourceConf.F_PASSWORD
				, DatasourceConf.F_DESCRIPTION
			),

			UPDATED_NAME

			, UPDATED_URL

			, UPDATED_USERNAME

			, UPDATED_PASSWORD


			, UPDATED_DESCRIPTION


		);

		DatasourceConfDto datasourceConfVo = datasourceConfService.copyBeanToDto(updatedDatasourceConf);
		restDatasourceConfMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(datasourceConfVo)))
			.andExpect(status().isOk());

		// Validate the DatasourceConf in the database
		List<DatasourceConf> datasourceConfList = datasourceConfService.list();
		assertThat(datasourceConfList).hasSize(databaseSizeBeforeUpdate);

		DatasourceConf testDatasourceConf = datasourceConfList.stream().filter(item -> datasourceConfDto.getId().equals(item.getId())).findAny().get();
		assertThat(testDatasourceConf.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDatasourceConf.getUrl()).isEqualTo(UPDATED_URL);
		assertThat(testDatasourceConf.getUsername()).isEqualTo(UPDATED_USERNAME);
		assertThat(testDatasourceConf.getPassword()).isEqualTo(UPDATED_PASSWORD);
		assertThat(testDatasourceConf.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
	}


	@Test
	@Transactional
	public void deleteDatasourceConf() throws Exception {
		// Initialize the database
		datasourceConfService.saveOrUpdate(datasourceConfDto);
		int databaseSizeBeforeDelete = datasourceConfService.list().size();

		// Get the datasourceConf
		restDatasourceConfMockMvc.perform(delete(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(datasourceConfDto.getId())))
				.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		List<DatasourceConf> datasourceConfList = datasourceConfService.list();
		assertThat(datasourceConfList).hasSize(databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional
	public void equalsVerifier() throws Exception {
		TestUtil.equalsVerifier(DatasourceConf.class);
		DatasourceConf datasourceConf1 = new DatasourceConf();
		datasourceConf1.setId("id1");
		DatasourceConf datasourceConf2 = new DatasourceConf();
		datasourceConf2.setId(datasourceConf1.getId());
		assertThat(datasourceConf1).isEqualTo(datasourceConf2);
		datasourceConf2.setId("id2");
		assertThat(datasourceConf1).isNotEqualTo(datasourceConf2);
		datasourceConf1.setId(null);
		assertThat(datasourceConf1).isNotEqualTo(datasourceConf2);
	}

}
