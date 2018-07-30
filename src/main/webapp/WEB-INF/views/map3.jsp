<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath()+"/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <%--<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.6&key=d6b25d8ee1d0a69b8cf01936abf5bee1"></script>--%>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.5&key=e738c1f7def9f791b36cd29a5df6aaff&plugin=AMap.CitySearch"></script>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="js/shengshiliandong/plugins/eleme-ui/index.css"/>

    <style>
        #container{
            height: 280px; width: 480px;
            margin: 5% 0px 0px 0px;
        }
        .layui-input-block input {
            width: 80%;
        }

        .layui-form-label {
            width: 85px;
        }

        .el-cascader {
            width: 78.5%;
        }
    </style>
</head>
<body>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
<script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
<script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->


<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-xs6">
            <form class="layui-form" action="" style="margin-top: 5%;">
                <div class="layui-form-item">
                    <label class="layui-form-label">物业小区名称</label>
                    <div class="layui-input-block">
                        <input type="text" id="placename" name="placename" lay-verify="placename" autocomplete="off" placeholder="请输入"
                               class="layui-input"  onblur="seachdata(this.value)"> <!--失去焦点时触发-->
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">省市区</label>
                    <%--<div class="layui-input-block">--%>
                    <div id="myVue"><%--省市联动--%>
                        <el-form ref="form" :model="form" label-width="100px">
                            <el-form-item>
                                <el-cascader id="aq"
                                        :options="CityInfo"
                                        v-model="form.selectedOptions"
                                        :change-on-select="true"
                                        :clearable="true"
                                        :filterable="true"
                                        @change="handleChange">
                                </el-cascader>
                                <span id ="forminfo" class="layui-hide">{{form.city | myAddressCity}}{{form.erae | myAddressErae}}{{form.minerae | myAddressMinerae}}</span>
                            </el-form-item>
                        </el-form>
                    </div>
                    <%--</div>--%>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">物业小区地址</label>
                    <div class="layui-input-block">
                        <input type="text" id="address" name="address" lay-verify="address" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">对外服务电话</label>
                    <div class="layui-input-block">
                        <input type="text" id="phone" name="phone" lay-verify="phone" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="demo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="layui-col-xs6">
            <div id="container"></div> <%--地图--%>
        </div>
    </div>
</div>

<script type=text/javascript src="js/jquery.js"></script>
<script type=text/javascript src="js/layui/layui.js"></script>
<script type=text/javascript src="js/vue.js"></script>

<!--省市联动 js类引用-->
<script type="text/javascript" src="js/shengshiliandong/plugins/vue/vue.min.js"></script>
<script type="text/javascript" src="js/shengshiliandong/plugins/eleme-ui/index.js"></script>
<script type="text/javascript" src="js/shengshiliandong/plugins/city-picker/city-data-json.js"></script>

<script type="text/javascript">

    //存放最终查询结果
    var finalResult = [];

    //工具初始化
    var map = new AMap.Map("container", {
        resizeEnable: true
    });

    //初始地图
    AMap.service(["AMap.PlaceSearch"], function () {
        var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
            pageSize: 5,
            pageIndex: 1,
            city: "",
            map: map
        });
    })

    //关键词查询(展示多个结果)
    function seachdata(address) {
        map.clearMap(); //清除上一次查询的图中maker ，很重要！！！
        var resultAll = null;
        AMap.service(["AMap.PlaceSearch"], function () {
            var placeSearch = new AMap.PlaceSearch({ //构造地点查询类
                pageSize: 5,  //显示5个结果
                pageIndex: 1,
                city:"", //城市,默认全国范围
                map: map
            });
            //关键字查询
            placeSearch.search(address, function (status, result) {
                console.log(result);

                if (result.poiList.count == 0) {
                    // layer.open({
                    //     title: '提示'
                    //     ,content: '未找到，请重新输入详细地址'
                    // });
                    return false;
                } else {
                    var placename = result.poiList.pois[0].name;//地名
                    $("#placename").val(placename);
                    var address = result.poiList.pois[0].address;//地址
                    $("#address").val(address);
                    var phone = result.poiList.pois[0].tel;//电话
                    $("#phone").val(phone);

                    var province = result.poiList.pois[0].pname;//省
                    var provincecode = result.poiList.pois[0].pcode;//省编码
                    var city = result.poiList.pois[0].cityname; //市
                    var citycode = getadcode(city);//市编码
                    var district = result.poiList.pois[0].adname;//县
                    var districtcode = result.poiList.pois[0].adcode;//县编码
                    var lng = result.poiList.pois[0].location.lng;//经度
                    var lat = result.poiList.pois[0].location.lat;//纬度
                    var lnglat = lng + "|" + lat;//经纬度
                }
                finalResult =  {placename:placename,address:address,phone:phone
                    ,province:province,provincecode:provincecode, city:city,citycode:citycode
                    ,district:district,districtcode:districtcode,lnglat:lnglat};

                vm.inputData(finalResult); //省市级联赋值
            })
            //点击事件，获取其中一个结果
            AMap.event.addListener(placeSearch, "markerClick", function(result) {
                console.log(result.data);

                var placename = result.data.name;//地名
                $("#placename").val(placename);
                var address = result.data.address;//地址
                $("#address").val(address);
                var phone = result.data.tel;//电话
                $("#phone").val(phone);

                var province = result.data.pname;//省
                var provincecode = result.data.pcode;//省编码
                var city = result.data.cityname; //市
                var citycode = getadcode(city);//市编码
                var district = result.data.adname;//县
                var districtcode = result.data.adcode;//县编码
                var lng = result.data.location.lng;//经度
                var lat = result.data.location.lat;//纬度
                var lnglat = lng + "|" + lat;//经纬度

                finalResult =  {placename:placename,address:address,phone:phone
                    ,province:province,provincecode:provincecode, city:city,citycode:citycode
                    ,district:district,districtcode:districtcode,lnglat:lnglat};

                vm.inputData(finalResult); //省市级联赋值
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

    //layui表单
    layui.use(['form'], function() {
        var form = layui.form;

        //自定义验证规则
        form.verify({
            placename: function(value){
                if(value.length < 5){
                    // return '至少得5个字符啊';
                }
            }
            ,address: function(value){

            }
            ,phone: function(value){

            }
        });

        //监听提交
        form.on('submit(demo)', function(data){
            var placename = $("#placename").val();
            var address = $("#address").val();

            //校验地名和地址
            if(placename!=finalResult.placename || address!=finalResult.address){
                console.log("--------error info------------"+placename+","+address);
                layer.open({
                    title: '提示'
                    ,content: '提交的信息和地图查询信息不一致！'
                });
                return false;
            }
            //校验省市县
            if($("#aq").text().indexOf(finalResult.province)<0 || $("#aq").text().indexOf(finalResult.city)<0 || $("#aq").text().indexOf(finalResult.district)<0){
                var errorinfo = $("#forminfo").text();
                console.log("--------error info------------"+errorinfo);
                layer.open({
                    title: '提示'
                    ,content: '提交的信息和地图查询信息不一致！'
                });
                return false;
            }

            //最终查询结果（包含所有要用到的信息）
            console.log(finalResult);

            //电话可以手动修改，可以与查询的不一致（有的电话查询结果为空）
            var phone = $("#phone").val();
            finalResult.phone = phone;

            //提交的信息
            data = finalResult
            layer.alert(JSON.stringify(data),{
                title: '提交的信息'
            })
            return false;
        });
    })

    //省市县级联
    var vm = new Vue({
        el: "#myVue",
        data: {
            /*数据源*/
            CityInfo: CityInfo, //地区筛选数组,//地区数据   addressdatas.addressdata,
            form: {
                city : '',
                erae : '',
                minerae : '',
                selectedOptions: [finalResult.provincecode,finalResult.citycode,finalResult.districtcode]//地区筛选数组
            },
        },
        methods: {
            inputData(value){ //改变默认值
                this.form.selectedOptions[0] = value.provincecode+"";
                this.form.selectedOptions[1] = value.citycode+"";
                this.form.selectedOptions[2] = value.districtcode+"";
                this.form.selectedOptions.push();//将数据推入
            },
            handleChange(value) { //变动时，放入
                this.form.city = this.form.selectedOptions[0];
                this.form.erae = this.form.selectedOptions[1];
                this.form.minerae = this.form.selectedOptions[2];
            },
        },
        /*过滤器*/
        filters:{
            myAddressCity:function(value){
                for(y in this.CityInfo){
                    if(this.CityInfo[y].value == value){
                        return value = this.CityInfo[y].label
                    }
                }
            },
            myAddressErae:function(value){
                for(y in this.CityInfo){
                    for(z in this.CityInfo[y].children){
                        if(this.CityInfo[y].children[z].value == value && value!=undefined){
                            return value = this.CityInfo[y].children[z].label;
                        }
                    }
                }
            },
            myAddressMinerae:function(value){
                for(y in this.CityInfo){
                    for(z in this.CityInfo[y].children){
                        for(i in this.CityInfo[y].children[z].children){
                            if(this.CityInfo[y].children[z].children[i].value == value && value!=undefined){
                                return value = this.CityInfo[y].children[z].children[i].label
                            }
                        }
                    }
                }
            },
        },
    });

    //点击重置时，省市级联输入清空
    $("#reset").click(function(){
        vm.inputData(""); //省市级联赋值
    });


</script>
</body>
</html>
