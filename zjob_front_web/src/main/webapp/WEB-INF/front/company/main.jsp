<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>zjob-企业用户</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script type="text/javascript">
        function showTime() {
            let d = new Date();
            let year = d.getFullYear();//获取4位年份
            let month = d.getMonth() + 1;//月份是从0开始计算
            let day = d.getDate();
            let hour = d.getHours();
            let minute = d.getMinutes();
            //let second = d.getSeconds();
            //将值拼接后写入id=timeId的节点上
            $("#timeId").html(year + '年' + month + '月' + day + '日' + hour + '时' + minute + '分');
        }

        $(function () {
            showTime();
            setInterval(showTime, 1000);
        });
        $(function () {
            // 点击切换页面
            $("#position-set").click(function () {
                $("#frame-id").attr("src", "${pageContext.request.contextPath}/front/company/findPositionAllByPage");
            });
            $("#resume-set").click(function () {
                $("#frame-id").attr("src", "${pageContext.request.contextPath}/front/company/findResumeAllByPage");
            });
            $("#product-set").click(function () {
                $("#frame-id").attr("src", "${pageContext.request.contextPath}/front/company/findProductAllByPage");
            });
            $("#order-set").click(function () {
                $("#frame-id").attr("src", "${pageContext.request.contextPath}/front/company/findOrderAllByPage");
            });
            $("#mydata-set").click(function () {
                $("#frame-id").attr("src", "${pageContext.request.contextPath}/front/company/findMyData");
            });
        });

        function loginOut() {
            $.ajax({
                method: 'post',
                url: '${pageContext.request.contextPath}/loginOut',
                success: function () {
                    alert('你已退出该系统');
                    //返回登录页重新登录
                    window.location = "${pageContext.request.contextPath}/showLogin";
                }

            });

        }


    </script>
</head>

<body>
<div class="wrapper-cc clearfix">
    <div class="content-cc">
        <!-- header start -->
        <div class="clear-bottom head">
            <div class="container head-cc">
                <p>ZJOB招聘<span>企业后台管理系统</span></p>
                <div class="welcome">
                    <div class="left">欢迎您：</div>
                    <div class="right">${company.companyName}</div>
                    <div class="exit" style="cursor: pointer" onclick="loginOut()">退出</div>
                </div>
            </div>
        </div>
        <!-- header end -->
        <!-- content start -->
        <div class="container-flude flude-cc" id="a">
            <div class="row user-setting">
                <div class="col-xs-2 user-wrap">
                    <ul class="list-group">
                        <li id="timeId"></li>
                        <li class="list-group-item active" name="userSet" id="position-set" style="cursor: pointer">
                            <i class="glyphicon glyphicon-user"></i> &nbsp;职位管理
                        </li>
                        <li class="list-group-item" name="userPic" id="resume-set" style="cursor: pointer">
                            <i class="glyphicon glyphicon-envelope"></i> &nbsp;收到的简历
                        </li>
                        <li class="list-group-item" name="companySet" id="product-set" style="cursor: pointer">
                            <i class="glyphicon glyphicon-th-list"></i> &nbsp;服务购买
                        </li>
                        <li class="list-group-item" name="adminSet" id="order-set" style="cursor: pointer">
                            <i class="glyphicon glyphicon-globe"></i> &nbsp;订单查看
                        </li>
                        <li class="list-group-item" name="productSet" id="mydata-set" style="cursor: pointer">
                            <i class="glyphicon glyphicon-wrench"></i> &nbsp;企业信息
                        </li>
                    </ul>
                </div>
                <div class="col-xs-10" id="userPanel">
                    <iframe id="frame-id" src="${pageContext.request.contextPath}/front/company/findPositionAllByPage"
                            width="100%" height="100%" frameborder="0" scrolling="no">
                    </iframe>
                </div>
            </div>
        </div>
        <!-- content end-->
    </div>
</div>
<!-- footers start -->
<div class="footer">
    版权所有：志明软件技术
</div>
<!-- footers end -->
</body>

</html>