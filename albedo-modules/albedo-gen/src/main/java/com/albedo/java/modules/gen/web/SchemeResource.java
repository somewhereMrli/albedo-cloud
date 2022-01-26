package com.albedo.java.modules.gen.web;

import cn.hutool.core.lang.Assert;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.dto.GenCodeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeGenDto;
import com.albedo.java.modules.gen.domain.dto.SchemeQueryCriteria;
import com.albedo.java.modules.gen.domain.vo.SchemeFormDataVo;
import com.albedo.java.modules.gen.service.SchemeService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Set;

/**
 * 生成方案Controller
 *
 * @author somewhere
 */
@RestController
@RequestMapping("/scheme")
@AllArgsConstructor
public class SchemeResource extends BaseResource {

	private final SchemeService schemeService;

	/**
	 * @param pm
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	@LogOperate(value = "生成方案查看")
	public Result getPage(PageModel pm, SchemeQueryCriteria schemeQueryCriteria) {
		return Result.buildOkData(schemeService.getSchemeVoPage(pm, schemeQueryCriteria));
	}

	@GetMapping(value = "/preview" + CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public Result preview(@PathVariable String id) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.previewCode(id, username);
		return Result.buildOkData(formData);
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public Result<SchemeFormDataVo> formData(SchemeDto schemeDto) {
		String username = SecurityUtil.getUser().getUsername();
		SchemeFormDataVo formData = schemeService.findFormData(schemeDto, username);
		return Result.buildOkData(formData);
	}

	@LogOperate(value = "方案生成代码")
	@PutMapping(value = "/gen-code")
	@PreAuthorize("@pms.hasPermission('gen_scheme_code')")
	public Result genCode(@Valid @RequestBody GenCodeDto genCodeDto) {
		SchemeDto genSchemeDto = schemeService.getOneDto(genCodeDto.getId());
		Assert.isTrue(genSchemeDto != null, "无法获取代码生成方案信息");
		genSchemeDto.setReplaceFile(genCodeDto.getReplaceFile());
		schemeService.generateCode(genSchemeDto);
		return Result.buildOk("生成", genSchemeDto.getName(), "代码成功");
	}

	@LogOperate(value = "生成方案编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_edit')")
	public Result save(@Valid @RequestBody SchemeDto schemeDto) {
		schemeService.saveOrUpdate(schemeDto);
		// 生成代码
		if (schemeDto.getGenCode()) {
			schemeService.generateCode(schemeDto);
		}
		return Result.buildOk("保存", schemeDto.getName(), "成功");
	}

	@LogOperate(value = "生成方案编辑")
	@PostMapping("/gen-menu")
	@PreAuthorize("@pms.hasPermission('gen_scheme_menu')")
	public Result genMenu(@Valid @RequestBody SchemeGenDto schemeGenDto) {
		SchemeDto schemeDataVo = schemeService.genMenu(schemeGenDto);
		return Result.buildOk("生成", schemeDataVo.getName(), "菜单成功");
	}


	@LogOperate(value = "生成方案删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_del')")
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete User: {}", ids);
		schemeService.removeByIds(ids);
		return Result.buildOk("删除成功");
	}


}
