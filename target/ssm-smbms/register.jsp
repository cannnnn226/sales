<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>新用户注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body class="login_bg">
<section class="publicMian ">
    <div>
        <div class="providerAdd">
            <form action="#">
                <div>
                    <label for="id">手机号：</label>
                    <input id="id" type="text" name="username" placeholder="手机号" required/>
                </div>
                <div>
                    <label for="password">密码：</label>
                    <input id="password" type="password" name="password" placeholder="请输入密码" required/>
                </div>
                <div>
                    <label for="checkPassword">确认密码：</label>
                    <input id="checkPassword" type="password" name="checkPassword" placeholder="再次输入密码" required/>
                </div>
                <div>
                    <label>用户性别：</label>
                    <select name="gender">
                        <option value="1">男</option>
                        <option value="2">女</option>
                    </select>
                    <span></span>
                </div>
                <div>
                    <label>出生日期</label>
                    <input type="date" id="birthday" name="birthday" required>
                    <div id="timeRemind2"></div>
                </div>
                <div>
                    <label>所在地区:</label>
                    <div data-toggle="distpicker">
                        <div class="form-group col-sm-12 col-md-3">
                            <label class="sr-only" for="province">province</label>
                            <select class="form-control" id="province" name="province"></select>
                        </div>
                        <div class="form-group col-sm-12 col-md-3">
                            <label class="sr-only" for="city">city</label>
                            <select class="form-control" id="city" name="city"></select>
                        </div>
                        <div class="form-group col-sm-12 col-md-3">
                            <label class="sr-only" for="district">district</label>
                            <select class="form-control" id="district" name="district"></select>
                        </div>
                    </div>
                </div>
                <div class="inputbox">
                    <label for="checkPassword">社区：</label>
                    <input id="community" type="text" name="community" placeholder="请输入社区" required/>
                </div>
                <div class="subBtn">
                    <input type="button" style="width: 100px" value="注册" class="register"/>
                    <input type="button" style="width: 100px" onclick="window.location.href='login.jsp'" value="返回"/>
                </div>
            </form>
        </div>
    </div>
</section>

</body>

<%--<script src="${pageContext.request.contextPath}/dist/css/bootstrap-theme.css"></script>--%>
<%--<script src="${pageContext.request.contextPath}/dist/css/bootstrap.css"></script>--%>
<script src="${pageContext.request.contextPath}/dist/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/distpicker.data.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/distpicker.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/jquery.min.js"></script>
<%--<script src="${pageContext.request.contextPath}/dist/js/npm.js"></script>--%>
<script>
    $(function () {
        $(".register").on("click", function () {
            //获取输入框内容
            var username = $("input[name=username]").val();
            var password = $("input[name=password]").val();
            var checkPassword = $("input[name=checkPassword]").val();
            var gender = $("select[name=gender]").val();
            var birthday = $("input[name=birthday]").val();
            var province = $("#province option:selected").val();
            var city = $("#city option:selected").val();
            var district = $("#district option:selected").val();
            var community = $("input[name=community]").val();

            if (username === "" || username.length !== 11) {
                alert("请输入正确的手机号！");
                return;
            }

            if (password === "") {
                alert("密码不能为空！");
                return;
            }

            if (checkPassword === "") {
                alert("确认密码不能为空！");
                return;
            }

            if (gender === "") {
                alert("性别不能为空！");
                return ;
            }

            if (birthday === "") {
                alert("生日不能为空！");
                return;
            }

            if (province === "") {
                alert("省份不能为空！");
                return;
            }

            if (city === "") {
                alert("市不能为空！");
                return;
            }

            if (district === "") {
                alert("区不能为空！");
                return;
            }

            if (community === "") {
                alert("社区不能为空！");
                return;
            }

            if (password !== checkPassword) {
                alert("两次输入的密码不一致！");
                return;
            }

            $.ajax({
                // 路径自己修改
                url: "${pageContext.request.contextPath}/login/register.do",
                type: "POST",
                dataType: "JSON",
                data: {
                    id: id,
                    password: password,
                    gender: gender,
                    birthday: birthday,
                    province: province,
                    city: city,
                    district: district,
                    community: community
                },
                success: function (data) {
                    if (data.result === 1) {
                        alert("注册成功")
                        window.location.href = "${pageContext.request.contextPath}/jsp/welcome.jsp";
                    } else if (data.result === 2) {
                        alert("手机号已存在，注册失败！")
                        window.location.href = "${pageContext.request.contextPath}/register.jsp";
                    }
                }
            })
        })
    })
</script>
</html>