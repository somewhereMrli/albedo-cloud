/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import org.springframework.util.Assert;

import javax.xml.bind.*;
import javax.xml.bind.annotation.XmlAnyElement;
import javax.xml.namespace.QName;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Collection;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * 使用Jaxb2.0实现XML<->Java Object的Mapper. 在创建时需要设定所有需要序列化的Root对象的Class.
 * 特别支持Root对象是Collection的情形.
 *
 * @author calvin
 * @version 2013-01-15
 */
@SuppressWarnings("rawtypes")
public class JaxbMapper {

	private static ConcurrentMap<Class, JAXBContext> jaxbContexts = new ConcurrentHashMap<Class, JAXBContext>();

	/**
	 * Java Object->Xml with encoding.
	 */
	public static String toXml(Object root, Class clazz, String encoding) {
		try {
			StringWriter writer = new StringWriter();
			createMarshaller(clazz, encoding).marshal(root, writer);
			return writer.toString();
		} catch (JAXBException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Java Collection->Xml without encoding, 特别支持Root Element是Collection的情形.
	 */
	public static String toXml(Collection<?> root, String rootName, Class clazz) {
		return toXml(root, rootName, clazz, null);
	}

	/**
	 * Java Collection->Xml with encoding, 特别支持Root Element是Collection的情形.
	 */
	public static String toXml(Collection<?> root, String rootName, Class clazz, String encoding) {
		try {
			CollectionWrapper wrapper = new CollectionWrapper();
			wrapper.collection = root;

			JAXBElement<CollectionWrapper> wrapperElement = new JAXBElement<CollectionWrapper>(new QName(rootName),
				CollectionWrapper.class, wrapper);

			StringWriter writer = new StringWriter();
			createMarshaller(clazz, encoding).marshal(wrapperElement, writer);

			return writer.toString();
		} catch (JAXBException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Xml->Java Object.
	 */
	@SuppressWarnings("unchecked")
	public static <T> T fromXml(String xml, Class<T> clazz) {
		try {
			StringReader reader = new StringReader(xml);
			return (T) createUnmarshaller(clazz).unmarshal(reader);
		} catch (JAXBException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 创建Marshaller并设定encoding(可为null). 线程不安全，需要每次创建或pooling。
	 */
	public static Marshaller createMarshaller(Class clazz, String encoding) {
		try {
			JAXBContext jaxbContext = getJaxbContext(clazz);

			Marshaller marshaller = jaxbContext.createMarshaller();

			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

			if (StringUtil.isNotEmpty(encoding)) {
				marshaller.setProperty(Marshaller.JAXB_ENCODING, encoding);
			}

			return marshaller;
		} catch (JAXBException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 创建UnMarshaller. 线程不安全，需要每次创建或pooling。
	 */
	public static Unmarshaller createUnmarshaller(Class clazz) {
		try {
			JAXBContext jaxbContext = getJaxbContext(clazz);
			return jaxbContext.createUnmarshaller();
		} catch (JAXBException e) {
			throw new RuntimeException(e);
		}
	}

	protected static JAXBContext getJaxbContext(Class clazz) {
		Assert.notNull(clazz, "'clazz' must not be null");
		JAXBContext jaxbContext = jaxbContexts.get(clazz);
		if (jaxbContext == null) {
			try {
				jaxbContext = JAXBContext.newInstance(clazz, CollectionWrapper.class);
				jaxbContexts.putIfAbsent(clazz, jaxbContext);
			} catch (JAXBException ex) {
				throw new RuntimeException(
					"Could not instantiate JAXBContext for class [" + clazz + "]: " + ex.getMessage());
			}
		}
		return jaxbContext;
	}

	/**
	 * 封装Root Element 是 Collection的情况.
	 */
	public static class CollectionWrapper {

		@XmlAnyElement
		protected Collection<?> collection;

	}

}
