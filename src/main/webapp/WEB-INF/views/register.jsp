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
    <link href="static/css/alert.css" rel="stylesheet">
</head>
<body>
<jsp:include page="alert.jsp"/>
<jsp:include page="header.jsp"/>
<%--register--%>
 <div class="row" style="margin-top: 10px">
        <div class="col-md-5 col-xs-5" style="margin-left: 32%;margin-right: 32%">
            <form onsubmit="return no_submit()" id="myform">
                <table style="border-collapse:separate;border-spacing: 25px;border: solid 2px gainsboro">
                    <tr>
                        <td colspan="2" style="margin-bottom: 10px;text-align: center;">
                            <h3 style="font-weight: bold;font-family: Arial">欢迎注册！</h3>
                        </td>
                    </tr>
                    <tr>
                        <td><label>头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像：</label></td>
                        <td>
                            <input name="photo" type="file" style="display: none">
                            <img style="width:50px;height:50px;display: none" class="img-circle" id="photoImg" src=""/>
                            <img id="uploadTrigger" class="img-thumbnail" src="static/img/other/plus.ico" style="width:30% ">
                        </td>
                    </tr>
                    <tr>
                        <td><label>用&nbsp;&nbsp;户&nbsp;&nbsp;名:</label></td>
                        <td>
                            <input name="username"
                                   type="text" class="form-control"  >
                            <span id="usernameSpan"></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label></td>
                        <td>

                            <input name="email" type="text" class="form-control" >
                            <span id="emailSpan"></span>
                        </td>
                    </tr>
                    <tr>
                        <td><label>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</label></td>
                        <td>
                            <input name="password"   type="password" class="form-control">
                            <span id="passwordSpan"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>个人描述：</label>
                        </td>
                        <td>
                    <textarea name="description" class="form-control">
                    </textarea><span id="descriptionSpan"></span>
                        </td>

                    </tr>

                    <tr>
                        <td colspan="2" style="text-align: center">
                            <button id="submit-button" type="submit" class="btn btn-info" style="width:280px;">确认</button>
                        </td>
                    </tr>
                </table>
            </form>

        </div>
    </div>


</body>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>

<%--check--%>
<script>

    function check() {
        var emailReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if ($("input[name='username']").val() == "") {
            $("form span").text("");
            $("#usernameSpan").text("用户名不能为空").css("color","red");
            return false;
        }

        if (!emailReg.test($("input[name='email']").val())) {
            $("form span").text("");
            $("#emailSpan").text("请输入正确邮箱").css("color","red");
            return false;
        }
        if ($("input[name='password']").val() == "") {
            $("form span").text("");
            $("#passwordSpan").text("密码不能为空").css("color","red");
            return false;
        }
        if ($("input[name='password']").val().length<6) {
            $("form span").text("");
            $("#passwordSpan").text("密码不能小于6位数").css("color","red");
            return false;
        }
        return true;
    }


</script>
<%--upload--%>
<script>
    $("#uploadTrigger").click(function () {
        $("input[type='file']").trigger("click");
    });
    $("input[type='file']").change(function () {
        var fileReader=new FileReader();
        fileReader.readAsDataURL($(this)[0].files[0]);
        fileReader.onload=function(){
            $("#photoImg").attr("src",this.result);//结果会存在result属性
            $("#photoImg").css("display","inline")
        };
    })

</script>
<%--submit--%>
<script>
    function no_submit() {
        return false;
    }
    $("#submit-button").click(function () {

        var form=new FormData($("#myform")[0]);
        if (check()) {

            $.ajax({
                type:"post",
                dataType:"json",
                url:"user/register",
                data:form,
                processData:false,
                contentType:false,
                success:function (result) {
                    $("#alert-span").text(result);
                    $("#alert-div").fadeIn(500);
                    $("#alert-div").fadeOut(1500,function () {
                        window.location.href="login"
                    });
                }
            })
        }
    })
</script>

</html>
