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
    <link href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        .table-hover {
            width: 100%;
        }
        .table-hover th{
            text-align: center;
            width: 150px;

        }
        .table-hover tr{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="row">
    <table class="table table-hover" id="table">
        <thead>
        <tr>
            <th>id</th>
            <th>用户名</th>
            <th>邮箱</th>
            <th>管理员</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userPageInfo.list}" var="u">
            <tr>
                <td>${u.uid}</td>
                <td>${u.username}</td>
                <td>${u.email}</td>
                <td>
                    <c:if test="${u.isadmin==true}">
                        是
                    </c:if>
                    <c:if test="${u.isadmin!=true}">
                        否
                    </c:if>
                </td>

                <td>
                    <button class="btn-danger small" del_uid="${u.uid}">删除</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<div class="row" style="text-align: center">
    <nav aria-label="Page navigation">
        <ul class="pagination">

            <c:if test="${userPageInfo.hasPreviousPage}">
                <li>
                    <a id="pre" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${userPageInfo.hasPreviousPage==false}">
                <li  class="disabled">
                    <a aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

            </c:if>

            <li>
                <a id="first">首页</a>
            </li>

            <c:forEach items="${userPageInfo.navigatepageNums}" var="num">
                <c:if test="${userPageInfo.pageNum==num}">
                    <li class="active">
                        <a class="num">${num}</a>
                    </li>
                </c:if>
                <c:if test="${userPageInfo.pageNum!=num}">
                    <li>
                        <a class="num">${num}</a>
                    </li>
                </c:if>
            </c:forEach>

            <li>
                <a id="last">末页</a>
            </li>
            <c:if test="${userPageInfo.hasNextPage}">
                <li>
                    <a id="next" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>

            </c:if>
            <c:if test="${userPageInfo.hasNextPage==false}">
                <li class="disabled">
                    <a aria-label="Next" class="disabled">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>

            </c:if>

        </ul>
    </nav>
</div>
</body>

<script src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<%--delete button click--%>
<script>
   
    $("#table button[del_uid]").click(function () {
        if (confirm("确定删除该用户么？")) {
            var id=$(this).attr("del_uid");
            var num=$(".active .num").text();

            $("#loadBlock .col-md-10").empty();
            $("#loadBlock .col-md-10").load("admin/deleteUser?uid="+id+"&num="+num);
        }

    })
</script>
<script>

    $("#first").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/1")
    })
    $("#pre").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${userPageInfo.prePage}")
    })
    $(".num").click(function () {
        $("#loadBlock .col-md-10").empty();
        var num=$(this).text();
        $("#loadBlock .col-md-10").load("${partPath}/"+num)
    })
    $("#next").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${userPageInfo.nextPage}")
    })
    $("#last").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${userPageInfo.pages}")
    })
</script>
</html>
