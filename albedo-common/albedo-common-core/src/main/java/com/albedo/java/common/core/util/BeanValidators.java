/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.util;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * JSR303 Validator(Hibernate Validator)工具类. ConstraintViolation中包含propertyPath, message
 * 和invalidValue等信息. 提供了各种convert方法，适合不同的i18n需求: 1. List<String>, String内容为message 2.
 * List<String>, String内容为propertyPath + separator + message 3. Map<propertyPath, message>
 * 详情见wiki: https://github.com/springside/springside4/wiki/HibernateValidator
 *
 * @author calvin
 * @version 2013-01-15
 */
public class BeanValidators {

	/**
	 * 调用JSR303的validate方法, 验证失败时抛出ConstraintViolationException.
	 */
	@SuppressWarnings({"unchecked", "rawtypes"})
	public static void validateWithException(Validator validator, Object object, Class<?>... groups)
		throws ConstraintViolationException {
		Set constraintViolations = validator.validate(object, groups);
		if (!constraintViolations.isEmpty()) {
			throw new ConstraintViolationException(constraintViolations);
		}
	}

	/**
	 * 辅助方法, 转换ConstraintViolationException中的Set<ConstraintViolations>中为List<message>.
	 */
	public static List<String> extractMessage(ConstraintViolationException e) {
		return extractMessage(e.getConstraintViolations());
	}

	/**
	 * 辅助方法, 转换Set<ConstraintViolation>为List<message>
	 */
	@SuppressWarnings("rawtypes")
	public static List<String> extractMessage(Set<? extends ConstraintViolation> constraintViolations) {
		List<String> errorMessages = Lists.newArrayList();
		for (ConstraintViolation violation : constraintViolations) {
			errorMessages.add(violation.getMessage());
		}
		return errorMessages;
	}

	/**
	 * 辅助方法, 转换ConstraintViolationException中的Set<ConstraintViolations>为Map<property,
	 * message>.
	 */
	public static Map<String, String> extractPropertyAndMessage(ConstraintViolationException e) {
		return extractPropertyAndMessage(e.getConstraintViolations());
	}

	/**
	 * 辅助方法, 转换Set<ConstraintViolation>为Map<property, message>.
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String, String> extractPropertyAndMessage(
		Set<? extends ConstraintViolation> constraintViolations) {
		Map<String, String> errorMessages = Maps.newHashMap();
		for (ConstraintViolation violation : constraintViolations) {
			errorMessages.put(violation.getPropertyPath().toString(), violation.getMessage());
		}
		return errorMessages;
	}

	/**
	 * 辅助方法, 转换ConstraintViolationException中的Set<ConstraintViolations>为List<propertyPath
	 * message>.
	 */
	public static List<String> extractPropertyAndMessageAsList(ConstraintViolationException e) {
		return extractPropertyAndMessageAsList(e.getConstraintViolations(), " ");
	}

	/**
	 * 辅助方法, 转换Set<ConstraintViolations>为List<propertyPath message>.
	 */
	@SuppressWarnings("rawtypes")
	public static List<String> extractPropertyAndMessageAsList(
		Set<? extends ConstraintViolation> constraintViolations) {
		return extractPropertyAndMessageAsList(constraintViolations, " ");
	}

	/**
	 * 辅助方法, 转换ConstraintViolationException中的Set<ConstraintViolations>为List<propertyPath
	 * +separator+ message>.
	 */
	public static List<String> extractPropertyAndMessageAsList(ConstraintViolationException e, String separator) {
		return extractPropertyAndMessageAsList(e.getConstraintViolations(), separator);
	}

	/**
	 * 辅助方法, 转换Set<ConstraintViolation>为List<propertyPath +separator+ message>.
	 */
	@SuppressWarnings("rawtypes")
	public static List<String> extractPropertyAndMessageAsList(Set<? extends ConstraintViolation> constraintViolations,
															   String separator) {
		List<String> errorMessages = Lists.newArrayList();
		for (ConstraintViolation violation : constraintViolations) {
			// violation.getPropertyPath() + separator +
			errorMessages.add(violation.getMessage());
		}
		return errorMessages;
	}

	public static List<ObjectError> extractPropertyAndMessage(
		MethodArgumentNotValidException methodArgumentNotValidException) {
		List<ObjectError> allErrors = methodArgumentNotValidException.getBindingResult().getAllErrors();

		return allErrors;

	}

	public static List<String> extractPropertyAndMessageAsList(
		MethodArgumentNotValidException methodArgumentNotValidException) {
		List<String> errorMessages = Lists.newArrayList();
		List<ObjectError> allErrors = extractPropertyAndMessage(methodArgumentNotValidException);
		for (ObjectError violation : allErrors) {
			// violation.getCodes()[0] + separator +
			String message = (violation instanceof FieldError && violation != null
				? ((FieldError) violation).getField() + " " : "") + violation.getDefaultMessage();
			errorMessages.add(message + ";");
		}
		return errorMessages;

	}

}
