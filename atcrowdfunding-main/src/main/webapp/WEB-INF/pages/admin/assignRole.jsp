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
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select class="form-control unAssignedRolesSelect" multiple size="10" style="width:300px;overflow-y:auto;">
              <%--           <c:forEach items="${unAssignedRoles }" var="role">
	                        <option value="${role.id }">${role.name }</option>
                        </c:forEach> --%>
                       <c:forEach items="${unAssignedRoles }"  var="role">
                         <option value="${role.id }">${role.name }</option>
                       </c:forEach>
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li class="btn btn-default glyphicon glyphicon-chevron-right assignRolesToAdminBtn"></li>
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-chevron-left unAssignRolesToAdminBtn" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select class="form-control assignedRolesSelect" multiple size="10" style="width:400px;overflow-y:auto;">
                         <c:forEach items="${assignedRoles }" var="role">
	                        <option value="${role.id }">${role.name }</option>
                        </c:forEach>
                    </select>
				  </div>
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
	<% pageContext.setAttribute("pageName", "用户维护"); %>
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
            
            //取消分配角色
            $(".unAssignRolesToAdminBtn").click(function(){
            	//获取adminid
            	var adminId = "${param.id}";
            	//获取要取消分配的角色id集合
            	var $ops = $(".assignedRolesSelect :selected");
            	var roleIdsArr = new Array();
				$.each($ops , function(){
					var roleId = this.value;
					roleIdsArr.push(roleId);
				});
				var roleIdsStr = roleIdsArr.join(",");
            	
            	//发送ajax请求：删除分配的角色
            	$.ajax({
            		type:"POST",
            		url:"${PATH}/admin/unAssignRolesToAdmin",
            		data:{"adminId":adminId , "roleIds":roleIdsStr},
            		success:function(result){
            			if("ok"==result){
            				layer.msg("取消分配角色成功!!!");
            				$ops.appendTo(".unAssignedRolesSelect");
            			}
            		}
            	});
            	
            	
            });
            
            
            
            //提交分配角色给admin的请求
            $(".assignRolesToAdminBtn").click(function(){
            	//获取adminid
            	var adminId = "${param.id}";
            	//获取选中的要分配的角色id集合
            	//获取未选中角色列表的select中被选中的option集合
            	var $ops = $(".unAssignedRolesSelect :selected");
            	var roleIdsArr = new Array();//[1 2 3]
            	$.each($ops , function(){
            		var roleId = this.value;
            		roleIdsArr.push(roleId);
            	});
            	//1,2,3
            	var roleIdsStr = roleIdsArr.join(",");
            	
            	//发送ajax请求提交  adminid和 要分配的角色id给后台处理
            	$.ajax({
            		type:"POST",
            		url:"${PATH}/admin/assignRolesToAdmin",
            		data:{"adminId": adminId , "roleIds" : roleIdsStr},
            		success: function(res){
            			if(res=="ok"){
            				layer.msg("角色分配成功");
            				//服务器响应成功。将左边选中的ops移动到右边即可
            				$ops.appendTo(".assignedRolesSelect");
            			}else{
            				layer.msg("角色分配失败，请稍后再试");
            			}
            		}
            	});
            	
            	
            });
        </script>
  </body>
</html>
