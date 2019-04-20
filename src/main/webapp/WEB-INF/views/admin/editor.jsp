<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=basePath%>">

    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">
    <link href="https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_editor.pkgd.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/css/froala_style.min.css" rel="stylesheet" type="text/css" />
    <style>

        h2{
            margin-top: 80px;
            margin-left: 20px;
        }
        form{
            margin-top: 80px;
        }
        form label{
            font-size: large;
            font-weight: bold;
        }
        .form-group input{
            height: 30px;
        }
        .form-group select{
            height: 30px;
        }

    </style>
</head>
<body>
<jsp:include page="../alert.jsp"/>
<div class="row" id="loadBlock">

    <div class="col-md-12 col-xs-12" style="padding: 0 0px">
        <div class="col-md-9 col-xs-9" style="padding-right: 0px;padding-left: 0px">
        <div id="editor">
            <c:if test="${editArticle!=null}">
                ${editArticle.content}
            </c:if>

        </div>
            <%-- <button id="bt">edwsfsf</button>--%>
        </div>
        <div class="col-md-3 col-xs-3">
            <h2>博客保存</h2>

            <form>
                <div class="form-group">
                    <label id="title-label">标题</label>
                    <c:if test="${editArticle!=null}">
                        <input  id="title" name="title" type="text" value="${editArticle.title}"/>
                    </c:if>
                    <c:if test="${editArticle==null}">
                        <input  id="title" name="title" type="text" placeholder="输入标题..."/>
                    </c:if>

                </div>
                <div class="form-group" style="margin-top: 50px">
                    <label id="category-label" for="categorySelect">分类</label>
                    <select id="categorySelect" name="cid">
                        <c:forEach items="${categoryList}" var="c" varStatus="st">

                            <c:if test="${editArticle==null}">
                                <c:if test="${st.first}">
                                    <option value="${c.cid}" selected="selected">
                                            ${c.cname}
                                    </option>
                                </c:if>
                                <c:if test="${!st.first}">
                                    <option value="${c.cid}">
                                            ${c.cname}
                                    </option>
                                </c:if>

                            </c:if>
                            <c:if test="${editArticle!=null}">

                                <c:if test="${editArticle.cid==c.cid}">
                                    <option value="${c.cid}" selected="selected">
                                            ${c.cname}
                                    </option>
                                </c:if>
                                <c:if test="${editArticle.cid!=c.cid}">
                                    <option value="${c.cid}">
                                            ${c.cname}
                                    </option>
                                </c:if>

                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group" style="padding-left: 40px">
                    <button id="addbutton" type="button" class="btn btn-success">提交</button>
                </div>

            </form>

        </div>

    </div>

</div>

</body>
<script src="static/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<%------froala------%>
<%--core--%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/mode/xml/xml.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/froala-editor@2.9.3/js/froala_editor.pkgd.min.js"></script>
<%--img/viedo/file--%>
<script src="https://cdn.bootcss.com/froala-editor/2.9.3/js/plugins/file.min.js"></script>
<script src="https://cdn.bootcss.com/froala-editor/2.9.3/js/plugins/image.min.js"></script>
<script src="https://cdn.bootcss.com/froala-editor/2.9.3/js/plugins/video.min.js"></script>
<%--chinese--%>
<script src="https://cdn.bootcss.com/froala-editor/2.9.3/js/languages/zh_cn.js"></script>
<%--实例化editor--%>
<script>
    $(function() {
        $('#editor')
            .froalaEditor({
                height:400,
                language: 'zh_cn',
                // Set the file upload parameter.
                fileUploadParam: 'file_name',

                // Set the file upload URL.
                fileUploadURL: 'admin/uploadFile',

                // Additional upload params.
                /*fileUploadParams: {id: 'my_editor'},*/

                // Set request type.
                fileUploadMethod: 'POST',

                // Set max file size to 20MB.
                fileMaxSize: 20 * 1024 * 1024,

                // Allow to upload any file.
                fileAllowedTypes: ['*'],
                /*image*/
                // Set the image upload parameter.
                imageUploadParam: 'image_name',

                // Set the image upload URL.
                imageUploadURL: 'admin/uploadImg',

                // Additional upload params.
                /*imageUploadParams: {id: 'my_editor'},*/

                // Set request type.
                imageUploadMethod: 'POST',

                // Set max image size to 5MB.
                imageMaxSize: 5 * 1024 * 1024,

                // Allow to upload PNG and JPG.
                imageAllowedTypes: ['jpeg', 'jpg', 'png'],
                /*---------video------------*/
                // Set the video upload parameter.
                videoUploadParam: 'video_name',

                // Set the video upload URL.
                videoUploadURL: 'admin/uploadVideo',

                // Additional upload params.
                /*videoUploadParams: {id: 'my_editor'},*/

                // Set request type.
                videoUploadMethod: 'POST',

                // Set max video size to 50MB.
                videoMaxSize: 50 * 1024 * 1024,

                // Allow to upload MP4, WEBM and OGG
                videoAllowedTypes: ['webm', 'mp4', 'ogg']
            })
            .on('froalaEditor.image.beforeUpload', function (e, editor, images) {
                // Return false if you want to stop the image upload.
                /* console.log("before load")*/
            })
            .on('froalaEditor.image.error', function (e, editor, error, response) {
                // Bad link.
                if (error.code == 1) { console.log("Bad link.") }

                // No link in upload response.
                else if (error.code == 2) { console.log("No link in upload response.") }

                // Error during image upload.
                else if (error.code == 3) { console.log("Error during image upload.") }

                // Parsing response failed.
                else if (error.code == 4) { console.log("Parsing response failed.") }

                // Image too text-large.
                else if (error.code == 5) { console.log("Image too text-large.") }

                // Invalid image type.
                else if (error.code == 6) { console.log("Invalid image type.") }

                // Image can be uploaded only to same domain in IE 8 and IE 9.
                else if (error.code == 7) { console.log("Image can be uploaded only to same domain in IE 8 and IE 9.") }

                // Response contains the original server response to the request if available.
            })
            .on('froalaEditor.video.beforeUpload', function (e, editor, videos) {
                // Return false if you want to stop the video upload.
                /*console.log("before video upload")*/
            })
            .on('froalaEditor.video.error', function (e, editor, error, response) {
                // Bad link.
                if (error.code == 1) { console.log("Bad link.") }

                // No link in upload response.
                else if (error.code == 2) {console.log("No link in upload response.") }

                // Error during video upload.
                else if (error.code == 3) { console.log("Error during video upload.") }

                // Parsing response failed.
                else if (error.code == 4) { console.log("Parsing response failed.") }

                // Video too text-large.
                else if (error.code == 5) {console.log("Video too text-large.")}

                // Invalid video type.
                else if (error.code == 6) {console.log("Invalid video type.")}

                // Video can be uploaded only to same domain in IE 8 and IE 9.
                else if (error.code == 7) {console.log("Video can be uploaded only to same domain in IE 8 and IE 9.")}

                // Response contains the original server response to the request if available.


            })
            .on('froalaEditor.file.beforeUpload', function (e, editor, files) {
                // Return false if you want to stop the file upload.
                console.log("before file upload")
            })
            .on('froalaEditor.file.error', function (e, editor, error, response) {
                // Bad link.
                if (error.code == 1) { console.log("Bad link.") }

                // No link in upload response.
                else if (error.code == 2) { console.log("No link in upload response..") }

                // Error during file upload.
                else if (error.code == 3) { console.log("Error during file upload.") }

                // Parsing response failed.
                else if (error.code == 4) { console.log("Parsing response failed.") }

                // File too text-large.
                else if (error.code == 5) { console.log("File too text-large.") }

                // Invalid file type.
                else if (error.code == 6) { console.log("Invalid file type.") }

                // File can be uploaded only to same domain in IE 8 and IE 9.
                else if (error.code == 7) {console.log("File can be uploaded only to same domain in IE 8 and IE 9.") }

                // Response contains the original server response to the request if available.
            })


    });
</script>
<%--提交--%>
<script>
    function checkInput(){
        if($("#title").val()==""){
            return false;
        }
        return $('#editor').froalaEditor('html.get', true) != null;

    }
    $("#addbutton").click(function () {

        if (checkInput()) {
            var content=$('#editor').froalaEditor('html.get', true);

            //截掉“power by ....”
            var index=content.indexOf("<p data-f-id");
            content=content.substring(0,index);
            var jsonObj={
                "aid":"${editArticle.aid}",/*如果null编辑提交，不为null新增提交*/
                "title":$("#title").val(),
                "cid":$("#categorySelect").val(),
                "uid":"${currentUser.uid}",
                "content":content,
            };
            $.ajax({
                type:"post",
                dataType:"json",
                contentType:"application/json;charset=utf-8",//utf-8别省，乱码
                url:"admin/addBlog",
                data:JSON.stringify(jsonObj),
                success:function (result) {
                    if (result.success) {
                        $("#alert-span").text(result.message);
                        $("#alert-div").fadeIn(200);
                        $("#alert-div").fadeOut(1200);
                    }
                }
            })
        }
    })
</script>
</html>
