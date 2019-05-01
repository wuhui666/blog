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
    <link rel="shortcut icon" type="image/x-icon" href="static/img/other/logo.ico"/>
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<jsp:include page="alert.jsp"/>
<jsp:include page="header.jsp"/>
<%--register--%>
<div style="margin-top: 10px">


    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active" style="padding-left: 40%">
            <a href="#base" aria-controls="base" role="tab" data-toggle="tab">基本修改</a>
        </li>
        <li role="presentation">
            <a href="#password" aria-controls="password" role="tab" data-toggle="tab">
            密码修改
            </a>
        </li>

    </ul>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active fade in" id="base">
            <div class="row" style="margin-top: 10px">
                <div class="col-md-5 col-xs-5" style="margin-left: 32%;margin-right: 32%">
                    <form id="myform" onsubmit="return no_submit()">
                        <table style="border-collapse:separate;border-spacing: 25px;border: solid 2px gainsboro">
                            <tr>
                                <td colspan="2" style="margin-bottom: 10px;text-align: center;">
                                    <h3 style="font-weight: bold;font-family: Arial">基本修改</h3>
                                </td>
                            </tr>
                            <tr>
                                <td><label>头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像：</label></td>
                                <td>
                                    <input name="photo" type="file" style="display: none">
                                    <c:if test="${currentUser==null}">
                                        <img style="width:50px;height:50px;display: none" class="img-circle" id="photoImg" src="${currentUser.photo}"/>
                                    </c:if>
                                    <c:if test="${currentUser!=null}">
                                        <img style="width:50px;height:50px;" class="img-circle" id="photoImg" src="${currentUser.photo}"/>
                                    </c:if>

                                    <img id="uploadTrigger" class="img-thumbnail" src="static/img/other/plus.ico" style="width:30% ">
                                </td>
                            </tr>
                            <tr>
                                <td><label>用&nbsp;&nbsp;户&nbsp;&nbsp;名:</label></td>
                                <td>
                                    <input name="username"
                                           type="text" class="form-control" value="${currentUser.username}" >
                                    <span id="usernameSpan"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label></td>
                                <td>

                                    <input name="email" type="text" class="form-control" value="${currentUser.email}">
                                    <span id="emailSpan"></span>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label>个人描述：</label>
                                </td>
                                <td>
                                    <textarea style="text-align: left" name="description" class="form-control">
                                        ${currentUser.description}
                                    </textarea>
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <input type="hidden" name="uid" value="${currentUser.uid}">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center">
                                    <button id="submit-button" class="btn btn-info" style="width:280px;">确认</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="password">
            <div class="row" style="margin-top: 10px">
                <div class="col-md-5 col-xs-5" style="margin-left: 32%;margin-right: 32%">
                    <form id="myform2" onsubmit="return no_submit()">
                        <table style="border-collapse:separate;border-spacing: 25px;border: solid 2px gainsboro">
                            <tr>
                                <td colspan="2" style="margin-bottom: 10px;text-align: center;">
                                    <h3 style="font-weight: bold;font-family: Arial">密码修改</h3>
                                </td>
                            </tr>

                            <tr>
                                <td><label>旧&nbsp;&nbsp;密&nbsp;&nbsp;码：</label></td>
                                <td>
                                    <input id="old_password" name="password"   type="password" class="form-control">
                                    <span id="passwordSpan"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label>新&nbsp;&nbsp;密&nbsp;&nbsp;码：</label></td>
                                <td>
                                    <input id="new_password" name="new_password"   type="password" class="form-control">
                                    <input type="hidden" name="uid" value="${currentUser.uid}"/>
                                    <span id="newpasswordSpan"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center">
                                    <button id="submit-password-form" type="submit" class="btn btn-info" style="width:280px;">确认</button>
                                </td>
                            </tr>
                        </table>
                    </form>

                </div>
            </div>
        </div>

    </div>

</div>


</body>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<%--menu--%>
<script>
    $(".menuLi").hover(function () {
        $(this).css("background-color","lightblue");
        $(this).children("ul").css("display","block")
    },function () {
        $(this).css("background-color","");
        $(this).children("ul").css("display","none")

    })
    $(".menuLi ul li").hover(function () {
        $(this).css("background-color","lightblue");
        $(this).children("ul").css("display","block")
    },function () {
        $(this).css("background-color","");
        $(this).children("ul").css("display","none")

    })
</script>
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
        return true;
    }


</script>
<%--upload preview--%>
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
<%--submit base form--%>
<script>
    function no_submit(){
                return false;
            }
            $("#submit-button").click(function () {

                var form=new FormData($("#myform")[0]);
                if (${currentUser==null}) {
                    $("#alert-span").text("没登录改个蛇皮啊！");
                    $("#alert-div").fadeIn(500);
                    $("#alert-div").fadeOut(500);
                    return;
                }
                if (check()){
                    $.ajax({
                        type:"post",
                data:form,
                dataType:"json",
                url:"user/edit",
                contentType:false,
                processData:false,
                success:function () {
                    $("#alert-span").text("修改成功！");
                    $("#alert-div").fadeIn(500);
                    $("#alert-div").fadeOut(500,function () {
                        window.location.reload(false);
                    });
                }
            })
        }
    })
</script>
<%--submit password form--%>
<script>
    $("#submit-password-form").click(function () {

        var form=new FormData($("#myform2")[0]);
        if (${currentUser==null}) {
            $("#alert-span").text("没登录改个蛇皮啊！");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(500);
            return;
        }
        /*check*/
        if ($("#old_password").val()=="") {
            $("#alert-span").text("请输入原密码");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(500);
            return;
        }
        if ($("#new_password").val()=="") {
            $("#alert-span").text("请输入新密码");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(500);
            return;
        }
        if ($("#new_password").val().length<6) {
            $("#alert-span").text("密码不能小于6位");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(500);
            return;
        }
        /*submit*/
        $.ajax({
            type:"post",
            data:form,
            dataType:"json",
            url:"user/editPassword",
            contentType:false,
            processData:false,
            success:function (result) {
                if (result=="原密码错误"){
                    $("#alert-span").text(result);
                    $("#alert-div").fadeIn(500);
                    $("#alert-div").fadeOut(1500);
                }
                else {
                    $("#alert-span").text(result);
                    $("#alert-div").fadeIn(500);
                    $("#alert-div").fadeOut(1500,function () {
                        window.location.href="login"
                    });
                }

            }
        })
    })
</script>
</html>
