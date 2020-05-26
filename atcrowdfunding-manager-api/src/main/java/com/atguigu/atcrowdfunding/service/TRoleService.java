package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TRole;

public interface TRoleService {
	//查询全部角色信息
	List<TRole> listRoles(String condition);
	//删除角色信息
	void deleteRole(Integer id);
	//根据id查询角色信息，并回显
	TRole getRole(Integer id);
	//修改role的信息
	void updateRole(TRole updateRole);
	//添加角色信息
	void addRole(TRole role);
	//批量删除role
	void batchDelRoles(List<Integer> ids);

}
