<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <script SRC="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-table.css"/>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-table.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.min.css"
          type="text/css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript">
        $(function(){
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
                    return '${pageContext.request.contextPath}/front/user/findNews?pageNum='+page;
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

        //显示新闻界面
        function showNews(id){
            //alert(id);
            $.post('${pageContext.request.contextPath}/front/user/findNewsById',
                {'id':id},function(result){
                    //console.log(result);
                    //如果成功，将值写入修改模态框
                    if(result.status==1){
                        $('#newsTitle').val(result.obj.newsTitle);
                        $('#newsContent').text(result.obj.newsContent);
                        $('#showNews').modal('show');
                    }
                });
        }


    </script>
</head>
<body>
<% request.setAttribute("index", 1); %>
<jsp:include page="top.jsp"/>
<div class="container margin-top-10">
    <div class="col-sm-9">
        <div class="show-list text-center">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">标题</th>
                    <th class="text-center">作者</th>
                    <th class="text-center">创建日期</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${data.list}" var="news">
                    <tr>
                        <td><a onclick="showNews(${news.id})">${news.newsTitle}</a></td>
                        <td>${news.sysuser.loginName}</td>
                        <td><fmt:formatDate value="${news.createDate}" pattern="yyyy-MM-dd HH:mm:ss"
                                            timeZone="UTC"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%--bootstrap分页条--%>
            <ul id="pagination"></ul>
        </div>


    </div>
    <jsp:include page="right.jsp"/>
</div>
<jsp:include page="buttom.jsp"/>
<div class="modal fade" tabindex="-1" id="showNews">
    <!-- 窗口声明 -->
        <div class="modal-dialog modal-lg">
            <!-- 内容声明 -->
            <div class="modal-content">
                <!-- 头部、主体、脚注 -->
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">查看新闻</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row text-right">
                        <div class="col-sm-4">
                            <strong><span id="newsTitle">sdsds</span></strong>
                        </div>
                    </div>
                    <br>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <div class="col-sm-4">
                                <span id="newsContent"></span>
                            </div>
                        </div>
                        <br>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary cancel" data-dismiss="modal">关闭</button>
                </div>
            </div>

        </div>
</div>
<!-- 查看新闻 end -->
</body>
</html>
