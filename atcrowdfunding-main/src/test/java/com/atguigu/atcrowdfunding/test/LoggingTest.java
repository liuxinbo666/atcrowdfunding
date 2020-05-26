package com.atguigu.atcrowdfunding.test;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.atguigu.atcrowdfunding.utils.MD5Util;

public class LoggingTest {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Test
	public void test() {
		
		logger.debug("debug级别调试");
		logger.info("info");
		logger.warn("warn");
		logger.error("error");
	}
	
	@Test
	public void test1() {
		String digest = MD5Util.digest("123456");
		logger.info("12345:加密后："+digest);
	}

}
