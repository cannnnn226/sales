<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/14
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="left">
    <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
    <nav>
        <ul class="list">
            <li><a href="${pageContext.request.contextPath}/cart/findAll.do?type=2">商品结算</a></li>
            <c:if test="${sessionScope.user.identity == 2}">
                <li class="goodsManage"><a href="${pageContext.request.contextPath}/goods/findAll.do?type=2">商品信息</a></li>
                <li class="billManage"><a href="${pageContext.request.contextPath}/bill/findAll.do?type=2">账单信息</a></li>
            </c:if>
            <c:if test="${sessionScope.user.identity == 1}">
                <li class="goodsManage"><a href="${pageContext.request.contextPath}/goods/findAll.do?type=2">商品管理</a></li>
                <li class="billManage"><a href="${pageContext.request.contextPath}/bill/findAll.do?type=2">账单管理</a></li>
                <li class="userManage"><a href="${pageContext.request.contextPath}/user/findAll.do?type=2">用户管理</a></li>
            </c:if>
            <li class="exit"><a href="${pageContext.request.contextPath}/login/logOut.do">退出系统</a></li>
        </ul>
    </nav>
</div>
</body>
</html>
