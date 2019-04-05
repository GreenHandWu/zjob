<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>系统用户管理</title>
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
            $('#frmAddSysUser').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    loginName: {
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            remote: {
                                url: '${pageContext.request.contextPath}/backend/sysuser/checkLoginName'
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
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
                    return '${pageContext.request.contextPath}/backend/sysuser/findAllByPage?pageNum='+page;
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


            $('#frmModifySysUser').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    loginName: {
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            remote: {
                                url: '${pageContext.request.contextPath}/backend/sysuser/checkLoginName',
                                type: "post",
                                dataType: "json",
                                data: {
                                    loginName: function () {
                                        return $('#mdifyLoginName').val();
                                    },
                                    id: function () {
                                        return $('#modifyId').val();
                                    }
                                }
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: '内容不能为空'
                            }
                        }
                    }

                }

            });

        });
        //展示添加系统用户界面
        function showAddSysUser() {
            $('#addSysUser').modal('show');
        }

        //添加系统用户
        function addSysuser(){
            //进行表单校验
            let bv = $('#frmAddSysUser').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {

                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/sysuser/add',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmAddSysUser').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin:'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/sysuser/findAllByPage?pageNum='
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

        //显示修改新闻界面
        function showSysUserModify(id){
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/sysuser/findById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#modifyId').val(result.obj.id);
                        $('#mdifyLoginName').val(result.obj.loginName);
                        $('#modifySysUser').modal('show');
                    }
                });
        }

        //修改新闻
        function modifySysUser(){
            let bv = $('#frmModifySysUser').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/sysuser/modify',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmModifySysUser').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin:'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/sysuser/findAllByPage?pageNum='
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


        //更新状态
        function modifyStatus(id,btn){
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/sysuser/modifyStatus',
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
        <h3 class="panel-title">系统用户管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加系统用户" class="btn btn-primary" onclick="showAddSysUser()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">登录名</th>
                    <th class="text-center">创建日期</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="sysuser">
                    <tr>
                        <td>${sysuser.id}</td>
                        <td>${sysuser.loginName}</td>
                        <td><fmt:formatDate value="${sysuser.createDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="UTC"/></td>
                        <td>
                            <c:if test="${sysuser.isValid==1}">启用</c:if>
                            <c:if test="${sysuser.isValid==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showSysUserModify(${sysuser.id})">
                            <c:if test="${sysuser.isValid==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${sysuser.id},this)">
                            </c:if>
                            <c:if test="${sysuser.isValid==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${sysuser.id},this)">
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

<!-- 添加系统用户 start -->
<div class="modal fade" tabindex="-1" id="addSysUser">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmAddSysUser">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加系统用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="loginName" class="col-sm-4 control-label">登录名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="loginName" name="loginName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="password" class="col-sm-4 control-label">密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addNews" onclick="addSysuser()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加系统用户 end -->

<!-- 修改系统用户 start -->
<div class="modal fade" tabindex="-1" id="modifySysUser">
    <!-- 窗口声明 -->
    <form id="frmModifySysUser">
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改系统用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="modifyId" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyId" name="id" readonly>
                        </div>
                    </div>
                    <br/>
                    <div class="row text-right">
                        <label for="loginName" class="col-sm-4 control-label">登录名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="mdifyLoginName" name="loginName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPassword" class="col-sm-4 control-label">密码：</label>
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="modifyPassword" name="password">
                        </div>
                    </div>
                    <br>
                    </div>

                <div class="modal-footer">
                    <button class="btn btn-warning updateProType" onclick="modifySysUser()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>

        </div>
    </form>
</div>
<!-- 修改系统用户 end -->

</body>

</html>