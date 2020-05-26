package com.atguigu.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;

@Controller  //可以被其他注解替换吗？ 不可以
public class DispatcherController {
	
	@Autowired
	TAdminMapper adminMapper;
	
	//处理跳转到首页的请求
	@RequestMapping(value= {"/" , "/index.html" , "/index"})
	public String toIndexPage() {
		List<TAdmin> list = adminMapper.selectByExample(null);
		System.out.println(list.size());
		
		return "index";
	}
	//处理跳转到登录页面的请求
	@GetMapping("/login.html")
	public String toLoginPage() {
		return "login";
	}
}
