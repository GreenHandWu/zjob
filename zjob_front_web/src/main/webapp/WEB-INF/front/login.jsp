<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>zjob招聘系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css"
          type="text/css"></link>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/css/mycss.css" type="text/css"></link>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.min.css"
          type="text/css"></link>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/verify.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/zjob.js"></script>
    <link rel="stylesheet" type="text/css"
          href="<%=request.getContextPath()%>/css/verify.css">
    <script>
        $(function(){
                    //使用bootstrap校验框架校验表单
                    $('#frmRegist1').bootstrapValidator(
                        {
                            message: 'This value is not valid',
                            feedbackIcons: {
                                valid: 'glyphicon glyphicon-ok',
                                invalid: 'glyphicon glyphicon-remove',
                                validating: 'glyphicon glyphicon-refresh'
                            },
                            fields: {
                                userName: {//和表单元素中对应的name一致
                                    message: '用户名验证失败',
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '用户名不能为空'
                                        },
                                        stringLength: {//判断长度是否3-10位
                                            min: 3,
                                            max: 10,
                                            message: '用户名长度必须3-10位'

                                        },
                                        //判断字符是否是数字，字母，下划线
                                        regexp: {
                                            regexp: /^[0-9a-zA-Z_]+$/,
                                            message: '用户名必须是字母，数字，下划线'

                                        },
                                        remote: {//向远程服务器发送请求进行校验
                                            type: 'post',
                                            url: '${pageContext.request.contextPath}/front/user/checkName'
                                        }
                                    }
                                },

                                password: {
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '密码不能为空'
                                        },
                                        //校验密码不能和账号相同
                                        different: {
                                            field: 'userName',//需要比较的属性
                                            message: '密码不能和用户名相同'
                                        }

                                    }

                                },
                                repassword: {
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '确认密码不能为空'
                                        },
                                        //校验确认密码必须和登录密码相同
                                        identical: {
                                            field: 'password',
                                            message: '两次输入的密码不一致'
                                        }
                                    }

                                },
                                protocol: {
                                    validators: {
                                        choice: {
                                            min: 1,
                                            max: 1,
                                            message: '请同意相关服务条款和隐私政策'
                                        }
                                    }
                                }

                            }
                        });

                    $('#frmRegist2').bootstrapValidator(
                        {
                            message: 'This value is not valid',
                            feedbackIcons: {
                                valid: 'glyphicon glyphicon-ok',
                                invalid: 'glyphicon glyphicon-remove',
                                validating: 'glyphicon glyphicon-refresh'
                            },
                            fields: {
                                companyName: {//和表单元素中对应的name一致
                                    message: '公司名称验证失败',
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '公司名称不能为空'
                                        },
                                        remote: {//向远程服务器发送请求进行校验
                                            type: 'post',
                                            url: '${pageContext.request.contextPath}/front/company/checkCompanyName'
                                        }
                                    }
                                },

                                password: {
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '密码不能为空'
                                        },
                                        //校验密码不能和账号相同
                                        different: {
                                            field: 'companyName',//需要比较的属性
                                            message: '密码不能和公司名相同'
                                        }

                                    }

                                },
                                repassword: {
                                    validators: {
                                        notEmpty: {//判断是否为空
                                            message: '确认密码不能为空'
                                        },
                                        //校验确认密码必须和登录密码相同
                                        identical: {
                                            field: 'password',
                                            message: '两次输入的密码不一致'
                                        }
                                    }

                                },
                                protocol: {
                                    validators: {
                                        choice: {
                                            min: 1,
                                            max: 1,
                                            message: '请同意相关服务条款和隐私政策'
                                        }
                                    }
                                }

                            }
                        });


                    $('#username').on(
                        'blur',
                        function () {
                            //alert(1);
                            if ($('#username').val() == '') {
                                //初始化tooltip
                                $('#username').tooltip({
                                    title: '用户名不能为空',//tooltip的内容
                                    placement: 'top',//tooltip的位置
                                    trigger: 'manual'//手动控制tooltip的显示和隐藏
                                }).tooltip('show');//显示提示框
                                //将元素框加上警告样式
                                $('#username').parent().parent()
                                    .addClass('has-error');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                            } else {
                                //将警告框样式移除
                                $('#username').parent().parent()
                                    .removeClass('has-error');
                                //将tooltip隐藏
                                $('#username').tooltip('hide');
                            }

                        });
                    $('#password').on(
                        'blur',
                        function () {
                            //alert(1);
                            if ($('#password').val() == '') {
                                //初始化tooltip
                                $('#password').tooltip({
                                    title: '密码不能为空',//tooltip的内容
                                    placement: 'top',//tooltip的位置
                                    trigger: 'manual'//手动控制tooltip的显示和隐藏
                                }).tooltip('show');//显示提示框
                                //将元素框加上警告样式
                                $('#password').parent().parent()
                                    .addClass('has-error');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                            } else {
                                //将警告框样式移除
                                $('#password').parent().parent()
                                    .removeClass('has-error');
                                //将tooltip隐藏
                                $('#password').tooltip('hide');
                            }

                        });
                    $('#state').on(
                        'blur',
                        function () {
                            //alert(1);
                            if ($('#state').val() == '') {
                                //初始化tooltip
                                $('#state').tooltip({
                                    title: '请选择身份',//tooltip的内容
                                    placement: 'top',//tooltip的位置
                                    trigger: 'manual'//手动控制tooltip的显示和隐藏
                                }).tooltip('show');//显示提示框
                                //将元素框加上警告样式
                                $('#state').parent().parent().addClass(
                                    'has-error');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                            } else {
                                //将警告框样式移除
                                $('#state').parent().parent()
                                    .removeClass('has-error');
                                //将tooltip隐藏
                                $('#state').tooltip('hide');
                            }

                        });

                    //表单提交时的非空校验
                    //单击了表单的提交按钮时，触发该事件，调用回调函数
                    $('#frmLogin').submit(
                        function () {
                            //alert(1);
                            if ($('#username').val() == '') {
                                //弹出tooltip
                                $('#username').tooltip({
                                    title: '用户名不能为空',
                                    placement: 'top',
                                    trigger: 'manual'
                                }).tooltip('show');
                                $('#username').parent().parent()
                                    .addClass('has-error');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                                //不提交表单
                                return false;
                            } else {
                                $('#username').parent().parent()
                                    .removeClass('has-error');
                            }

                            if ($('#password').val() == '') {
                                //弹出tooltip
                                $('#password').tooltip({
                                    title: '密码不能为空',
                                    placement: 'top',
                                    trigger: 'manual'
                                }).tooltip('show');
                                $('#password').parent().parent()
                                    .addClass('has-error');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                                //不提交表单
                                return false;
                            } else {
                                $('#password').parent().parent()
                                    .removeClass('has-error');
                            }
                            if ($('#state').val() == '') {
                                //弹出tooltip
                                $('#state').tooltip({
                                    title: '请选择身份',
                                    placement: 'top',
                                    trigger: 'manual'
                                }).tooltip('show');
                                $(this).on('shown.bs.tooltip', function () {
                                    //alert(1);
                                    let _this = this;
                                    setTimeout(function () {
                                        //console.log(this==_this);
                                        $(_this).tooltip('hide');
                                    }, 2000);
                                });
                                //不提交表单
                                return false;
                            }
                            //提交表单
                            return true;
                        });

                    //服务端校验信息
                    //接收服务端返回的错误消息
                    let error = '${error}';
                    //如果该消息有值
                    if (error != '') {
                        //用tooltip弹出框显示该错误消息
                        $('#frmLogin').tooltip({
                            title: error,
                            trigger: 'manual'
                        }).tooltip('show');
                    }

                    //将该错误提示框在2秒后自动消失
                    $('[data-toggle="tooltip"]').each(function (i) {
                        //alert(i);
                        //给其绑定事件，在tooltip显示之后触发
                        $(this).on('shown.bs.tooltip', function () {
                            //alert(1);
                            let _this = this;
                            setTimeout(function () {
                                //console.log(this==_this);
                                $(_this).tooltip('hide');
                            }, 2000);
                        });

                    });
                });
    </script>


</head>
<body>
<!-- 使用自定义css样式 div-signin 完成元素居中-->
<div class="container div-signin">
    <div class="panel panel-primary div-shadow">
        <!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
        <div class="panel-heading">
            <h3>zjob招聘系统 3.0</h3>
            <span>zjob 欢迎你</span>
        </div>
        <div class="panel-body">
            <!-- login form start -->
            <form action="${pageContext.request.contextPath}/login"
                  class="form-horizontal" method="post" id="frmLogin"
                  data-toggle="tooltip">
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-9">
                        <input class="form-control" name="loginName" id="username"
                               type="text" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                    <div class="col-sm-9">
                        <input class="form-control" name="password" id="password"
                               type="password" placeholder="请输入密码">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">身&nbsp;&nbsp;&nbsp;&nbsp;份：</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="state" id="state">
                            <option value="">-请选择身份-</option>
                            <option value="user">普通用户</option>
                            <option value="company">企业用户</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">验证码：</label>
                    <div id="mpanel2" class="col-sm-9"></div>
                </div>
                <div class="form-group">
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-link btn-block"
                                data-toggle="modal" data-target="#registeModal">注册账号
                        </button>
                    </div>
                    <div class="col-sm-9 padding-left-0">
                        <div class="col-sm-4">
                            <button type="button" id="check-btn"
                                    class="btn btn-primary btn-block">登&nbsp;&nbsp;陆
                            </button>
                        </div>
                        <div class="col-sm-4">
                            <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-link btn-block">忘记密码？</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- login form end -->
        </div>
    </div>
</div>
<!-- 页尾 版权声明 -->
<div class="container">
    <div class="col-sm-12 foot-css">
        <p class="text-muted credit">Copyright © 2019 志明软件 版权所有</p>
    </div>
</div>


<!-- 注册模态框 start  -->
<div class="modal fade" id="registeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <!-- 普通用户注册 start -->
        <div class="modal-content" id="login-account">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">普通用户注册</h4>
            </div>
            <form action="${pageContext.request.contextPath}/front/user/registe" class="form-horizontal" method="post" id="frmRegist1">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" placeholder="请输入用户名" name="userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" placeholder="请输入密码" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确认密码</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" placeholder="请输入确认密码" name="repassword">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-6 col-sm-offset-3">
                            <div class="checkbox">
                                <input type="checkbox" name="protocol" /> 同意相关服务条款和隐私政策
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button> &nbsp;&nbsp;
                    <a class="btn-link" id="btn-sms-back">企业用户注册</a>
                </div>
            </form>
        </div>
        <!-- 普通用户注册 end -->
        <!-- 企业用户注册 start -->
        <div class="modal-content" id="login-sms" style="display: none;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">企业用户注册</h4>
            </div>
            <form class="form-horizontal" action="${pageContext.request.contextPath}/front/company/registe" method="post" id="frmRegist2">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">公司名称：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" placeholder="请输入用户名" name="companyName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" placeholder="请输入密码" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确认密码</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" placeholder="请输入确认密码" name="repassword">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-6 col-sm-offset-3">
                            <div class="checkbox">
                                <input type="checkbox" name="protocol" /> 同意相关服务条款和隐私政策
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: center">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button> &nbsp;&nbsp;
                    <a class="btn-link" id="btn-account-back">普通用户注册</a>
                </div>
            </form>
        </div>
        <!-- 企业用户注册 end -->
    </div>
</div>
<!-- 注册模态框 end  -->


<script>
    $('#mpanel2').codeVerify({
        type: 1,
        width: '100px',
        height: '25px',
        fontSize: '15px',
        codeLength: 4,
        btnId: 'check-btn',
        ready: function () {
        },
        success: function () {
            $('#frmLogin').submit();
        },
        error: function () {
            $('#mpanel2').tooltip({
                title: '验证码不匹配',
                placement: 'top',
                trigger: 'manual'
            }).tooltip('show');
            $('#mpanel2').on('shown.bs.tooltip', function () {
                //alert(1);
                let _this = this;
                setTimeout(function () {
                    //console.log(this==_this);
                    $(_this).tooltip('hide');
                }, 2000);
            });
        }
    });
</script>
</body>
</html>
