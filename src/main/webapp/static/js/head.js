
$(".menuLi").hover(function () {
    $(this).css("background-color","lightblue");
    $(this).children("ul").css("display","block")
},function () {
    $(this).css("background-color","");
    $(this).children("ul").css("display","none")

})
$(".menuLi ul li").hover(function () {
    $(this).css("background-color","lightblue");
    $(this).children("ul").css("display","block")
},function () {
    $(this).css("background-color","");
    $(this).children("ul").css("display","none")

})
$(".random-article-row .row").hover(function () {
    $(this).css("background-color","lightgrey")
},function () {
    $(this).css("background-color","")
})
