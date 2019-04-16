<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <th>用户</th>
            <th>内容</th>
            <th>时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${replyPageInfo.list}" var="r">
            <tr>
                <td>${r.userName}</td>
                <td>${r.content}</td>
                
                <td><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                    <button class="btn-danger small" del_rid="${r.rid}">删除</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<div class="row" style="text-align: center">
    <nav aria-label="Page navigation">
        <ul class="pagination">

            <c:if test="${replyPageInfo.hasPreviousPage}">
                <li>
                    <a id="pre" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${replyPageInfo.hasPreviousPage==false}">
                <li  class="disabled">
                    <a aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

            </c:if>

            <li>
                <a id="first">首页</a>
            </li>

            <c:forEach items="${replyPageInfo.navigatepageNums}" var="num">
                <c:if test="${replyPageInfo.pageNum==num}">
                    <li class="active">
                        <a class="num">${num}</a>
                    </li>
                </c:if>
                <c:if test="${replyPageInfo.pageNum!=num}">
                    <li>
                        <a class="num">${num}</a>
                    </li>
                </c:if>
            </c:forEach>

            <li>
                <a id="last">末页</a>
            </li>
            <c:if test="${replyPageInfo.hasNextPage}">
                <li>
                    <a id="next" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>

            </c:if>
            <c:if test="${replyPageInfo.hasNextPage==false}">
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

    $("#table button[del_rid]").click(function () {
        if (confirm("确定删除该回复么？")) {
            var id=$(this).attr("del_rid");
            var num=$(".active .num").text();
            $("#loadBlock .col-md-10").empty();
            $("#loadBlock .col-md-10").load("admin/deleteReply?rid="+id+"&num="+num);
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
        $("#loadBlock .col-md-10").load("${partPath}/${replyPageInfo.prePage}")
    })
    $(".num").click(function () {
        $("#loadBlock .col-md-10").empty();
        var num=$(this).text();
        $("#loadBlock .col-md-10").load("${partPath}/"+num)
    })
    $("#next").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${replyPageInfo.nextPage}")
    })
    $("#last").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${replyPageInfo.pages}")
    })
</script>
</html>
