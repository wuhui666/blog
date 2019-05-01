<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    if (request.getSession().getAttribute("webapp_path")==null){
        request.getSession().setAttribute("webapp_path",request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort());
    }

%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>The Blog Of WuHui</title>
    <base href="<%=basePath%>">
    <link rel="shortcut icon" type="image/x-icon" href="static/img/other/logo.ico"/>
    <link rel="stylesheet" href="static/css/home.css">
    <link href="static/css/calender.css" rel="stylesheet">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_234130_nem7eskcrkpdgqfr.css">
<style>
    #breadcrumb-div{
        background-color: #f8f8f8;
        margin-top:50px;
        margin-left: 10%;
        margin-right: 10%;
        width: 100%;
        padding-left:10%;
        padding-right:10%;
    }
</style>
</head>
<body>
   <jsp:include page="header.jsp"/>
   <div id="contentContainer" class="container-fluid">
       <div class="row">
           <div class="col-md-9 col-xs-9" style="padding-left:3%;padding-right: 0px;width: 75%"><%--style="visibility: hidden"--%>
               <div style="width: 100%" id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="5000">
                   <!-- Indicators -->
                   <ol class="carousel-indicators">
                       <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                       <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                       <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                       <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                   </ol>
                   <!-- Wrapper for slides -->
                   <div class="carousel-inner" role="listbox">
                       <div class="item active" style="background-image: url('${sessionScope.webapp_path}/blog_upload/img/carousel/1.jpg')">
                           <%-- <img src="static/img/1.jpg" alt="...">--%>
                           <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                   Hope
                                </span>
                           </div>
                       </div>
                       <div class="item" style="background-image: url('${sessionScope.webapp_path}/blog_upload/img/carousel/2.jpg')">
                           <%-- <img src="static/img/2.jpg" alt="...">--%>
                           <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                Freedom
                                </span>
                           </div>
                       </div>
                       <div class="item" style="background-image: url('${sessionScope.webapp_path}/blog_upload/img/carousel/3.jpg')">
                           <%--<img src="static/img/3.jpg" alt="...">--%>
                           <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                Emotion
                                </span>
                           </div>
                       </div>
                       <div class="item" style="background-image: url('${sessionScope.webapp_path}/blog_upload/img/carousel/4.jpg')">
                           <%--<img src="static/img/3.jpg" alt="...">--%>
                           <div class="carousel-caption">
                               <span style="font-size: large;font-weight: bold;color: #d9534f">
                                Life
                               </span>
                           </div>
                       </div>
                   </div>
                   <!-- Controls -->
                   <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                       <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                       <span class="sr-only">Previous</span>
                   </a>
                   <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                       <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                       <span class="sr-only">Next</span>
                   </a>
               </div>
               <div id="articleListContainer">
                   <%--文章--%>
                   <ul>
                       <c:forEach items="${articlePageInfo.list}" var="a" varStatus="st">
                           <li>
                               <a class="articleIcon" href="article/${a.aid}">
                                   <img src=""/>
                               </a>
                               <div class="articleInfo">
                                   <a class="articleTitle" href="article/${a.aid}" style="border-left:solid 15px green;padding-left: 10px">
                                           <c:if test="${fn:length(a.title)>=27}">
                                               ${fn:substring(a.title,0,27)}...
                                           </c:if>
                                            <c:if test="${fn:length(a.title)<27}">
                                               ${a.title}
                                           </c:if>
                                   </a>
                                   <div class="articleAbstract">
                                       <span>
                                           "${abstractList.get(st.index)}..."
                                           <%--加引号防止提取的文字含html标签引起布局混乱--%>
                                       </span>
                                   </div>

                               </div>
                               <div class="articleMeta" style="width: 100%;top: 135px">
                                   <div class="row" style="margin-left: 0px;">
                                       <div class="col-md-1 col-xs-1" style="padding: 0 0px">
                                           <p style="width: 100%;margin-bottom: 0px">
                                               <span class="glyphicon glyphicon-eye-open"></span>
                                               <span class="count">${a.viewCount}</span>
                                           </p>
                                       </div>
                                       <div class="col-md-1 col-xs-1" style="padding: 0 0px">
                                           <p style="margin-bottom: 0px">
                                               <span class="glyphicon glyphicon-comment"></span>
                                               <span  class="count">${a.commentCount}</span>
                                           </p>
                                       </div>
                                       <div class="col-md-4 col-xs-4" style="text-align: left">
                                           <p style="width: 100%;margin-bottom: 0px">
                                               <span class="glyphicon glyphicon-time"></span>
                                               <span style="font-size: medium;">
                                                   <fmt:formatDate value="${a.createTime}" pattern="yyyy/MM/dd HH:mm"/>
                                               </span>

                                           </p>
                                       </div>
                                       <div class="col-md-4 col-xs-6" style="text-align: left;margin-left:-5%">
                                           <p style="margin-right: 20%;margin-bottom: 0px">
                                                <span>
                                                    所属分类:
                                                </span>
                                               <span class="label label-warning" style="margin-left: 0px;font-size: smaller">
                                                       ${a.categoryName}
                                               </span>
                                           </p>
                                       </div>
                                   </div>


                               </div>
                           </li>
                       </c:forEach>
                   </ul>
                   <%--页码--%>
                   <nav aria-label="Page navigation">
                       <ul class="pagination" style="margin-left: 300px">

                           <c:if test="${articlePageInfo.hasPreviousPage}">
                               <li>
                                   <a href="${partPath}/${articlePageInfo.prePage}" aria-label="Previous">
                                       <span aria-hidden="true">&laquo;</span>
                                   </a>
                               </li>
                           </c:if>
                           <c:if test="${articlePageInfo.hasPreviousPage==false}">
                               <li  class="disabled">
                                   <a href="#" aria-label="Previous">
                                       <span aria-hidden="true">&laquo;</span>
                                   </a>
                               </li>

                           </c:if>

                           <li>
                               <a href="${partPath}/1">首页</a>
                           </li>

                           <c:forEach items="${articlePageInfo.navigatepageNums}" var="num">
                               <c:if test="${articlePageInfo.pageNum==num}">
                                   <li class="active">
                                       <a href="${partPath}/${num}">${num}</a>
                                   </li>
                               </c:if>
                               <c:if test="${articlePageInfo.pageNum!=num}">
                                   <li>
                                       <a href="${partPath}/${num}">${num}</a>
                                   </li>
                               </c:if>
                           </c:forEach>

                           <li>
                               <a href="${partPath}/${articlePageInfo.pages}">末页</a>
                           </li>
                           <c:if test="${articlePageInfo.hasNextPage}">
                               <li>
                                   <a href="${partPath}/${articlePageInfo.nextPage}" aria-label="Next">
                                       <span aria-hidden="true">&raquo;</span>
                                   </a>
                               </li>

                           </c:if>
                           <c:if test="${articlePageInfo.hasNextPage==false}">
                               <li class="disabled">
                                   <a href="#" aria-label="Next" class="disabled">
                                       <span aria-hidden="true">&raquo;</span>
                                   </a>
                               </li>

                           </c:if>

                       </ul>
                   </nav>

               </div>
           </div>

           <div class="col-md-3 col-xs-3" style="width: 25%;">
               <div id="hotRankingListContainer">
                   <table class="table table-hover">

                       <tr>
                           <th>
                               <span>热门博客</span>
                           </th>
                       </tr>
                       <c:forEach items="${hotList}" var="a" varStatus="st">
                           <tr>
                               <td>
                                   <c:if test="${st.count==1}">
                                       <a href="article/${a.aid}"><span style="font-size: large;color: red;font-weight: bold">${st.count}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                   </c:if>
                                   <c:if test="${st.count==2}">
                                       <a href="article/${a.aid}"><span style="font-size: larger;color: silver;font-weight: bolder">${st.count}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                   </c:if>
                                   <c:if test="${st.count==3}">
                                       <a href="article/${a.aid}"><span style="color: orange;">${st.count}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                   </c:if>
                                   <c:if test="${st.count>3}">
                                       <a href="article/${a.aid}"><span style="font-size: smaller">${st.count}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                   </c:if>
                               </td>
                           </tr>
                       </c:forEach>
                   </table>

               </div>
               <div id='schedule-box' class="boxshaw" style="width:100%"></div>
               <%--random article--%>
               <div class="row" style="padding-left: 4%">
                    <span style="font-size: large;font-weight: bold;font-style: italic">
                        推荐阅读
                    </span>
               </div>
               <c:forEach items="${randomList}" var="r">

                   <div class="random-article-row" style="margin-bottom: 3%;">
                       <div class="row" style="margin-bottom: 3%;">
                           <div class="col-md-4 col-xs-4" style="padding-right: 0px;width: 40%;">
                               <a class="left_random" href="article/${r.aid}"><img src="" style="width: 100%;height:80px;"></a>
                           </div>
                           <div class="col-md-8 col-xs-8" style="padding-bottom: 10%;padding-top: 10%;padding-left: 6%;width: 50%">
                               <a href="article/${r.aid}" style="color: black;font-size:1em">
                                       <span>
                                           <c:if test="${fn:length(r.title)>=20}">
                                               ${fn:substring(r.title,0, 20)}
                                           </c:if>
                                           <c:if test="${fn:length(r.title)<20}">
                                               ${r.title}
                                           </c:if>
                                       </span>
                               </a>
                           </div>
                       </div>
                   </div>

               </c:forEach>



           </div>
       </div>


   </div>
</body>
<script src="static/js/schedule.js"></script>
<script src="static/js/calender-init.js"></script>
<script src="static/js/home.js"></script>
<script>

</script>
</html>
