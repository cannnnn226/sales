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
            <span>商品结算页面</span><br/>
            <span>当前购物车信息:<c:if test="${!empty info}">${info}</c:if></span>
        </div>

        <span>&nbsp;</span><br/>
        <span>&nbsp;</span>

        <!--商品结算页面购物车展示-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">商品编号</th>
                <th width="10%">商品名称</th>
                <th width="10%">售价</th>
                <th width="10%">数量</th>
                <th width="10%">总价</th>
                <th width="10%">商品类型</th>
                <th width="10%">操作</th>
            </tr>
            <c:if test="${!empty cartList}">
                <c:forEach items="${cartList}" var="goods">
                    <tr>
                        <td>${goods.id}</td>
                        <td>${goods.name}</td>
                        <td>${goods.price}</td>
                        <td>
                            <a onclick="subGoods('${goods.id}')">
                                <img src="../img/sub.png" width="15" height="15" alt="减一" title="减一"/>
                            </a>
                                ${goods.quantity}&nbsp;
                            <a onclick="plusGoods('${goods.id}')">
                                <img src="../img/add.png" width="15" height="15" alt="加一" title="加一"/>
                            </a>
                        </td>
                        <td>${goods.price * goods.quantity}</td>
                        <td>${goods.type==1?'食品':goods.type==2?'日用品':'家用电器'}</td>
                        <td>
                            <a onclick="deleteGoods('${goods.id}')" ><img
                                    src="../img/delete.png" width="15" height="20" alt="移除" title="移除"/></a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>

        <span>&nbsp</span>

        <form action="${pageContext.request.contextPath}/cart/findAll.do?type=1" method="post">
            <div class="search">
                <span>商品名称：</span>
                <input name="name" type="text" placeholder="请输入商品的名称"/>
                <span>商品类型：</span>
                <select name="goodsType">
                    <option value="0">--请选择--</option>
                    <option value="1">食品</option>
                    <option value="2">日用品</option>
                    <option value="3">家用电器</option>
                </select>
                <input type="submit" value="查询"/>
                <c:if test="${!empty cartList}" ><a onclick="pay()">商品结算</a></c:if>
            </div>
        </form>

        <!--商品结算页面商品展示-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">商品编号</th>
                <th width="10%">商品名称</th>
                <th width="10%">售价</th>
                <th width="10%">商品数量</th>
                <th width="10%">商品类型</th>
                <th width="10%">加入购物车</th>
            </tr>
            <c:if test="${!empty goodsList}">
                <c:forEach items="${goodsList.list}" var="goods">
                    <tr>
                        <td>${goods.id}</td>
                        <td>${goods.name}</td>
                        <td>${goods.price}</td>
                        <td>${goods.quantity}</td>
                        <td>${goods.type==1?'食品':goods.type==2?'日用品':'家用电器'}</td>
                        <td>
                            <a onclick="addGoods('${goods.id}')"><img src="../img/buy.png" width="40" height="32" alt="购买"
                                                                 title="购买"/></a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
        <div class="page-icon">
            <a class="page-current" href="${pageContext.request.contextPath}/cart/findAll.do?page=1&size=5"
               aria-label="Previous">首页</a>
            <a class="previous-page"
               href="${pageContext.request.contextPath}/cart/findAll.do?page=${goodsList.pageNum-1}&size=5">上一页</a>
            <c:forEach begin="1" end="${goodsList.pages}" var="pageNums">
                <a href="${pageContext.request.contextPath}/cart/findAll.do?page=${pageNums}&size=5">${pageNums}</a>
            </c:forEach>
            <a class="page-next"
               href="${pageContext.request.contextPath}/cart/findAll.do?page=${goodsList.pageNum+1}&size=5">下一页</a>
            <a href="${pageContext.request.contextPath}/cart/findAll.do?page=${goodsList.pages}&size=5"
               aria-label="Next">尾页</a>
        </div>

    </div>
</section>

<footer class="footer">

</footer>

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/time.js"></script>

</body>

<script>

    //添加到购物车中
    function addGoods(id) {
            $.ajax({
                url: "${pageContext.request.contextPath}/cart/addGoods.do",
                type: "POST",
                dataType: "JSON",
                data: {
                    id: id
                },
                success: function (data) {
                    if (data.result == 1) {//添加成功
                        window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                    } else if (data.result == 2){
                        alert("操作失败，该商品已经在购物车中！");
                        window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                    } else if (data.result == 3) {
                        alert("操作失败，商品库存为0！");
                        window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                    }
                }
            })
    }

    //购物车减一
    function subGoods(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/subGoods.do",
            type: "POST",
            dataType: "JSON",
            data: {
                id: id
            },
            success: function (data) {
                if (data.result == 1) {//减一成功
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                } else if (data.result == 2){
                    alert("操作失败，商品数量不能为0！");
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                }
            }
        })
    }

    //购物车加一
    function plusGoods(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/plusGoods.do",
            type: "POST",
            dataType: "JSON",
            data: {
                id: id
            },
            success: function (data) {
                if (data.result == 1) {//加一成功
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                } else if (data.result == 2){
                    alert("操作失败，该商品库存不足！");
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                }
            }
        })
    }

    //移除购物车中的商品
    function deleteGoods(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/delGoods.do",
            type: "POST",
            dataType: "JSON",
            data: {
                id: id
            },
            success: function (data) {
                if (data.result == 1) {//加一成功
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                }
            }
        })
    }

    //结算
    function pay() {
        $.ajax({
            url: "${pageContext.request.contextPath}/cart/pay.do",
            type: "POST",
            dataType: "JSON",
            data: {
            },
            success: function (data) {
                if (data.result == 1) {//结算成功
                    alert("结算成功！")
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                } else if (data.result == 2) {
                    alert("结算失败，购物车为空！")
                    window.location.href = "${pageContext.request.contextPath}/cart/findAll.do?page=" + ${goodsList.pageNum};
                }
            }
        })
    }

</script>

</html>