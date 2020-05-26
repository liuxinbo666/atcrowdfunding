package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;

public interface MenuService {
	//获取多有菜单的集合
	List<TMenu> listAllPMenus();

}
