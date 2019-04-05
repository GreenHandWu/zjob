<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>新闻管理</title>
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

            //服务器端接收消息
            let successMsg='${successMsg}';
            let errorMsg='${errorMsg}';
            if(successMsg!=''){
                layer.msg(successMsg,{
                    time:2000,
                    skin:'successMsg'
                });

            }
            if(errorMsg!=''){
                layer.msg(errorMsg,{
                    time:2000,
                    skin:'successMsg'
                });

            }

            $('#frmAddNews').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    newsTitle: {
                        validators: {
                            notEmpty: {
                                message: '标题不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/backend/news/checkTitle'
                            }
                        }
                    },
                    newsContent: {
                        validators: {
                            notEmpty: {
                                message: '内容不能为空'
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
                    return '${pageContext.request.contextPath}/backend/news/findAllByPage?pageNum='+page;
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


            $('#frmModifyNews').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    newsTitle: {
                        validators: {
                            notEmpty: {
                                message: '标题不能为空'
                            },
                            remote: {
                                url: '${pageContext.request.contextPath}/backend/news/checkTitle',
                                type: "post",
                                dataType: "json",
                                data: {
                                    newsTitle: function () {
                                        return $('#modifyNewsTitle').val();
                                    },
                                    id: function () {
                                        return $('#NewsNum').val();
                                    }
                                }
                            }
                        }
                    },
                    newsContent: {
                        validators: {
                            notEmpty: {
                                message: '内容不能为空'
                            }
                        }
                    }

                }

            });

        });
        //展示添加新闻界面
        function showAddNews() {
            $('#addNews').modal('show');
        }

        //显示修改新闻界面
        function showNewsModify(id){
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/news/findById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#NewsNum').val(result.obj.id);
                        $('#modifyNewsTitle').val(result.obj.newsTitle);
                        $('#modifyNewsContent').val(result.obj.newsContent);
                        $('#modifyNews').modal('show');
                    }
                });
        }

        //修改新闻
        function modifyNews(){
            let bv = $('#frmModifyNews').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/news/modify',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmModifyNews').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin:'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/news/findAllByPage?pageNum='
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

        //显示确认删除新闻模态框
        function showDelModal(id){
            //alert(id);
            //将id值存入删除模态框的隐藏域
            $('#NewsId').val(id);
            //显示删除模态框
            $('#delNews').modal('show');

        }

        //删除新闻
        function deleteNews(){
            $.post('${pageContext.request.contextPath}/backend/news/deleteById',
                {'id':$('#NewsId').val()},function(result){
                    if(result.status==1){
                        layer.msg(result.message,{
                            time:2000,//2秒钟后隐藏弹出框
                            skin:'successMsg'//设置弹出框的样式
                        },function(){
                            //返回当前页
                            window.location.href='${pageContext.request.contextPath}/backend/news/findAllByPage?pageNum='+${data.pageNum};
                        });

                    }
                    else{
                        layer.msg(result.message,{
                            time:2000,
                            skin:'errorMsg'
                        });
                    }


                });

        }

        //更新状态
        function modifyStatus(id,btn){
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/news/modifyStatus',
                {'id':id},function(){
                    //异步局部刷新页面
                    //找到该点击的按钮的父元素的上一个元素
                    let $td=$(btn).parent().prev();
                    if($td.text().trim()=='启用'){
                        $td.text('禁用');
                        $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');

                    }
                    else{
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
        <h3 class="panel-title">新闻管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加新闻" class="btn btn-primary" onclick="showAddNews()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">作者</th>
                    <th class="text-center">标题</th>
                    <th class="text-center">内容</th>
                    <th class="text-center">创建日期</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="news">
                    <tr>
                        <td>${news.id}</td>
                        <td>${news.sysuser.loginName}</td>
                        <td>${news.newsTitle}</td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${news.newsContent}</div></td>
                        <td><fmt:formatDate value="${news.createDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="UTC"/></td>

                        <td>
                            <c:if test="${news.newsStatus==1}">启用</c:if>
                            <c:if test="${news.newsStatus==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showNewsModify(${news.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="删除"
                                   onclick="showDelModal(${news.id})">
                            <c:if test="${news.newsStatus==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${news.id},this)">
                            </c:if>
                            <c:if test="${news.newsStatus==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${news.id},this)">
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

<!-- 添加新闻 start -->
<div class="modal fade" tabindex="-1" id="addNews">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmAddNews" action="${pageContext.request.contextPath}/backend/news/add" method="post">
            <input type="hidden" name="pageNum" value="${data.pageNum}">
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">添加新闻</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="newsTitle" class="col-sm-4 control-label">标题：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="newsTitle" name="newsTitle">
                    </div>
                </div>
                <br>
                <div class="row text-right">
                    <label for="newsContent" class="col-sm-4 control-label">内容：</label>
                    <div class="col-sm-4">
                        <textarea class="form-control" rows="8" id="newsContent" name="newsContent"></textarea>
                        <%--<input type="hidden" >--%>
                    </div>
                </div>
                <br>
            </div>
            <div class="modal-footer">
                <input type="submit" class="btn btn-primary addNews" value="添加"></input>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
        </form>
    </div>
</div>
<!-- 添加新闻 end -->

<!-- 修改新闻 start -->
<div class="modal fade" tabindex="-1" id="modifyNews">
    <!-- 窗口声明 -->
    <form id="frmModifyNews">
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->

        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">修改新闻</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row text-right">
                    <label for="NewsNum" class="col-sm-4 control-label">编号：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="NewsNum" name="id" readonly>
                    </div>
                </div>
                <br>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="modifyNewsTitle" class="col-sm-4 control-label">标题：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyNewsTitle" name="newsTitle">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyNewsContent" class="col-sm-4 control-label">内容：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="8" id="modifyNewsContent" name="newsContent"></textarea>
                        </div>
                    </div>
                    <br>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="modifyNews()">修改</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>

    </div>
    </form>
</div>
<!-- 修改新闻 end -->

<!-- 确认删除新闻 start -->
<div class="modal fade" tabindex="-1" id="delNews">
    <input type="hidden" id="NewsId"/>
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
                <h4>确认删除该新闻吗？</h4>

            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="deleteNews()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除新闻 end -->
</body>

</html>