<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>用户管理</title>
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
            let successMsg = '${successMsg}';
            let errorMsg = '${errorMsg}';
            if (successMsg != '') {
                layer.msg(successMsg, {
                    time: 2000,
                    skin: 'successMsg'
                });

            }
            if (errorMsg != '') {
                layer.msg(errorMsg, {
                    time: 2000,
                    skin: 'successMsg'
                });

            }

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
                    return '${pageContext.request.contextPath}/backend/user/findAllByPage?pageNum='+page;
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
            $('#frmAddUser').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    userName: {
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/backend/user/checkUserName'
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            }

                        }
                    },
                    gender: {
                        validators: {
                            notEmpty: {
                                message: '请选择性别'
                            }

                        }
                    },
                    phone: {
                        validators: {
                            notEmpty: {
                                message: '电话不能为空'
                            },
                            regexp: {
                                regexp: /^1\d{10}$/ ,
                                message: '请输入正确的11位手机号'
                            }
                        }
                    },
                    userEdu: {
                        validators: {
                            notEmpty: {
                                message: '教育程度不能为空'
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                                message: '电子邮箱不能为空'
                            },
                            regexp: {
                                regexp: /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/ ,
                                message: '请输入正确的邮箱地址'
                            }
                        }
                    },
                    file: {
                        validators: {
                            notEmpty: {
                                message: '请选择文件'
                            }
                        }
                    }
                }
            });
            $('#frmModifyUser').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    userName: {
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/backend/user/checkUserName',
                                type: "post",
                                dataType: "json",
                                data: {
                                    userName: function () {
                                        return $('#modifyUserName').val();
                                    },
                                    id: function () {
                                        return $('#userId').val();
                                    }
                                }
                            }
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            }

                        }
                    },
                    gender: {
                        validators: {
                            notEmpty: {
                                message: '请选择性别'
                            }

                        }
                    },
                    phone: {
                        validators: {
                            notEmpty: {
                                message: '电话不能为空'
                            },
                            regexp: {
                                regexp: /^1\d{10}$/ ,
                                message: '请输入正确的11位手机号'
                            }
                        }
                    },
                    userEdu: {
                        validators: {
                            notEmpty: {
                                message: '教育程度不能为空'
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                                message: '电子邮箱不能为空'
                            },
                            regexp: {
                                regexp: /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/ ,
                                message: '请输入正确的邮箱地址'
                            }
                        }
                    },
                    file: {
                        validators: {
                            notEmpty: {
                                message: '请选择文件'
                            }
                        }
                    }
                }
            });

        });

        function showAddUser() {
            $('#addUser').modal('show');
        }

        function showUserModify(id){
            $.post('${pageContext.request.contextPath}/backend/user/findById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#userId').val(result.obj.id);
                        $('#modifyUserName').val(result.obj.userName);
                        //$('#modifyPassword').val(result.obj.password);
                        $('#modifyGender').val(result.obj.gender);
                        $('#modifyPhone').val(result.obj.phone);
                        $('#modifyUserEdu').val(result.obj.userEdu);
                        $('#modifyEmail').val(result.obj.email);
                       // $('#modifyResume').val(result.obj.userResume);
                        $('#modifyUser').modal('show');
                    }
                });
        }

        //显示确认删除新闻模态框
        function showDelModal(id){
            //将id值存入删除模态框的隐藏域
            $('#delUserId').val(id);
            //显示删除模态框
            $('#delUser').modal('show');

        }

        //删除用户
        function delUser(){
            $.post('${pageContext.request.contextPath}/backend/user/deleteById',
                {'id':$('#delUserId').val()},function(result){
                    if(result.status==1){
                        layer.msg(result.message,{
                            time:2000,//2秒钟后隐藏弹出框
                            skin:'successMsg'//设置弹出框的样式
                        },function(){
                            //返回当前页
                            window.location.href='${pageContext.request.contextPath}/backend/user/findAllByPage?pageNum='+${data.pageNum};
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
            $.post('${pageContext.request.contextPath}/backend/user/modifyStatus',
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
        <h3 class="panel-title">用户管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加用户" class="btn btn-primary" onclick="showAddUser()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">用户名</th>
                    <th class="text-center">性别</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">教育程度</th>
                    <th class="text-center">电子邮件</th>
                    <th class="text-center">简历</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.userName}</td>
                        <td>
                            <c:if test="${user.gender==1}">男</c:if>
                            <c:if test="${user.gender==0}">女</c:if>
                        </td>
                        <td>${user.phone}</td>
                        <td>${user.userEdu}</td>
                        <td>${user.email}</td>
                        <td><a href="${pageContext.request.contextPath}/backend/user/download?fileName=${user.userResume}&userName=${user.userName}">${user.userName}的简历</a></td>
                        <td>
                            <c:if test="${user.userStatus==1}">启用</c:if>
                            <c:if test="${user.userStatus==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showUserModify(${user.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="删除"
                                   onclick="showDelModal(${user.id})">
                            <c:if test="${user.userStatus==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${user.id},this)">
                            </c:if>
                            <c:if test="${user.userStatus==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${user.id},this)">
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
<!-- 添加用户 start -->
<div class="modal fade" tabindex="-1" id="addUser" >
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/user/add" method="post" id="frmAddUser" enctype="multipart/form-data" class="form-horizontal">
            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="userName" class="col-sm-4 control-label">用户名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="userName" name="userName">
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
                    <div class="row text-right">
                        <label for="gender" class="col-sm-4 control-label">性别：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="gender" name="gender">
                                <option value="">--请选择--</option>
                                    <option value="1">男</option>
                                    <option value="0">女</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="phone" class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="phone" name="phone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="userEdu" class="col-sm-4 control-label">教育程度 ：</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="userEdu" name="userEdu">
                                <option value="">--请选择--</option>
                                <option value="高中">高中</option>
                                <option value="本科">本科</option>
                                <option value="研究生">研究生</option>
                                <option value="博士">博士</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="email" class="col-sm-4 control-label">电子邮箱 ：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="email" name="email">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="userResume" class="col-sm-4 control-label">简历 ：</label>
                        <div class="col-sm-4">
                            <input type="file" title="请选择文件" class="btn form-control" id="userResume" name="file">
                        </div>
                    </div>
                    <br>

                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-primary" value="提交">
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加用户 end -->
<!-- 修改用户 start -->
<div class="modal fade" tabindex="-1" id="modifyUser">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/user/modify" method="post" id="frmModifyUser" enctype="multipart/form-data" class="form-horizontal">
            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改用户</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="userId" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="userId" name="id" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyUserName" class="col-sm-4 control-label">用户名：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyUserName" name="userName">
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
                    <div class="row text-right">
                        <label for="modifyGender" class="col-sm-4 control-label">性别：</label>
                        <div class=" col-sm-4">
                            <select class="form-control" id="modifyGender" name="gender">
                                <option value="">--请选择--</option>
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPhone" class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyPhone" name="phone">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyUserEdu" class="col-sm-4 control-label">教育程度 ：</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="modifyUserEdu" name="userEdu">
                                <option value="">--请选择--</option>
                                <option value="高中">高中</option>
                                <option value="本科">本科</option>
                                <option value="研究生">研究生</option>
                                <option value="博士">博士</option>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyEmail" class="col-sm-4 control-label">电子邮箱 ：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyEmail" name="email">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyResume" class="col-sm-4 control-label">简历 ：</label>
                        <div class="col-sm-4">
                            <input type="file" title="请选择文件" class="btn form-control" id="modifyResume" name="file">
                        </div>
                    </div>
                    <br>

                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-primary " value="修改"/>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改用户 end -->

<!-- 确认删除用户 start -->
<div class="modal fade" tabindex="-1" id="delUser">
    <input type="hidden" id="delUserId"/>
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
                <h4>确认删除该用户吗？</h4>

            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="delUser()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除用户 end -->


</body>
</html>
