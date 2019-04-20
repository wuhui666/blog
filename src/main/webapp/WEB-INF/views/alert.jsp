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
    <div id="alert-div" class="col-md-5 col-xs-5" style="margin-left: 32%;margin-right: 32%;margin-top: 15%;" >
        <span id='alert-span'></span>
    </div>
</body>
</html>
