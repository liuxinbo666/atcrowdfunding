package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.service.MenuService;
@Service
public class menuServiceImpl implements MenuService {
	@Autowired
	TMenuMapper menuMapper;
	@Override
	public List<TMenu> listAllPMenus() {
		List<TMenu> menus = menuMapper.selectByExample(null);
		//List<TMenu> pmenus = new ArrayList<TMenu>();
		Map<Integer,TMenu> pmenuMap = new HashMap<Integer,TMenu>();
		//先挑选父菜单
		for (TMenu tMenu : menus) {
			//pid=0的是父菜单
			if(tMenu.getPid()==0) {
				//pmenus.add(tMenu);
				pmenuMap.put(tMenu.getId(), tMenu);//使用id当做key
			}
		}
		//遍历所有的菜单集合，将它设置到它的父菜单的子菜单集合中[TMenu：需要添加子菜单集合属性]
		for (TMenu tMenu : menus) {
			//根据当前遍历菜单的pid去pmenus集合中查找，
			//如果pmenus中有menu的id和它一样，那么正在遍历的menu就是pmenus中menu的子菜单
			TMenu pmenu = pmenuMap.get(tMenu.getPid());
			if(pmenu!=null) {
				pmenu.getChildren().add(tMenu);
			}
		}
		//返回父菜单List集合
		return new ArrayList<TMenu>(pmenuMap.values());
	}

}
