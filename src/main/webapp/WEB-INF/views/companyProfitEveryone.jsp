<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../js/layui/css/layui.css" media="all">
    <style>
        .layui-row {
            width: 99%;
        }

        .layui-col-xs12 {
            height: 415px;
            overflow: auto;
        }

        .layui-tab-title .li {
            font-size: 13px;
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

        .HeadingTitle > .b-list {
            background-position: -40px -2px;
        }

        .layui-input {
            height: 32px;
        }

        .layui-tab-title li {
            font-size: 13px;
        }

        .layui-form-select .layui-input {
            margin-top: 4px;
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="OneTab">
    <div class="HeadingTitle">
        <b class="icons b-list">利润汇总-按月份</b>
    </div>
    <ul class="layui-tab-title">
        <li class="layui-this">数据</li>
        <li>图表</li>
    </ul>

    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div class="layui-row">
                <div class="layui-col-xs12">
                    <div class="demoTable">
                        <div class="layui-row layui-col-space10">
                            <div class="layui-col-xs5">
                                <form class="layui-form">
                                    <label class="layui-form-label" style="text-align: left;width: 60px;">客户名称</label>
                                    <div class="layui-inline" style="width: 80%;">
                                        <select name="companyCode" lay-verify="required" id="companyCodes"
                                                lay-filter="kehu">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                            <div class="layui-col-xs7">
                                <button class="layui-btn" data-type="reload" id="selectbtn">搜索</button>
                                <button class="layui-btn" id="empty">清空</button>
                            </div>
                        </div>
                    </div>

                    <table class="layui-hide" lay-size="sm" id="test" lay-filter="demo"></table>
                </div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div class="layui-col-xs12">
                <div id="main" style="width: 1000px;height:375px;margin-top: 7px;"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="../js/echarts.min.js"></script>
<script type="text/javascript" src="../js/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/jquery3.2.js"></script>

<!--获取companyProfit.jsp页面传过来的值-客户编号-->
<script>
    var param = "" //全局参数 客户编号

    var loc = location.href;
    console.log("跳转路径->" + loc)
    var n1 = loc.length;//地址的总长度
    var n2 = loc.indexOf("=");//取得=号的位置
    var n3 = loc.indexOf("&");//取得&号的位置
    if (loc.indexOf("companyProfitEveryone.jsp?code=") != -1) {
        param = decodeURI(loc.substr(n2 + 1, n3 - 1 - n2))+"";//从&号前面的内容
        // param = decodeURI(loc.substr(n2+1, n1));//从=号后面的内容
        console.log("接收页面参数：" + param)
    }
</script>

<!--获取下拉框内容-->
<script>
    jQuery.ajax({
        type: 'POST',
        url: "/nx/CompanyProfitAPI.jsp",
        data: {
            op: "findall",
            page: "",
            limit: "",
            startDate: "",
            endDate: "",
            companyCode: "",
            field: "",
            order: ""
        },
        dataTyte: "json",
        success: function (data) {
            var jsonObjAll = eval('(' + data + ')');//转换为json对象数组
            var jsonObj = jsonObjAll.data

            for (var j = 0; j < jsonObj.length; j++) {
                var companyname = jsonObj[j].ComFullName;
                var companycode = jsonObj[j].classCode;

                $("#companyCodes").append("<option value=" + companycode + ">" + companyname + "</option>");
                renderForm();//表单重新渲染，要不然添加完显示不出来新的option
            }
            optionData();//显示下拉框选中项
        }
    });

    //重新渲染表单
    function renderForm() {
        layui.use(['form', 'jquery'], function () {
            var form = layui.form;
            var $ = layui.$;
            form.render();
        });
    }
    //显示下拉框选中项
    function optionData() {
        layui.use(['form', 'jquery'], function () {
            var form = layui.form;
            var $ = layui.$;

            if(param!="" && param != null) { //有页面参数
                // var select = 'dd[lay-value=' + param + ']';
                // $('#companyCodes').siblings(".layui-unselect .layui-form-select").find('dl').find(select).click();

                $('select').val(param); //下拉框选中项。$()中要用单引号
                console.log("下拉框选中项x:" + $('select').val())
                form.render(); //加载下拉框
            }
        });
    }
</script>

<!--Layui表格-->
<script>
    //排序参数，各图共用
    var sortFiled = "";
    var sortWay = "";

    layui.use(['jquery', 'element', 'table', 'laydate', 'form'], function () {
        var element = layui.element;
        var table = layui.table;
        var $ = layui.$;
        var laydate = layui.laydate;
        var form = layui.form;

        //时间框
        laydate.render({
            elem: '#startDate',
            elem: '#endDate'
        });

        var urlTable = null;
        var colsTable = null;

        //cols1和cols2页面显示不同
        var cols1 = [[
            {field: 'rows', width: 70, title: '序号'}
            // , {field: 'classCode', width: 100, title: '客户编号'}
            // , {field: 'ComFullName', width: 230, title: '客户名称', edit: false}
            , {field: 'BillDate', width: 100, title: '销售时间', sort: true}
            , {field: 'QtyAll', width: 140, title: '销量', sort: true, align:'right'}
            , {field: 'profitAll', width: 140, title: '利润', sort: true, align:'right'}
        ]]
        var cols2 = [[
            {field: 'rows', width: 70, title: '序号'}
            // , {field: 'classCode', width: 100, title: '客户编号'}
            // , {field: 'ComFullName', width: 230, title: '客户名称', edit: false}
            , {field: 'BillDate', width: 100, title: '销售时间', sort: true}
            , {field: 'QtyAll', width: 140, title: '销量', sort: true, align:'right'}
            , {field: 'profitAll', width: 140, title: '利润', sort: true, align:'right'}
        ]]

        //根据是否有页面参数，选择url
        var url = '/nx/CompanyProfitAPI.jsp?op=findallEveryone';
        if (param != "" && param != null) { //利润汇总-按客户 页面传来的参数（客户编号）
            url += '&companyCode=' + param;
        }

        //当下拉框没有选择时，显示每个月份的销量、利润汇总
        if (param == "" && param == null) {
            urlTable = '/nx/CompanyProfitAPI.jsp?op=findallForTotal';
            colsTable = cols1;
        } else {
            urlTable = url;
            colsTable = cols2;
        }
        console.log("urlTable:"+urlTable)

        //首次加载表格数据
        table.render({
            elem: '#test'
            , url: urlTable   //用get请求才可自动拼接page等参数
            , height: 'full-165' //445
            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            , cols: colsTable
            , id: 'testReload'
            , even: true  //阴影间隔
            , page: true
            , limit: 90
            , fontSize: 13
        });

        //筛选框
        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        active = {
            reload: function () {
                console.log("搜索重载参数:" + $('#companyCodes').val())

                //当下拉框没有选择时，显示每个月份的销量、利润汇总
                var colsReload = "";
                var urlReload = "";
                if ($('#companyCodes').val() == "" || $('#companyCodes').val() == null) {
                    urlReload = '/nx/CompanyProfitAPI.jsp?op=findallForTotal';
                    colsReload = cols1;
                } else {
                    urlReload = '/nx/CompanyProfitAPI.jsp?op=findallEveryone';
                    colsReload = cols2;
                }
                //执行重载
                table.reload('testReload', {
                    url: urlReload,
                    cols: colsReload,
                    where: {
                        companyCode: $('#companyCodes').val()
                    }
                });
            }
        };
        //清空按钮
        $("#empty").on('click', function () {
            $('#companyCodes').val('');
            layui.form.render('select'); //加载下拉框
        })
    })
</script>

<!--下面公用的ajax-->
<script>
    function getAjax(data){
        jQuery.ajax({
            type: 'POST',
            url: '/nx/CompanyProfitAPI.jsp',
            data: data,
            dataTyte: "json",
            success: function (data) {
                var jsonObjAll = eval('(' + data + ')');//转换为json对象数组
                var jsonObj = jsonObjAll.data
                var json1 = [];
                var json2 = [];
                var str = [];
                for (var j = 0; j < jsonObj.length; j++) {
                    //下拉框是否有值
                    if ($('#companyCodes').val() == "" || $('#companyCodes').val() == null) {
                        var row = {"value": jsonObj[j].QtyAll, "name": jsonObj[j].BillDate}
                        json1.push(row);
                        var row2 = {"value": jsonObj[j].profitAll, "name": jsonObj[j].BillDate}
                        json2.push(row2);
                        str.push(jsonObj[j].BillDate);
                    } else {
                        var row = {"value": jsonObj[j].QtyAll, "name": jsonObj[j].ComFullName}
                        json1.push(row);
                        var row2 = {"value": jsonObj[j].profitAll, "name": jsonObj[j].ComFullName}
                        json2.push(row2);
                        str.push(jsonObj[j].BillDate);
                    }
                }

                // 填入数据
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
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(textStatus + XMLHttpRequest.status);
            }
        });
    }
</script>

<!--ECharts折线图-->
<script>
    var myChart = echarts.init(document.getElementById('main'), 'light');
    var option = ({
        title: {
            text: '客户月份利润',
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
            data: ['销量(kg)', '利润(元)']
        },
        grid: {
            bottom: '2%', //图表距边框的距离
            containLabel: true   //x轴文字是否显示
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: true},
                magicType: {show: true, type: ['bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        //x轴信息样式
        xAxis: {
            type: 'category',
            boundaryGap: true,//坐标轴两端空白策略，数组内数值代表百分比.
            data: [],
        },
        yAxis: [
            {
                type: 'value',
            }
        ],
        series: [
            {
                name: '销量(kg)',
                type: 'line',
                symbolSize: 5,   //拐点圆的大小
                color: ['#5A95F5'],  //折线条的颜色
                data: [],
            },
            {
                name: '利润(元)',
                type: 'line',
                symbolSize: 5,
                color: ['green'],
                data: []
            }
        ]
    })
    myChart.setOption(option);

    var dataView = ""
    //当下拉框没有选择时，显示每个月份的总销量、总利润
    if (param == "" || param == null) {
        dataView = {
            op: "findallForTotal",
            page: "",
            limit: "",
            startDate: "",
            endDate: "",
            companyCode: "",
            field: "",
            order: ""
        }
    } else {
        dataView = {
            op: "findallEveryone",
            page: "",
            limit: "",
            startDate: "",
            endDate: "",
            companyCode: param,
            field: "",
            order: ""
        }
    }

    //折线图-异步加载数据
    getAjax(dataView);
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
            var dataTu = ""
            //当下拉框没有选择时，显示每个月份的销量、利润汇总
            if ($('#companyCodes').val() == "" || $('#companyCodes').val() == null) {
                dataTu = {
                    op: "findallForTotal",
                    page: "",
                    limit: "",
                    startDate: "",
                    endDate: "",
                    companyCode: "",
                    field: sortFiled,
                    order: sortWay
                }
            } else {
                dataTu = {
                    op: "findallEveryone",
                    page: "",
                    limit: "",
                    startDate: "",
                    endDate: "",
                    companyCode:$('#companyCodes').val(),  //param,
                    field: sortFiled,
                    order: sortWay
                }
            }
            //排序-异步加载数据
            getAjax(dataTu);
        });
    })
</script>

<!--搜索-->
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        form.render();
    });

    //点击搜索按钮，重新加载echarts数据
    $("#selectbtn").click(function () {
        var dataSeach = ""
        //当下拉框没有选择时，显示每个月份的销量、利润汇总
        if ($('#companyCodes').val() == "" || $('#companyCodes').val() == null) {
            dataSeach = {
                op: "findallForTotal",
                page: "",
                limit: "",
                startDate: "",
                endDate: "",
                companyCode: "",
                field: "",
                order: ""
            }
        } else {
            dataSeach = {
                op: "findallEveryone",
                page: "",
                limit: "",
                startDate: "",
                endDate: "",
                companyCode:$('#companyCodes').val(),
                field: "",
                order: ""
            }
        }
        //搜索-异步加载数据
        getAjax(dataSeach);
    });
</script>

</body>
</html>

