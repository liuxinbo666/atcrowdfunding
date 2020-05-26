<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@ include file="/WEB-INF/pages/include/base_css.jsp" %>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
       <%@ include file="/WEB-INF/pages/include/admin_loginbar.jsp"  %>
 
      
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<%@ include file="/WEB-INF/pages/include/admin_leftmenu.jsp"  %>

		</div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
			  	<span style="color:red;">${errorMsgs }</span>
				<form role="form" method="post" action="${PATH }/admin/updateAdmin">
					<input  type="hidden" name="id" value="${editAdmin.id }"/>
				  <div class="form-group">
					<label for="exampleInputPassword1">登陆账号</label>
					<input type="text"  class="form-control forminp" id="exampleInputPassword1" value="${editAdmin.loginacct }">
					<input  type="hidden" name="loginacct"  value="${editAdmin.loginacct }"/>
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control forminp" id="exampleInputPassword1"  value="${editAdmin.username }">
				  	<input  type="hidden" name="username" value="${editAdmin.username }"/>
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email"  class="form-control forminp"  id="exampleInputEmail1" value="${editAdmin.email }">
					<input  type="hidden" name="email"  value="${editAdmin.email }"/>
					<p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
		</div>
	  </div>
	</div>
    <%@ include file="/WEB-INF/pages/include/base_js.jsp" %> 
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            //当页面显示，需要查找当前页面对应的左边菜单栏的菜单项 高亮显示+并让所在的ul样式display值为block
            //高亮显示： 设置字体颜色为red
            $(".tree a:contains(' 用户维护')").css("color", "red");
            //手动显示展开的用户维护所在的菜单栏
            $(".tree a:contains(' 用户维护')").parents("ul").css("display" , "block");
            //去掉ul所在的li的tree-closed class属性值，去掉代表当前菜单的状态是展开的
            $(".tree a:contains(' 用户维护')").parents(".tree-closed").removeClass("tree-closed");

			//
			$("form .forminp").change(function(){
				var updateVal = this.value;
				var val = $(this).next().val();
				if(updateVal != val){
					//修改了   修改隐藏域的val值为修改后的属性值
					$(this).next().val(updateVal);
				}
			})
            
            
            
        </script>
  </body>
</html>
