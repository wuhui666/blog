<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <link href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <link href="static/css/alert.css" rel="stylesheet">

    <style>
        #head{
            text-align: center;
            width: 100%;
            height: 80px;
            background-image: url('${pageContext.request.contextPath}/static/img/other/66.jpg');
            padding-top: 5px;
            font-size: x-large;
            color: #449d44;

        }

        .nav-li span{
            margin-left: 60px;
        }
        #headPicture img{
            width: 50px;
            height: 50px;
        }

    </style>
</head>
<body>
    <jsp:include page="../alert.jsp"/>
    <div id="head" class="row" style="margin-right: 0px">
        <div class="col-md-10">
            <h1>欢迎登录!</h1>
        </div>
        <div class="col-md-2" style="padding: 0 0px">
            <div id="headPicture" class="col-md-6" style="padding-right: 0px;text-align: right">
                <img src="${pageContext.request.contextPath}/${currentUser.photo}" alt="..." class="img-circle">

            </div>
            <div class="col-md-6" style="padding-left: 0px">
                <p style="font-size: medium">${currentUser.username}</p>
                <a style="font-size: medium" href="home/1">回到前台</a>

            </div>

        </div>

    </div>

    <div class="row" id="loadBlock">
        <div class="col-md-2" style="padding-right: 0px">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="nav-li">

                    <a><span >博客</span></a>

                    <div class="sub-nav-pills" style="display: none">
                        <ul class="nav nav-pills nav-stacked">
                            <li role="presentation" id="showBlogLi"><a><span>管理博客</span></a></li>
                            <li <%--id="editorLi"--%> role="presentation"><%--froala局部刷新不稳定，so...--%>
                                <a href="admin/addBlogPage"><span>新增博客</span></a>
                            </li>

                        </ul>
                    </div>

                </li>
                <li  id="userLi" role="presentation" class="nav-li" >
                    <a><span>用户</span></a>
                </li>
                <li role="presentation" class="nav-li">
                    <a><span>评论</span></a>
                    <div class="sub-nav-pills" style="display: none">
                        <ul class="nav nav-pills nav-stacked">
                            <li id="commentLi" role="presentation"><a><span>管理评论</span></a></li>
                            <li id="replyLi" role="presentation"><a><span>管理回复</span></a></li>
                        </ul>
                    </div>
                </li>
                <li id="categoryLi" role="presentation" class="nav-li">
                    <a><span>分类</span></a>

                </li>
            </ul>
        </div>
        <div class="col-md-10" style="padding: 0 0px">


        </div>
    </div>
    

</body>
<script src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<%--Li click--%>
<script>
    $(".nav-li a").click(function(){
        $(this).next(".sub-nav-pills").slideToggle();
    });
    $(".nav-li").hover(function(){
        $(this).addClass("active");
    },function () {
        $(this).removeClass("active");
    });
    $("#showBlogLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/manageBlog/1");
    })
    $("#userLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/manageUser/1");
    })
    $("#commentLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/manageComment/1");
    })
    $("#replyLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/manageReply/1");
    })
    $("#categoryLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/manageCategory/1");
    })
   /* $("#editorLi").click(function () {
        $("#loadBlock .col-md-10").empty();
        /!*$("#loadBlock .col-md-10").load("admin/editor");*!/
        $("#loadBlock .col-md-10").load("admin/addBlogPage");

    })*/
</script>
</html>
