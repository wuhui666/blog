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
</head>
<body>
<jsp:include page="alert.jsp"/>
<jsp:include page="header.jsp"/>
<div class="jumbotron"style="width:100%;height:100%;margin-bottom: 0px">   <!--  放大     -->
    <div style="text-align: center;">
        <p  class="text-info"style="font:italic bolder 100px '微软雅黑';">Wuhui's Blog</p>
        <br />
        <br />
        <p class="text-muted"style="font:italic bolder 30px '微软雅黑';">Welcome to Login here</p>
        <br />
        <br />
        <br />
        <br />


        <div class="row" style="margin-left: 38%;margin-right: 38%">

            <form class="form-horizontal">
                <div class="form-group">
                    <label for="email" class="col-md-3 col-xs-3 control-label">Email</label>
                    <div class="col-md-9 col-xs-9">
                        <input name="email" type="email" class="form-control" id="email" placeholder="Email">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-md-3 col-xs-3 control-label">Password</label>
                    <div class="col-md-9 col-xs-9">
                        <input name="password" type="password" class="form-control" id="password" placeholder="Password">

                    </div>

                </div>

            </form>
            <button class="btn btn-success" id="login-btn">login</button>

        </div>


    </div>
</div>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<%--check--%>
<script>
    function check(str,str2){
        if(str==""){
            $("#alert-span").text("亲我们这边建议您先填写邮箱呢！");
            $("#alert-div").fadeIn(1000);
            $("#alert-div").fadeOut(2000);
            return false;
        }
        else if(str2==""){
            $("#alert-span").text("密码忘填写了，老哥:)");
            $("#alert-div").fadeIn(1000);
            $("#alert-div").fadeOut(2000);
            return false;
        }
        else if(str2.length<6){
            $("#alert-span").text("密码大于6位");
            $("#alert-div").fadeIn(1000);
            $("#alert-div").fadeOut(2000);
            return false;
        }

        return true;
    }
</script>
<%--submit--%>
<script>
    $("#login-btn").click(function () {
        var str=$("input[type='email']").val();
        var str2=$("input[type='password']").val();

        if (check(str,str2)==true){
            var dataObj={
                "email":str,
                "password":str2
            };
            $.ajax({
                type:"post",
                url:"user/login",
                contentType:"application/json;charset=utf-8",
                dataType:"json",
                data:JSON.stringify(dataObj),
                success:function (result) {

                    if (result.success) {
                        $("#alert-span").text("登录成功");
                        $("#alert-div").fadeIn(500);
                        $("#alert-div").fadeOut(1500);
                        if (result.content.flag=="true") {/*back to page login before*/

                            window.location.href=result.content.to_url
                        }
                        else {
                            window.location.href="${pageContext.request.contextPath}/"+result.content.to_url
                        }

                    }
                    else {
                        $("#alert-span").text(result.message);
                        $("#alert-div").fadeIn(500);
                        $("#alert-div").fadeOut(1500);
                    }
                }
            })
        }
    })


</script>
</body>
</html>
