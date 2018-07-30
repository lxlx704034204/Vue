<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>高德地图-地理编码</title>
    <script type=text/javascript src="js/jquery.js"></script>

    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.3&key=d6b25d8ee1d0a69b8cf01936abf5bee1"></script>
    <style type="text/css">#iCenter{width:300px; height: 280px; border:1px #000 solid;margin:20px auto;}</style>
</head>
<body>

<div>
    <input id="in" size="25px" placeholder="查询地址" value="厦门123海岸"/>
    <input id="in2" size="20px" placeholder="所属省市" />
    <input type="button" value="查询" onclick="seachdata()"/>
</div>

<div>
    <table border="1" cellspacing="0">
        <tr>
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
            <td ><input id="address"/></td>
            <td ><input id="province"/></td>
            <td ><input id="provincecode"/></td>
            <td ><input id="city"/></td>
            <td ><input id="citycode"/></td>
            <td ><input id="district"/></td>
            <td ><input id="districtcode"/></td>
            <td ><input id="location"/></td>
        </tr>
    </table>

</div>
<br/>
<div id="iCenter"></div>

<script type="text/javascript">

    $(function(){
        var mapObj = new AMap.Map('iCenter');
        mapObj.plugin('AMap.Geolocation', function () {
            geolocation = new AMap.Geolocation({
                enableHighAccuracy: true, // 是否使用高精度定位，默认:true
                timeout: 10000,           // 超过10秒后停止定位，默认：无穷大
                maximumAge: 0,            // 定位结果缓存0毫秒，默认：0
                convert: true,            // 自动偏移坐标，偏移后的坐标为高德坐标，默认：true
                showButton: true,         // 显示定位按钮，默认：true
                buttonPosition: 'LB',     // 定位按钮停靠位置，默认：'LB'，左下角
                buttonOffset: new AMap.Pixel(10, 20), // 定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
                showMarker: true,         // 定位成功后在定位到的位置显示点标记，默认：true
                showCircle: true,         // 定位成功后用圆圈表示定位精度范围，默认：true
                panToLocation: true,      // 定位成功后将定位到的位置作为地图中心点，默认：true
                zoomToAccuracy:true       // 定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            });
            mapObj.addControl(geolocation);
            geolocation.getCurrentPosition();
            AMap.event.addListener(geolocation, 'complete', onComplete); // 返回定位信息
            AMap.event.addListener(geolocation, 'error', onError);       // 返回定位出错信息
        });
        // var districtcode = getadcode("大同县");
        // console.log("111:"+districtcode);

        // http://webapi.amap.com/maps?v=1.4.3&key=3df877a70685dac5ecb3afa375d4c305
        //     $.ajax({
        //         url: "http://restapi.amap.com/v3/geocode/geo?key=ead17a14e690304fc4dd2763a51c1cfa",
        //         type: "POST",
        //         data: {address: address, city: city},
        //         dataType: "json",
        //         cache: false,
        //         success: function (param) { //解析得到的json
        //             console.log(param)
        //         }
        //     })
    })

    function onComplete(obj){
        var res = '经纬度：' + obj.position +
            '\n精度范围：' + obj.accuracy +
            '米\n定位结果的来源：' + obj.location_type +
            '\n状态信息：' + obj.info +
            '\n地址：' + obj.formattedAddress +
            '\n地址信息：' + JSON.stringify(obj.addressComponent, null, 4);
        alert(res);
    }

    function onError(obj) {
        alert(obj.info + '--' + obj.message);
        console.log(obj);
    }

    //获取地址信息
    function seachdata(){
        var address = $("#in").val();
        var city = $("#in2").val();
        $.ajax({
            url: "http://restapi.amap.com/v3/geocode/geo?key=ead17a14e690304fc4dd2763a51c1cfa",
            type: "POST",
            data: {address:address,city:city},
            dataType: "json",
            cache: false,
            success: function (param) { //解析得到的json
                console.log(param)
                if(($("#in").val()).length==0){
                    alert("请先输入要查询的地址！");
                    return;
                }

                if(param.count<=0){
                    alert("未找到，请重新输入详细地址");
                    return;
                }else{
                    var province = param.geocodes[0].province;//省
                    $("#province").val(province);
                    var provincecode = getadcode(province);
                    $("#provincecode").val(provincecode);//省编码

                    var city = param.geocodes[0].city; //市
                    $("#city").val(city);
                    var citycode = getadcode(city);
                    $("#citycode").val(citycode);//市编码

                    var district = param.geocodes[0].district; //县
                    $("#district").val(district);
                    var districtcode = getadcode(district);
                    $("#districtcode").val(districtcode);//县编码

                    var addr = param.geocodes[0].formatted_address;
                    var len = 0;
                    if(province == city){ //直辖市
                        len = city.length+district.length;
                    }else{
                        len = province.length+city.length+district.length;
                    }
                    $("#address").val(addr.substring(len,addr.length));//地址

                    var location = param.geocodes[0].location.split(',');
                    var lon = location[0];//经度
                    var lat = location[1];//纬度
                    $("#location").val(lon+"|"+lat);//经纬度

                    console.log("街道："+param.geocodes[0].street)
                }
            }
        })
    }

    //获取城市编码
    function getadcode(name){
        var code = "";
        $.ajax({
            url: "http://restapi.amap.com/v3/config/district?key=ead17a14e690304fc4dd2763a51c1cfa",
            type: "POST",
            data: {keywords:name},
            dataType: "json",
            async:false,  //同步，异步无返回值
            cache: false,
            success: function (params) { //解析得到的json
                //console.log(params);
                var city = params.districts[0].name;  //获取查询的城市名
                //console.log(city);
                if (name == city){ //检查查询的城市名是否正确
                    code = params.districts[0].adcode; //获取城市编码
                }
            }
        });
        return code;
    }


</script>
</body>
</html>
