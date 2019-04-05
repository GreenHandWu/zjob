<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>收到的简历</title>
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
        $(function(){
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
                    return '${pageContext.request.contextPath}/front/company/findResumeAllByPage?pageNum='+page;
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
        //显示确认删除新闻模态框
        function showSendEmail(userId,positionName,positionId){
            //将id值存入删除模态框的隐藏域
            $('#userId').val(userId);
            $('#positionName').val(positionName);
            $('#positionId').val(positionId);
            $('#sendEmail').modal('show');
        }

        function send(){
            $.post('${pageContext.request.contextPath}/front/company/sendEmail',
                //将表单中的元素以key=value的形式序列化，key就是name属性的值，value就是value属性的值
                $('#frmEmail').serialize(),function (result) {
                    if (result.status == 1) {
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'successMsg'
                        });
                    } else{
                        layer.msg(result.message, {
                            time: 2000,
                            skin: 'errorMsg'
                        });
                    }

                });
        }

    </script>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">简历查看</h3>
    </div>
    <div class="panel-body">
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">

                    <th class="text-center">用户名</th>
                    <th class="text-center">职位</th>
                    <th class="text-center">性别</th>
                    <th class="text-center">电话</th>
                    <th class="text-center">教育程度</th>
                    <th class="text-center">简历</th>
                    <th class="text-center">发送邮件</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="user">
                    <tr>
                        <td>${user.userName}</td>
                        <td>${user.positionName}</td>
                        <td>
                            <c:if test="${user.gender==1}">男</c:if>
                            <c:if test="${user.gender==0}">女</c:if>
                        </td>
                        <td>${user.phone}</td>
                        <td>${user.userEdu}</td>
                        <%--<td>${user.email}</td>--%>
                        <td><a href="${pageContext.request.contextPath}/front/user/download?fileName=${user.userResume}&userName=${user.userName}">${user.userName}的简历</a></td>
                        <td class="text-center">
                            <c:if test="${user.isSend==0}">
                                <input type="button" class="btn btn-success btn-sm" value="发送邮件"
                                       onclick="showSendEmail('${user.userId}','${user.positionName}','${user.positionId}')">
                            </c:if>
                            <c:if test="${user.isSend==1}">
                                <input type="button" class="btn btn-warning btn-sm" value="已发送邮件">
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


<div class="modal fade" tabindex="-1" id="sendEmail">
    <!-- 窗口声明 -->
    <div class="modal-dialog modal-lg">
        <!-- 内容声明 -->
        <form id="frmEmail">
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">通知内容</h4>
                </div>
                <div class="modal-body text-center">
                    <input type="hidden" class="form-control" id="userId" name="userId">
                    <input type="hidden" class="form-control" id="positionName" name="positionName">
                    <input type="hidden" class="form-control" id="positionId" name="positionId">
                    <div class="row text-right">
                        <label for="time" class="col-sm-4 control-label">面试时间：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="time" name="time">
                        </div>
                    </div>
                    <br>
                    <div class="row text-right">
                        <label for="venue" class="col-sm-4 control-label">面试地点：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="venue" name="venue">
                        </div>
                    </div>
                    <br>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-primary" onclick="send()" value="通知"></input>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>


</body>
</html>
