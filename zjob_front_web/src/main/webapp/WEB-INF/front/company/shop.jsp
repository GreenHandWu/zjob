<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>产品管理</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script SRC="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/zjob.css" />
    <script>
        var ck;
        $(function(){
            //在页面加载完成后初始化分页条
            $('#pagination').bootstrapPaginator({

                //主版本号
                bootstrapMajorVersion: 3,
                //当前页
                currentPage:${data.pageNum},
                //总页数
                totalPages:${data.pages},//el表达式取的是对应属性的get方法
                //分页时用到的url请求
                //page:当前页
                pageUrl: function (type, page, current) {
                    return '${pageContext.request.contextPath}/front/company/findProductAllByPage?pageNum='+page;
                },
                itemTexts: function (type, page, current) {//根据type的值，显示对应的分页栏
                    switch (type) {
                        case "first":
                            return '首页';

                        case "prev":
                            return '上一页';
                        case "next":
                            return '下一页';
                        case "last":
                            return '尾页';
                        case "page":
                            return page;
                    }
                }
            });

        });

        function showShopModel(productId,companyId,productName,productPrice) {
            $("#productId").val(productId);
            $("#companyId").val(companyId);
            $("#productName").val(productName);
            $("#productPrice").val(productPrice);
            $("#positionNum").val('1');
            $("#price").val(productPrice);
            $('#shopModel').modal('show');
        }
       function checkNum() {
          var num =  $("#positionNum").val();
          if(num<=0){
              alert("购买数量需要大于0");
              $("#positionNum").val('1');
              $("#price").val($("#productPrice").val());
          }else if(num<100){
          var price = $("#positionNum").val()*$("#productPrice").val();
           $("#price").val(price);
          }else{
              alert("购买数量得在1-100之间");
              $("#positionNum").val('1');
              $("#price").val($("#productPrice").val());
          }
       }

        function checkOrder() {
            $.post('${pageContext.request.contextPath}/front/company/checkOrder',
                //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                $('#frmShopProduct').serialize(), function (data) {
                if(data=="success"){
                    console.log(data);
                    $('#showQR').modal('hide');
                    layer.msg("支付成功", {
                        time: 2000,
                        skin: 'successMsg'
                    });
                    clearInterval(ck);

                }
                });

        }
        function shop(){
            var createDate = new Date();
            $("#createDate").val(createDate);
            $('#shopModel').modal('hide');
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/front/company/shop',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmShopProduct').serialize(), function (url) {
                        $('#imgQR').attr('src','${pageContext.request.contextPath}/front/company/showQR?image='+url);
                        $('#showQR').modal('show');
                    });
            ck = setInterval(checkOrder, 3000);
        }

        function showProductDetail(id){
            $.post('${pageContext.request.contextPath}/front/company/findProductById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#detailProductName').val(result.obj.productName);
                        $('#detailProductPrice').val(result.obj.productPrice);
                        $('#detailPositionNum').val(result.obj.positionNum);
                        $('#detailProductDesc').val(result.obj.productDesc);
                        $('#detailProduct').modal('show');
                    }
                });
        }

    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">产品列表</h3>
    </div>
    <div class="panel-body">
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">产品名称</th>
                    <th class="text-center">产品描述</th>
                    <th class="text-center">产品价格</th>
                    <th class="text-center">邮件发送数量</th>
                    <th class="text-center">购买</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="product">
                    <tr>
                        <%--<td>${product.id}</td>--%>
                        <td>${product.productName}</td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${product.productDesc}</div></td>
                        <td>${product.productPrice}</td>
                        <td>${product.positionNum}</td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="详情"
                                   onclick="showProductDetail(${product.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="购买"
                                   onclick="showShopModel('${product.id}','${company.id}','${product.productName}','${product.productPrice}')">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%--bootstrap分页条--%>
            <ul id="pagination"></ul>
        </div>
    </div>
</div>
<!-- 添加产品 start -->
<div class="modal fade" tabindex="-1" id="shopModel" >
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmShopProduct" method="post" class="form-horizontal">
            <input type="hidden" class="form-control" id="productId" name="productId">
            <input type="hidden" class="form-control" id="companyId" name="companyId">
            <input type="hidden" class="form-control" id="createDate" name="createDate">

            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">购买产品</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="productName" class="col-sm-4 control-label">产品名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productName" name="productName" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="productPrice" class="col-sm-4 control-label">产品价格：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productPrice" name="productPrice" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionNum" class="col-sm-4 control-label">购买数量：</label>
                        <div class=" col-sm-4">
                            <input type="number" class="form-control" id="positionNum" name="positionNum" onchange="checkNum()">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="productDesc" class="col-sm-4 control-label">总价：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="price" name="price">
                        </div>
                    </div>
                    <br>

                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-primary" onclick="shop()" value="购买"></input>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加产品 end -->
<!-- 修改产品 start -->
<div class="modal fade" tabindex="-1" id="detailProduct">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmModifyProduct">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">查看产品</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="detailProductName" class="col-sm-4 control-label">产品名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="detailProductName" name="productName" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="detailProductPrice" class="col-sm-4 control-label">产品价格：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="detailProductPrice" name="productPrice" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="detailPositionNum" class="col-sm-4 control-label">邮件发送数量：</label>
                        <div class=" col-sm-4">
                            <input type="number" class="form-control" id="detailPositionNum" name="positionNum" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="detailProductDesc" class="col-sm-4 control-label">产品描述：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="8" id="detailProductDesc" name="productDesc" readonly></textarea>
                        </div>
                    </div>
                    <br>

                </div>
            </div>
        </form>
    </div>
</div>
<!-- 二维码 end -->
<div class="modal fade" tabindex="-1" id="showQR">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">扫码付款</h4>
                </div>
                <div class="modal-body text-center">
                    <img id="imgQR"/>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 二维码 end -->
</body>
</html>
