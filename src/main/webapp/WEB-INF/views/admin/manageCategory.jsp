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
        <tr style="position: relative">

            <th>
                <button class="btn-success small" style="position: absolute;top: 8px;left: 0px" data-toggle="modal" data-target="#myModal">+</button>
                分类id
            </th>
            <th>上级id</th>
            <th>分类名</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${categoryPageInfo.list}" var="r">
            <tr>
                <td>${r.cid}</td>
                <td>${r.pcid}</td>
                <td>${r.cname}</td>
                <td>
                    <button class="btn-info small" data-toggle="modal" data-target="#myModal_edit" edit_cid="${r.cid}">修改</button>
                    <button class="btn-danger small" del_cid="${r.cid}">删除</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <%--modal--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增分类</h4>
                </div>
                <div class="row" style="width: 100%">
                    <form style="margin-top: 10px" id="myform">
                        <div class="row" style="margin:10 30px;">
                            <div class="form-group" style="">
                                <label class="col-sm-3 control-label">分类名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="cname" maxlength="12">
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin:0 30px">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">上级分类</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="pcid">
                                        <c:forEach items="${parentCategoryList}" var="ca" varStatus="st">
                                            <c:if test="${st.first}">
                                                <option value="${ca.cid}" selected="selected">${ca.cname}</option>
                                            </c:if>
                                            <c:if test="${!st.first}">
                                                <option value="${ca.cid}">${ca.cname}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button id="cancel" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="ensure" type="button" class="btn btn-primary">确定</button>
                </div>
            </div>
        </div>
    </div>
    <%--modal_edit--%>
    <div class="modal fade" id="myModal_edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModal_editLabel">修改分类</h4>
                </div>
                <div class="row" style="width: 100%">
                    <form style="margin-top: 10px" id="myform_edit">
                        <div class="row" style="margin:10 30px;">
                            <div class="form-group" style="">
                                <label class="col-sm-3 control-label">分类名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="cname" maxlength="12">
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin:0 30px">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">上级分类</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="pcid">
                                        <c:forEach items="${parentCategoryList}" var="ca" varStatus="st">
                                            <c:if test="${st.first}">
                                                <option value="${ca.cid}" selected="selected">${ca.cname}</option>
                                            </c:if>
                                            <c:if test="${!st.first}">
                                                <option value="${ca.cid}">${ca.cname}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <input type="hidden" name="cid" value="">
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button id="cancel_edit" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="ensure_edit" type="button" class="btn btn-primary"cid="">确定</button>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="row" style="text-align: center">
    <nav aria-label="Page navigation">
        <ul class="pagination">

            <c:if test="${categoryPageInfo.hasPreviousPage}">
                <li>
                    <a id="pre" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${categoryPageInfo.hasPreviousPage==false}">
                <li  class="disabled">
                    <a aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

            </c:if>

            <li>
                <a id="first">首页</a>
            </li>

            <c:forEach items="${categoryPageInfo.navigatepageNums}" var="num">
                <c:if test="${categoryPageInfo.pageNum==num}">
                    <li class="active">
                        <a class="num">${num}</a>
                    </li>
                </c:if>
                <c:if test="${categoryPageInfo.pageNum!=num}">
                    <li>
                        <a class="num">${num}</a>
                    </li>
                </c:if>
            </c:forEach>

            <li>
                <a id="last">末页</a>
            </li>
            <c:if test="${categoryPageInfo.hasNextPage}">
                <li>
                    <a id="next" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>

            </c:if>
            <c:if test="${categoryPageInfo.hasNextPage==false}">
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

    $("#table button[del_cid]").click(function () {
        if (confirm("确定删除该分类么？")) {
            var id=$(this).attr("del_cid");
            var num=$(".active .num").text();
            $("#loadBlock .col-md-10").empty();
            $("#loadBlock .col-md-10").load("admin/deleteCategory?cid="+id+"&num="+num);
        }

    })
    $("#table button[edit_cid]").click(function () {

            var id=$(this).attr("edit_cid");
            $("#myform_edit input[name='cid']").val(id);
            console.log($(this).prev().text());
            $("#myform_edit input[name='cname']").val($(this).parent().prev().text());
            $("select[name='pcid']").val($(this).parent().prev().prev().text());

    })
</script>
<script>

    $("#first").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/1")
    })
    $("#pre").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${categoryPageInfo.prePage}")
    })
    $(".num").click(function () {
        $("#loadBlock .col-md-10").empty();
        var num=$(this).text();
        $("#loadBlock .col-md-10").load("${partPath}/"+num)
    })
    $("#next").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${categoryPageInfo.nextPage}")
    })
    $("#last").click(function () {
        $("#loadBlock .col-md-10").empty();
        $("#loadBlock .col-md-10").load("${partPath}/${categoryPageInfo.pages}")
    })
</script>
<%--modal--%>
<script>
    $("#cancel").click(function () {
        $("#myform")[0].reset();
    })
    $("#cancel_edit").click(function () {
        $("#myform_edit")[0].reset();
    })
    $("#ensure").click(function () {

        var form=new FormData($("#myform")[0]);
        console.log(7);
       $.ajax({
           type:"post",
           url:"admin/addCategory",
           dataType:"json",
           processData:false,
           contentType:false,
           data:form,
           success:function (r) {
               $("#alert-span").text(r);
               $("#alert-div").fadeIn(500);
               $("#alert-div").fadeOut(1500);
           }
       })
    })
    $("#ensure_edit").click(function () {

        if ($("#myform_edit input[name='cname']").val()=="") {
            $("#alert-span").text("不能为空");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(1500);
            return;
        }
        var form=new FormData($("#myform_edit")[0]);

        $.ajax({
            type:"post",
            url:"admin/editCategory",
            dataType:"json",
            processData:false,
            contentType:false,
            data:form,
            success:function (r) {
                $("#alert-span").text(r);
                $("#alert-div").fadeIn(500);
                $("#alert-div").fadeOut(1500);
            }
        })
    })
</script>
</html>
