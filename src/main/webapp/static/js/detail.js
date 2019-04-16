/*pre or next article*/
$(".pre-next").hover(function () {

    $(this).parent().css("background-color","lightblue")
},function () {

    $(this).parent().css("background-color","")
})
/* comment delete click*/
$(".button-row button[del]").click(function () {
    var coid=$(this).attr("comment-id");
    var choice=confirm("确定要删除该评论么？");
    if (choice){
        $.ajax({
            type:"post",
            dataType:"json",
            url:"comment/delete/"+$(this).attr("comment-id"),
            success:function () {
                $("#alert-span").text("删除成功");
                $("#alert-div").fadeIn(500);
                $("#alert-div").fadeOut(1500,function () {
                    window.location.reload(false);
                });
            }
        })
    }
})
/* reply delete  click*/
$(".button-row button[rid]").click(function () {
    var rid=$(this).attr("rid");
    var choice=confirm("确定要删除该回复么？");
    if (choice){
        $.ajax({
            type:"post",
            dataType:"json",
            url:"reply/delete/"+$(this).attr("rid"),
            success:function () {
                $("#alert-span").text("删除成功");
                $("#alert-div").fadeIn(500);
                $("#alert-div").fadeOut(1000,function () {
                    window.location.reload(false);
                });
            }
        })
    }
})
/*comment-button-click*/
$(".button-row button[reply]").click(function () {
    $(this).parents(".comment-item").find("textarea").val("");//clean it firstly
    //deliver the coid to button
    $(this).parents(".comment-item").find("textarea").next().children("button").last().attr("pcoid",$(this).attr("comment-id"));

    $(this).parents(".comment-item").find(".reply-area-li").css("display","block")
});
/*reply-button-click*/
$(".button-row button[uid]").click(function () {
    $(this).parents(".comment-item").find("textarea").val("");//clean it firstly
    //deliver the coid to button
    $(this).parents(".comment-item").find("textarea").next().children("button").last().attr("pcoid",$(this).parents(".comment-item").find("button[comment-id]").attr("comment-id"));

    if ( $(this).attr("uid")!=undefined){
        var name=$(this).attr("username");
        //reply to specific user
        $(this).parents(".reply-ul").children(".reply-area-li").find("textarea").val("@"+name+" ");
        //deliver the uname to button as toName
        $(this).parents(".reply-ul").children(".reply-area-li").find("textarea").next().children("button").last().attr("to_user_name",name);

        //deliver the uid to button as toUid
        $(this).parents(".reply-ul").children(".reply-area-li").find("textarea").next().children("button").last().attr("toUid",$(this).attr("uid"));

    }
    $(this).parents(".comment-item").find(".reply-area-li").css("display","block")
});
/*cancel and ensure button click*/
$(".reply-button-row button:first-child").click(function () {

    $(this).parents(".reply-area-li").find("textarea").val("");
    $(this).next().attr("toUid","");//clear uid on button
    $(this).next().attr("pcoid","");//clear the coid on button
    $(this).parents(".reply-area-li").css("display","none")
});

/*reply success*/
function reply_comment_success(){
    $("#alert-span").text("发表成功！");
    $("#alert-div").fadeIn(500);
    $("#alert-div").fadeOut(1000,function () {
        window.location.reload(false);
    });
}
/* textarea of  article for comment*/
$("#cancel").click(function () {
    $("#content-area").val("");
    $("#button-row").css("display","none")
})
$("#content-area").click(function () {
    $("#button-row").css("display","block")
})
