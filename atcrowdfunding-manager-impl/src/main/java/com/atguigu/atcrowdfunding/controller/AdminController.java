package com.atguigu.atcrowdfunding.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@GetMapping("/admin/assignRole.html")
	public String toAssignRolesPage(Integer id,Model model) {
		//查询所有角色
		List<TRole> roles = adminService.getAllRoles();
		//查询id对应角色已经分配的角色id
		List<Integer> roleIds = adminService.getAssignedRoleIds(id);
		//遍历roles将其分为已分配角色集合，和未分配角色集合
		List<TRole> assignedRoles = new ArrayList<TRole>();
		List<TRole> unAssignedRoles = new ArrayList<TRole>();
		for (TRole role : roles) {
			if (roleIds.contains(role.getId())) {
				assignedRoles.add(role);
			}else {
				unAssignedRoles.add(role);
			}
		}
		model.addAttribute("assignedRoles", assignedRoles);
		model.addAttribute("unAssignedRoles", unAssignedRoles);
		
		return "admin/assignRole";
	}
	
	//批量删除管理员
	@GetMapping("/admin/batchDelAdmins")//?id=1&id=2&id=3
	public String batchDelAdmins(Integer[] id , @RequestHeader(value="referer")String referer) {
		adminService.deleteAdmins(id);
		
		return "redirect:"+referer;
	}
	
	
	//修改管理员完成，并跳转至修改之前页面
	@PostMapping("/admin/updateAdmin")
	public String updateAdmin(TAdmin admin,HttpSession session,Model model) {
		adminService.updateAdmin(admin);
	String referer = (String) session.getAttribute("ref");
	session.removeAttribute("ref");
		return "redirect:"+referer;
	}
	
	/**
	 * 跳转至修改信息界面，并回显要修改的管理员信息
	 * @param model
	 * @param session
	 * @param admin
	 * @return
	 */
	@RequestMapping("/admin/getAdmin")
	public String toEditpage(Integer adminId,HttpSession session,@RequestHeader("referer")String referer) {
		//获取要修改管理员的ID，并查询信息
		System.out.println(adminId);
		TAdmin Admin=adminService.getAdminById(adminId);
		System.out.println(Admin);
		session.setAttribute("editAdmin", Admin);
		session.setAttribute("ref", referer);
		return "admin/edit";
		
	}
	
	//添加管理员
	@PostMapping("/admin/saveAdmin")
	public String saveAdmin(Model model,HttpSession session,TAdmin admin) {
		try {
			adminService.saveAdmin(admin);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("errorMsg", e.getMessage());
			return "admin/add";
		}
	
		//获取session中的数据
		Integer pages = (Integer) session.getAttribute("pages");
		return "redirect:/admin/index.html?pageNum="+(pages+1);
	}
	
	//跳转至添加页面 
	@RequestMapping("/admin/add.html")
	public String toAdminAdd() {
		return "/admin/add";
	}
	
	//根据ID删除指定管理员
	@RequestMapping("/admin/deleteAdmin")
	public String deleteAdmin(Integer adminId,@RequestHeader("referer")String referer) {
		//调用业务层删除指定id管理员
		adminService.deleteAdminById(adminId);
		return "redirect:"+referer;
	}
	
	//跳转到用户管理页面
	@RequestMapping("/admin/index.html")
	public String toUserPage(HttpSession session,@RequestParam(value="condition",defaultValue="",required=false)String condition,
			@RequestParam(value="pageNum",defaultValue="1",required=false) Integer pageNum, Model model) {
		
		//开启分页
				PageHelper.startPage(pageNum, 2);
		//查询所有管理员
		 List<TAdmin> admins = adminService.listAdmins(condition);
		 PageInfo<TAdmin> pageInfo = new PageInfo<TAdmin>(admins,3);
		 session.setAttribute("pages", pageInfo.getPages());
		//将查询到的数据放到域中
		model.addAttribute("pageInfo", pageInfo);
		return "admin/user";
	}
	
	
	//注销登录方法
	@ResponseBody
	@PostMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "success";
	}

	@PostMapping("/doLogin")
	public String doLogin(TAdmin admin , Model model , HttpSession session) {
		//调用业务层处理登录的业务
		TAdmin loginAdmin = adminService.doLogin(admin);
		//判断
		if(loginAdmin==null) {
			//登录失败
			//设置失败消息到request域中
			model.addAttribute("errorMsg", "账号或密码错误");
			return "login";
		}
		//登录成功，将用户对象存到session域中，重定向到登录成功页面main
		session.setAttribute("admin", loginAdmin);
		//以后所有的页面都放在web-inf下，每个页面都通过controller转发到
		return "redirect:/main.html";//重定向的地址是浏览器解析，浏览器不能直接访问web-inf下的资源
	}
	//菜单数据除了 数据库中存的一行记录还应该包含子菜单集合
	@Autowired
	MenuService menuService;
	//转发到admin/main页面的方法
	@GetMapping("/main.html")
	public String toMainPage(HttpSession session) {
		
		
		//查询所有父菜单集合，并在业务层封装父子关系的菜单集合
		List<TMenu> pmenus = menuService.listAllPMenus();
		//设置到session域中共享
		session.setAttribute("pmenus", pmenus);
		//转发到页面遍历显示
		return "admin/main";
	}
}
