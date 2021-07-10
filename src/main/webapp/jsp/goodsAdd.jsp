<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span>商品管理页面 >> 商品添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="#">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="">
                    <label for="name">商品名称：</label>
                    <input type="text" name="name" id="name"/>
                    <span>*请输入商品名称</span>
                </div>
                <div>
                    <label for="purchasePrice">进价：</label>
                    <input type="text" name="purchasePrice" id="purchasePrice"/>
                    <span>*请输入进价</span>
                </div>
                <div>
                    <label for="price">售价：</label>
                    <input type="text" name="price" id="price"/>
                    <span>*请输入售价</span>
                </div>
                <div>
                    <label for="desc">商品描述：</label>
                    <input type="text" name="desc" id="desc"/>
                    <span>*请输入商品描述</span>
                </div>
                <div>
                    <label for="quantity">商品数量：</label>
                    <input type="text" name="quantity" id="quantity"/>
                    <span>*请输入商品数量</span>
                </div>
                <div>
                    <label>商品类型：</label>
                    <input type="radio" name="type" value="1"/>食品
                    <input type="radio" name="type" value="2"/>日用品
                    <input type="radio" name="type" value="3"/>家用电器
                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="goodsList.html">返回</a>-->
                    <input class="add" type="button" value="保存"/>
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
        $(".add").on("click", function () {

            var name = $("input[name=name]").val();
            var purchasePrice = $("input[name=purchasePrice]").val();
            var price = $("input[name=price]").val();
            var desc = $("input[name=desc]").val();
            var quantity = $("input[name=quantity]").val();
            var type = $("input[name=type]:checked").val();

            if (name === "") {
                alert("商品名称不能为空！");
                return ;
            }
            if (purchasePrice === "" || isNaN(purchasePrice) || parseFloat(purchasePrice) <= 0) {
                alert("商品进价请输入大于0的数字！");
                return ;
            }
            if (price === "" || isNaN(price) || parseFloat(price) <= 0) {
                alert("商品售价请输入大于0的数字！");
                return ;
            }
            if (desc === "") {
                alert("商品描述不能为空！");
                return ;
            }
            if (quantity === "" || !(/(^[1-9]\d*$)/.test(quantity))) {
                alert("商品数量请输入正整数！");
                return ;
            }
            if (type == null) {
                alert("商品类型不能不选！");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/goods/addGoods.do",
                type: "POST",
                dataType: "JSON",
                data: {
                    name: name,
                    purchasePrice: purchasePrice,
                    price: price,
                    desc: desc,
                    quantity: quantity,
                    type: type
                },
                success: function (data) {
                    if (data.result == 1) {
                        alert("添加成功！商品编号：" + data.id);
                        window.location.href = "${pageContext.request.contextPath}/goods/findAll.do";
                    } else if (data.result == 2) {
                        alert("添加失败！商品已存在");
                        window.location.href = "${pageContext.request.contextPath}/jsp/goodsAdd.jsp";
                    }
                }
            })
        })

    })


</script>

</html>