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
            $('#frmAddPosition').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    positionName: {
                        validators: {
                            notEmpty: {
                                message: '职位名称不能为空'
                            }
                        }
                    },
                    positionSalary: {
                        validators: {
                            notEmpty: {
                                message: '薪资不能为空'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }

                        }
                    },
                    positionNum: {
                        validators: {
                            notEmpty: {
                                message: '招聘人数不能为空'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }

                        }
                    },
                    positionRequire: {
                        validators: {
                            notEmpty: {
                                message: '招聘要求不能为空'
                            }

                        }
                    },
                    positionEdu: {
                        validators: {
                            notEmpty: {
                                message: '学历要求不能为空'
                            }

                        }
                    },

                    companyId: {
                        validators: {
                            notEmpty: {
                                message: '请填写公司名称'
                            }

                        }
                    },
                    positionPhone: {
                        validators: {
                            notEmpty: {
                                message: '联系电话不能为空'
                            },
                            regexp: {
                                regexp: /^1\d{10}$/ ,
                                message: '请输入正确的11位手机号'
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
                    return '${pageContext.request.contextPath}/backend/position/findAllByPage?pageNum=' + page;
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

            $('#frmModifyPosition').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    positionName: {
                        validators: {
                            notEmpty: {
                                message: '职位名称不能为空'
                            }
                        }
                    },
                    positionSalary: {
                        validators: {
                            notEmpty: {
                                message: '薪资不能为空'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }

                        }
                    },
                    positionNum: {
                        validators: {
                            notEmpty: {
                                message: '招聘人数不能为空'
                            },
                            digits: {
                                message: '请输入数字（整数）'
                            }

                        }
                    },
                    positionRequire: {
                        validators: {
                            notEmpty: {
                                message: '招聘要求不能为空'
                            }

                        }
                    },
                    positionEdu: {
                        validators: {
                            notEmpty: {
                                message: '学历要求不能为空'
                            }

                        }
                    },

                    companyId: {
                        validators: {
                            notEmpty: {
                                message: '请填写公司名称'
                            }

                        }
                    },
                    positionPhone: {
                        validators: {
                            notEmpty: {
                                message: '联系电话不能为空'
                            },
                            regexp: {
                                regexp: /^1\d{10}$/ ,
                                message: '请输入正确的11位手机号'
                            }

                        }
                    }

                }
            });

        });

        //展示添加职位界面
        function showAddPosition() {
            $('#addPosition').modal('show');
        }

        //添加职位
        function addPosition() {
//进行表单校验
            let bv = $('#frmAddPosition').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //alert(1);
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/position/add',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmAddPosition').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/position/findAllByPage?pageNum='
                                    +${data.pageNum};
                            });
                        } else if (result.status == 0) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'errorMsg'
                            });
                        }

                    });
            }
        }

        //显示修改新闻界面
        function showPositionModify(id) {
            $.post('${pageContext.request.contextPath}/backend/position/findById',
                {'id': id}, function (result) {
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if (result.status == 1) {
                        $('#modifyId').val(result.obj.id);
                        $('#modifyPositionName').val(result.obj.positionName);
                        $('#modifyPositionSalary').val(result.obj.positionSalary);
                        $('#modifyPositionNum').val(result.obj.positionNum);
                        $('#modifyPositionRequire').val(result.obj.positionRequire);
                        $('#modifyPositionEdu').val(result.obj.positionEdu);
                        $('#modifyCompanyId').val(result.obj.company.id);
                        $('#modifyPositionPhone').val(result.obj.positionPhone);
                        $('#modifyPosition').modal('show');
                    }
                });
        }

        //修改新闻
        function modifyPosition() {
            let bv = $('#frmModifyPosition').data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                //alert(1);
                //调用ajax到后台执行添加用户
                $.post('${pageContext.request.contextPath}/backend/position/modify',
                    //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                    $('#frmModifyPosition').serialize(), function (result) {

                        if (result.status == 1) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'successMsg'
                            }, function () {
                                location.href = '${pageContext.request.contextPath}/backend/position/findAllByPage?pageNum='
                                    +${data.pageNum};
                            });
                        } else if (result.status == 0) {
                            layer.msg(result.message, {
                                time: 2000,
                                skin: 'errorMsg'
                            });
                        }

                    });
            }

        }

        //显示确认删除职位模态框
        function showDelModal(id) {
            //alert(id);
            //将id值存入删除模态框的隐藏域
            $('#PositionId').val(id);
            //显示删除模态框
            $('#delPosition').modal('show');

        }

        //删除职位
        function deletePosition() {
            $.post('${pageContext.request.contextPath}/backend/position/deleteById',
                {'id': $('#PositionId').val()}, function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'successMsg'
                        }, function () {
                            //返回当前页
                            window.location.href = '${pageContext.request.contextPath}/backend/position/findAllByPage?pageNum=' +${data.pageNum};
                        });

                    } else {
                        $('#delPosition').modal('hide');
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
            $.post('${pageContext.request.contextPath}/backend/position/modifyStatus',
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
        <h3 class="panel-title">职位管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加职位" class="btn btn-primary" onclick="showAddPosition()">
        <br>
        <br>
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">职位名称</th>
                    <th class="text-center">薪资</th>
                    <th class="text-center">招聘人数</th>
                    <th class="text-center">职位要求</th>
                    <th class="text-center">学历要求</th>
                    <th class="text-center">公司名称</th>
                    <th class="text-center">联系电话</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="position">
                    <tr>
                        <td>${position.id}</td>
                        <td>${position.positionName}</td>
                        <td>${position.positionSalary}</td>
                        <td>${position.positionNum}</td>
                        <td><div style="width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${position.positionRequire}</div></td>
                        <td>${position.positionEdu}</td>
                        <td>${position.company.companyName}</td>
                        <td>${position.positionPhone}</td>


                        <td>
                            <c:if test="${position.status==1}">启用</c:if>
                            <c:if test="${position.status==0}">禁用</c:if>
                        </td>
                        <td class="text-center">
                            <input type="button" class="btn btn-warning btn-sm" value="修改"
                                   onclick="showPositionModify(${position.id})">
                            <input type="button" class="btn btn-warning btn-sm" value="删除"
                                   onclick="showDelModal(${position.id})">
                            <c:if test="${position.status==1}">
                                <input type="button" class="btn btn-danger btn-sm" value="禁用"
                                       onclick="modifyStatus(${position.id},this)">
                            </c:if>
                            <c:if test="${position.status==0}">
                                <input type="button" class="btn btn-success btn-sm" value="启用"
                                       onclick="modifyStatus(${position.id},this)">
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

<!-- 添加职位 start -->
<div class="modal fade" tabindex="-1" id="addPosition">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmAddPosition">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加职位</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="positionName" class="col-sm-4 control-label">职位名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="positionName" name="positionName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionSalary" class="col-sm-4 control-label">薪资：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="positionSalary" name="positionSalary">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionNum" class="col-sm-4 control-label">招聘人数：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="positionNum" name="positionNum">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionRequire" class="col-sm-4 control-label">职位要求：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="3" id="positionRequire"
                                      name="positionRequire"></textarea>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionEdu" class="col-sm-4 control-label">学历要求：</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="positionEdu" name="positionEdu">
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
                        <label for="companyId" class="col-sm-4 control-label">公司名称：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="companyId" id="companyId">
                                <option value="">--请选择--</option>
                                <c:forEach items="${companyList}" var="company">
                                    <option value="${company.id}">${company.companyName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="positionPhone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="positionPhone" name="positionPhone">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addNews" onclick="addPosition()">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加职位 end -->

<!-- 修改职位 start -->
<div class="modal fade" tabindex="-1" id="modifyPosition">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmModifyPosition">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改职位</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label for="modifyId" class="col-sm-4 control-label">编号：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyId" name="id" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionName" class="col-sm-4 control-label">职位名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyPositionName" name="positionName">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionSalary" class="col-sm-4 control-label">薪资：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyPositionSalary" name="positionSalary">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionNum" class="col-sm-4 control-label">招聘人数：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyPositionNum" name="positionNum">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionRequire" class="col-sm-4 control-label">职位要求：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="3" id="modifyPositionRequire"
                                      name="positionRequire"></textarea>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionEdu" class="col-sm-4 control-label">学历要求：</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="modifyPositionEdu" name="positionEdu">
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
                        <label for="modifyCompanyId" class="col-sm-4 control-label">公司名称：</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="companyId" id="modifyCompanyId">
                                <option value="">--请选择--</option>
                                <c:forEach items="${companyList}" var="company">
                                    <option value="${company.id}">${company.companyName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="modifyPositionPhone" class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="modifyPositionPhone" name="positionPhone">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary addNews" onclick="modifyPosition()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改职位 end -->

<!-- 确认删除职位 start -->
<div class="modal fade" tabindex="-1" id="delPosition">
    <input type="hidden" id="PositionId"/>
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
                <h4>确认删除该职位吗？</h4>

            </div>
            <div class="modal-footer">
                <button class="btn btn-warning updateProType" onclick="deletePosition()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认删除职位 end -->
</body>

</html>