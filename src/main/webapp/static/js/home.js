$(".articleIcon img").each(function () {
    var index=Math.floor(Math.random()*16)+1;

    $(this).attr("src","static/img/random/p"+index+".jpg")
})
$(".left_random img").each(function () {
    var index=Math.floor(Math.random()*16)+1;

    $(this).attr("src","static/img/random/p"+index+".jpg")
})