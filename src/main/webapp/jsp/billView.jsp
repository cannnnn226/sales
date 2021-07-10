<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市销售管理系统</title>
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/style.css"/>
    <link rel="stylesheet" href="../css/page.css"/>
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
            <span>账单管理页面 >> 账单信息查看</span>
        </div>

        <form action="#">
            <div class="search">
                <strong><span>账单编号：${bill.id}, 总价：${bill.totalPrice}, 付款日期：${bill.createTime.toLocaleString()}, 操作员：${user.name}</span></strong>
                <a href="${pageContext.request.contextPath}/bill/findAll.do">返回</a>
            </div>
        </form>

        <!--账单表格-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">商品编码</th>
                <th width="10%">商品名称</th>
                <th width="10%">单价</th>
                <th width="10%">购买数量</th>
                <th width="10%">总价</th>
            </tr>
            <c:forEach items="${goodsList}" var="goods">
                <tr>
                    <td>${goods.id}</td>
                    <td>${goods.name}</td>
                    <td>${goods.price}</td>
                    <td>${goods.quantity}</td>
                    <td>${goods.purchasePrice}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</section>
<footer class="footer">
   
</footer>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/time.js"></script>

</body>
</html>