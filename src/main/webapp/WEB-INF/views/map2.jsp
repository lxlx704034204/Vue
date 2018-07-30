<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>高德地图-JavaScript API-关键字检索</title>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <style type="text/css">
        #panel {
            position: absolute;
            background-color: white;
            max-height: 90%;
            overflow-y: auto;
            top: 10px;
            right: 10px;
            width: 280px;
        }
        #container{
            height: 280px; width: 480px;
            margin: 10px 0px 0px 0px;
        }
    </style>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.6&key=d6b25d8ee1d0a69b8cf01936abf5bee1"></script>
    <!--引入UI组件库（1.0版本） -->
    <%--<script src="//webapi.amap.com/ui/1.0/main.js"></script>--%>
    <%--<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>--%>

</head>
<body>

<div id="container"></div> <%--地图--%>
<%--<div id="panel"></div>--%>
<div style="margin: 25% 0 0 0 ">
    <div>
        <%--onblur 事件会在对象失去焦点时发生--%>
        <input id="in" size="25px" placeholder="查询地址" value="海岸"/>
        <input id="in2" size="20px" placeholder="所属省市" value="厦门"/>
        <input type="button" value="查询" onclick="seachdata()"/>
    </div>
    <div>
        <table border="1" cellspacing="0">
            <tr>
                <th>地名</td>
                <th>地址</td>
                <th>省</td>
                <th>省编码</td>
                <th>市</td>
                <th>市编码</td>
                <th>县</td>
                <th>县编码</td>
                <th>坐标</td>
            </tr>
            <tr>
                <td ><input id="placename"/></td>
                <td ><input id="address"/></td>
                <td ><input id="province"/></td>
                <td ><input id="provincecode"/></td>
                <td ><input id="city"/></td>
                <td ><input id="citycode"/></td>
                <td ><input id="district"/></td>
                <td ><input id="districtcode"/></td>
                <td ><input id="lngandlat"/></td>
            </tr>
        </table>
    </div>
    <input type="button" value="添加到数据库" onclick="add()"/>
</div>


<script type=text/javascript src="js/jquery.js"></script>
<script src="js/layui/layui.js"></script>
<script type="text/javascript">

    //工具初始化
    var map = new AMap.Map("container", {
        resizeEnable: true
    });
    //初始地点
    var placeSearch =null;
        AMap.service(["AMap.PlaceSearch"], function () {
        placeSearch = new AMap.PlaceSearch({ //构造地点查询类
            pageSize: 5,  //一页显示1个
            pageIndex: 1,
            city: "", //城市
            map: map
            //panel: "panel" //查询结果面板
        });
    })

    //关键词查询
    function seachdata() {
        var address = $("#in").val();
        var city = $("#in2").val();
        map.clearMap(); //清除上一次查询的图中maker ，很重要！！！

        AMap.service(["AMap.PlaceSearch"], function () {
            var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
                pageSize: 5,  //一页显示1个
                pageIndex: 1,
                city: city, //城市
                map: map
                //panel: "panel" //查询结果面板
            });
            //关键字查询
            placeSearch.search(address, function (status, result) {
                //console.log(result)
                console.log(result.poiList.pois[0]) //poi数据
                if (($("#in").val()).length == 0 && ($("#in2").val()).length == 0) {
                    alert("请先输入要查询的地址和城市！");
                    return;
                }

                if (result.info != "OK") {
                    alert("未找到，请重新输入详细地址");
                    return;
                } else {
                    $("#placename").val(result.poiList.pois[0].name);//地名

                    $("#province").val(result.poiList.pois[0].pname);//省
                    $("#provincecode").val(result.poiList.pois[0].pcode);//省编码

                    var city = result.poiList.pois[0].cityname; //市
                    $("#city").val(city);
                    var citycode = getadcode(city);
                    $("#citycode").val(citycode);//市编码

                    $("#district").val(result.poiList.pois[0].adname);//县
                    $("#districtcode").val(result.poiList.pois[0].adcode);//县编码

                    $("#address").val(result.poiList.pois[0].address);//地址

                    var lngandlat = result.poiList.pois[0].location;
                    var lng = lngandlat.lng;//经度
                    var lat = lngandlat.lat;//纬度
                    $("#lngandlat").val(lng + "|" + lat);//经纬度
                }
            })
            //点击事件，获取其中一个结果
            AMap.event.addListener(placeSearch, "markerClick", function(result) {
                console.log(result);
                console.log(result.data.name);

                $("#placename").val(result.data.name);
                $("#province").val(result.data.pname);
                $("#provincecode").val(result.data.pcode);

                var city = result.data.cityname;
                $("#city").val(city);
                var citycode = getadcode(city);
                $("#citycode").val(citycode);

                $("#district").val(result.data.adname);
                $("#districtcode").val(result.data.adcode);
                $("#address").val(result.data.address);

                var lngandlat = result.data.location;
                var lng = lngandlat.lng;//经度
                var lat = lngandlat.lat;//纬度
                $("#lngandlat").val(lng + "|" + lat);//经纬度
            })
        });
    }

    //获取城市编码
    function getadcode(name) {
        var code = "";
        $.ajax({
            url: "http://restapi.amap.com/v3/config/district?key=ead17a14e690304fc4dd2763a51c1cfa",
            type: "POST",
            data: {keywords: name},
            dataType: "json",
            async: false,  //同步，异步无返回值
            cache: false,
            success: function (params) { //解析得到的json
                //console.log(params);
                var city = params.districts[0].name;  //获取查询的城市名
                //console.log(city);
                if (name == city) { //检查查询的城市名是否正确
                    code = params.districts[0].adcode; //获取城市编码
                }
            }
        });
        return code;
    }

    function add() {
        var placename = $("#placename").val();
        var address = $("#address").val();
        var province = $("#province").val();
        var provincecode = $("#provincecode").val();
        var city = $("#city").val();
        var citycode = $("#citycode").val();
        var district = $("#district").val();
        var districtcode = $("#districtcode").val();
        var lngandlat = $("#lngandlat").val();

        $.ajax({
            url: "addlocation",
            type: "POST",
            data: {
                placename: placename,
                address: address,
                province: province,
                provincecode: provincecode,
                city: city,
                citycode: citycode,
                district: district,
                districtcode: districtcode,
                lngandlat: lngandlat
            },
            dataType: "json",
            //contentType:"application/json",
            success: function (params) {
                if (params > 0)
                    alert("添加成功！" + params);
                else
                    alert("添加失败！" + params);
            },
            error: function (msg) {
                alert("添加失败！");
            }
        });
    }


</script>
</body>
</html>
