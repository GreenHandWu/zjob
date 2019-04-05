<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>企业用户管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/zjob.css"/>
    <script src="${pageContext.request.contextPath}/My97DatePicker/WdatePicker.js"></script>
    <script>
        $(function () {
            //上传图像预览
            $('#modifyCompanyLogo').on('change', function () {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });
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


            $('#modifyCompanyId').val("${company.id}");
            $('#modifyCompanyName').val("${company.companyName}");
            $('#img').attr('src','${pageContext.request.contextPath}/front/company/showPic?image='+"${company.companyLogo}");
            $('#modifyCompanyPerson').val("${company.companyPerson}");
            $('#modifyCompanyEmail').val("${company.companyEmail}");
            $('#modifyCompanyAddress').val("${company.companyAddress}");
            $('#modifyCompanyType').val("${company.companyType}");
            $('#modifyCompanyDesc').val("${company.companyDesc}");
            $('#modifyCompanyPhone').val("${company.companyPhone}");
            $('#modifyCompanyCreateDate').val(" <fmt:formatDate value='${company.companyCreateDate}' pattern='yyyy-MM-dd'
                                                        timeZone="UTC"/>");
            $('#frmModifyCompany').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    companyName: {
                        validators: {
                            notEmpty: {
                                message: '公司名称不能为空'
                            },
                            remote: {
                                //ajax后端校验该登录账号是否已经存在
                                url: '${pageContext.request.contextPath}/front/company/checkCompanyName',
                                type: "post",
                                dataType: "json",
                                data: {
                                    companyName: function () {
                                        return $('#modifyCompanyName').val();
                                    },
                                    id: function () {
                                        return $('#modifyCompanyId').val();
                                    }
                                }

                            }
                        }
                    },
                    file: {
                        validators: {
                            notEmpty: {
                                message: '请选择logo'
                            }

                        }
                    },
                    companyPerson: {
                        validators: {
                            notEmpty: {
                                message: '企业法人不能为空'
                            }

                        }
                    },
                    companyEmail: {
                        validators: {
                            notEmpty: {
                                message: '电子邮箱不能为空'
                            },
                            regexp: {
                                regexp: /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/,
                                message: '请输入正确的邮箱地址'
                            }

                        }
                    },
                    companyAddress: {
                        validators: {
                            notEmpty: {
                                message: '公司地址不能为空'
                            }

                        }
                    },
                    companyType: {
                        validators: {
                            notEmpty: {
                                message: '公司类型不能为空'
                            }

                        }
                    },
                    companyDesc: {
                        validators: {
                            notEmpty: {
                                message: '公司描述不能为空'
                            }

                        }
                    },
                    companyPhone: {
                        validators: {
                            notEmpty: {
                                message: '公司电话不能为空'
                            },
                            regexp: {
                                regexp: /^1\d{10}$/,
                                message: '请输入正确的11位手机号'
                            }

                        }
                    },
                    companyCreateDate: {
                        validators: {
                            notEmpty: {
                                message: '请选择公司创建日期'
                            }
                        }
                    }
                }
            });

        });

    </script>
</head>

<body>
<div class="container margin-top-12">
                <form action="${pageContext.request.contextPath}/front/company/modifyCompany" method="post"
                      enctype="multipart/form-data" class="form-horizontal" id="frmModifyCompany">
                    <div class="modal-content">
                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <h4 class="modal-title">查看修改企业用户</h4>
                        </div>
                        <div class="modal-body text-center row">
                            <div class="col-sm-8">
                                        <input type="hidden" class="form-control" id="modifyCompanyId" name="id" readonly>
                                <div class="form-group">
                                    <label for="modifyCompanyName" class="col-sm-4 control-label">公司名称：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyName" name="companyName">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="modifyCompanyLogo" class="col-sm-4 control-label">公司logo：</label>
                                    <div class="col-sm-8">
                                        <a href="javascript:;" class="file">选择文件
                                            <input type="file" name="file" id="modifyCompanyLogo">
                                        </a>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="modifyCompanyPerson" class="col-sm-4 control-label">企业法人：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyPerson" name="companyPerson">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="modifyCompanyEmail" class="col-sm-4 control-label">公司邮箱：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyEmail" name="companyEmail">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="modifyCompanyAddress" class="col-sm-4 control-label">公司地址：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyAddress" name="companyAddress">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="modifyCompanyType" class="col-sm-4 control-label">公司类型：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyType" name="companyType">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="modifyCompanyDesc" class="col-sm-4 control-label">公司描述：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyDesc" name="companyDesc">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="modifyCompanyPhone" class="col-sm-4 control-label">公司电话：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyPhone" name="companyPhone">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="modifyCompanyCreateDate" class="col-sm-4 control-label">公司创建时间</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modifyCompanyCreateDate"
                                               name="companyCreateDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <!-- 显示图像预览 -->
                                <img style="width: 160px;height: 180px;" id="img">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input class="btn btn-primary" type="submit" value="修改"></input>
                        </div>
                    </div>
                </form>
</div>

</body>

</html>