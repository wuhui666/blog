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
                <th>id</th>
                <th>标题</th>
                <th>浏览</th>
                <th>评论</th>
                <th>分类</th>
                <th>时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${articlePageInfo.list}" var="a">
                <tr>
                    <td>${a.aid}</td>
                    <td>${a.title}</td>
                    <td>${a.viewCount}</td>
                    <td>${a.commentCount}</td>
                    <td>${a.categoryName}</td>
                    <td><fmt:formatDate value="${a.createTime}" pattern="yyyy年MM月dd日 HH时mm分"/></td>
                    <td>
                        <button class="btn-success small" edit_aid="${a.aid}">修改</button>
                        <button class="btn-danger small" del_aid="${a.aid}">删除</button>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
   <div class="row" style="text-align: center">
       <nav aria-label="Page navigation">
           <ul class="pagination">

               <c:if test="${articlePageInfo.hasPreviousPage}">
                   <li>
                       <a id="pre" aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                       </a>
                   </li>
               </c:if>
               <c:if test="${articlePageInfo.hasPreviousPage==false}">
                   <li  class="disabled">
                       <a aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                       </a>
                   </li>

               </c:if>

               <li>
                   <a id="first">首页</a>
               </li>

               <c:forEach items="${articlePageInfo.navigatepageNums}" var="num">
                   <c:if test="${articlePageInfo.pageNum==num}">
                       <li class="active">
                           <a class="num">${num}</a>
                       </li>
                   </c:if>
                   <c:if test="${articlePageInfo.pageNum!=num}">
                       <li>
                           <a class="num">${num}</a>
                       </li>
                   </c:if>
               </c:forEach>

               <li>
                   <a id="last">末页</a>
               </li>
               <c:if test="${articlePageInfo.hasNextPage}">
                   <li>
                       <a id="next" aria-label="Next">
                           <span aria-hidden="true">&raquo;</span>
                       </a>
                   </li>

               </c:if>
               <c:if test="${articlePageInfo.hasNextPage==false}">
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
<%--edit/delete button click--%>
<script>
    $("#table button[edit_aid]").click(function () {
        var id=$(this).attr("edit_aid");
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("admin/editor?aid="+id);


    })
    $("#table button[del_aid]").click(function () {
        if (confirm("确定删除该博客么？")) {
            var id=$(this).attr("del_aid");
            var num=$(".active .num").text();

            $("#loadBlock .col-md-10").empty();
            $("#loadBlock .col-md-10").load("admin/deleteBlog?aid="+id+"&num="+num);
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
        $("#loadBlock .col-md-10").load("${partPath}/${articlePageInfo.prePage}")
    })
    $(".num").click(function () {
        $("#loadBlock .col-md-10").empty();
        var num=$(this).text();
        $("#loadBlock .col-md-10").load("${partPath}/"+num)
    })
    $("#next").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${articlePageInfo.nextPage}")
    })
    $("#last").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${articlePageInfo.pages}")
    })
</script>

</html>
