<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="static/css/head.css">
</head>
<body>
<%--菜单栏--%>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#" style="display: inline-block;margin-left: 60px;padding-top: 0px">
                <span style="font-size: x-large">Wuhui's blog</span><br/>
                <span>The future always changes...</span>
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" style="width:70%">
                <c:forEach items="${categoryList}" var="c">
                    <c:if test="${c.cid==c.pcid}">
                        <li class="menuLi">
                            <a href="category-articles/${c.cid}/1">${c.cname}</a>
                            <ul>
                                <c:if test="${c.childList!=null}">
                                    <c:forEach items="${c.childList}" var="cc">
                                        <li>
                                            <a href="category-articles/${cc.cid}/1">${cc.cname}</a>
                                            <ul>
                                                <c:if test="${cc.childList!=null}">
                                                    <c:forEach items="${cc.childList}" var="ccc">
                                                        <li>
                                                            <a href="category-articles/${ccc.cid}/1">${ccc.cname}</a>
                                                        </li>
                                                    </c:forEach>
                                                </c:if>
                                            </ul>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>

                <li class="menuLi">
                    <c:if test="${currentUser!=null}">
                        <div id="headPicture" class="col-md-6" style="padding:0 0px;text-align: center">
                            <img src="${currentUser.photo}" alt="..." class="img-circle">
                        </div>
                        <div class="col-md-6" style="padding:0 0px">
                            <p style="font-size: medium;">${currentUser.username}</p>
                            <span>个人中心</span>
                        </div>
                        <ul style="top: 53px;">
                            <li><a href="user/editPage">修改资料</a></li>
                            <li><a class="keepUrlAfterLogin">退出登录</a></li>
                        </ul>
                    </c:if>
                    <c:if test="${currentUser==null}">
                        <a href="#">个人中心</a>
                        <ul>
                            <li><a class="keepUrlbBeforeLogin">登录</a></li>
                            <li><a href="register">注册</a></li>
                        </ul>
                    </c:if>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<%--导航路径--%>
<div class="row" style="background-color: #f8f8f8;margin-top: 50px;width: 100%;margin-left:20px">
    <ol class="breadcrumb" style="margin: 0px 0px 0px 60px">
        <li><a href="home/1">Home</a></li>
        <c:if test="${currentCategory!=null}">
            <li class="active">
                    <%--
                                            <a href="category-articles/${currentCategory.cid}/1">${currentCategory.cname}</a>
                    --%>
                    ${currentCategory.cname}

            </li>

        </c:if>
        <c:if test="${currentCategory==null}">
            <li class="active"></li>
        </c:if>

    </ol>
</div>
</body>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<script src="static/js/head.js"></script>
<%--back to page before login--%>
<script>
    $(".keepUrlbBeforeLogin").click(function () {
        $.ajax({
            type:"get",
            url:"keep_url",
            /*contentType:"application/json;charset=utf-8",*/
            dataType:"json",
            data:"to_url="+window.location.href,
            success:function (r) {
                console.log("ak");
                console.log(r);

                window.location.href="login"
            }
        })
    })
    $(".keepUrlAfterLogin").click(function () {
        $.ajax({
            type:"get",
            url:"user/logout",
            dataType:"json",
            success:function () {
               window.location.reload(false);
            }
        })
    })
</script>

</html>
