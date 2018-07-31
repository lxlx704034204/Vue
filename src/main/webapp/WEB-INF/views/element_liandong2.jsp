<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath()+"/";;
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link href="css/element-ui-test.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%--按钮弹窗--%>
<div id="app1">
    <el-button @click="visible = true">Button</el-button>
    <el-dialog :visible.sync="visible" title="Hello world">
        <p>Try Element</p>
    </el-dialog>
</div>

<%--联动下拉框--%>
<%--<div id="app">--%>
    <%--<el-cascader :options="options" change-on-select></el-cascader>--%>
<%--</div>--%>



<div id="app2">
<el-cascader
        :options="options"
        v-model="selectedOptions3"
></el-cascader>
</div>


<script type=text/javascript src="js/jquery.js"></script>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script>
    new Vue({
        el: '#app1',
        data: function () {
            return {visible: false}
        }
    })

    new Vue({
        el: '#app2',
        data: {
            options: [{
                value: 'zhinan',
                label: '指南',
                children: [{
                    value: 'shejiyuanze',
                    label: '设计原则',
                    children: [{
                        value: 'yizhi',
                        label: '一致'
                    }, {
                        value: 'fankui',
                        label: '反馈'
                    }, {
                        value: 'xiaolv',
                        label: '效率'
                    }, {
                        value: 'kekong',
                        label: '可控'
                    }]
                }, {
                    value: 'daohang',
                    label: '导航',
                    children: [{
                        value: 'cexiangdaohang',
                        label: '侧向导航'
                    }, {
                        value: 'dingbudaohang',
                        label: '顶部导航'
                    }]
                }]
            }, {
                value: 'zujian',
                label: '组件',
                children: [{
                    value: 'basic',
                    label: 'Basic',
                    children: [{
                        value: 'layout',
                        label: 'Layout 布局'
                    }, {
                        value: 'color',
                        label: 'Color 色彩'
                    }, {
                        value: 'typography',
                        label: 'Typography 字体'
                    }, {
                        value: 'icon',
                        label: 'Icon 图标'
                    }, {
                        value: 'button',
                        label: 'Button 按钮'
                    }]
                }, {
                    value: 'form',
                    label: 'Form',
                    children: [{
                        value: 'radio',
                        label: 'Radio 单选框'
                    }, {
                        value: 'checkbox',
                        label: 'Checkbox 多选框'
                    }, {
                        value: 'input',
                        label: 'Input 输入框'
                    }, {
                        value: 'input-number',
                        label: 'InputNumber 计数器'
                    }, {
                        value: 'select',
                        label: 'Select 选择器'
                    }, {
                        value: 'cascader',
                        label: 'Cascader 级联选择器'
                    }, {
                        value: 'switch',
                        label: 'Switch 开关'
                    }, {
                        value: 'slider',
                        label: 'Slider 滑块'
                    }, {
                        value: 'time-picker',
                        label: 'TimePicker 时间选择器'
                    }, {
                        value: 'date-picker',
                        label: 'DatePicker 日期选择器'
                    }, {
                        value: 'datetime-picker',
                        label: 'DateTimePicker 日期时间选择器'
                    }, {
                        value: 'upload',
                        label: 'Upload 上传'
                    }, {
                        value: 'rate',
                        label: 'Rate 评分'
                    }, {
                        value: 'form',
                        label: 'Form 表单'
                    }]
                }, {
                    value: 'data',
                    label: 'Data',
                    children: [{
                        value: 'table',
                        label: 'Table 表格'
                    }, {
                        value: 'tag',
                        label: 'Tag 标签'
                    }, {
                        value: 'progress',
                        label: 'Progress 进度条'
                    }, {
                        value: 'tree',
                        label: 'Tree 树形控件'
                    }, {
                        value: 'pagination',
                        label: 'Pagination 分页'
                    }, {
                        value: 'badge',
                        label: 'Badge 标记'
                    }]
                }, {
                    value: 'notice',
                    label: 'Notice',
                    children: [{
                        value: 'alert',
                        label: 'Alert 警告'
                    }, {
                        value: 'loading',
                        label: 'Loading 加载'
                    }, {
                        value: 'message',
                        label: 'Message 消息提示'
                    }, {
                        value: 'message-box',
                        label: 'MessageBox 弹框'
                    }, {
                        value: 'notification',
                        label: 'Notification 通知'
                    }]
                }, {
                    value: 'navigation',
                    label: 'Navigation',
                    children: [{
                        value: 'menu',
                        label: 'NavMenu 导航菜单'
                    }, {
                        value: 'tabs',
                        label: 'Tabs 标签页'
                    }, {
                        value: 'breadcrumb',
                        label: 'Breadcrumb 面包屑'
                    }, {
                        value: 'dropdown',
                        label: 'Dropdown 下拉菜单'
                    }, {
                        value: 'steps',
                        label: 'Steps 步骤条'
                    }]
                }, {
                    value: 'others',
                    label: 'Others',
                    children: [{
                        value: 'dialog',
                        label: 'Dialog 对话框'
                    }, {
                        value: 'tooltip',
                        label: 'Tooltip 文字提示'
                    }, {
                        value: 'popover',
                        label: 'Popover 弹出框'
                    }, {
                        value: 'card',
                        label: 'Card 卡片'
                    }, {
                        value: 'carousel',
                        label: 'Carousel 走马灯'
                    }, {
                        value: 'collapse',
                        label: 'Collapse 折叠面板'
                    }]
                }]
            }, {
                value: 'ziyuan',
                label: '资源',
                children: [{
                    value: 'axure',
                    label: 'Axure Components'
                }, {
                    value: 'sketch',
                    label: 'Sketch Templates'
                }, {
                    value: 'jiaohu',
                    label: '组件交互文档'
                }]
            }],
            selectedOptions3: ['zujian', 'data', 'tag']
        }
    });
</script>

<script>

    new Vue({
        el: '#app1',
        data: function () {
            return {visible: false}
        }
    })

    //1.先循环出省份即可
    //2.根据所选省份来筛选循环出市县即可

    //循环出所有的省市县
    // $.getJSON("/json/adcode.json", function (data) {
    //     var province = null;
    //     var city = null;
    //     var district = null;
    //     for (var provincecode in data) { //省
    //         province = data
    //         console.log(provincecode)//key值
    //         console.log(province[provincecode].name)
    //         city = province[provincecode].child;
    //         for (var citycode in city) { //市
    //             console.log(citycode)//key值
    //             console.log(city[citycode].name)
    //             district = city[citycode].child;
    //             for (var districtcode in district) { //县
    //                 console.log(districtcode)//key值
    //                 console.log(district[districtcode])
    //             }
    //         }
    //     }
    // });

    //--未完
    new Vue({
        el: '#app',
        data: {
            options:[{   //循环
                value: "110000",
                label: selectprovince("110000"),
                children: [{   //循环
                    value: 'shejiyuanze',
                    label: '设计原则',
                    children: [{   //循环
                        value: 'yizhi',
                        label: '一致'
                    }]
                }]
            }]
        }
    })

    //获取一个省份
    function selectprovince(provincecode){
        var province = null;
        $.getJSON("/json/adcode.json", function (data) {
            $.each(data, function (i, obj) {
                if (i == provincecode) {
                    console.log(i)
                    console.log(obj.name)
                    province = obj.name;
                }
            })
        })
        return province;
    }

    //获取一个省份下所有市
    function selectcity(provincecode) {
        var cityall = new Array();
        var j = 0;
        $.getJSON("/json/adcode.json", function (data) {
            $.each(data, function (i, obj) {
                if (i == provincecode) {
                    console.log(i)
                    console.log(obj.name)

                    var city = obj.child;
                    for (var citycode in city) { //市
                        console.log(citycode)
                        console.log(city[citycode].name)
                        var cityone = {citycode:citycode,cityname:city[citycode].name};
                        cityall[j] = cityone;
                        ++j;
                    }

                }
            });
        });
        return cityall;
    }

    //获取一个市下的所有区县--未完
    function selectdistrict(citycode) {
        $.getJSON("/json/adcode.json", function (data) {
            $.each(data, function (i, obj) {
                if (i == citycode) {
                    console.log(i)
                    console.log(obj.name)

                    var city = obj.child;
                    for (var citycode in city) { //市
                        console.log(citycode)
                        console.log(city[citycode].name)

                        var district = city[citycode].child;
                        for (var districtcode in district) { //县
                            console.log(districtcode)
                            console.log(district[districtcode])
                        }
                    }
                }
            });
        });
    }

</script>
</body>

</html>
