<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath() + "/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
</head>
<body>

<div id="app">
    <el-row type="flex" justify="center">
        <el-col :span="16" :offset="1">
            <el-radio-group v-model="labelPosition" size="small" style="margin-bottom: 20px">
                <el-radio-button label="left">左对齐</el-radio-button>
                <el-radio-button label="right">右对齐</el-radio-button>
                <el-radio-button label="top">顶部对齐</el-radio-button>
            </el-radio-group>  <%--:label-position 是label左右对齐--%>

            <el-form ref="form" :model="form" :rules="rules" label-width="100px" :label-position="labelPosition">
                <el-form-item label="活动名称" prop="name">   <!--prop是配合:rules="",进行具体字段校验-->
                    <!--输入框-->
                    <el-col :span="6" >
                        <el-input v-model="form.name"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="活动区域">
                    <!--下拉框-->
                    <el-select v-model="form.region" placeholder="请选择活动区域">
                        <el-option label="区域一" value="shanghai"></el-option>
                        <el-option label="区域二" value="beijing"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="活动时间">
                    <!--日期-->
                    <el-col :span="6" >
                        <el-date-picker type="date" placeholder="选择日期" v-model="form.date1"
                                        style="width: 100%;"></el-date-picker>
                    </el-col>
                    <el-col class="line" :span="1" :offset="1">-</el-col>
                    <!--时间-->
                    <el-col :span="6">
                        <el-time-picker type="fixed-time" placeholder="选择时间" v-model="form.date2"
                                        style="width: 100%;"></el-time-picker>
                    </el-col>
                </el-form-item>
                <el-form-item label="即时配送">
                    <!--选择开关-->
                    <el-switch v-model="form.delivery"></el-switch>
                </el-form-item>
                <el-form-item label="活动性质">
                    <!--多选-->
                    <el-checkbox-group v-model="form.types">
                        <el-checkbox label="美食/餐厅线上活动"></el-checkbox>
                        <el-checkbox label="地推活动"></el-checkbox>
                        <el-checkbox label="线下主题活动"></el-checkbox>
                        <el-checkbox label="单纯品牌曝光"></el-checkbox>
                    </el-checkbox-group>
                </el-form-item>
                <el-form-item label="特殊资源">
                    <!--单选-->
                    <el-radio-group v-model="form.resource">
                        <el-radio label="线上品牌商赞助"></el-radio>
                        <el-radio label="线下场地免费"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="活动形式">
                    <el-col :span="8" >
                        <!--textarea-->
                        <el-input type="textarea" v-model="form.desc" :rows="6"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="onSubmit">立即创建</el-button>
                    <el-button @click="reset">重置</el-button>
                </el-form-item>
            </el-form>
        </el-col>
    </el-row>
</div>

<div id="app2">

</div>

<script type=text/javascript src="js/jquery.js"></script>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script type=text/javascript src="js/jquery.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<%--app--%>
<script>
    new Vue({
        el: "#app",
        data: {
            form: {
                name: '',
                region: '',
                date1: '',
                date2: '',
                delivery: false,
                types: [],
                resource: '',
                desc: ''
            },
            rules:{
                // name:[{
                //     required: true,
                //     message: '请输入活动名称',
                //     trigger: 'blur'
                // },{
                //     min: 4,
                //     max: 25,
                //     message: '长度在 4 到 25 个字符'
                // }, {
                //     pattern: /^[\u4E00-\u9FA5]+$/,
                //     message: '活动名称只能为中文'
                // }]
            },
            labelPosition: 'left',
        },
        methods: {
            onSubmit() {
                console.log(this.form);

                if(this.form.name.length<4){
                    this.$message({message:"不能少于4个字符",type:'warning'});
                    return false;
                }

                var reg=/(^\s+)|(\s+$)|\s+/g;
                if(reg.test(this.form.name)){ //判断任何位置是否有空格
                    //$.trim(this.form.name);//去首尾空格
                    //str.replace(/\s+/g, "");//去掉所有
                    this.$message({message:"不能有空格",type:'warning'});
                    return false;
                }

                var reg =/^[\u4E00-\u9FA5]+$/;
                if(!reg.test(this.form.name)){
                    this.$message({message:"必须是中文",type:'warning'});
                    return false;
                }

                // axios.post('updatestu', {
                //     name: this.form.name,
                //     region: this.form.region,
                //     date1: this.form.date1,
                //     date2: this.form.date2,
                //     delivery: this.form.delivery,
                //     type: this.form.type,
                //     resource: this.form.resource,
                //     desc: this.form.desc
                // })
                // .then(function (res) {
                //     console.log(res);
                // })
                // .catch(function (error) {
                //     console.log(error);
                // });
            },
            reset(){
                this.form = {types: []}; //重置时，多选需要赋值空数组，否则再次点击时，会出现全部选中的现象
            },
        }
    })
</script>

<%--app2--%>
<script>
    new Vue({
        el: "",
        data: {

        }
    })
</script>
</body>
</html>

<%--row--%>
<!--
gutter指定分栏间隔
type=’flex’指定对齐方式
justify=center 居中对齐
justify=start 左对齐
justify=end 右对齐
justify=space-between 空格间距在中间对齐
justify=space-around 左右各占半格空格对齐
-->

<%--col--%>
<%--span 指定分栏,offset属性指定分栏偏移的栏数（向右偏移）--%>


<%--:rows=""只对textarea生效，代表可以写几行--%>


<!--
以前，一直以为在SpringMVC环境中，@RequestBody接收的是一个Json对象，
一直在调试代码都没有成功，后来发现，其实 @RequestBody接收的是一个Json对象的字符串，
而不是一个Json对象。然而在ajax请求往往传的都是Json对象，后来发现用 JSON.stringify(data)的方式就能将对象变成字符串。
同时ajax请求的时候也要指定dataType: "json",contentType:"application/json" 这样就可以轻易的将一个对象或者List传到Java端，
使用@RequestBody即可绑定对象或者List.
-->
