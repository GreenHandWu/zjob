<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <title>zjob</title>
    <meta charset="utf-8">
  	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mycss.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-table.css" />
  	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-table.js"></script>
  	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.min.css" type="text/css"></link>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.min.js"></script>
      <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/zjob.css" type="text/css"></link>

    <script type="text/javascript">
     $(function () {
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
         var a = "${user.userResume}" ;
         $('#userId').val("${user.id}");
         $('#modifyUserName').val("${user.userName}");
         $('#modifyGender').val("${user.gender}");
         $('#modifyPhone').val("${user.phone}");
         $('#modifyUserEdu').val("${user.userEdu}");
         $('#modifyEmail').val("${user.email}");
         if(!(a == "" || a == null || a == undefined)){ // "",null,undefined
             $('#Resume').html("我的简历");
         }
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
                             url: '${pageContext.request.contextPath}/front/user/checkUserName',
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
    </script>
  </head>
  <body>
  <% request.setAttribute("index",2); %>
    <jsp:include page="top.jsp"/>
    <div class="container margin-top-10">
    	<div class="col-sm-9">
            <!-- 修改用户 start -->
            <div>
                    <!-- 内容声明 -->
                    <form action="${pageContext.request.contextPath}/front/user/modify" method="post" id="frmModifyUser" enctype="multipart/form-data" class="form-horizontal">
                        <div class="modal-content">
                            <!-- 头部、主体、脚注 -->
                            <div class="modal-header">
                                <h4 class="modal-title">修改个人信息</h4>
                            </div>
                            <div class="modal-body text-center">
                                <div class="row text-right">
                                    <input type="hidden" class="form-control" id="userId" name="id" readonly>
                                    <label for="modifyUserName" class="col-sm-4 control-label">用户名：</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="modifyUserName" name="userName">
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
                                            <option value="专科">专科</option>
                                            <option value="本科">本科</option>
                                            <option value="硕士研究生">硕士研究生</option>
                                            <option value="博士研究生">博士研究生</option>
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
                                        <a  id="Resume" href="${pageContext.request.contextPath}/front/user/download?fileName=${user.userResume}&userName=${user.userName}"></a>
                                        <input type="file" title="请选择文件" class="btn form-control" id="modifyResume" name="file">
                                    </div>
                                </div>
                                <br>

                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary " value="修改"/>
                            </div>
                        </div>
                    </form>
            </div>
            <!-- 修改用户 end -->
   		</div>
    	<jsp:include page="right.jsp"/>
   	</div>
    <jsp:include page="buttom.jsp"/>

  </body>
</html>
