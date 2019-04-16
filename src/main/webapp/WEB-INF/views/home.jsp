<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>The Blog Of WuHui</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="static/css/home.css">
    <link href="static/css/calender.css" rel="stylesheet">
    <link rel="stylesheet" href="https://at.alicdn.com/t/font_234130_nem7eskcrkpdgqfr.css">

</head>
<body>
   <jsp:include page="header.jsp"/>
    <div id="contentContainer">
        <div class="row">
            <div class="col-md-9" style="padding-left: 40px;padding-right: 0px"><%--style="visibility: hidden"--%>
                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="3000">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                    </ol>
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <div class="item active" style="background-image: url('${pageContext.request.contextPath}/static/img/carousel/1.jpg')">
                            <%-- <img src="static/img/1.jpg" alt="...">--%>
                            <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                   希望
                                </span>
                            </div>
                        </div>
                        <div class="item" style="background-image: url('${pageContext.request.contextPath}/static/img/carousel/go.jpg')">
                            <%-- <img src="static/img/2.jpg" alt="...">--%>
                            <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                自由
                                </span>
                            </div>
                        </div>
                        <div class="item" style="background-image: url('${pageContext.request.contextPath}/static/img/carousel/stay.jpg')">
                            <%--<img src="static/img/3.jpg" alt="...">--%>
                            <div class="carousel-caption">
                                <span style="font-size: large;font-weight: bold;color: #d9534f">
                                情感
                                </span>
                            </div>
                        </div>
                        <div class="item" style="background-image: url('${pageContext.request.contextPath}/static/img/carousel/over.jpg')">
                            <%--<img src="static/img/3.jpg" alt="...">--%>
                            <div class="carousel-caption">
                               <span style="font-size: large;font-weight: bold;color: #d9534f">
                                人生
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
                        <c:forEach items="${articlePageInfo.list}" var="a">
                            <li>
                                <a class="articleIcon" href="article/${a.aid}">
                                    <img src="static/img/random/p.jpg">
                                </a>
                                <div class="articleInfo">
                                    <a class="articleTitle" href="article/${a.aid}" style="border-left:solid 15px green;padding-left: 10px">
                                            ${a.title}
                                    </a>
                                    <a class="articleAbstract" href="article/${a.aid}">
                                        <p>
                                            <%--会自带power by froala，delete "power by froala" and 空格--%>
                                            <c:set var="real_content" value="${fn:trim(fn:substringBefore(a.content,'<p data-f-id' ))}"/>
                                            <c:if test="${fn:contains(real_content,'<img' )}">
                                                <c:set var="content" value="${fn:substringBefore(real_content, '<img')}"/>

                                                <%--第一张图片之前文字--%>
                                                <c:if test="${fn:length(content)>70}">
                                                    ${fn:substring(content,0,70)}...

                                                </c:if>
                                                <c:if test="${fn:length(content)<=70}">
                                                    ${content}...
                                                </c:if>
                                            </c:if>
                                            <c:if test="${fn:contains(real_content,'<img' )==false}">

                                                <c:if test="${fn:length(real_content)>70}">
                                                    ${fn:substring(real_content,0,70)}...
                                                </c:if>
                                                <c:if test="${fn:length(real_content)<=70}">
                                                    ${real_content}...
                                                </c:if>
                                            </c:if>

                                        </p>
                                    </a>

                                </div>
                                <div class="articleMeta">
                                    <p>
                                        <span class="glyphicon glyphicon-eye-open"></span>
                                        <span style="margin-left: auto" class="count">${a.viewCount}</span>
                                    </p>
                                    <p>
                                        <span class="glyphicon glyphicon-comment"></span>
                                        <span style="margin-left: auto" class="count">${a.commentCount}</span>
                                    </p>
                                    <p>
                                        <span class="glyphicon glyphicon-time"></span>
                                        <span style="margin-left: auto">
                                                         <fmt:formatDate value="${a.createTime}" pattern="yyyy年MM月dd日 HH时mm分"/>
                                                 </span>

                                    </p>
                                    <p style="margin-left: 80px">
                                                <span style="margin-left: 0px;">
                                                    所属分类:
                                                    <span class="label label-warning" style="margin-left: 0px;font-size: larger">
                                                            ${a.categoryName}
                                                    </span>

                                                </span>
                                    </p>

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
            <div class="col-md-3">
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
                                    <c:if test="${st.index==1}">
                                        <a href="article/${a.aid}"><span style="font-size: large;color: red;font-weight: bold">${st.index}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                    </c:if>
                                    <c:if test="${st.index==2}">
                                        <a href="article/${a.aid}"><span style="font-size: larger;color: silver;font-weight: bolder">${st.index}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                    </c:if>
                                    <c:if test="${st.index==3}">
                                        <a href="article/${a.aid}"><span style="color: orange;">${st.index}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                    </c:if>
                                    <c:if test="${st.index>3}">
                                        <a href="article/${a.aid}"><span style="font-size: smaller">${st.index}</span><span>&nbsp;&nbsp;${a.title}</span></a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                </div>
                <div id='schedule-box' class="boxshaw"></div>
                <%--random article--%>
                <div class="row" style="padding-left: 12px">
                    <span style="font-size: large;font-weight: bold;font-style: italic">
                        推荐阅读
                    </span>
                </div>
                <c:forEach items="${randomList}" var="r">

                    <div class="random-article-row" style="margin-bottom: 10px;">
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-md-4" style="padding-right: 0px">
                                <a class="left_random" href="article/${r.aid}"><img src="static/img/1.jpg" style="width: 100%;height: 80px"></a>
                            </div>
                            <div class="col-md-8" style="padding-top: 25px;padding-left: 15px">
                                <a href="article/${r.aid}" style="color: black;font-size: larger">
                                       <span>
                                               ${r.title}
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
</html>
