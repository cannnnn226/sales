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
            <c:if test="${sessionScope.user.identity==1}"><span>商品管理页面</span></c:if>
            <c:if test="${sessionScope.user.identity==2}"><span>商品信息页面</span></c:if>
        </div>

        <form action="${pageContext.request.contextPath}/goods/findAll.do?type=1" method="post">
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
                <c:if test="${sessionScope.user.identity == 1}"><a href="../jsp/goodsAdd.jsp">添加商品</a></c:if>
            </div>
        </form>

        <!--商品操作表格 管理员-->
        <c:if test="${sessionScope.user.identity == 1}">
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">商品编号</th>
                    <th width="10%">商品名称</th>
                    <th width="10%">进货价</th>
                    <th width="10%">售价</th>
                    <th width="10%">商品描述</th>
                    <th width="10%">商品数量</th>
                    <th width="10%">商品类型</th>
                    <th width="10%">操作</th>
                </tr>
                <c:if test="${!empty goodsList}">
                    <c:forEach items="${goodsList.list}" var="goods">
                        <tr>
                            <td>${goods.id}</td>
                            <td>${goods.name}</td>
                            <td>${goods.purchasePrice}</td>
                            <td>${goods.price}</td>
                            <td>${goods.desc}</td>
                            <td>${goods.quantity}</td>
                            <td>${goods.type==1?'食品':goods.type==2?'日用品':'家用电器'}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/goods/selOne.do?id=${goods.id}"><img
                                        src="../img/xiugai.png" width="15" height="15" alt="修改" title="修改"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </c:if>

        <!--商品操作表格 售货员-->
        <c:if test="${sessionScope.user.identity == 2}">
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">商品编号</th>
                    <th width="10%">商品名称</th>
                    <th width="10%">进货价</th>
                    <th width="10%">售价</th>
                    <th width="10%">商品描述</th>
                    <th width="10%">商品数量</th>
                    <th width="10%">商品类型</th>
                </tr>
                <c:if test="${!empty goodsList}">
                    <c:forEach items="${goodsList.list}" var="goods">
                        <tr>
                            <td>${goods.id}</td>
                            <td>${goods.name}</td>
                            <td>${goods.purchasePrice}</td>
                            <td>${goods.price}</td>
                            <td>${goods.desc}</td>
                            <td>${goods.quantity}</td>
                            <td>${goods.type==1?'食品':goods.type==2?'日用品':'家用电器'}</td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </c:if>

        <div class="page-icon">
            <a class="page-current" href="${pageContext.request.contextPath}/goods/findAll.do?page=1&size=8"
               aria-label="Previous">首页</a>
            <a class="previous-page"
               href="${pageContext.request.contextPath}/goods/findAll.do?page=${goodsList.pageNum-1}&size=8">上一页</a>

            <c:forEach begin="1" end="${goodsList.pages}" var="pageNums">
                <a href="${pageContext.request.contextPath}/goods/findAll.do?page=${pageNums}&size=8">${pageNums}</a>
            </c:forEach>

            <a class="page-next"
               href="${pageContext.request.contextPath}/goods/findAll.do?page=${goodsList.pageNum+1}&size=8">下一页</a>
            <a href="${pageContext.request.contextPath}/goods/findAll.do?page=${goodsList.pages}&size=8"
               aria-label="Next">尾页</a>
        </div>

    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeProv">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该供应商吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>


<footer class="footer">

</footer>

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/time.js"></script>

</body>
</html>