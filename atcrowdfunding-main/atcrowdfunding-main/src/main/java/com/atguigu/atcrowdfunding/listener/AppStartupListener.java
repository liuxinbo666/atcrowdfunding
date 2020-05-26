package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.atguigu.atcrowdfunding.consts.AppConsts;

/**
 * Application Lifecycle Listener implementation class AppStartupListener
 *
 */
public class AppStartupListener implements ServletContextListener {
	//上下文对象销毁前调用： 将全局上下文中保存的一些数据持久化保存
    public void contextDestroyed(ServletContextEvent sce)  { 
    	
    }
    //上下文对象创建后调用： 存入初始化的全局配置参数，例如 上下文路径
    public void contextInitialized(ServletContextEvent sce)  { 
    	//写死的字符串可以提取为常量:以后调用常量即可获取属性值
    	sce.getServletContext().setAttribute(AppConsts.CONTEXT_PATH,
    			sce.getServletContext().getContextPath());
    }
	
}
