/*
 * Copyright (c) 2019-2022, somewhere (somewhere0813@gmail.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.plugins.swagger.annotation;

import com.albedo.java.plugins.swagger.config.ApplicationSwaggerProperties;
import com.albedo.java.plugins.swagger.config.SwaggerAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * 开启 pig spring doc
 *
 * @author lengleng
 * @date 2022-03-26
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@EnableConfigurationProperties(ApplicationSwaggerProperties.class)
@Import({SwaggerAutoConfiguration.class})
public @interface EnableSwaggerDoc {

}
