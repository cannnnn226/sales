<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
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
            <span>用户管理页面 >> 用户添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="#">
                <!--div的class 为error是验证错误，ok是验证成功-->
<%--                <div class="">--%>
<%--                    <label for="userId">用户编码：</label>--%>
<%--                    <input type="text" name="userCode" id="userId"/>--%>
<%--                    <span>*请输入用户编码，且不能重复</span>--%>
<%--                </div>--%>
                <div>
                    <label for="name">姓名：</label>
                    <input type="text" name="name" id="name"/>
                    <span>*请输入姓名</span>
                </div>
                <div>
                    <label for="password">密码：</label>
                    <input type="text" name="password" id="password"/>
                    <span>*密码长度必须大于6位小于20位</span>

                </div>
                <div>
                    <label for="userRemi">确认密码：</label>
                    <input type="text" name="userRemi" id="userRemi"/>
                    <span>*请输入确认密码</span>
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
                    <label for="data">出生日期：</label>
                    <input type="date" name="birthday" id="data"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                    <input type="text" name="address" id="address"/>
                    <span>*</span>
                </div>
                <div>
                    <label>用户类别：</label>
                    <input type="radio" name="identity" value="1"/>管理员
                    <input type="radio" name="identity" value="2"/>售货员
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="userList.jsp">返回</a>-->
                    <input class="update" type="button" value="保存"/>
                    <input type="button" value="返回" onclick="history.back(-1)"/>
                </div>
            </form>
        </div>

    </div>
</section>
<footer class="footer">

</footer>
<script src="${pageContext.request.contextPath}/js/time.js"></script>

</body>

<script>
    $(function () {
        $(".update").on("click", function () {
            //alert("123");
            //获取输入框内容
            var name = $("input[name=name]").val();
            var password = $("input[name=password]").val();
            var userRemi = $("input[name=userRemi]").val();
            var gender = $("select[name=gender]").val();
            var birthday = $("input[name=birthday]").val();
            var phone = $("input[name=phone]").val();
            var address = $("input[name=address]").val();
            var identity = $("input[name=identity]:checked").val();
            //alert(gender + "****" + userType);//提示信息

            //输入框表单验证

            if(name === ""){
                alert("用户名称不能为空！");
                return;
            }
            if(password === ""){
                alert("用户密码不能为空！");
                return;
            }
            if(userRemi === ""){
                alert("确认密码不能为空！");
                return;
            }
            if(password != userRemi){
                alert("两次密码输入不一致！");
                return;
            }
            if(birthday == ""){
                alert("用户出生日期不能为空！");
                return;
            }
            if(phone == ""){
                alert("电话号码不能为空！");
                return;
            }
            if(address == ""){
                alert("地址不能为空！");
                return;
            }
            if(identity == ""){
                alert("用户类型不能不选！");
                return;
            }

            //url: 点击btn之后，发生的事情，等同于action；type：请求的方式；dataType：数据传输格式
            $.ajax({
                url:"${pageContext.request.contextPath}/user/addUser.do",
                type: "POST",
                dataType: "JSON",
                data:{
                    name:name,
                    password:password,
                    gender:gender,
                    birthday:birthday,
                    phone:phone,
                    address:address,
                    identity:identity
                },
                success: function (data){
                    if (data.result==1){
                        alert("添加成功！账号：" + data.id);
                        window.location.href="${pageContext.request.contextPath}/user/findAll.do";
                    }
                }
            })
        })
    })
</script>
</html>