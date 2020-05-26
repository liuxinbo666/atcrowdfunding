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
	.tree-closed {
	    height : 40px;
	}
	.tree-expanded {
	    height : auto;
	}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 控制面板</a></div>
        </div> 
        <!-- 动态包含  jsp:include和静态包含的区别：    -->
        <%@ include file="/WEB-INF/pages/include/admin_loginbar.jsp"  %>
      </div>
    </nav>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
		
         <%@ include file="/WEB-INF/pages/include/admin_leftmenu.jsp"  %>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">控制面板</h1>

          <div class="row placeholders">
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
          </div>
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
            
            $("#logoutA").click(function(){
            	//弹出一个load 加载进度弹层
            	var index = layer.load();
            	//发送ajax请求给服务器注销
            	$.post("${PATH}/logout" , function(data){
            		setTimeout(function(){//判断结果
            			layer.close(index);
	    	            	//接受到服务器的响应
	    	            	if("success"==data){
	    	            		//如果注销成功，关闭进度加载的弹层，给用户一个注销成功的提示
	    	            		layer.msg("注销成功，即将跳转到首页...");
	    	            		setTimeout(function(){
	    	            			//再跳转到index.jsp页面给用户响应
		    		            	window.location = "${PATH}/index";
	    	            		},2000);
	    		            	
	    	            	}else{
	    	            		layer.msg("注销失败，请稍后重试...");
	    	            	}
    	            	},2000);
            		
            	});
            	
            	
            	return false;//取消a标签的默认行为
            });
            
        </script>
  </body>
</html>
