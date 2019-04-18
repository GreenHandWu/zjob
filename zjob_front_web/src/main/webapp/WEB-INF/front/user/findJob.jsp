<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>zjob</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mycss.css" type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-table.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-table.js"></script>
    <script SRC="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.min.css"
          type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/zjob.css" type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
        $(function () {
            console.log("${data}");
            $('#frmQuery').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'

                },
                fields: {
                    positionSalary: {
                        validators: {
                            regexp: {//匹配规则
                                regexp:/^\d+\.\d+$/,
                                message:'请输入小数'
                            }
                        }
                    }

                }
            });


            $("#search-edu").val("${jobParam.positionEdu}");
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
                onPageClicked: function (event, originalEvent, type, page) {
                    //alert(page);
                    //给隐藏表单域的pageNum重新赋值为当前点击的页号page
                    $('#pageNum').val(page);
                    //重新提交表单
                    $('#frmQuery').submit();
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




        });
        //显示申请模态框
        function showConfirmModal(id){
            //alert(id);
            //将该值写入到该模态框的隐藏表单域
            $('#applyPositionId').val(id);
            //显示模态框
            $('#applyPositionModal').modal('show');

        }
        //申请职位
        function apply(){
            $.post('${pageContext.request.contextPath}/front/user/apply',
                {'id':$('#applyPositionId').val()},function(result){
                    if(result.status==1){
                        layer.msg(result.message,{
                            time:2000,
                            skin:'successMsg'
                        });
                        $("#applyPositionModal").modal('hide');
                    }
                    else{
                        layer.msg(result.message,{
                            time:2000,
                            skin:'errorMsg'
                        });
                        $("#applyPositionModal").modal('hide');
                    }
                });
        }
        function showPosition(id) {
            $.post('${pageContext.request.contextPath}/front/user/findPositionById',
                {'id': id}, function (result) {
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if (result.status == 1) {
                        $('#findPositionName').val(result.obj.positionName);
                        $('#findPositionSalary').val(result.obj.positionSalary+'元/月');
                        $('#findPositionNum').val(result.obj.positionNum);
                        $('#findPositionRequire').val(result.obj.positionRequire);
                        $('#findPositionEdu').val(result.obj.positionEdu);
                        $('#findPositionPhone').val(result.obj.positionPhone);
                        $('#findPosition').modal('show');
                    }
                });
        }
        //显示公司界面
        function showCompany(id) {
            $.post('${pageContext.request.contextPath}/front/user/findCompanyById',
                {'id': id}, function (result) {
                    //console.log(result);
                    //如果成功，将值写入修改模态框

                    if (result.status == 1) {
                        $('#findCompanyName').val(result.obj.companyName);
                        $('#findCompanyPerson').val(result.obj.companyPerson);
                        $('#findimg').attr('src','${pageContext.request.contextPath}/front/company/showPic?image='+result.obj.companyLogo);
                        $('#findCompanyEmail').val(result.obj.companyEmail);
                        $('#findCompanyAddress').val(result.obj.companyAddress);
                        $('#findCompanyType').val(result.obj.companyType);
                        $('#findCompanyDesc').val(result.obj.companyDesc);
                        $('#findCompanyPhone').val(result.obj.companyPhone);
                        $('#findCompanyCreateDate').val(jsonDateFormat(result.obj.companyCreateDate));
                        $('#findCompany').modal('show');
                    }
                });
        }
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
    </script>
</head>
<body>
<% request.setAttribute("index", 0); %>
<jsp:include page="top.jsp"/>
<div class="container margin-top-10">
    <div class="col-sm-9">


        <div class="panel-body">
            <div class="showmargersearch">
                <form class="form-inline" action="${pageContext.request.contextPath}/front/user/findJobByParams"
                      method="post" id="frmQuery">
                    <input type="hidden" id="pageNum" name="pageNum" value="${data.pageNum}"/>
                    <div class="form-group">
                        <label for="search-positionName">职位名称:</label>
                        <input type="text" class="form-control" id="search-positionName" placeholder="请输入职位名称" name="positionName"
                               value="${jobParam.positionName}">
                    </div>
                    <div class="form-group">
                        <label for="search-companyName">公司:</label>
                        <input type="text" class="form-control" id="search-companyName" placeholder="请输入公司名称" name="companyName"
                               value="${jobParam.companyName}">
                    </div>
                    <br/>
                    <br/>

                    <div class="form-group">
                        <label for="search-positionSalary">薪资:</label>
                        <input type="text" class="form-control" id="search-positionSalaryStart" placeholder="请输入最低薪资" name="positionSalaryStart"
                               value="${jobParam.positionSalaryStart}">
                        -
                        <input type="text" class="form-control" id="search-positionSalaryEnd" placeholder="请输入最高薪资" name="positionSalaryEnd"
                               value="${jobParam.positionSalaryEnd}">
                    </div>
                    <div class="form-group">
                        <label for="role">学历要求</label>
                        <select class="form-control" name="positionEdu" id="search-edu">
                            <option value="">全部</option>
                            <option value="专科">专科</option>
                            <option value="本科">本科</option>
                            <option value="硕士研究生">硕士研究生</option>
                            <option value="博士研究生">博士研究生</option>
                        </select>
                    </div>
                    <br/>
                    <input type="submit" value="查询" class="btn btn-primary" id="doSearch" style="float: right">
                </form>
            </div>
            <br>

            <div class="show-list text-center" style="position: relative; top: 10px;">
                <table class="table table-striped table-bordered table-hover" style='text-align: center;'>
                    <thead>
                    <tr class="text-danger">
                        <th class="text-center">职位</th>
                        <th class="text-center">公司</th>
                        <th class="text-center">学历要求</th>
                        <th class="text-center">招聘人数</th>
                        <th class="text-center">薪资</th>
                        <th class="text-center">申请</th>
                    </tr>
                    </thead>
                    <tbody id="tb">
                    <c:forEach items="${data.list}" var="job">
                        <tr>
                            <td><a onclick="showPosition(${job.id})">${job.positionName}</a></td>
                            <td><a onclick="showCompany(${job.company.id})">${job.company.companyName}</a></td>
                            <td>${job.positionEdu}</td>
                            <td>${job.positionNum}</td>
                            <td>${job.positionSalary}</td>
                            <td><input type="button" class="btn btn-warning btn-sm doProDelete" value="申请"
                                       onclick="showConfirmModal(${job.id})"></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <ul id="pagination"></ul>
            </div>
        </div>


    </div>
    <jsp:include page="right.jsp"/>
</div>
<!-- 页尾 版权声明 -->
<jsp:include page="buttom.jsp"/>

<!-- 确认申请 start -->
<div class="modal fade" tabindex="-1" id="applyPositionModal">
    <!-- 窗口声明 -->
    <div class="modal-dialog">
        <!-- 内容声明 -->
        <input type="hidden" id="applyPositionId">
        <div class="modal-content">
            <!-- 头部、主体、脚注 -->
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">提示消息</h4>
            </div>
            <div class="modal-body text-center row">
                <div class="col-sm-8">
                    <h4>确认要申请该职位吗吗？</h4>
                </div>

            </div>
            <div class="modal-footer">
                <button class="btn btn-primary " onclick="apply()">确认</button>
                <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 确认申请 end -->
<!-- 查看公司 start -->
<div class="modal fade" tabindex="-1" id="findCompany">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form>
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">企业信息</h4>
                </div>
                <div class="modal-body text-center row">
                    <div class="col-sm-8">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">公司名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyName" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>


                        <div class="form-group">
                            <label class="col-sm-4 control-label"> 企业法人：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyPerson" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">公司邮箱：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyEmail" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">公司地址：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyAddress" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">公司类型：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyType" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label  class="col-sm-4 control-label">公司电话：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyPhone" readonly>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label  class="col-sm-4 control-label">公司创建时间</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="findCompanyCreateDate" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <!-- 显示图像预览 -->
                        <img style="width: 160px;height: 180px;" id="findimg">
                    </div>
                    <div>&nbsp;</div>
                    <div class="col-sm-4">
                                <textarea class="form-control" id="findCompanyDesc" rows="8" readonly>
                                </textarea>
                    </div>

                    <br/>
                    <br/>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary cancel" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 查看公司 end -->
<!-- 修改职位 start -->
<div class="modal fade" tabindex="-1" id="findPosition">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmFindPosition">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">职位信息</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">职位名称：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="findPositionName" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">薪资：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="findPositionSalary" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">招聘人数：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="findPositionNum" readonly>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">职位要求：</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" rows="3" id="findPositionRequire" readonly>

                            </textarea>
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">学历要求：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="findPositionEdu" readonly >
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label class="col-sm-4 control-label">联系电话：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="findPositionPhone" readonly>
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary cancel" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改职位 end -->

</body>
</html>
