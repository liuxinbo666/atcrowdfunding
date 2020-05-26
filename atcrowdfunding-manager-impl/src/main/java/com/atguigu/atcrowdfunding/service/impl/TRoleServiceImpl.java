package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.service.TRoleService;
@Service
public class TRoleServiceImpl implements TRoleService {

	@Autowired
	TRoleMapper roleMapper;
	


	@Override
	public List<TRole> listRoles(String condition) {
		//带条件的查询
				TRoleExample e;
				if(StringUtils.isEmpty(condition)) {
					e = null;
				}else {
					e = new TRoleExample();
					e.createCriteria().andNameLike("%"+condition+"%");
				}
				
				return roleMapper.selectByExample(e);
	}

	@Override
	public void deleteRole(Integer id) {
		roleMapper.deleteByPrimaryKey(id);
	}
	@Override
	public TRole getRole(Integer id) {
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateRole(TRole updateRole) {
		roleMapper.updateByPrimaryKeySelective(updateRole);
	}

	@Override
	public void addRole(TRole role) {
		roleMapper.insertSelective(role);
	}

	@Override
	public void batchDelRoles(List<Integer> ids) {
		TRoleExample example = new TRoleExample();
		example.createCriteria().andIdIn(ids);
		roleMapper.deleteByExample(example);
		
	}

}
