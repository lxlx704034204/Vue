<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../js/layui/css/layui.css" media="all">
    <style>
        .layui-row{
            width: 99%;
        }

        .layui-col-xs12 {
            height: 415px;
            overflow:auto;
        }

        .layui-tab-title{
            font-size: 12px;
        }

        .HeadingTitle {
            position: relative;
            font-weight: bolder;
            color: #428bca;
            display: inline-block;
            font-size: 15px;
            line-height: 25px;
            padding: 0 0 0 50px;
            margin-left: 15px;
        }
        .icons {
            background-image: url(/style/v7/images/v7_icons.png);
            background-repeat: no-repeat;
        }

        .HeadingTitle>.b-list {
            background-position: -40px -2px;
        }

        .layui-input{
            height: 32px;
        }

        .layui-tab-title li{
            font-size: 13px;
        }
    </style>
</head>
<body>

    <div class="layui-tab layui-tab-brief" lay-filter="OneTab">
        <div class="HeadingTitle">
            <b class="icons b-list">利润汇总-按客户</b>
        </div>

        <ul class="layui-tab-title">
            <li class="layui-this" lay-id="profitInfo">数据</li>
            <li lay-id="profitView">图表</li>
        </ul>

        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <div class="layui-row">
                    <div class="layui-col-xs12">
                        <div class="demoTable">
                            <!--客户编号：
                            <div class="layui-inline">
                                <input class="layui-input" name="id" id="demoReload" autocomplete="off">
                            </div>-->
                            销售时间：
                            <div class="layui-inline">
                                <input type="text" class="layui-input" id="startDate">
                            </div>
                            -
                            <div class="layui-inline">
                                <input type="text" class="layui-input" id="endDate">
                            </div>
                            <button class="layui-btn" data-type="reload" id="selectbtn">搜索</button>
                            <button class="layui-btn" id="empty">清空</button>
                        </div>

                        <table class="layui-hide" lay-size="sm" id="test" lay-filter="demo"></table>
                        <script type="text/html" id="barDemo">
                            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="tiaozhuan">按月分析</a>
                        </script>
                    </div>
                </div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-col-xs12">
                    <div class="layui-row">
                        <div id="main" style="width: 1000px;height:500px;margin-top: 7px;"></div>
                    </div>
                    <div class="layui-row" style="height: 3px;width: 100%;background-color:#d2d2d2;margin-bottom: 20px; "></div>
                    <div class="layui-row">
                        <div class="layui-col-xs6">
                            <div id="main2" style="width: 500px;height:300px;"></div>
                        </div>
                        <div class="layui-col-xs6">
                            <div id="main3" style="width: 500px;height:300px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="../js/echarts.min.js"></script>
    <script type="text/javascript" src="../js/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="../js/jquery3.2.js"></script>

    <!--跳转新页签-->
    <script>
        function mdiwin(url,title){
            // console.log(top.showreModule)
            //如果发现没有多窗口方法就调用window.open
            if(typeof(top.showreModule)=="undefined"){
                window.open(url);
            }else{
                top.showreModule(title,url);
            }
        }
    </script>

    <!--Layui表格-->
    <script>
        //排序参数，各图共用
        var sortFiled = "";
        var sortWay = "";

        //获取时间
        var nowDate = new Date();
        var lastNowDate = nowDate.getFullYear() + '-';
        if(nowDate.getMonth()<10){
            lastNowDate += '0'+nowDate.getMonth() + '-'
        }else{
            lastNowDate += nowDate.getMonth() + '-'
        }
        if(nowDate.getDate()<10){
            lastNowDate += '0'+nowDate.getDate()
        }else{
            lastNowDate += nowDate.getDate()
        }
        console.log("一个月前："+lastNowDate)

        //注意：选项卡 依赖 element 模块，否则无法进行功能性操作
        layui.use(['element','jquery','table','laydate'], function () {
            var element = layui.element;
            var table = layui.table;
            var $ = layui.$;
            var laydate = layui.laydate;

            //时间框
            laydate.render({
                elem: '#startDate'
                ,value: lastNowDate
                ,isInitValue: true  //是否显示初始值
            });
            laydate.render({
                elem: '#endDate'
            });

            //表格数据
            table.render({
                elem: '#test'
                , url: '/nx/CompanyProfitAPI.jsp?op=findall&startDate='+lastNowDate  //用get请求才可自动拼接page等参数
                , height: 'full-165'//355
                , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                , cols: [[
                    {field: 'rows', width: 60, title: '序号'}
                    // , {field: 'classCode', width: 90, title: '客户编号'}
                    , {field: 'ComFullName', width: 230, title: '客户名称', edit: false}
                    , {field: 'QtyAll', width: 120, title: '销量', sort: true, align:'right'}
                    , {field: 'profitAll', width: 120, title: '利润', sort: true, align:'right'}
                    , {fixed: 'right', width: 90, align: 'center', toolbar: '#barDemo'}
                ]]
                , id: 'testReload'
                , even: true  //阴影间隔
                , page: true
                , limit: 90
                , fontSize:13
            });

            //筛选框
            $('.demoTable .layui-btn').on('click', function(){
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
            active = {
                reload: function(){
                    //传参数，执行重载
                    table.reload('testReload', {
                        url:'/nx/CompanyProfitAPI.jsp?op=findall', //可以在这里重写url！！！
                        where: {
                            // companyCode:  $('#demoReload').val(),//客户编号
                            startDate:  $('#startDate').val(),
                            endDate:  $('#endDate').val()
                        }
                    });
                }
            };
            //清空按钮
            $("#empty").on('click',function(){
                // $('#demoReload').val(""); //客户编号
                $('#startDate').val("");
                $('#endDate').val("");
            })

            //监听工具条
            table.on('tool(demo)', function (obj) { //注：tool是工具条事件名
                var data = obj.data //获得当前行数据
                    , layEvent = obj.event; //获得 lay-event 对应的值
                if (layEvent === 'tiaozhuan') {
                    //跳转新页签
                    window.location.href="javascript:mdiwin('/nx/companyProfitEveryone.jsp?code="+data.classCode+"','利润汇总-按月份')"
                }
            });
        });
    </script>

    <!--ECharts柱形图-->
    <script>
        var myChart = echarts.init(document.getElementById('main'),'light');
        var option = {
                title: {
                    text: '客户利润汇总',
                    x: 'left',
                    y: 'top'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    show: true,
                    x: 'center',
                    y: 'top',
                    data:['销量(kg)','利润(元)']
                },
                grid: {
                    top:"7%",
                    bottom: '2%', //图表距边框的距离
                    containLabel: true   //x轴文字是否显示
                },
                dataZoom: [{
                    type: 'inside'
                }, {
                    type: 'slider'
                }],
                toolbox:{
                    show: true,
                    feature: {
                        mark: {show: true},
                        magicType: {show: true, type: ['line']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                calculable: false,
                xAxis: {
                    show: true,
                    type: 'category',
                    boundaryGap: true,//坐标轴两端空白策略，数组内数值代表百分比.
                    data: [],
                    axisLabel:{  //x轴文字旋转
                        //直立
                        interval: 0,
                        formatter:function(value)
                        {
                            return value.split("").join("\n");
                        }
                    },
                },
                yAxis: {
                    show: true,
                    type: 'value',
                    splitArea: {show: false},
                    scale: true
                    // max: 4000000,//在下面传值
                    // min: 0,
                },
                series: [{
                    name: '销量(kg)',
                    type: 'bar',
                    data: [],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            // {type: 'min', name: '最小值'}
                        ],
                        symbolSize: 35, // 标注大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2

                    },
                },{
                    name: '利润(元)',
                    type: 'bar',
                    data: [],
                    markPoint: {
                        data: [
                            {type: 'max', name: '最大值'},
                            // {type: 'min', name: '最小值'}
                        ],
                        symbolSize: 35
                    }
                }]
            }
        myChart.setOption(option);

        //异步加载数据-柱形图
        jQuery.ajax({
            type: 'POST',
            url: "/nx/CompanyProfitAPI.jsp",
            data:{op:"findall",page:"",limit:"",startDate:lastNowDate,endDate:"",companyCode:"",field:"",order:""},
            dataTyte:"json",
            success:function(data){
                var jsonObjAll = eval('('+data+')');//转换为json对象数组
                var jsonObj = jsonObjAll.data
                var json1 = [];
                var json2 = [];
                var str = [];
                var profit = [];
                for(var j = 0;j<jsonObj.length;j++){
                    var row = {"value":jsonObj[j].QtyAll,"name":jsonObj[j].ComFullName}
                    json1.push(row); //组成新的json数据

                    var row2 = {"value":jsonObj[j].profitAll,"name":jsonObj[j].ComFullName}
                    json2.push(row2); //组成新的json数据

                    str.push(jsonObj[j].ComFullName);
                    profit.push(jsonObj[j].profitAll)
                }

                //获取利润最大值
                profit.sort(function (a, b) {
                    return a-b;
                });
                var maxprofit = profit[profit.length - 1];

                // 填入数据
                myChart.setOption({
                    xAxis: {
                        data:str
                    },
                    yAxis:{
                        max:maxprofit
                    },
                    series: [{
                        name: '销量(kg)',
                        data: json1
                    },{
                        name: '利润(元)',
                        data: json2
                    }]
                });
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(textStatus+XMLHttpRequest.status);
            }
        });
    </script>

    <!--ECharts扇形图(销量)-->
    <script>
        var myChart2 = echarts.init(document.getElementById('main2'),'light');
        var option2 = {
            title : {
                text: '客户销量',
                x:'55%'
            },
            //提示框
            tooltip : {
                trigger: 'item',
                //提示框文字格式
                formatter: "{a} <br/>{b} : {c} kg"
            },
            //图例
            legend: {
                orient : 'vertical',//垂直的
                x : 'left',
                data:[]
            },
            //工具箱
            toolbox:{
                show: true,
                feature: {
                    saveAsImage: {show: true}
                }
            },
            series : [
                {
                    name: '销量(kg)',
                    type: 'pie',
                    radius: '60%', //饼图的半径大小
                    center: ['70%', '50%'],//饼图的位置
                    data:[],  //为空，下面赋值
                    itemStyle : { //是否显示延伸线和文字
                        normal: {
                            label: {
                                show: false
                            },
                            labelLine: {
                                show: false
                            }
                        }
                    }
                }
            ]
        }
        myChart2.setOption(option2);

        //扇形图(销量)-异步加载数据
        jQuery.ajax({
            type: 'POST',
            url: "/nx/CompanyProfitAPI.jsp",
            data:{op:"findall",page:"",limit:"",startDate:lastNowDate,endDate:"",companyCode:"",field:"",order:""},
            dataTyte:"json",
            success:function(data){
                if(data.length>0) {
                    var jsonObjAll = eval('(' + data + ')');//转换为json对象数组
                    var jsonObj = jsonObjAll.data
                    if(jsonObj.length>0){
                        var json1 = [];
                        for (var j = 0; j < jsonObj.length; j++) {
                            var row = {"value": jsonObj[j].QtyAll, "name": jsonObj[j].ComFullName} //获取需要的字段
                            json1.push(row); //组成新的json数据
                        }
                        //----------------------------------------
                        //获取销量最大的前10个
                        function asc(x, y) {
                            return x.value - y.value
                        }

                        var jsons = json1.sort(asc);
                        var MaxQtyAll = [];
                        if(jsons.length>10) {
                            for (var i = jsons.length - 1; i >= jsons.length - 10; i--) {
                                MaxQtyAll.push(jsons[i].name)
                            }
                        }else{
                            for (var i = jsons.length - 1; i >= 0; i--) {
                                MaxQtyAll.push(jsons[i].name)
                            }
                        }
                        //------------------------------------------
                    }else{
                        MaxQtyAll="";
                        jsons="";
                    }

                    // 填入数据
                    myChart2.setOption({
                        legend: {
                            data: MaxQtyAll
                        },
                        series: [{
                            name: '销量(kg)',
                            data: jsons
                        }]
                    });
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(textStatus+XMLHttpRequest.status);
            }
        });
    </script>

    <!--ECharts扇形图(利润)-->
    <script>
        var myChart3 = echarts.init(document.getElementById('main3'),'light');
        var option3 = {
            title : {
                text: '客户利润',
                x:'55%'
            },
            //提示框
            tooltip : {
                trigger: 'item',
                //提示框文字格式
                formatter: "{a} <br/>{b} : {c} 元"
            },
            //图例
            legend: {
                orient : 'vertical',//垂直的
                x : 'left',
                data:[]
            },
            //工具箱
            toolbox:{
                show: true,
                feature: {
                    saveAsImage: {show: true}
                }
            },
            series : [
                {
                    name: '利润(元)',
                    type: 'pie',
                    radius: '55%', //饼图的半径大小
                    center: ['70%', '50%'],//饼图的位置
                    data:[],  //为空，下面赋值
                    itemStyle : { //是否显示延伸线和文字
                        normal: {
                            label: {
                                show: false
                            },
                            labelLine: {
                                show: false
                            }
                        }
                    }
                }
            ]
        }
        myChart3.setOption(option3);

        //扇形图(利润)-异步加载数据
        jQuery.ajax({
            type: 'POST',
            url: "/nx/CompanyProfitAPI.jsp",
            data:{op:"findall",page:"",limit:"",startDate:lastNowDate,endDate:"",companyCode:"",field:"",order:""},
            dataTyte:"json",
            success:function(data){
                if(data.length>0){
                    var jsonObjAll = eval('('+data+')');//转换为json对象数组
                    var jsonObj = jsonObjAll.data
                    if(jsonObj.length>0){
                        var json1 = [];
                        for(var j = 0;j<jsonObj.length;j++){
                            var row = {"value":jsonObj[j].profitAll,"name":jsonObj[j].ComFullName} //获取需要的字段
                            json1.push(row);
                        }
                        //----------------------------------------
                        //获取销量最大的前10个
                        function asc(x,y)
                        {
                            return x.value - y.value
                        }
                        var jsons = json1.sort(asc);
                        var MaxProfitAll=[];
                        if(jsons.length>10){
                            for(var i=jsons.length-1;i>=jsons.length-10;i--){
                                MaxProfitAll.push(jsons[i].name)
                            }
                        }else if(jsons.length>0 && jsons.length<=10){
                            for(var i=jsons.length-1;i>=0;i--){
                                MaxProfitAll.push(jsons[i].name)
                            }
                        }
                        //------------------------------------------
                    }else{
                        MaxProfitAll="";
                        jsons="";
                    }

                    // 填入数据
                    myChart3.setOption({
                        legend:{
                            data:MaxProfitAll
                        },
                        series: [{
                            name: '利润(元)',
                            data: jsons
                        }]
                    });
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                console.log(textStatus+XMLHttpRequest.status);
            }
        });

    </script>

    <!--点击搜索按钮，重新加载echarts数据-->
    <script>
        $("#selectbtn").click(function(){
            jQuery.ajax({
                type: 'POST',
                url: "/nx/CompanyProfitAPI.jsp",
                data:{op:"findall",page:"",limit:"",startDate:$('#startDate').val(),endDate:$('#endDate').val(),companyCode:"",field:"",order:""},
                dataTyte:"json",
                success:function(data){
                    var jsonObjAll = eval('('+data+')');//转换为json对象数组
                    var jsonObj = jsonObjAll.data
                    var json1 = [];
                    var json2 = [];
                    var str = [];
                    var profit = [];
                    for(var j = 0;j<jsonObj.length;j++){
                        var row = {"value":jsonObj[j].QtyAll,"name":jsonObj[j].ComFullName}
                        json1.push(row); //组成新的json数据

                        var row2 = {"value":jsonObj[j].profitAll,"name":jsonObj[j].ComFullName}
                        json2.push(row2); //组成新的json数据

                        str.push(jsonObj[j].ComFullName);
                        profit.push(jsonObj[j].profitAll);//重算利润最大数
                    }

                    //获取利润最大值
                    profit.sort(function (a, b) {
                        return a-b;
                    });
                    var maxprofit = profit[profit.length - 1];

                    //柱形、折线图填入数据 (必须放前面，否则json1和json2会被后面的排序影响)
                    myChart.setOption({
                        xAxis: {
                            data:str
                        },
                        yAxis:{
                            max:maxprofit
                        },
                        series: [{
                            name: '销量(kg)',
                            data: json1
                        },{
                            name: '利润(元)',
                            data: json2
                        }]
                    });
                    //----------------------------------------
                    //扇形图数据
                    if(json1!="" && json1!=null && json2!="" && json2!=null){
                        function asc(x,y)
                        {
                            return x.value - y.value
                        }
                        var startDate = $("#startDate").val()
                        var endDate = $("#endDate").val()
                        //数据库原始排序是 利润倒序
                        //点击搜索时，获取销量、利润最大的1个
                        if((startDate!="" && startDate!=null)||(endDate!="" && endDate!=null)){
                            json1.sort(asc); //重新比较
                            var MaxQtyAll=[];
                            for(var i=json1.length-1;i>=json1.length-1;i--){
                                MaxQtyAll.push(json1[i].name)
                            }
                            json2.sort(asc); //重新比较
                            var MaxProfitAll=[];
                            for(var i=json2.length-1;i>=json2.length-1;i--){
                                MaxProfitAll.push(json2[i].name)
                            }
                        }else{ //点击搜索时，搜索项都为空，获取销量、利润最大的10个
                            json1.sort(asc);//重新比较
                            var MaxQtyAll=[];
                            for(var i=json1.length-1;i>=json1.length-10;i--){
                                MaxQtyAll.push(json1[i].name)
                            }
                            json2.sort(asc);//重新比较
                            var MaxProfitAll=[];
                            for(var i=json2.length-1;i>=json2.length-10;i--){
                                MaxProfitAll.push(json2[i].name)
                            }
                        }

                        //销量-扇形图填入数据
                        myChart2.setOption({
                            legend:{
                                data:MaxQtyAll
                            },
                            series: [{
                                name: '销量(kg)',
                                data: json1
                            }]
                        });
                        //利润-扇形图填入数据
                        myChart3.setOption({
                            legend:{
                                data:MaxProfitAll
                            },
                            series: [{
                                name: '利润(元)',
                                data: json2
                            }]
                        });
                    }else{
                        //销量-扇形图填入数据
                        myChart2.setOption({
                            legend:{
                                data:null
                            },
                            series: [{
                                name: '销量(kg)',
                                data: null
                            }]
                        });
                        //利润-扇形图填入数据
                        myChart3.setOption({
                            legend:{
                                data:null
                            },
                            series: [{
                                name: '利润(元)',
                                data: null
                            }]
                        });
                    }
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    console.log(textStatus+XMLHttpRequest.status);
                }
            });
        });
    </script>

    <!--排序-->
    <script>
        layui.use('table', function () {
            var table = layui.table;

            //点击排序，重载页面，向后台传参
            table.on('sort(demo)', function (obj) {  //demo是table的lay-filter，testReload是table.render的id
                //将排序参数赋给全局变量，以便调用
                sortFiled = obj.field;
                sortWay = obj.type;

                //1.table重载
                table.reload('testReload', {
                    // initSort:obj, //取消layui的自动排序(自动排序不完善，会出错，如数字按字典顺序排和取不到排列方式)
                    where: {
                        field: obj.field,//排序字段
                        order: obj.type//排序方式，正序倒序
                    }
                });
                //2.柱状图重载
                jQuery.ajax({
                    type: 'POST',
                    url: "/nx/CompanyProfitAPI.jsp",
                    data:{op:"findall",page:"",limit:"",startDate:$('#startDate').val(),endDate:$('#endDate').val(),companyCode:"",field:sortFiled,order:sortWay},
                    dataTyte:"json",
                    success:function(data){
                        if(data.length>0) {
                            var jsonObjAll = eval('(' + data + ')');//转换为json对象数组
                            var jsonObj = jsonObjAll.data
                            if(jsonObj.length>0) {
                                var json1 = [];
                                var json2 = [];
                                var str = [];
                                for (var j = 0; j < jsonObj.length; j++) {
                                    var row = {"value": jsonObj[j].QtyAll, "name": jsonObj[j].ComFullName}
                                    json1.push(row); //组成新的json数据

                                    var row2 = {"value": jsonObj[j].profitAll, "name": jsonObj[j].ComFullName}
                                    json2.push(row2); //组成新的json数据

                                    str.push(jsonObj[j].ComFullName);
                                }
                            }else{
                                str="";
                                json1="";
                                json2="";
                            }
                            //柱形、折线图填入数据
                            myChart.setOption({
                                xAxis: {
                                    data: str
                                },
                                series: [{
                                    name: '销量(kg)',
                                    data: json1
                                }, {
                                    name: '利润(元)',
                                    data: json2
                                }]
                            });
                        }
                    },
                    error:function(XMLHttpRequest, textStatus, errorThrown){
                        console.log(textStatus+XMLHttpRequest.status);
                    }
                });
            });
        })
    </script>

</body>
</html>

