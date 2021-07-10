<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市销售管理系统</title>
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/style.css"/>
</head>
<body>
<!--头部-->
<jsp:include page="/common/header.jsp"></jsp:include>
<!--主体内容-->
<section class="publicMian">
    <jsp:include page="/common/aside.jsp"></jsp:include>
    <div class="right">
        <img class="wColck" src="../img/clock.jpg" alt=""/>
        <div class="wFont">
            <h2>${sessionScope.user.name}</h2>
            <p>欢迎来到超市销售管理系统!</p>
        </div>
    </div>
</section>
<footer class="footer">
    
</footer>
<script src="../js/time.js"></script>
</body>
</html>