
// js中计时器重要使用window.setInterval()方法和window.setTimeout()方法，
// 其中setInterval()方法的作用是每隔一段时间执行一次方法，而window.setTimeout()在一段时间内调用函数。
// setTimeout()方法一般通过调用自身迭代的方式实现计时器。与这两个方法对应的，还有清除这两个函数效果的
// 两个方法，分别是window.clearInterval()和window.clearTimeout()。


// 第一种：
// <p id="timer">点击开始计时！</p>
//<button id="cutTimer1" onclick="start()">开始</button>
//<button id="cutTimer2" onclick="stop()">停止</button>

var timer1 = null;
function start(){
    var countTime = function(){
        date = new Date(); //获取当前系统时间
        dateStr = date.toLocaleTimeString(); //根据本地时间把 Date 对象的时间部分转换为字符串：
        document.getElementById("timer").innerHTML = dateStr;
    }
    timer1 = window.setInterval(countTime,1000);
}
function stop(){
    console.log("timer stop:"+timer1);
    window.clearInterval(timer1);
}

//-------------------------------------------------------------------------------------------

// 第二种：
//<p id="timer"></p>
//<button id="cutTimer3" onclick="timeOutAlert();">执行</button>
//<button id="cutTimer4" onclick="stopTimeOutAlert();">停止</button>

timeOut = null;
function timeOutAlert(){
    timeOut = window.setTimeout(function(){
        console.log("time out..."+timeOut);
        timeOutAlert();
    },1000);
}
function stopTimeOutAlert(){
    console.log("timeCut:"+timeOut);
    window.clearTimeout(timeOut);
}