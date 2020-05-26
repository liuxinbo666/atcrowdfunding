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
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" onclick="batchDelRoles();" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" onclick="addRole();" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
               
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
								
						</ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
<!-- 修改角色模态框：默认不显示 -->    
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">修改角色</h4>
      </div>
      <div class="modal-body">
        <form>
            <input type="hidden" name="id" class="form-control" id="recipient-name">
          <div class="form-group">
            <label for="recipient-name" class="control-label">角色名：</label>
            <input type="text" name="name" class="form-control" id="recipient-name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消修改</button>
        <button type="button" id="updateRoleBtn" class="btn btn-primary">提交修改</button>
      </div>
    </div>
  </div>
</div>
<!-- 添加角色模态框：默认不显示 -->    
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">添加角色</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="control-label">角色名：</label>
            <input type="text" name="name" class="form-control" id="recipient-name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" id="saveRoleBtn" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>    
<!-- 携带总页码参数 -->
 <input type="hidden" name="pages" />   
    
    
 <% pageContext.setAttribute("pageName", "角色维护"); %>
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
            
            $("tbody .btn-success").click(function(){
                window.location.href = "assignPermission.html";
            });
    ///////////////////////////////异步请求role列表并解析//////////////////////////////////////////////////        
            //发起ajax请求：请求角色列表json数组
            //如果是html+css+js 选择到w3cschool离线手册中查找api
            //凡是使用$查找到的对象 或使用$包装的对象或者使用$进行传参，都到jquery中查找api
            //提取发送ajax请求获取分页数据的方法
            function initRolesTable(pageNum , condition){
                $.ajax({
                	type:"GET",
                	url:"${PATH}/role/listRoles",
                	data: {"pageNum":pageNum , "condition":condition},
                	success:function(pageInfo){
                		$("input[name='pages']").val(pageInfo.pages);
                		//解析数据之前先清除 页面中之前的ajax请求的数据
                		//清除role列表 
                		$("tbody").empty();
                		//清空 分页导航栏  ul中的所有的li
                		$("tfoot .pagination").empty();
                		var roles = pageInfo.list;
                		//roles是服务器响应的角色列表的json字符串
                		//alert(JSON.stringify(roles));
                		console.log(pageInfo);//在浏览器控制台输出 等价于java中的syso
                		//根据响应结果，解析并显示到页面中
       					//1、解析分页数据的集合显示到表格的tbody内
                		initTableTbody(roles);
                		//2、解析分页数据的分页页码数据显示到表格的tfoot内[分页导航栏]
                		initTableTfoot(pageInfo);
                	}
                });
            };
			//页面第一次初始化，需要手动调用ajax请求的方法获取role列表并显示
			initRolesTable(1);
            //解析分页导航栏
            function initTableTfoot(pageInfo){
            	/* 
            		<li class="disabled"><a href="#">上一页</a></li>
					<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">下一页</a></li>
            	*/
            	//上一页
            	if(pageInfo.hasPreviousPage){
            		//有上一页   pageInfo.pageNum-1
            		$('<li><a class="nvaPageA" pageNum="'+ (pageInfo.pageNum-1) +'" href="${PATH}/role/listRoles?pageNum='+ (pageInfo.pageNum-1) +'">上一页</a></li>').appendTo("tfoot .pagination");
            	}else{
            		//没有上一页
            		$('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot .pagination");
            	}
            	//页码
            	$.each(pageInfo.navigatepageNums , function(){
            		//当前页需要高亮显示
            		if(this==pageInfo.pageNum){
            			//是当前页  高亮显示并禁止点击
	            		$('<li class="active"><a class="currentPageNum" href="javascript:void(0);">'+this+' <span class="sr-only">(current)</span></a></li>').appendTo("tfoot .pagination");
            		}else{
            			//不是当前页
	            		// this代表遍历集合中的一个页码数字   
	            		$('<li><a class="nvaPageA" pageNum="'+ this +'" href="${PATH}/role/listRoles?pageNum='+this+'">'+this+'</a></li>').appendTo("tfoot .pagination");
            		}
            	});
            	//下一页
            	if(pageInfo.hasNextPage){
            		//有下一页   pageInfo.pageNum+1
            		$('<li><a class="nvaPageA"  pageNum="'+ (pageInfo.pageNum+1) +'" href="${PATH}/role/listRoles?pageNum='+ (pageInfo.pageNum+1) +'">下一页</a></li>').appendTo("tfoot .pagination");
            	}else{
            		//没有下一页
            		$('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot .pagination");
            	}
            }
            
			//由于需要绑定的分页导航栏是异步请求加载后生成的标签，所以必须等标签生成之后再绑定事件或者 使用动态委派事件的方式绑定事件            
            //给分页导航栏的超链接绑定单击事件   [live 1.9之后被砍掉了...    祖先元素.delegate("要动态委派事件的元素" , "委派事件的类型" ,事件处理函数)]
            $("tfoot .pagination").delegate(".nvaPageA" , "click" , function(){
            	//获取点击a标签所在行的页码
            	var pageNum = $(this).attr("pageNum");
            	//如果页面的条件input中有内容，也应该携带提交查询分页数据
            	var condition = $("form input[name='condition']").val();
            	//发送ajax请求，请求被点击a标签对应的分页数据  更新页面
            	initRolesTable(pageNum , condition);//清空之前的数据
            	return false;
            });
            
            
            //解析数据列表的函数
            function initTableTbody(roles){
         		$.each(roles ,function(i){ //当each函数遍历时会将正在遍历的元素的索引传入到函数中
        			//this:代表正在遍历的json对象
        			//创建一行保存json的信息并追加给显示角色列表的表格
        			var $tr = $("<tr></tr>");//传入参数为html标签创建节点对象，传入参数为选择器字符串查找页面中的标签，传入参数为函数代表window.onload ， 传入参数为dom对象转为jquery对象
        			/* 
        			<tr>
	                  <td>1</td>
					  <td><input type="checkbox"></td>
	                  <td>PM - 项目经理</td>
	                  <td>
					      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
					      <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr>
		                	一条数据: {id: 1, name: "PM - 项目经理"}
        			*/
        			//js,和java的语法类似
        			$tr.append("<td>"+(++i)+"</td>")
        				.append('<td><input value="'+this.id+'" type="checkbox"></td>')
        				.append('<td>'+ this.name +'</td>')//js或json对象获取属性值：jsObj.属性名
        				.append('<td> \
  						      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\
						      <button roleId="'+ this.id +'" type="button" class="btn btn-primary btn-xs updateRoleBtn"><i class=" glyphicon glyphicon-pencil"></i></button>\
							  <button roleId="'+ this.id +'" type="button" class="btn btn-danger btn-xs remRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\
						 		</td>')
						 .appendTo("tbody");
        			//  js中如果字符串一行写不下，可以使用\代表折行
        		} );
            }
            ///////////////////////////////////////异步请求role列表并解析 代码结束/////////////////////////////////
            
            
            //给查询按钮绑定单击事件，点击时提交请求给服务器查询带条件的分页数据
            $("form #queryBtn").click(function(){
            	//获取条件
            	var condition = $("form input[name='condition']").val();
            	//发送ajax请求
            	//解析数据显示到表格中
            	initRolesTable(1 , condition);
            });
          //给tbody内的删除按钮绑定单击事件,点击提交异步删除请求响应成功dom操作删除指定标签[绑定事件：需要动态委派]
          $("tbody").delegate(".remRoleBtn" , "click" , function(){
        	  //获取点击按钮所在行的角色id
        	  //this代表被点击的按钮的dom对象
        	  var roleId = $(this).attr("roleId");
        	  //alert(roleId);
        	  var $tr = $(this).parents("tr"); //jquery对象的命名规范
        	  layer.confirm("确定删除吗?",{title:"删除提示:"} , function(index){
        		  //确认框确认按钮的单击处理函数
        		  //提交异步请求让服务器删除角色
            	  $.ajax({
            		  type:"GET",
            		  data:{"id":roleId},
            		  url:"${PATH}/role/deleteRole",
            		  success:function(result){
            			  //如果服务器响应成功，通过dom操作删除页面中的 点击按钮所在行的角色 tr
            			  if(result=="ok"){
            				  layer.msg("删除成功");
            				  $tr.remove();
            				  //判断当前页面中是否已经将所有的角色行全部删除，如果全部删除需要跳转到上一页
            				  //判断行数
            				  if($("tbody .remRoleBtn").length==0){
	            				  //如果行数为0，获取当前页码，使用当前页码-1 再发送异步请求上一页数据显示
            					  var currentPageNum = $("a.currentPageNum").html();
	            				  var pageNum = currentPageNum.substring(0,1)-1;
	            				  //alert(pageNum);
	            				  //调用提取方法
	            				  //获取条件
	            				  var condition = $("form input[name='condition']").val();
	            				  initRolesTable(pageNum,condition);
            				  }
            				  
            			  }else{
            				  layer.msg("删除失败，请稍后再试");
            			  }
            			  
            		  }
            	  });
        		  //关闭确认框
        		  layer.close(index);
        	  });
        	
        	  
          });
            
          //给修改的按钮绑定单击事件，点击时回显要修改的角色信息并 弹出修改的模态框  
          
          $("tbody").delegate(".updateRoleBtn" , "click" , function(){
        	  //异步获取要修改的角色信息
        	  var roleId = $(this).attr("roleId");
        	  $.getJSON("${PATH}/role/getRole" , {id:roleId} ,function(role){//{id:1,name:xxx}
        		  //回显role的数据到模态框中
        		  $("#updateRoleModal form input[name='id']").val(role.id);
        		  $("#updateRoleModal form input[name='name']").val(role.name);
        		  //弹出模态框
	        	  $("#updateRoleModal").modal("toggle");
        	  });
        	  
          });
           //给修改模态框的提交按钮绑定单击事件：点击提交修改请求 
            $("#updateRoleModal #updateRoleBtn").click(function(){
            	$.ajax({
            		type:"POST",
            		url:"${PATH}/role/updateRole",
            		data: $("#updateRoleModal form").serialize(),//.serialize()将表单内有name属性值的参数拼接成get方式的参数字符串： name1=val1&name2=val2
            		success:function(result){
            			if(result=="ok"){
            				//关闭模态框
            				$("#updateRoleModal").modal("toggle");
            				//修改成功
            				layer.msg("修改成功");
            				//刷新当前页面
            				var currentPageNum = $("a.currentPageNum").html();
          				   var pageNum = currentPageNum.substring(0,1);
          				   //alert(pageNum);
          				   //调用提取方法
          				   //获取条件
          				   var condition = $("form input[name='condition']").val();
          				   initRolesTable(pageNum,condition);
            			}
            		}
            	});
            });
           //编写处理弹出添加role模态框的方法
           function addRole(){
        	   $("#addRoleModal").modal("toggle");
           }
           
           
           //编写 添加模态框提交按钮被点击的处理方法
           $("#addRoleModal #saveRoleBtn").click(function(){
        	   $.ajax({
        		   type:"POST",
        		   data: $("#addRoleModal form").serialize(),
        		   url:"${PATH}/role/addRole",
        		   success:function(result){
        			   if(result=="ok"){
        				   //添加成功
        				   //关闭模态框
        				   $("#addRoleModal").modal("toggle");
        				   //跳转到最后一页显示[在获取到总页码时，将总页码在页面中使用标签的属性将页码缓存]
        				   var pages = $("input[name='pages']").val();
        				   var condition = $("form input[name='condition']").val();
          				   initRolesTable((pages+1),condition);
        			   }
        		   }
        	   });
           });
           
           //给thead中的全选矿 绑定单击事件
           $("thead :checkbox").click(function(){
        	   $("tbody :checkbox").prop("checked" , this.checked);
           });
           //给tbody内的全选框绑定单击事件[tbody中的内容是异步加载的，需要动态委派事件]
           $("tbody").delegate(":checkbox" , "click" , function(){
        	   $("thead :checkbox").prop("checked" , $("tbody :checkbox").length==$("tbody :checked").length);
           })
           //批量删除的方法
           function batchDelRoles(){
        	   //获取tbody内被选中的要删除的复选框所在行的角色id
        	   var idsArr = new Array();
        	   $.each($("tbody :checked"), function(){
        		   //this代表正在遍历的复选框
        		   idsArr.push(this.value);
        	   });
        	   //将数组转为字符串： 1 2 3   ==>  1,2,3  服务器接受时springmvc可以将此参数值转为@RequestParam("")List<Integer> 集合接受
          	    var idsStr = idsArr.join(",");
        	   //发送删除的异步请求
        	   $.ajax({
        		   type:"POST",
        		   url:"${PATH}/role/batchDelRoles",
        		   data:{"ids" : idsStr},
        		   success:function(result){
        			   if(result=="ok"){
        				   //删除成功
        				   layer.msg("删除成功");
        				   //刷新当前页面
           					var currentPageNum = $("a.currentPageNum").html();
         				   var pageNum = currentPageNum.substring(0,1);
         				   //alert(pageNum);
         				   //调用提取方法
         				   //获取条件
         				   var condition = $("form input[name='condition']").val();
         				   initRolesTable(pageNum,condition);
        			   }
        		   }
        	   });
        	   
           };
           
        </script>
        
  </body>
</html>
