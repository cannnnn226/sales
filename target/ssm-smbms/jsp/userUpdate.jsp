<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市销售管理系统</title>
    <link rel="stylesheet" href="../css/public.css"/>
    <link rel="stylesheet" href="../css/style.css"/>
    <script src="../js/jquery.js"></script>
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
            <span>用户管理页面 >> 用户信息修改页面</span>
        </div>
        <div class="providerAdd">
            <%--            <form action="${pageContext.request.contextPath}/user/updUserById.do?id=${user.id}" method="post">--%>
            <form action="#">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="name">用户姓名：</label>
                    <input type="text" name="name" id="name" placeholder="${user.name}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="password">用户密码：</label>
                    <input type="text" name="password" id="password" placeholder="${user.password}"/>
                    <span>*</span>
                </div>
                <div>
                    <label>用户性别：</label>
                    <select name="gender">
                        <option value="1" ${user.gender==1?'selected':''}>男</option>
                        <option value="2" ${user.gender==2?'selected':''}>女</option>
                    </select>
                </div>
                <div>
                    <label for="data">出生日期：</label>
                    <input type="date" name="birthday" id="data">
                    <%--需要加命名空间--%>
                    <span><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/></span>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone" placeholder="${user.phone}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="userAddress">用户地址：</label>
                    <input type="text" name="address" id="userAddress" placeholder="${user.address}"/>
                    <span>*</span>
                </div>

                <div>
                    <label>用户类别：</label>
                    <input type="radio" name="identity" value="1" ${user.identity==1?'checked':''}>管理员
                    <c:if test="${sessionScope.user.id != user.id}">
                        <input type="radio" name="identity" value="2" ${user.identity==2?'checked':''}>售货员
                    </c:if>
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="userList.html">返回</a>-->
                    <%--<input class="btn" type="submit" value="保存"/>--%>
                    <input type="button" class="login_bg" value="保存">
                    <input type="button" value="返回" onclick="history.back(-1)"/>
                </div>
            </form>
        </div>

    </div>
</section>
<footer class="footer">
</footer>
<script src="../js/time.js"></script>

</body>
<script>
    $(function () {
        $(".login_bg").on("click", function () {
            //获取输入框内容
            var name = $("input[name=name]").val();
            var password = $("input[name=password]").val();
            var gender = $("select[name=gender]").val();
            var birthday = $("input[name=birthday]").val();
            var phone = $("input[name=phone]").val();
            var address = $("input[name=address]").val();
            var identity = $("input[name=identity]:checked").val();
            //alert(gender + "****" + userType);//提示信息

            //输入框表单验证
            if (name === "") {
                alert("用户姓名不能为空！");
                return;
            }
            if (password === "") {
                alert("用户密码不能为空！");
                return;
            }
            if (birthday === "") {
                alert("出生日期不能为空！");
                return;
            }
            if (phone === "") {
                alert("电话号码不能为空！");
                return;
            }
            if (address === "") {
                alert("地址不能为空！");
                return;
            }
            if (identity == null) {
                alert("用户类型不能不选！");
                return;
            }
            //url: 点击btn之后，发生的事情，等同于action；type：请求的方式；dataType：数据传输格式
            $.ajax({
                url: "${pageContext.request.contextPath}/user/updUserById.do",
                type: "POST",
                dataType: "JSON",
                data: {
                    id:${user.id},
                    name: name,
                    password: password,
                    gender: gender,
                    birthday: birthday,
                    phone: phone,
                    address: address,
                    identity: identity
                },
                success: function (data) {
                    if (data.result == 1) {
                        alert("修改成功！");
                        window.location.href = "${pageContext.request.contextPath}/user/findAll.do";
                    } else if (data.result == 2) {
                        alert("修改成功，请重新登录！");
                        window.location.href = "${pageContext.request.contextPath}/login/logOut.do";
                    }
                }
            })
        })
    })
</script>
</html>