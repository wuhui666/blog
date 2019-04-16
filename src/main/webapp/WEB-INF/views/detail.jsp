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
    <title>The Blog Of WuHui-${currentArticle.title}</title>
    <meta name="description" content="这是个描述">
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="static/css/detail.css">
    <link rel="stylesheet" href="static/css/alert.css">

</head>
<body>
    <jsp:include page="alert.jsp"/>
    <jsp:include page="header.jsp"/>
    <div id="contentContainer">
        <div class="row">
            <div class="col-md-10 col-md-offset-1" style="padding-right: 0px"><%--style="visibility: hidden"--%>

                <div class="articleContainer">
                    <h1 class="title" >${currentArticle.title}</h1>
                    <div class="row" style="text-align: center;margin-bottom: 20px">
                        <%--作者，阅读量，评论量--%>
                        <ul id="articleInfoList">
                            <li>浏览&nbsp${currentArticle.viewCount}</li>
                            <li>评论&nbsp${currentArticle.commentCount}</li>
                            <li>
                                发表于&nbsp<fmt:formatDate value="${currentArticle.createTime}" pattern="yyyy年MM月dd日 HH时mm分"/>
                            </li>
                        </ul>


                    </div>
                    <%--文章详情--%>
                    <div class="article-content" style="font-size:larger">
                        ${currentArticle.content}
                    </div>
                    <div class="row">
                        <div class="col-md-2" style="padding-top: 5px">
                            <p>分类：${currentArticle.categoryName}</p>
                        </div>
                        <div class="col-md-3 col-md-offset-7">

                            <ul id="shareList">
                                <li onclick="shareTo('qzone')">
                                    分享：<img class="img-circle" src="static/img/share/qq.ico">
                                </li>
                                <li onclick="shareTo('wechat')">
                                    <a data-toggle="modal" data-target="#wechatModal">
                                        <img class="img-circle" src="static/img/share/wechat.ico">
                                    </a>
                                    <div class="modal fade" id="wechatModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header" style="text-align: center">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="myModalLabel">微信扫一扫</h4>
                                                </div>
                                                <div class="modal-body" style="text-align: center">
                                                    <div id="qrcode">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li onclick="shareTo('sina')">
                                    <img class="img-circle" src="static/img/share/weibo.ico">
                                </li>
                                <li onclick="shareTo('qq')">
                                    <img class="img-circle" src="static/img/share/qq_client.ico">
                                </li>
                            </ul>
                        </div>

                    </div>
                    <div class="row" style="padding-left: 20px">
                        <h4 style="font-weight: bolder;font-style: italic;margin-bottom: 0px">发布评论</h4>

                    </div>
                    <c:if test="${currentUser==null}">
                        <div class="well well-lg" style="padding-left: 300px">
                            <a name="ask-for-login"></a>
                            <img src="static/img/other/unlogin.ico" class="img-circle" style="width: 50px;height: 50px;">
                            <p style="display: inline;font-size: larger">亲，您还未登录哦</p>
                            <a class="keepUrlbBeforeLogin">
                                <button class="btn btn-info">去登录</button>
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${currentUser!=null}">
                        <div class="well" style="padding-bottom:20px;padding-top: 20px;padding-left: 20px;padding-right: 20px">
                            <div>
                                <textarea id="content-area"  class="form-control" rows="6"></textarea>
                                <div id="button-row" class="row" style="text-align: right;display: none">
                                    <button id="cancel" class="btn btn-default" style="margin-top: 5px;margin-right: 20px">取消</button>
                                    <button id="ensure" class="btn btn-success"
                                            style="margin-top: 5px;margin-right: 50px">发表</button>
                                </div>

                            </div>
                        </div>
                    </c:if>
                    <%--pre/next--%>
                    <div>
                        <div class="col-md-6" style="text-align: center;border: dashed 1px gainsboro">
                            <c:if test="${preArticle!=null}">
                                <a href="article/${preArticle.aid}" style="text-decoration: none;color: grey" class="pre-next">
                                    <span class="glyphicon glyphicon-arrow-left"></span>上一篇<br>
                                    <span>${preArticle.title}</span>
                                </a>
                            </c:if>
                            <c:if test="${preArticle==null}">
                                <a style="text-decoration: none;color: grey" class="pre-next">
                                    <span class="glyphicon glyphicon-arrow-left"></span>上一篇<br>
                                    <span>木有上一篇啦</span>
                                </a>
                            </c:if>
                        </div>
                        <div class="col-md-6" style="text-align: center;border: dashed 1px gainsboro">
                            <c:if test="${nextArticle!=null}">
                                <a href="article/${nextArticle.aid}" style="text-decoration: none;color: grey" class="pre-next">
                                    <span class="glyphicon glyphicon-arrow-right"></span>下一篇<br>
                                    <span>${nextArticle.title}</span>
                                </a>
                            </c:if>
                            <c:if test="${nextArticle==null}">
                                <a style="text-decoration: none;color: grey" class="pre-next">
                                    <span class="glyphicon glyphicon-arrow-right"></span>下一篇<br>
                                    <span>木有下一篇啦</span>

                                </a>
                            </c:if>
                        </div>
                    </div>
                    <%--评论区--%>
                    <div id="comment-block">
                        <div class="comment-top-line">
                            <h4 style="font-weight: bolder;font-style: italic">${currentArticle.commentCount}条评论</h4>
                            <hr>
                        </div>
                        <div id="comment-container"  style="margin-right: 30px;margin-left: 30px">
                            <c:forEach items="${commentList}" var="c">
                                <div class="comment-item">
                                    <div id="comment-publisher"
                                         class="row"
                                         style="padding-left: 20px;padding-right: 0px" >
                                        <div class="col-md-1" style="margin-right: -10px">
                                            <c:if test="${c.userPhoto!=null}">
                                                <img src="${c.userPhoto}" class="img-circle" style="width: 40px;height: 40px;">
                                            </c:if>
                                            <c:if test="${c.userPhoto==null}">
                                                <img src="static/img/user/deleted.ico" class="img-circle" style="width: 40px;height: 40px;">
                                            </c:if>
                                        </div>
                                        <div class="col-md-11" style="padding-left: 0px">
                                            <p style="margin-bottom: 0px;font-size: larger">
                                                <c:if test="${c.uid==adminUid}">
                                                    <span class="glyphicon glyphicon-user" style="color: red"></span>
                                                </c:if>
                                                <c:if test="${c.userName==null}">
                                                    用户已注销
                                                </c:if>
                                                <c:if test="${c.userName!=null}">
                                                        ${c.userName}
                                                </c:if>
                                            </p>
                                            <span><fmt:formatDate value="${c.createTime}" pattern="yyyy-MM-dd HH:mm"/> </span>
                                        </div>
                                    </div>
                                    <div id="comment-content" class="row" style="padding-left: 50px;font-size: large;margin-top: 5px">
                                        <span>${c.content}</span>
                                    </div>
                                    <div class="button-row" style="text-align: right">
                                        <c:if test="${currentUser==null||currentUser.uid!=c.uid}">
                                            <button type="button" class="btn btn-default btn-sm" reply="truer" comment-id="${c.coid}">
                                                <span class="glyphicon glyphicon-fire" aria-hidden="true"></span>回复
                                            </button>
                                        </c:if>
                                        <c:if test="${currentUser.uid==c.uid}">
                                            <button type="button" class="btn btn-danger btn-sm" comment-id="${c.coid}" del="true">
                                                <span class="glyphicon glyphicon-fire" aria-hidden="true"></span>删除
                                            </button>
                                        </c:if>

                                    </div>
                                    <hr>
                                    <div class="row" id="reply-list">
                                        <div class="col-md-11 col-md-offset-1">
                                            <ul class="reply-ul">
                                                <c:forEach items="${c.replyList}" var="r">
                                                    <li>
                                                        <div class="row">
                                                                <%--user-info--%>
                                                            <div class="row">
                                                                    <%--reply-user-photo--%>
                                                                <div class="col-md-1" style="margin-right: -10px">
                                                                    <c:if test="${r.userPhoto==null}">
                                                                        <img src="static/img/user/deleted.ico" class="img-circle" style="width: 40px;height: 40px;">
                                                                    </c:if>
                                                                    <c:if test="${r.userPhoto!=null}">
                                                                        <img src="${r.userPhoto}" class="img-circle" style="width: 40px;height: 40px;">
                                                                    </c:if>

                                                                </div>
                                                                    <%--reply-user-info--%>
                                                                <div class="col-md-11" style="padding-left: 0px">
                                                                    <p style="margin-bottom: 0px;font-size: larger">
                                                                        <c:if test="${r.uid==adminUid}">
                                                                            <span class="glyphicon glyphicon-user" style="color: red"></span>
                                                                        </c:if>
                                                                        <c:if test="${r.userName==null}">
                                                                            用户已注销
                                                                        </c:if>
                                                                        <c:if test="${r.userName!=null}">
                                                                            ${r.userName}
                                                                        </c:if>

                                                                    </p>
                                                                    <span><fmt:formatDate value="${r.createTime}" pattern="yyyy-MM-dd HH:mm"/> </span>
                                                                </div>

                                                            </div>
                                                                <%--reply-content--%>
                                                            <div  class="row" style="padding-left: 50px;font-size: large;margin-top: 5px">
                                                                <c:if test="${r.type=='1'}">
                                                                    <span>
                                                                        <c:set var="to_user_name" value="${fn:split(r.content,' ')[0]}"/>
                                                                        <a>${to_user_name}</a>&nbsp;
                                                                        ${fn:substring(r.content,fn:length(to_user_name)+1, fn:length(r.content)-1)}
                                                                    </span>

                                                                </c:if>
                                                                <c:if test="${r.type!='1'}">
                                                                    <span>${r.content}</span>
                                                                </c:if>

                                                            </div>
                                                                <%--reply-button--%>
                                                            <div class="button-row" style="text-align: right;padding-right: 30px">
                                                                <c:if test="${currentUser==null||currentUser.uid!=r.uid}">
                                                                    <button type="button" class="btn btn-default btn-sm" uid="${r.uid}" username="${r.userName}" >
                                                                        <span class="glyphicon glyphicon-fire" aria-hidden="true"></span>回复
                                                                    </button>
                                                                </c:if>
                                                                <c:if test="${currentUser.uid==r.uid}">
                                                                    <button type="button" class="btn btn-danger btn-sm" rid="${r.rid}">
                                                                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                                                                    </button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                                <li class="reply-area-li" style="display: none">
                                                    <div class="well" style="padding-bottom:0px;margin-bottom: 0px">
                                                        <div>
                                                            <textarea id="content-area-reply"  class="form-control" rows="3"></textarea>
                                                            <div class="reply-button-row" style="text-align: right;">
                                                                <button id="cancel-reply" class="btn btn-default" style="margin-top: 5px;margin-right: 20px">取消</button>
                                                                <button id="ensure-reply" class="btn btn-success mmp"
                                                                        style="margin-top: 5px;margin-right: 50px">发表</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                </div>
                                <hr>
                            </c:forEach>
                        </div>
                    </div>
                    <h3></h3>
                    <hr>
                    <div>

                    </div>


                </div>
                <div></div>
            </div>

        </div>

    </div>
</body>
<script src="https://cdn.bootcss.com/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>
<script src="static/js/detail.js"></script>
<%--发表--%>
<script>
    $(".reply-button-row button:last-child").click(function () {

        var contentStr=$(this).parents(".reply-area-li").find("textarea").val().trim();

        if (reply_comment_check(contentStr)){

            var dataObj={
                "content":contentStr,
                "uid":"${currentUser.uid}",
                "toUid":$(this).attr("toUid"),
                "pcoid":$(this).attr("pcoid"),
                "to_user_name":"@"+$(this).attr("to_user_name")

            };

            $.ajax({
                type:"post",
                contentType:"application/json;charset=utf8",
                dataType:"json",
                url:"reply/add",
                data:JSON.stringify(dataObj),
                success:function (result) {
                    reply_comment_success();
                    console.log(result.message)
                }
            })
        }

    })
</script>
<%--/*reply_comment_check() validate*/--%>
<script>
    function reply_comment_check(contentStr){
        if (${currentUser==null}) {
            $("#alert-span").text("登录就能评论啦。。。");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(1000);
            return false;
        }

        if (contentStr=="") {
            $("#alert-span").text("小老弟。。你好像啥也没输入");
            $("#alert-div").fadeIn(500);
            $("#alert-div").fadeOut(1000);
            /*console.log("99999");*/
            return false;
        }
        return true;
    }
</script>
<%--/* textarea of  article for comment*/--%>
<script>

    $("#ensure").click(function () {
        var contentStr=$("#content-area").val();
        if (reply_comment_check(contentStr)) {
            $.ajax({
                type:"post",
                dataType:"json",
                url:"comment/add",
                data:{
                    uid:"${currentUser.uid}",
                    aid:"${currentArticle.aid}",
                    content:contentStr
                },
                success:function (result) {
                    reply_comment_success();
                    console.log(result.msg);

                }

            })
        }

    })
</script>
<%--back to page before login--%>
<script>
    $(".keepUrlbBeforeLogin").click(function () {
        $.ajax({
            type:"get",
            url:"keep_url",
            /*contentType:"application/json;charset=utf-8",*/
            dataType:"json",
            data:"to_url="+window.location.href,
            success:function (r) {
                console.log("ak");
                console.log(r);

                 window.location.href="login"
            }
        })
    })
</script>
<%--/*share*/--%>
<script>

    function shareTo(stype){
        var ftit = '';
        var flink = '';
        var lk = '';
        //获取文章标题
        ftit = "${currentArticle.title}";
        flink = "http://192.168.1.100:8080/blog/static/img/test1.jpg";
        if(typeof flink == 'undefined'){
            flink='';
        }
        if(stype=='qzone'){
            window.open('https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url='+document.location.href+'?sharesource=qzone&title='+ftit+'&pics='+flink+'&summary='+document.querySelector('meta[name="description"]').getAttribute('content'));
        }

        if(stype=='sina'){
            window.open('http://service.weibo.com/share/share.php?url='+document.location.href+'?sharesource=weibo&title='+ftit+'&pic='+flink+'&appkey=2706825840');
        }

        if(stype == 'qq'){
            window.open('http://connect.qq.com/widget/shareqq/index.html?url='+document.location.href+'?sharesource=qzone&title='+ftit+'&pics='+flink+'&summary='+document.querySelector('meta[name="description"]').getAttribute('content'));
        }

        if(stype == 'wechat'){
            jQuery(function(){
                $("#qrcode").empty();
                jQuery('#qrcode').qrcode(document.location.href);
            });
        }
    }
</script>
</html>
