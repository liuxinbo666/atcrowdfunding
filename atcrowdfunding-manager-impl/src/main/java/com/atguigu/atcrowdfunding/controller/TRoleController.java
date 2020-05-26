package com.atguigu.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.consts.AppConsts;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TRoleController {
	
	@Autowired
	TRoleService roleService;
	
	//批量删除角色信息
	@ResponseBody
	@PostMapping("/role/batchDelRoles")
	public String batchDelRoles(@RequestParam("ids")List<Integer> ids) {
		roleService.batchDelRoles(ids);
		return "ok";
	}
	
	//添加角色信息
	@ResponseBody
	@PostMapping("/role/addRole")
	public String addRole(TRole role) {
		roleService.addRole(role);
		return "ok";
	}
	
	
	//修改角色信息
	@ResponseBody
	@PostMapping("/role/updateRole")
	public String updateRole(TRole updateRole) {
		roleService.updateRole(updateRole);
		return "ok";
	}
	
	//根据角色id查询角色信息，并回显
	@ResponseBody
	@GetMapping("/role/getRole")
	public TRole getRole(Integer id) {
		 TRole role = roleService.getRole(id);
		 return role;
	}
	
	
	//根据角色ID删除角色
	@ResponseBody
	@GetMapping("/role/deleteRole")
	public String deleteRole(Integer id) {
		roleService.deleteRole(id);
		return "ok";
	}
	
	//2、  处理异步查询角色集合的方法
		@ResponseBody  //如果返回结果是复杂类型，必须引入JACKSONjar包
		//java.lang.IllegalArgumentException: No converter found for return value of type: class java.util.ArrayList
		@GetMapping("/role/listRoles")
		public PageInfo<TRole> listRoles(@RequestParam(defaultValue="" , required=false)String condition ,@RequestParam(defaultValue="1" , required=false) Integer pageNum) {
			//1、开启分页
			PageHelper.startPage(pageNum, AppConsts.PAGE_SIZE);
			//2、调用业务方法查询分页数据
			List<TRole>  roles = roleService.listRoles(condition);
			//3、获取分页详情
			PageInfo<TRole> pageInfo = new PageInfo<TRole>(roles, AppConsts.PAGE_NAVS);
			return pageInfo;
		}

	@RequestMapping("/role/index.html")
	public String toRolePage() {
		return "role/role";
	}
}
