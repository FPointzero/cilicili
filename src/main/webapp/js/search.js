

// 界面滚动事件
let videoList = {};
window.onscroll = function () {
    let t = document.documentElement.scrollTop || document.body.scrollTop;
    changeNav(t);
}

window.onload = function () {
    const params = new URLSearchParams(location.search);
    const keyword = params.get('keyword');
    input.value = keyword;
    search(keyword);
}

// 改变nav样式
function changeNav(t) {
    if (t > 10) {
        $('.nav-left>a').css('color', 'black');
        $('.nav-right>a').css('color', 'black');
        $('.nav').css('background', 'white');
        //设置工具栏可见
        $('.tools').css('display', 'inline');
    } else {
        $('.nav-left>a').css('color', 'white');
        $('.nav-right>a').css('color', 'white');
        $('.nav').css('border-bottom', 'none');
        $('.nav').css('background', 'none');
        $('.nav').css('box-shadow', '');
        //设置工具栏隐藏
        $('.tools').css('display', 'none');
    }
}

//刷新事件
$('.reload').click(function () {
    location.reload();
})

// 回到顶端事件
function back() {
    // 平滑滚动
    window.scrollTo({top: 0, behavior: "smooth"});
}


// 监听输入框的keydown事件
input.addEventListener('keydown', function(e) {

    // 检测是否按下了Enter键
    if(e.key === 'Enter') {
        // 防止默认行为
        e.preventDefault();
        // 模拟点击搜索按钮
        searchIcon.click();
    }
});

// 为搜索图标添加点击事件监听
searchIcon.addEventListener('click', function() {
    // 判断输入框是否有内容
    if(input.value.trim()) {
        // //清空搜索
        // const div = document.querySelector('.video-card-box');
        // div.innerHTML = '';
        // // 输入框有内容,执行搜索逻辑
        // search(input.value.trim());
        // 跳转到search页面,同时传递搜索关键词
        window.location.href = `Search.html?keyword=${input.value.trim()}`;
    } else {
        // 输入框无内容,提示用户输入
        alert('请输入搜索内容');
    }
});

function search(keyword) {
    let data = {"keyword":keyword};
    $.ajax({
        url: "/cilicili_war/api/search",
        method: "POST",
        data: JSON.stringify(data),
        dataType: "json",
        contentType: "application/json",
        success: function (res) {
            console.log(res)
            videoList = res["data"];
            for (let i = 0; i < videoList.length; i++) {
                createVideoCard(videoList[i]["coverPath"], videoList[i]["id"], videoList[i]["title"], videoList[i]["username"], videoList[i]["createTime"])
            }
            initClick();
        },
    });
}


function createVideoCard(imagePath, id, title, subtitle, time) {
    // 创建 video-card 容器
    let card = document.createElement('div');
    card.className = 'video-card';
    card.id = id;

    // 创建图片元素
    let img = document.createElement('img');
    img.src = imagePath;
    img.alt = title; // 可以根据实际需要设置一个更合适的alt文本

    // 创建 video-card-info 容器
    let cardInfo = document.createElement('div');
    cardInfo.className = 'video-card-info';

    // 创建标题的<p>元素
    let titleElement = document.createElement('p');
    titleElement.textContent = title;

    // 创建副标题的<p>元素
    let subtitleElement = document.createElement('p');
    subtitle = subtitle + " · " + timeSince(time);
    subtitleElement.textContent = subtitle;

    // 将元素添加到对应的容器中
    cardInfo.appendChild(titleElement);
    cardInfo.appendChild(subtitleElement);

    card.appendChild(img);
    card.appendChild(cardInfo);

    $('.video-card-box').append(card);

}

function timeSince(dateString) {
    const now = new Date();
    const pastDate = new Date(dateString);
    const timeDiff = now - pastDate; // 差异（毫秒）

    // 检查时间差异是否小于1小时
    if (timeDiff < 1000 * 60 * 60) {
        return '刚刚';
    }
    // 检查时间差异是否小于24小时
    else if (timeDiff < 1000 * 60 * 60 * 24) {
        const hours = Math.floor(timeDiff / (1000 * 60 * 60));
        return `${hours}小时前`;
    }
    // 如果时间差异大于或等于24小时，返回月日
    else {
        return pastDate.toLocaleDateString(undefined, {year: 'numeric', month: 'numeric', day: 'numeric'});
    }
}

function initClick() {
    const videoCards = document.querySelectorAll('.video-card');
    console.log(videoCards.length)
    videoCards.forEach(card => {
        card.addEventListener('click', function() {
            // 获取 data-video-id 属性值
            const videoId = card.getAttribute('id');
            console.log(videoId)
            window.location.href = `video.html?vid=${videoId}`;
        });
    });
}