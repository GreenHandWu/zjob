<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script>
    function showTime() {
        let d = new Date();
        let year = d.getFullYear();//获取4位年份
        let month = d.getMonth() + 1;//月份是从0开始计算
        let day = d.getDate();
        let hour = d.getHours();
        let minute = d.getMinutes();
        //let second = d.getSeconds();
        //将值拼接后写入id=timeId的节点上
        $("#timeId").html('当前时间：' + year + '年' + month + '月' + day + '日' + hour + '时' + minute + '分');

    }

    $(function () {
        showTime();
        setInterval(showTime, 1000);

        //正确高亮显示导航栏
        //获取当前页面的索引
        let curIndex =${requestScope.index};
        //找到class=nav的元素的所有li子元素
        $('ul.nav li').each(function (i) {
            //alert(i);
            //将所有导航栏的背景清空
            $(this).removeClass('active');
            if (curIndex == i) {
                //如果就是当前页，背景高亮显示
                $(this).addClass('active');
            }
        });


    });
</script>
<div class="container nav-height">
    <div class="col-sm-3">
        <img alt="" src="${pageContext.request.contextPath}/images/logn.png">
    </div>
    <div class="col-md-3 col-md-offset-6 visible-md-block visible-lg-block">
        <p class="p-css" id="timeId"></p>
    </div>
</div>
<div class="nav-style">
    <div class="container">
        <div class="col-sm-12">
            <ul class="nav nav-pills">
                <li class="active"><a href="${pageContext.request.contextPath}/front/user/findJobByParams">求职招聘</a></li>
                <li><a href="${pageContext.request.contextPath}/front/user/findNews">新闻资讯</a></li>
                <li><a href="${pageContext.request.contextPath}/front/user/findMyData">我的信息</a></li>
                <li><a href="${pageContext.request.contextPath}/front/user/findMyapply">我的申请</a></li>
            </ul>
        </div>
    </div>
</div>