<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>zjob</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" type="text/css"></link>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mycss.css" type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-table.css"/>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-table.js"></script>
    <script SRC="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.min.css"
          type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
        $(function () {
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
                    return '${pageContext.request.contextPath}/front/user/findMyapply?pageNum=' + page;
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
    </script>
</head>
<body>
<% request.setAttribute("index", 3); %>
<jsp:include page="top.jsp"/>
<div class="container margin-top-10">
    <div class="col-sm-9">

        <div class="panel-body">
            <br>
            <div class="show-list text-center">
                <table class="table table-bordered table-hover" style='text-align: center;'>
                    <thead>
                    <tr class="text-danger">
                        <th class="text-center">职位</th>
                        <th class="text-center">公司名称</th>
                        <th class="text-center">薪资</th>
                        <th class="text-center">面试邀请</th>
                    </tr>
                    </thead>
                    <tbody id="tb">
                    <c:forEach items="${data.list}" var="findjobs">
                        <tr>
                            <td>${findjobs.positionName}</td>
                            <td>${findjobs.companyName}</td>
                            <td>${findjobs.positionSalary}</td>
                            <td>
                                <c:if test="${findjobs.isSend==1}">已收到</c:if>
                                <c:if test="${findjobs.isSend==0}">未收到</c:if>
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
    <jsp:include page="right.jsp"/>
</div>
<jsp:include page="buttom.jsp"/>


</body>
</html>
