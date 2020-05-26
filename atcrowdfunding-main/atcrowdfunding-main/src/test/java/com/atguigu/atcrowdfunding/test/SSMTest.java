package com.atguigu.atcrowdfunding.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
//1、使用Spring单元测试来驱动普通的测试方法
@RunWith(value=SpringJUnit4ClassRunner.class)
//2、加载Spring配置文件
@ContextConfiguration(locations={"classpath:spring/spring-beans.xml",
"classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})
public class SSMTest {

	@Autowired
	TAdminMapper adminMapper;
	
	@Test
	public void test1() {
		System.out.println(adminMapper);
	}
}
