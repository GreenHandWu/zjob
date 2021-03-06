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
        $(function(){
            $('#frmAddProduct').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    productName: {
                        validators: {
                            notEmpty: {
                                message: '产品名称不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/backend/product/checkProductName'
                            }
                        }
                    },
                    productPrice: {
                        validators: {
                            notEmpty: {
                                message: '产品价格不能为空'
                            },
                            regexp:{
                                regexp:/^\d+\.\d+$/,
                                message:'价格必须为小数'
                            }

                        }
                    },
                    positionNum: {
                        validators: {
                            notEmpty: {
                                message: '请输入邮件服务数量'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }

                        }
                    },
                    productDesc: {
                        validators: {
                            notEmpty: {
                                message: '产品描述不能为空'
                            }
                        }
                    }
                }
            });

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
                    return '${pageContext.request.contextPath}/backend/product/findAllByPage?pageNum='+page;
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

            $('#frmModifyProduct').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    productName: {
                        validators: {
                            notEmpty: {
                                message: '产品名称不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/backend/product/checkProductName',
                                type: "post",
                                dataType: "json",
                                data: {
                                    productName: function () {
                                        return $('#modifyProductName').val();
                                    },
                                    id: function () {
                                        return $('#modifyProductId').val();
                                    }
                                }

                            }
                        }
                    },
                    productPrice: {
                        validators: {
                            notEmpty: {
                                message: '产品价格不能为空'
                            },
                            regexp:{
                                regexp:/^\d+\.\d+$/,
                                message:'价格必须为小数'
                            }

                        }
                    },
                    positionNum: {
                        validators: {
                            notEmpty: {
                                message: '请输入邮件服务数量'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }
                        }
                    },
                    productDesc: {
                        validators: {
                            notEmpty: {
                                message: '产品描述不能为空'
                            }
                        }
                    }
                }
            });

        });

        function showAddProduct() {
            $('#addProduct').modal('show');
        }
        //添加产品
        function addProduct(){
//进行表单校验
            let bv = $('#frmAddProduct').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/product/add',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmAddProduct').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin:'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/product/findAllByPage?pageNum='
                                    +${data.pageNum};
                            });
                        }
                        else if (result.status == 0) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'errorMsg'
                            });
                        }

                    });
            }
        }

        function showProductModify(id){
            $.post('${pageContext.request.contextPath}/backend/product/findById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#modifyProductId').val(result.obj.id);
                        $('#modifyProductName').val(result.obj.productName);
                        $('#modifyProductPrice').val(result.obj.productPrice);
                        $('#modifyPositionNum').val(result.obj.positionNum);
                        $('#modifyProductDesc').val(result.obj.productDesc);
                        $('#modifyProduct').modal('show');
                    }
                });
        }
        //修改用户
        function modifyProduct(){
            let bv = $('#frmModifyProduct').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //alert(1);
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/product/modify',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmModifyProduct').serialize(), function (result) {
                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin:'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/product/findAllByPage?pageNum='
                                    +${data.pageNum};
                            });
                        }
                        else if (result.status == 0) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'errorMsg'
                            });
                        }

                    });
            }

        }
        //显示确认删除产品模态框
        function showDelModal(id){
            //alert(id);
            //将id值存入删除模态框的隐藏域
            $('#ProductId').val(id);
            //显示删除模态框
            $('#delProduct').modal('show');

        }

        //删除新闻
        function deleteProduct(){
            $.post('${pageContext.request.contextPath}/backend/product/deleteById',
                {'id':$('#ProductId').val()},function(result){
                    if(result.status==1){
                        layer.msg(result.message,{
                            time:2000,//2秒钟后隐藏弹出框
                            skin:'successMsg'//设置弹出框的样式
                        },function(){
                            //返回当前页
                            window.location.href='${pageContext.request.contextPath}/backend/product/findAllByPage?pageNum='+${data.pageNum};
                        });

                    }
                    else{
                        layer.msg(result.message,{
                            time:2000,
                            skin:'errorMsg'
                        });
                        $('#delProduct').modal('hide');
                    }


                });

        }
        //更新状态
        function modifyStatus(id, btn) {
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/product/modifyStatus',
                {'id': id}, function () {
                    //异步局部刷新页面
                    //找到该点击的按钮的父元素的上一个元素
                    let $td = $(btn).parent().prev();
                    if ($td.text().trim() == '启用') {
                        $td.text('禁用');
                        $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');

                    } else {
                        $td.text('启用');
                        $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');
                    }
                });
        }
    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">产品管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加产品" class="btn btn-primary" onclick="showAddProduct()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">产品名称</th>
                    <th class="text-center">产品描述</th>
                    <th class="text-center">产品价格</th>
                    <th class="text-center">邮件服务数量</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.productName}</td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${product.productDesc}</div></td>
                        <td>${product.productPrice}</td>
                        <td>${product.positionNum}</td>
                        <td>
                            <c:if test="${product.productStatus==1}">启用</c:if>
                            <c:if test="${product.productStatus==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showProductModify(${product.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="删除"
                                   onclick="showDelModal(${product.id})">
                            <c:if test="${product.productStatus==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${product.id},this)">
                            </c:if>
                            <c:if test="${product.productStatus==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${product.id},this)">
                            </c:if>
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
<div class="modal fade" tabindex="-1" id="addProduct" >
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmAddProduct" method="post" enctype="multipart/form-data" class="form-horizontal" id="frmAddProduct">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加产品</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="productName" class="col-sm-4 control-label">产品名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productName" name="productName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="productPrice" class="col-sm-4 control-label">产品价格：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="productPrice" name="productPrice">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionNum" class="col-sm-4 control-label">邮件服务数量：</label>
                        <div class=" col-sm-4">
                            <input type="number" class="form-control" id="positionNum" name="positionNum">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="productDesc" class="col-sm-4 control-label">产品描述：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="8" id="productDesc" name="productDesc"></textarea>
                        </div>
                    </div>
                    <br>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addUser" onclick="addProduct()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加产品 end -->
<!-- 修改产品 start -->
<div class="modal fade" tabindex="-1" id="modifyProduct">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmModifyProduct">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改产品</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="modifyProductId" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyProductId" name="id" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyProductName" class="col-sm-4 control-label">产品名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyProductName" name="productName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyProductPrice" class="col-sm-4 control-label">产品价格：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyProductPrice" name="productPrice">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionNum" class="col-sm-4 control-label">邮件服务数量：</label>
                        <div class=" col-sm-4">
                            <input type="number" class="form-control" id="modifyPositionNum" name="positionNum">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyProductDesc" class="col-sm-4 control-label">产品描述：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="8" id="modifyProductDesc" name="productDesc"></textarea>
                        </div>
                    </div>
                    <br>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addUser" onclick="modifyProduct()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改产品 end -->
<!-- 确认删除产品 start -->
<div class="modal fade" tabindex="-1" id="delProduct">
    <input type="hidden" id="ProductId"/>
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-sm">
        <!-- 内容声明 -->
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">提示消息</h4>
            </div>
            <div class="modal-body text-center">
                <h4>确认删除产品吗？</h4>

            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="deleteProduct()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除产品 end -->



</body>
</html>
