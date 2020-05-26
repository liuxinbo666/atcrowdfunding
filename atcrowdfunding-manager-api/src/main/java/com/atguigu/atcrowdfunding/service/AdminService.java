package com.atguigu.atcrowdfunding.service;

import java.util.ArrayList;
import java.util.List;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;

public interface AdminService {
	//处理登录的业务方法
	TAdmin doLogin(TAdmin admin);

	List<TAdmin> listAdmins(String condition);

	void deleteAdminById(Integer id);

	void saveAdmin(TAdmin admin);

	TAdmin getAdminById(Integer id);

	void updateAdmin(TAdmin admin);

	void deleteAdmins(Integer[] idsStr);
	//查询所有角色
	List<TRole> getAllRoles();
	//查询id对应角色已经分配的角色id
	List<Integer> getAssignedRoleIds(Integer id);

	

}
