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
            <span>用户管理页面</span>
        </div>

        <form action="${pageContext.request.contextPath}/user/findAll.do?type=1" method="post">
            <div class="search">
                <span>用户姓名：</span>
                <input type="text" name="name" placeholder="请输入用户姓名"/>
                <span>用户类型：</span>
                <select name="userType">
                    <option value="0">--请选择--</option>
                    <option value="1">管理员</option>
                    <option value="2">售货员</option>
                </select>
                <input type="submit" value="查询" style="width: 100px"/>
                <a href="../jsp/userAdd.jsp">添加用户</a>
            </div>
        </form>

        <jsp:useBean id="nowDate" class="java.util.Date"/>
        <!--用户-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">账号</th>
                <th width="10%">姓名</th>
                <th width="10%">性别</th>
                <th width="10%">年龄</th>
                <th width="10%">电话</th>
                <th width="10%">地址</th>
                <th width="10%">类型</th>
                <th width="30%">操作</th>
            </tr>
            <c:if test="${!empty userList}">
                <c:forEach items="${userList.list}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.gender==2?"女":"男"}</td>
                        <td>${nowDate.year-user.birthday.year}</td>
                        <td>${user.phone}</td>
                        <td>${user.address}</td>
                        <td>
                            <c:if test="${user.identity eq 1}">管理员</c:if>
                            <c:if test="${user.identity eq 2}">售货员</c:if>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/user/findOne.do?id=${user.id}"><img
                                    src="../img/read.png" alt="查看" title="查看"/></a>
                            <a href="${pageContext.request.contextPath}/user/selOne.do?id=${user.id}"><img
                                    src="../img/xiugai.png" alt="修改" title="修改"/></a>
                            <c:if test="${sessionScope.user.id != user.id}"><a href="#" myValue="${user.id}" class="removeUser myI">
                                <img src="../img/schu.png" alt="删除" title="删除"/></a></c:if>
                                <%--<img src="../img/schu.png" alt="删除" title="删除"/>--%>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>

        <div class="page-icon">
            <a class="page-current" href="${pageContext.request.contextPath}/user/findAll.do?page=1&size=5"
               aria-label="Previous">首页</a>
            <a class="previous-page"
               href="${pageContext.request.contextPath}/user/findAll.do?page=${userList.pageNum-1}&size=5">上一页</a>

            <c:forEach begin="1" end="${userList.pages}" var="pageNums">
                <a href="${pageContext.request.contextPath}/user/findAll.do?page=${pageNums}&size=5">${pageNums}</a>
            </c:forEach>

            <a class="page-next"
               href="${pageContext.request.contextPath}/user/findAll.do?page=${userList.pageNum+1}&size=5">下一页</a>
            <a href="${pageContext.request.contextPath}/user/findAll.do?page=${userList.pages}&size=5"
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
            <p>你确定要删除该用户吗？</p>
            <a href="${pageContext.request.contextPath}/user/delUser.do?id=" id="yes">确定</a>
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
        $(".myI").on("click", function (ev) {
            var str = $("#yes").attr("href");//得到初始的路径
            str = str.substr(0, str.indexOf('=') + 1)//对路径进行切割 从开头到‘=’
            $("#yes").attr("href", str);
            var myvalue = ev.target.parentNode.getAttribute("myValue");
            var href = $("#yes").attr("href");
            href += myvalue;
            $("#yes").attr("href", href);
        })
    })

</script>
</body>
</html>