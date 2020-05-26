<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<!-- 
  		浏览器解析响应报文时，如何选择解码方式：
  			1、优先从响应头中获取[response.setContentType("text/html;charset=UTF-8")/CharacterEncodingFilter配置到web.xml中 并设置了forceResponseEncoding=true encoding=UTF-8   ]
  			2、如果没有1，再从响应报文的响应体中查找meta标签的charset属性值，获取到则使用
  			3、如果没有1和2，浏览器则选择使用所在系统的默认编码格式解析响应体[GBK]
  	
  	 -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- 动态包含，会编译两个java文件的两个class类文件，执行user页面的class文件时，如果有动态包含再去执行动态包含的页面的class文件 -->
    <!-- 静态包含，先将静态包含的内容原封不动的拷贝到当前位置 -->
   <%--  <jsp:include page="/WEB-INF/pages/include/base_css.jsp"></jsp:include> --%>
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
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
<form class="form-inline" role="form" style="float:left;" action="${PATH }/admin/index.html">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input value="${param.condition }" name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button id="batchDelBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              	<c:forEach items="${requestScope.pageInfo.list }" var="admin" varStatus="vs">
              		<!-- vs:遍历开始时标签创建的遍历状态对象，包含了  当前正在遍历元素的索引从0开始，当前遍历元素的个数从1开始，当前正在遍历的对象，遍历的对象是不是第一个或最后一个.. ，每次遍历时都会更新 -->
	              	<!-- table和要显示的一个集合对应 ， 表格的一行和集合中的一个元素对应 ， 一行的一个单元格和对象的一个属性对应 -->
	              	 <tr>
	                  <td>${vs.count }</td>
					  <td><input id="${admin.id }" type="checkbox"></td>
	                  <td>${admin.loginacct }</td>
	                  <td>${admin.username }</td>
	                  <td>${admin.email }</td>
	                  <td>
					      <button adminid="${admin.id }" type="button" class="btn btn-success btn-xs assignRoleBtn"><i class=" glyphicon glyphicon-check"></i></button>
					      <button adminid="${admin.id }" type="button" class="btn btn-primary btn-xs updateBtn"><i class=" glyphicon glyphicon-pencil"></i></button>
						  <button adminid="${admin.id }"  type="button" class="btn btn-danger btn-xs deleteBtn"><i class=" glyphicon glyphicon-remove"></i></button>
					  </td>
	                </tr>
              	</c:forEach>
               
               
              </tbody>
			  <tfoot>
			  	<!-- 
			  	pageNum=1,
			  	size=3, startRow=1, endRow=3, total=10, pages=4, 
			  	list= 分页列表
			  	, prePage=0, nextPage=2, isFirstPage=true, isLastPage=false, hasPreviousPage=false, 
			  	hasNextPage=true, navigatePages=3, navigateFirstPage1, navigateLastPage3, 
			  	navigatepageNums=[1, 2, 3]}
			  	
			  	 -->
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
								<!-- 上一页 -->
								<c:choose>
									<c:when test="${pageInfo.hasPreviousPage }">
										<!-- 有上一页:点击时访问当前页码-1 的页面 -->
										<li><a href="${PATH }/admin/index.html?pageNum=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a></li>
									</c:when>
									<c:otherwise>
										<!-- 没有上一页 -->
										<li class="disabled"><a href="javascipt:void(0);">上一页</a></li>
									</c:otherwise>
								</c:choose>
								<!-- [1,2,3] -->
								<c:forEach items="${pageInfo.navigatepageNums }" var="index">
									<c:choose>
										<c:when test="${pageInfo.pageNum==index }">
											<!-- 正在遍历的页码是当前页 -->
											<li class="active"><a href="javascript:void(0);">${index } <span class="sr-only">(current)</span></a></li>
										</c:when>
										<c:otherwise>
											<!-- 不是当前页 -->
											<li><a href="${PATH }/admin/index.html?pageNum=${index}&condition=${param.condition}">${index }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<!-- 上一页 -->
								<c:choose>
									<c:when test="${pageInfo.hasNextPage }">
										<!-- 有下一页:点击时访问当前页码-1 的页面 -->
										<li><a href="${PATH }/admin/index.html?pageNum=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a></li>
									</c:when>
									<c:otherwise>
										<!-- 没有下一页 -->
										<li class="disabled"><a href="javascipt:void(0);">下一页</a></li>
									</c:otherwise>
								</c:choose>
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
            //$("tbody .btn-success").click(function(){
            //    window.location.href = "assignRole.html";
          //  });
            //$("tbody .btn-primary").click(function(){
           //     window.location.href = "edit.html";
           // });
            
            //给修改按钮绑定单击事件
            $(".updateBtn").click(function(){
            	//获取修改的管理员的id
            	var adminId = $(this).attr("adminid");
            	//提交请求给服务器 查询管理员信息
            	window.location = "${PATH}/admin/getAdmin?adminId="+adminId;
            });
            
            
            //给删除管理员按钮绑定单击事件，点击删除所在行的管理员
            $(".deleteBtn").click(function(){
            	//获取被点击的标签的adminId 属性值，代表要删除的管理员的id
            	//prop();获取标签自带属性，  attr():获取标签自定义属性
            	var adminId = $(this).attr("adminid");
            	layer.confirm("你确定删除 "+$(this).parents("tr").children("td:eq(3)").text()+" 吗?" , {title:"删除确认"} , function(index){
            		layer.close(index);
            		//点击确认框的确认按钮的回调方法
	            	//后台根据id识别唯一的一条记录
	            	window.location = "${PATH}/admin/deleteAdmin?adminId="+adminId;
            	});
            });
            //给全选框绑定单击事件，设置管理员列表的复选框状态和它一致
            $("thead :checkbox").click(function(){
            	$("tbody :checkbox").prop("checked" , this.checked);
            });
            //给管理员列表的复选框设置单击事件，点击时 判断如果有没被选中的，则设置全选框未选中，否则设置全选矿为选中
            $("tbody :checkbox").click(function(){
            	$("thead :checkbox").prop("checked"  , $("tbody :checkbox:checked").length==$("tbody :checkbox").length);
            });
            
            //给批量删除按钮绑定单击事件
            $("#batchDelBtn").click(function(){
            	//获取选中要删除的复选框所在行的管理员id列表
            	var $checkedIpus = $("tbody :checked");
            	var idsStr = "";
            	$.each($checkedIpus , function(){
            		//this代表正在遍历的 复选框
            		var adminId = this.id;
            		idsStr+="id="+adminId+"&"
            	});
            	//截取字符串：将最后拼接的&截取掉
            	idsStr = idsStr.substring(0,idsStr.length-1);
            	// id=1&id=2&id=3&  
            	window.location = "${PATH}/admin/batchDelAdmins?idsStr="+idsStr;
            });
            //给分配角色按钮绑定单击事件
            $(".assignRoleBtn").click(function(){
            	//获取单击按钮所在行的id
            	var id = $(this).attr("adminId");
            	//跳转页面
            	window.location="${PATH}/admin/assignRole.html?id="+id;
            });
            
        </script>
  </body>
</html>
