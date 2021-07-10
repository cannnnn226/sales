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
            <span>账单管理页面</span>
        </div>

        <form action="${pageContext.request.contextPath}/bill/findAll.do?type=1" method="post">
            <div class="search">
                <span>账单编号：</span>
                <input name="code" type="text" placeholder="请输入账单编号"/>
                <span>操作人：</span>
                <select name="searchId">
                    <option value="0">--请选择--</option>
                    <c:forEach items="${userList}" var="user">
                        <option value="${user.id}">${user.name}</option>
                    </c:forEach>

                </select>
                <input type="submit" value="查询"/>
            </div>
        </form>

        <!--账单表格 样式和供应商公用-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="20%">账单编码</th>
                <th width="20%">创建时间</th>
                <th width="10%">总金额</th>
                <th width="10%">操作人</th>
                <th width="20%">操作</th>
            </tr>
            <c:forEach items="${billList.list}" var="bill">
                <tr>
                    <td>${bill.code}</td>
                    <td>${bill.createTime.toLocaleString()}</td>
                    <td>${bill.totalPrice}</td>
                    <td>
                        <c:forEach items="${userList}" var="user">
                            <c:if test="${bill.user_id == user.id}">${user.name}</c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/bill/findOne.do?id=${bill.id}"><img src="../img/read.png" alt="查看" title="查看"/></a>
                        <c:if test="${sessionScope.user.identity == 1}">
                            <a href="#" myValue2="${bill.id}" class="removeUser myI2">
                            <img src="../img/schu.png" alt="删除" title="删除"/></a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div class="page-icon">
            <a class="page-current" href="${pageContext.request.contextPath}/bill/findAll.do"
               aria-label="Previous">首页</a>
            <a class="previous-page"
               href="${pageContext.request.contextPath}/bill/findAll.do?page=${billList.pageNum-1}&size=5">上一页</a>

            <c:forEach begin="1" end="${billList.pages}" var="pageNums">
                <a href="${pageContext.request.contextPath}/bill/findAll.do?page=${pageNums}&size=5">${pageNums}</a>
            </c:forEach>

            <a class="page-next"
               href="${pageContext.request.contextPath}/bill/findAll.do?page=${billList.pageNum+1}&size=5">下一页</a>
            <a href="${pageContext.request.contextPath}/bill/findAll.do?page=${billList.pages}&size=5"
               aria-label="Next">尾页</a>
        </div>

    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeUse">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该账单记录吗？</p>
            <a href="${pageContext.request.contextPath}/bill/delBill.do?id=" id="yes">确定</a>
            <a id="no">取消</a>
        </div>
    </div>
</div>

<footer class="footer">

</footer>

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/time.js"></script>

<script>
    $(function () {
        $(".myI2").on("click", function (ev) {
            var str = $("#yes").attr("href");//得到初始的路径
            str = str.substr(0, str.indexOf('=') + 1)//对路径进行切割 从开头到‘=’
            // console.log(str.indexOf('='))
            // console.log(str);
            $("#yes").attr("href", str);
            // console.log( $("#yes").attr('href'));
            // console.log(ev.target.parentNode);
            var myvalue2 = ev.target.parentNode.getAttribute("myValue2");
            //console.log(myvalue);
            var href = $("#yes").attr("href");
            href += myvalue2;
            // console.log(str);
            //console.log(href);
            $("#yes").attr("href", href);
            // var str= $("#yes").attr("href").substr(0,44);
            // console.log(str)
        })
    })
</script>

</body>
</html>