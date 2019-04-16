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
    <link rel="stylesheet" href="static/css/alert.css">

</head>
<body>
<div class='row'>
    <div id="alert-div" class="col-md-2 col-md-offset-5">
        <span id='alert-span'></span>
    </div>
</div>
</body>
</html>
