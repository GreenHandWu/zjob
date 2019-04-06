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
            $('#company-image').on('change', function () {
                $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
            });
            $('#modifyCompanyLogo').on('change', function () {
                $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
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

            $('#frmAddCompany').bootstrapValidator({
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
                                url: '${pageContext.request.contextPath}/backend/company/checkCompanyName'
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
                    return '${pageContext.request.contextPath}/backend/company/findAllByPage?pageNum=' + page;
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
                                url: '${pageContext.request.contextPath}/backend/company/checkCompanyName',
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
        function jsonDateFormat(jsonDate) {//json日期格式转换为正常格式
            try {
                var date = new Date(parseInt(jsonDate));
                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                console.log(date.getFullYear() + "-" + month + "-" + day);
                return date.getFullYear() + "-" + month + "-" + day;
            } catch (ex) {
                return "";
            }
        }
        //展示添加公司界面
        function showAddCompany() {
            $('#addCompany').modal('show');
        }


        //显示修改公司界面
        function showCompanyModify(id) {
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/company/findById',
                {'id': id}, function (result) {
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if (result.status == 1) {
                        $('#modifyCompanyId').val(result.obj.id);
                        $('#modifyCompanyName').val(result.obj.companyName);
                        $('#img2').attr('src','${pageContext.request.contextPath}/backend/company/showPic?image='+result.obj.companyLogo);
                        $('#modifyCompanyPerson').val(result.obj.companyPerson);
                        $('#modifyCompanyEmail').val(result.obj.companyEmail);
                        $('#modifyCompanyAddress').val(result.obj.companyAddress);
                        $('#modifyCompanyType').val(result.obj.companyType);
                        $('#modifyCompanyDesc').val(result.obj.companyDesc);
                        $('#modifyCompanyPhone').val(result.obj.companyPhone);
                        $('#modifyCompanyCreateDate').val(jsonDateFormat(result.obj.companyCreateDate));
                        $('#ModifyCompany').modal('show');
                    }
                });
        }



        //显示确认删除公司模态框
        function showDelModal(id) {
            //alert(id);
            //将id值存入删除模态框的隐藏域
            $('#CompanyId').val(id);
            //显示删除模态框
            $('#delCompany').modal('show');

        }

        //删除公司
        function deleteCompany() {
            $.post('${pageContext.request.contextPath}/backend/company/deleteById',
                {'id': $('#CompanyId').val()}, function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'successMsg'
                        }, function () {
                            //返回当前页
                            window.location.href = '${pageContext.request.contextPath}/backend/company/findAllByPage?pageNum=' +${data.pageNum};
                        });

                    } else {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'errorMsg'
                        });
                    }


                });

        }

        //更新状态
        function modifyStatus(id, btn) {
            //alert(id);
            $.post('${pageContext.request.contextPath}/backend/company/modifyStatus',
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
        <h3 class="panel-title">企业用户管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加企业用户" class="btn btn-primary" onclick="showAddCompany()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">公司名称</th>
                    <th class="text-center">公司电子邮件</th>
                    <th class="text-center">公司logo</th>
                    <th class="text-center">公司地址</th>
                    <th class="text-center">公司类型</th>
                    <th class="text-center">公司介绍</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">创建时间</th>
                    <th class="text-center">企业法人</th>
                    <th class="text-center">可发送邮件数</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="company">
                    <tr>
                        <td>${company.id}</td>
                        <td>${company.companyName}</td>
                        <td>${company.companyEmail}</td>
                        <td><img
                                src="${pageContext.request.contextPath}/backend/company/showPic?image=${company.companyLogo}"
                                alt="" width="40" height="40"></td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${company.companyAddress}</div></td>
                        <td>${company.companyType}</td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${company.companyDesc}</div></td>
                        <td>${company.companyPhone}</td>
                        <td><fmt:formatDate value="${company.companyCreateDate}" pattern="yyyy-MM-dd"
                                            timeZone="UTC"/></td>
                        <td>${company.companyPerson}</td>
                        <td>${company.positionNum}</td>
                        <td><c:if test="${company.companyStatus==1}">启用</c:if>
                            <c:if test="${company.companyStatus==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showCompanyModify(${company.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="删除"
                                   onclick="showDelModal(${company.id})">
                            <c:if test="${company.companyStatus==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${company.id},this)">
                            </c:if>
                            <c:if test="${company.companyStatus==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${company.id},this)">
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

<!-- 添加公司 start -->
<div class="modal fade" tabindex="-1" id="addCompany">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/company/add" method="post"
              enctype="multipart/form-data" class="form-horizontal" id="frmAddCompany">
            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加公司</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="company-name" class="col-sm-4 control-label">公司名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-name" name="companyName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company-image" class="col-sm-4 control-label">公司logo：</label>
                            <div class="col-sm-8">
                                <a href="javascript:;" class="file">选择文件
                                    <input type="file" name="file" id="company-image">
                                </a>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="company-name" class="col-sm-4 control-label">企业法人：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="companyPerson" name="companyPerson">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="company-email" class="col-sm-4 control-label">公司邮箱：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-email" name="companyEmail">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company-address" class="col-sm-4 control-label">公司地址：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-address" name="companyAddress">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company-type" class="col-sm-4 control-label">公司类型：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-type" name="companyType">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company-desc" class="col-sm-4 control-label">公司描述：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-desc" name="companyDesc">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company-phone" class="col-sm-4 control-label">公司电话：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-phone" name="companyPhone">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="company-create-time" class="col-sm-4 control-label">公司创建时间</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="company-create-time"
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
                    <button class="btn btn-primary" type="submit">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加公司 end -->
<!-- 修改公司 start -->
<div class="modal fade" tabindex="-1" id="ModifyCompany">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form action="${pageContext.request.contextPath}/backend/company/modify" method="post"
              enctype="multipart/form-data" class="form-horizontal" id="frmModifyCompany">
            <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改企业用户</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label for="modifyCompanyId" class="col-sm-4 control-label">编号：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="modifyCompanyId" name="id" readonly>
                            </div>
                        </div>

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
                        <img style="width: 160px;height: 180px;" id="img2">
                    </div>
                </div>
                <div class="modal-footer">
                    <input class="btn btn-primary" type="submit" value="修改"></input>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改公司 end -->


<!-- 确认删除公司 start -->
<div class="modal fade" tabindex="-1" id="delCompany">
    <input type="hidden" id="CompanyId"/>
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
                <h4>确认删除该企业用户吗？</h4>
            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="deleteCompany()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除公司 end -->
</body>

</html>