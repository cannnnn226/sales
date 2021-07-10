<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>系统登录 - 超市销售管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body class="login_bg">
<section class="loginBox">
    <header class="loginHeader">
        <h1>超市销售管理系统</h1>
    </header>
    <section class="loginCont">
        <form class="loginForm">
            <div class="inputbox">
                <label for="id">账号：</label>
                <input id="id" type="text" name="id" placeholder="请输入账号" required/>
            </div>
            <div class="inputbox">
                <label for="password">密码：</label>
                <input id="password" type="password" name="password" placeholder="请输入密码" required/>
            </div>
            <div class="subBtn">
                <input type="button" value="登录" class="login" />
                <input type="button" onclick="window.location.href='register.jsp'" value="注册"/>
            </div>
        </form>
    </section>
</section>

</body>

<script>
    $(function () {
        $(".login").on("click", function () {
            //获取输入框内容
            var id = $("input[name=id]").val();
            var password = $("input[name=password]").val();

            if (id === "" || isNaN(id) || parseFloat(id) <= 0 || !(/(^[1-9]\d*$)/.test(id))) {
                alert("请输入正确的账号！");
                return ;
            }
            if (password == "") {
                alert("密码不能为空！");
                return;
            }

            //url: 点击btn之后，发生的事情，等同于action；type：请求的方式；dataType：数据传输格式
            $.ajax({
                url: "${pageContext.request.contextPath}/login/doLogin.do",
                type: "POST",
                dataType: "JSON",
                data: {
                    id: id,
                    password: password,
                },
                success: function (data) {
                    if (data.result == 1) {
                        // alert("success")
                        window.location.href = "${pageContext.request.contextPath}/jsp/welcome.jsp";
                    } else if (data.result == 2) {
                        alert("账号不存在，请重新输入！")
                        window.location.href = "${pageContext.request.contextPath}/login.jsp";
                    } else {
                        alert("密码错误，请重新输入！")
                        window.location.href = "${pageContext.request.contextPath}/login.jsp";
                    }
                }
            })
        })
    })
</script>
</html>