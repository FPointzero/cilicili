// 页面加载时执行的方法
window.onload = function() {
    var a1 = $('.hidden-nav .hiddenNav-left>a:nth-of-type(1)');
    var a2 = $('.content-nav .hiddenNav-left>a:nth-of-type(1)');
    a1.css('color', '#00A1D6');
    a2.css('color', '#00A1D6');
    $('.hidden-nav .hiddenNav-left>div').css('width', a1.width());
    $('.content-nav .hiddenNav-left>div').css('width', a2.width());
    hiddenNavItems();
}
// 隐藏nav的滑动监听事件
window.onscroll = function () {
    var t = document.documentElement.scrollTop || document.body.scrollTop;
    if (t > 323){
        $('.hidden-nav').css('transform', 'translateY(70px)');
    }else {
        $('.hidden-nav').css('transform', 'translateY(-70px)');
    }
}
// 导航栏选项样式切换
function hiddenNavItems() {
    var a = $('.hiddenNav-left>a');
    // 获取触发标签 a标签 设置a标签鼠标悬浮事件 e是鼠标对象 e.target是鼠标所指向的目标对象
    // fnOver是鼠标进入事件
    // 获取滑动条对象
    var d = $('.border-bottom');
    var d1 = $('.hidden-nav .border-bottom');
    var d2 = $('.content-nav .border-bottom');
    a.hover(function (e) {
        var target = e.target;
        // 判断鼠标所指向对象是否为a标签
        if ($(target).is('.hiddenNav-left>a')) {
            // 设置滑动条里左边的位置 距离为鼠标所指向对象的left坐标
            d.css('left',$(target).position().left);
            d.css('width',$(target).width());
            a.css('color','#18191C');
            $(target).css('color','#00A1D6');
        }else {
            // 如果是指向a标签子元素 则切换为父元素
            d.css('left',$(target).parent().position().left);
            d.css('width',$(target).parent().width());
            a.css('color','#18191C');
            $(target).parent().css('color','#00A1D6');
        }
    },function (e){  // 鼠标移出方法
        var a1 = $('.hidden-nav .hiddenNav-left>a:nth-of-type(1)');
        var a2 = $('.content-nav .hiddenNav-left>a:nth-of-type(1)');
        d1.css('left',a1.position().left);
        d2.css('left',a2.position().left);
        d1.css('width',a1.width());
        d2.css('width',a2.width());
        $('.hiddenNav-left>a').css('color','#18191C');
        a1.css('color','#00A1D6');
        a2.css('color','#00A1D6');
    })
}

const params = new URLSearchParams(location.search);
const vid = params.get('vid');
const title = params.get('title');
const subtitle = params.get('subtitle');

// 初始化
if (title != null)
    $(".title-input").val(title);
if (subtitle != null)
    $(".introduction-input").val(subtitle);

$('.btn-upload-cover').click(function(){
    $("#cover").trigger("click");
});

$("#cover").on("change", function () {
    let file = this.files[0];
    console.log(file);
    // ajax
    var form = new FormData();
    form.append("file", file);

    var settings = {
        url: "/cilicili_war/api/creation/uploadCover?vid="+vid,
        method: "POST",
        processData: false,
        contentType: false,
        dataType: "json",
        "data": form
    };

    $.ajax(settings).done(function (response) {
        console.log(response);
        if (response.code == 200) {
            alert("上传成功");
        } else{
            alert("文件上传失败");
        }
    });
});

$('.btn-cancel').click(function(){
    window.location.href = `creationList.html`;
});

$('.btn-upload').click(function () {

    var title = $(".title-input").val();
    var introduction = $(".introduction-input").val();

    let data = {"action": "set","vid":vid,"title":title,"subtitle":introduction}
    $.ajax({
        url: "/cilicili_war/api/creation/creationInfo",
        method: "POST",
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        success: function (res) {
            console.log(res)
            if (res.code == 200) {
                alert("修改成功");
                window.location.href = `creationList.html`;
            } else{
                alert("修改失败");
            }
        },
    });
})

