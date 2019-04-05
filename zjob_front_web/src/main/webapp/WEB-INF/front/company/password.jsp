<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>职位管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script SRC="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zjob.css"/>
    <script>
        $(function () {
            $('#modForm').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {


                    oldPass: {
                        validators: {
                            notEmpty: {//判断是否为空
                                message: '旧密码不能为空'
                            }

                        }

                    },
                    newPass: {
                        validators: {
                            notEmpty: {//判断是否为空
                                message: '旧密码不能为空'
                            }

                        }

                    },
                    rePass: {
                        validators: {
                            notEmpty: {//判断是否为空
                                message: '确认密码不能为空'
                            },
                            //校验确认密码必须和登录密码相同
                            identical: {

                                field: 'newPass',
                                message: '两次输入的密码不一致'
                            }
                        }

                    }
                }

            });
        });

        function modifyPwd(){
            let id=${company.id};
            let oldPass=$('#oldPass').val();
            let newPass=$('#newPass').val();
            //将其封装成一个json对象
            let params={"id":id,"oldPass":oldPass,"newPass":newPass};
            $.post('${pageContext.request.contextPath}/front/company/modifyCompanyPwd',params,function(data){
                if(data=="success"){
                    //返回登录页面继续登录
                    alert("修改密码成功");
                }
                else{
                    alert("修改密码失败");
                }
            });



        }


    </script>
</head>

<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">密码修改</h3>
    </div>
    <form class="form-horizontal" method="post" id="modForm">
        <div class="modal-body">
            <div class="form-group">
                <label class="col-sm-3 control-label">登录密码：</label>
                <div class="col-sm-6">
                    <input class="form-control" type="password" id="oldPass" name="oldPass">
                </div>
                <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">新的密码：</label>
                <div class="col-sm-6">
                    <input class="form-control" type="password" id="newPass" name="newPass">
                </div>
                <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">重复密码：</label>
                <div class="col-sm-6">
                    <input class="form-control" type="password" id="rePass" name="rePass">
                </div>
                <label class="col-sm-3 control-label error-info" style="text-align:left;">*不可为空</label>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">关&nbsp;&nbsp;闭
            </button>
            <button type="reset" class="btn btn-default">重&nbsp;&nbsp;置</button>
            <button type="submit" class="btn btn-default" onclick="modifyPwd()" disabled="disabled">修&nbsp;&nbsp;改
            </button>
        </div>
    </form>

</div>


</body>

</html>