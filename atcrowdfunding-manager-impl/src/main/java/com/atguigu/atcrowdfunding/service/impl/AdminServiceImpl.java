package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.utils.AppDateUtils;
import com.atguigu.atcrowdfunding.utils.MD5Util;
import com.atguigu.atcrowdfunding.utils.StringUtil;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	TAdminMapper adminMapper;

	@Override
	public TAdmin doLogin(TAdmin admin) {
		TAdminExample e = new TAdminExample();
		Criteria c = e.createCriteria();
		c.andLoginacctEqualTo(admin.getLoginacct()).andUserpswdEqualTo(MD5Util.digest(admin.getUserpswd()));
		List<TAdmin> list = adminMapper.selectByExample(e);
		if (CollectionUtils.isEmpty(list) || list.size()>1) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<TAdmin> listAdmins(String condition) {
		TAdminExample e = null;
		if (!StringUtil.isEmpty(condition)) {
			e = new TAdminExample();
			e.createCriteria().andLoginacctLike("%"+condition+"%");
			Criteria c1 = e.createCriteria().andUsernameLike("%"+condition+"%");
			Criteria c2 = e.createCriteria().andEmailLike("%"+condition+"%");
			e.or(c1);
			e.or(c2);
		}
		List<TAdmin> admins = adminMapper.selectByExample(e);
		return admins;
	}

	@Override
	public void deleteAdminById(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void saveAdmin(TAdmin admin) {
		TAdminExample e = new TAdminExample();
		e.createCriteria().andLoginacctEqualTo(admin.getLoginacct());
		long l = adminMapper.countByExample(e);
		if (l>0) {
			throw new RuntimeException("账号已被占用");
		}
		e.clear();
		e.createCriteria().andEmailEqualTo(admin.getEmail());
		l = adminMapper.countByExample(e);
		if (l>0) {
			throw new RuntimeException("邮箱已经被占用");
		}
		
		//密码加密
		admin.setUserpswd(MD5Util.digest(admin.getUserpswd()));
		//时间设置
		admin.setCreatetime(AppDateUtils.getFormatTime());
		adminMapper.insertSelective(admin);
		
	}

	@Override
	public TAdmin getAdminById(Integer id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateAdmin(TAdmin admin) {
		
		adminMapper.updateByPrimaryKeySelective(admin);
		
	}

//	@Override
//	public void deleteAdmins(ArrayList<Integer> list) {
//		TAdminExample example = new TAdminExample();  
//		example.createCriteria().andIdIn(list);
//		adminMapper.deleteByExample(example);
//	}

	@Override
	public void deleteAdmins(Integer[] idsStr) {
		TAdminExample example = new TAdminExample();  // DELETE FROM t_admin WHERE id in(1,2,3);
		List<Integer> list = Arrays.asList(idsStr);
		example.createCriteria().andIdIn(list);
		adminMapper.deleteByExample(example);
	}
	@Autowired
	TRoleMapper roleMapper;
	@Override
	public List<TRole> getAllRoles() { 
		
		return roleMapper.selectByExample(null);
	}
	@Autowired
	TAdminRoleMapper adminRoleMapper;
	@Override
	public List<Integer> getAssignedRoleIds(Integer id) {
		return adminRoleMapper.selectRoleIdsByAdminId(id);
	}



	
}
