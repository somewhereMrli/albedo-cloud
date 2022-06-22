package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the UserResource REST web.
 *
 * @see com.albedo.java.modules.sys.web.UserResource
 */
@Slf4j
public class UserResourceIntTest extends SimulationRuntimeIntegrationTest {


	private static final String DEFAULT_ANOTHER_USERNAME = "johndoeddd";
	private static final String DEFAULT_USERNAME = "johndoe";
	private static final String UPDATED_USERNAME = "jhipster";
	private static final String DEFAULT_PASSWORD = "passjohndoe";
	private static final String UPDATED_PASSWORD = "passjhipster";
	private static final String DEFAULT_PHONE = "13258812456";
	private static final String UPDATED_PHONE = "13222222222";
	private static final String DEFAULT_ANOTHER_PHONE = "13222221111";
	private static final String DEFAULT_ANOTHER_EMAIL = "23423432@localhost";
	private static final String DEFAULT_EMAIL = "johndoe@localhost";
	private static final String UPDATED_EMAIL = "jhipster@localhost";
	private static final String DEFAULT_QQOPENID = "QQOPENID1";
	private static final String UPDATED_QQOPENID = "QQOPENID2";
	private static final Integer DEFAULT_AVAILABLE = CommonConstants.YES;
	private static final Integer UPDATED_AVAILABLE = CommonConstants.NO;
	UserDto anotherUser = new UserDto();
	private String DEFAULT_API_URL;
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private DeptService deptService;
	private MockMvc restUserMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;
	private UserDto user;
	private List<RoleDo> roleList;
	private List<DeptDo> deptDoList;

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = "/user/";
		MockitoAnnotations.openMocks(this);
		final UserResource userResource = new UserResource(userService);
		this.restUserMockMvc = MockMvcBuilders.standaloneSetup(userResource)
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();

	}

	/**
	 * Create a User.
	 * <p>
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an domain which has a required relationship to the User domain.
	 */
	public UserDto createEntity() {
		UserDto user = new UserDto();
		user.setUsername(DEFAULT_USERNAME);
		user.setPassword(DEFAULT_PASSWORD);
		user.setEmail(DEFAULT_EMAIL);
		user.setPhone(DEFAULT_PHONE);
		user.setQqOpenId(DEFAULT_QQOPENID);
		user.setDeptId(deptDoList.get(0).getId());
		user.setRoleIdList(CollUtil.extractToList(roleList, RoleDo.F_ID));
		return user;
	}

	@BeforeEach
	public void initTest() {
		deptDoList = deptService.list();
		roleList = roleService.list();
		user = createEntity();
		// Initialize the database

		anotherUser.setUsername(DEFAULT_ANOTHER_USERNAME);
		anotherUser.setPassword(DEFAULT_PASSWORD);
		anotherUser.setEmail(DEFAULT_ANOTHER_EMAIL);
		anotherUser.setPhone(DEFAULT_ANOTHER_PHONE);
		anotherUser.setDeptId(deptDoList.get(0).getId());
		anotherUser.setRoleIdList(CollUtil.extractToList(roleList, RoleDo.F_ID));
		userService.saveOrUpdate(anotherUser);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createUser() throws Exception {
		List<UserDo> databaseSizeBeforeCreate = userService.list();

		// Create the User
		restUserMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(user)))
			.andExpect(status().isOk());

		// Validate the User in the database
		List<UserDo> userDoList = userService.list();
		assertThat(userDoList).hasSize(databaseSizeBeforeCreate.size() + 1);
		UserDo testUserDo = userService.getOne(Wrappers.<UserDo>query().lambda()
			.eq(UserDo::getUsername, user.getUsername()));
		assertThat(testUserDo.getUsername()).isEqualTo(DEFAULT_USERNAME);
		assertThat(testUserDo.getPhone()).isEqualTo(DEFAULT_PHONE);
		assertThat(testUserDo.getEmail()).isEqualTo(DEFAULT_EMAIL);
		assertThat(testUserDo.getQqOpenId()).isEqualTo(DEFAULT_QQOPENID);
		assertThat(testUserDo.getDelFlag()).isEqualTo(UserDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createUserWithExistingEmail() throws Exception {
		// Initialize the database
		int databaseSizeBeforeCreate = userService.list().size();

		// Create the User
		UserDto managedUserVM = createEntity();
		managedUserVM.setEmail(DEFAULT_ANOTHER_EMAIL);
		// Create the User
		restUserMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.code").value(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Validate the User in the database
		List<UserDo> userDoList = userService.list();
		assertThat(userDoList).hasSize(databaseSizeBeforeCreate);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void findPage() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		// Get all the users
		restUserMockMvc.perform(get(DEFAULT_API_URL)
				.param(PageModel.F_DESC, UserDo.F_SQL_CREATED_DATE)
				.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].username").value(hasItem(DEFAULT_USERNAME)))
			.andExpect(jsonPath("$.data.records.[*].qqOpenId").value(hasItem(DEFAULT_QQOPENID)))
			.andExpect(jsonPath("$.data.records.[*].phone").value(hasItem(DEFAULT_PHONE)))
			.andExpect(jsonPath("$.data.records.[*].email").value(hasItem(DEFAULT_EMAIL)))
		;
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// Get the user
		restUserMockMvc.perform(get(DEFAULT_API_URL + "{id}", user.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.username").value(user.getUsername()))
			.andExpect(jsonPath("$.data.qqOpenId").value(DEFAULT_QQOPENID))
			.andExpect(jsonPath("$.data.phone").value(DEFAULT_PHONE))
			.andExpect(jsonPath("$.data.email").value(DEFAULT_EMAIL));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getInfo() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// Get the user
		restUserMockMvc.perform(get(DEFAULT_API_URL + "/info/{username}", user.getUsername()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.user.username").value(user.getUsername()))
			.andExpect(jsonPath("$.data.user.qqOpenId").value(DEFAULT_QQOPENID))
			.andExpect(jsonPath("$.data.roles").value(equalTo(roleList.stream().map(roleDo -> String.valueOf(roleDo.getId())).collect(Collectors.toList()))))
			.andExpect(jsonPath("$.data.permissions").isNotEmpty())
		;
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingUser() throws Exception {
		restUserMockMvc.perform(get("/sys/user/ddd/unknown"))
			.andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		int databaseSizeBeforeUpdate = userService.list().size();

		// Update the user
		UserDo updatedUserDo = userService.getById(user.getId());


		UserDto managedUserVM = new UserDto();
		managedUserVM.setUsername(UPDATED_USERNAME);
		managedUserVM.setPassword(UPDATED_PASSWORD);
		managedUserVM.setEmail(UPDATED_EMAIL);
		managedUserVM.setPhone(UPDATED_PHONE);
		managedUserVM.setQqOpenId(UPDATED_QQOPENID);
		managedUserVM.setQqOpenId(UPDATED_QQOPENID);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, RoleDo.F_ID));

		managedUserVM.setId(updatedUserDo.getId());
		restUserMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the User in the database
		List<UserDo> userDoList = userService.list();
		assertThat(userDoList).hasSize(databaseSizeBeforeUpdate);
		UserDo testUserDo = userService.getById(updatedUserDo.getId());
		assertThat(testUserDo.getUsername()).isEqualTo(UPDATED_USERNAME);
		assertThat(testUserDo.getEmail()).isEqualTo(UPDATED_EMAIL);
		assertThat(testUserDo.getPhone()).isEqualTo(UPDATED_PHONE);
		assertThat(testUserDo.getQqOpenId()).isEqualTo(UPDATED_QQOPENID);
	}


	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUserExistingEmail() throws Exception {

		userService.saveOrUpdate(user);
		// Update the user
		UserDo updatedUserDo = userService.getById(user.getId());


		UserDto managedUserVM = new UserDto();
		managedUserVM.setEmail(DEFAULT_ANOTHER_EMAIL);
		managedUserVM.setUsername(updatedUserDo.getUsername());
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, RoleDo.F_ID));
		managedUserVM.setId(updatedUserDo.getId());
		restUserMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.code").value(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());
		UserDo testUserDo = userService.getById(updatedUserDo.getId());
		assertThat(testUserDo.getEmail()).isEqualTo(DEFAULT_EMAIL);

	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUserExistingUsername() throws Exception {

		userService.saveOrUpdate(user);
		// Update the user
		UserDo updatedUserDo = userService.getById(user.getId());


		UserDto managedUserVM = new UserDto();
		managedUserVM.setUsername(DEFAULT_ANOTHER_USERNAME);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, RoleDo.F_ID));
		managedUserVM.setId(updatedUserDo.getId());
		restUserMockMvc.perform(post(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.code").value(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());
		UserDo testUserDo = userService.getById(updatedUserDo.getId());
		assertThat(testUserDo.getUsername()).isEqualTo(DEFAULT_USERNAME);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		long databaseSizeBeforeDelete = userService.count();

		// Delete the user
		restUserMockMvc.perform(delete(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
				.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = userService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void lockOrUnLockUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// lockOrUnLock the user
		restUserMockMvc.perform(put(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
				.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		UserDo tempUserDo = userService.getById(user.getId());
		assertThat(CommonConstants.STR_YES.equals(tempUserDo.getAvailable()));
		// lockOrUnLock the user
		restUserMockMvc.perform(put(DEFAULT_API_URL)
				.contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
				.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		UserDo tempUser1Do = userService.getById(user.getId());
		assertThat(CommonConstants.STR_NO.equals(tempUser1Do.getAvailable()));
	}

}
