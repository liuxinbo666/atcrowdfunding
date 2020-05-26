<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="tree">
				<ul style="padding-left:0px;" class="list-group">
					<c:choose>
						<c:when test="${empty pmenus }">
							<h3>查询菜单失败</h3>
						</c:when>
						<c:otherwise>
							<c:forEach items="${pmenus }" var="pmenu">
								<c:choose>
									<c:when test="${empty pmenu.children }">
										<li class="list-group-item tree-closed" >
											<a href="${PATH }/${pmenu.url }"><i class="${pmenu.icon }"></i> ${pmenu.name }</a> 
										</li>
									</c:when>
									<c:otherwise>
										<li class="list-group-item tree-closed">
											<span><i class="${pmenu.icon }"></i> ${pmenu.name } <span class="badge" style="float:right">${pmenu.children.size() }</span></span> 
											<ul style="margin-top:10px;display:none;">
												<c:forEach items="${pmenu.children }" var="childmenu">
													<li style="height:30px;">
														<a href="${PATH }/${childmenu.url }"><i class="${childmenu.icon }"></i> ${childmenu.name }</a> 
													</li>
												</c:forEach>
												
											</ul>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
       
       