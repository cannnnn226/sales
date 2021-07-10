<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/style.css"/>
</head>
<body>
<!--头部-->
<jsp:include page="/common/header.jsp"></jsp:include>
<!--主体内容-->
<section class="publicMian ">
    <jsp:include page="/common/aside.jsp"></jsp:include>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面 >> 用户信息查看页面</span>
        </div>
        <div class="providerView">
            <p><strong>用户账号：</strong><span>${user.id}</span></p>
            <p><strong>用户姓名：</strong><span>${user.name}</span></p>
            <p><strong>用户密码：</strong><span>${user.password}</span></p>
            <p><strong>用户性别：</strong><span>${user.gender==2?"女":"男"}</span></p>
<%--            <p><strong>出生日期：</strong><span>${user.birthday.toLocaleString()}</span></p>--%>
            <p><strong>出生日期：</strong><span><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/></span></p>
            <p><strong>用户电话：</strong><span>${user.phone}</span></p>
            <p><strong>用户地址：</strong><span>${user.address}</span></p>
            <p><strong>用户类别：</strong><span>${user.identity==1?"管理员":"售货员"}</span></p>
            <a href="${pageContext.request.contextPath}/user/findAll.do">返回</a>
        </div>
    </div>
</section>
<footer class="footer">
    
</footer>
<script src="../js/time.js"></script>

</body>
</html>