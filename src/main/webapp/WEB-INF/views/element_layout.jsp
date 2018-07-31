<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath()+"/";;
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <style>
        .el-row {
            margin-bottom: 20px;
        }

        .el-row:last-child {
            margin-bottom: 0;
        }

        .el-col {
            border-radius: 4px;
        }

        .bg-purple-dark {
            background: #99a9bf;
        }

        .bg-purple {
            background: #d3dce6;
        }

        .bg-purple-light {
            background: #e5e9f2;
        }

        .grid-content {
            border-radius: 4px;
            min-height: 36px;
        }

        .row-bg {
            padding: 10px 0;
            background-color: #f9fafc;
        }

        .el-header, .el-footer {
            /*background-color: #B3C0D1;*/
            /*color: #333;*/
            text-align: center;
            line-height: 60px;
        }

        /*.el-aside {*/
        /*background-color: #D3DCE6;*/
        /*color: #333;*/
        /*text-align: center;*/
        /*line-height: 200px;*/
        /*}*/

        .el-main {
            /*background-color: #E9EEF3;*/
            /*color: #333;*/
            text-align: center;
            line-height: 160px;
        }

        .el-carousel__item h3 {
            color: #475669;
            font-size: 14px;
            opacity: 0.75;
            line-height: 200px;
            margin: 0;
        }

        .el-carousel__item:nth-child(2n) {
            background-color: #99a9bf;
        }

        .el-carousel__item:nth-child(2n+1) {
            background-color: #d3dce6;
        }

        /*选项卡*/
        .time {
            font-size: 13px;
            color: #999;
        }

        .bottom {
            margin-top: 13px;
            line-height: 12px;
        }

        .button {
            padding: 0;
            float: right;
        }

        .image {
            width: 100%;
            display: block;
        }

        .clearfix:before,
        .clearfix:after {
            display: table;
            content: "";
        }

        .clearfix:after {
            clear: both
        }
    </style>
</head>
<body>
<%--<div id="app">--%>
<%--布局--%>
<%--<el-row>--%>
<%--<el-col :span="12">--%>
<%--<div class="grid-content bg-purple"></div>--%>
<%--</el-col>--%>
<%--<el-col :span="12">--%>
<%--<div class="grid-content bg-purple-light"></div>--%>
<%--</el-col>--%>
<%--</el-row>--%>
<%--</div>--%>

<div id="app4">
    <el-carousel :interval="4000" type="card" height="200px">
        <el-carousel-item v-for="item in 6" :key="item">
            <h3>{{ item }}</h3>
        </el-carousel-item>
    </el-carousel>
</div>
<el-container id="app2">
    <el-header class="bg-purple" style="background-color:#20a0ff;">Header</el-header>
    <el-container>
        <el-aside width="200px" class="bg-purple">
            <%--导航--%>
            <el-menu
                    default-active="2"
                    class="el-menu-vertical-demo"
                    <%--@open="handleOpen"--%>
                    <%--@close="handleClose"--%>
                    background-color="#eef1f6"
                    text-color="#545c64"
                    active-text-color="#ffd04b">
                <el-submenu index="1">
                    <template slot="title">
                        <i class="el-icon-location"></i>
                        <span>导航一</span>
                    </template>
                    <el-submenu index="1-1">
                        <template slot="title">分组一</template>
                        <el-menu-item index="1-1">选项1</el-menu-item>
                        <el-menu-item index="1-2">选项2</el-menu-item>
                    </el-submenu>
                    <%--<el-menu-item-group title="分组2">--%>
                    <%--<el-menu-item index="1-3">选项3</el-menu-item>--%>
                    <%--</el-menu-item-group>--%>
                    <el-submenu index="1-3">
                        <template slot="title">分组二</template>
                        <el-menu-item index="1-3-1">选项1</el-menu-item>
                        <el-menu-item index="1-3-2">选项2</el-menu-item>
                    </el-submenu>
                    <el-submenu index="1-4">
                        <template slot="title">选项4</template>
                        <el-menu-item index="1-4-1">选项1</el-menu-item>
                    </el-submenu>
                </el-submenu>
                <el-menu-item index="2">
                    <i class="el-icon-menu"></i>
                    <span slot="title">导航二</span>
                </el-menu-item>
                <el-menu-item index="3" disabled>
                    <i class="el-icon-document"></i>
                    <span slot="title">导航三</span>
                </el-menu-item>
                <el-menu-item index="4">
                    <i class="el-icon-setting"></i>
                    <span slot="title">导航四</span>
                </el-menu-item>
            </el-menu>
        </el-aside>
        <el-container>
            <el-main>
                <el-container>
                    <el-header>Header</el-header>
                    <el-main>
                        <el-table
                                :data="tableData"
                                style="width: 100%"
                                :default-sort="{prop: 'sid', order: 'descending'}"
                        >
                            <el-table-column
                                    prop="sid"
                                    label="编号"
                                    sortable
                                    width="180">
                            </el-table-column>
                            <el-table-column
                                    prop="sname"
                                    label="姓名"
                                    sortable
                                    width="180">
                            </el-table-column>
                            <el-table-column
                                    prop="age"
                                    label="年龄"
                                    sortable
                                    width="180">  <%--:formatter="formatter"--%>
                            </el-table-column>
                        </el-table>
                    </el-main>
                    <el-footer>
                        footer
                    </el-footer>
                </el-container>
            </el-main>
        </el-container>
    </el-container>
</el-container>

<br/>
<div id="app5">
    <el-row :gutter="10">
        <el-col :span="6" v-for="(o, index) in 4" :key="o">
            <el-card :body-style="{ padding: '0px' }">
                <img src="image/Vue.png" class="image">
                <div style="padding: 14px;">
                    <span>好吃的汉堡</span>
                    <div class="bottom clearfix">
                        <%--<time class="time">{{ currentDate }}</time>--%>
                        <el-button type="text" class="button"><a href="">操作按钮</a></el-button>
                    </div>
                </div>
            </el-card>
        </el-col>
    </el-row>
</div>

<div id="app6">
    <el-row :gutter="10">
        <el-col :xs="8" :sm="6" :md="4" :lg="3" :xl="1">
            <div class="grid-content bg-purple"></div>
        </el-col>
        <el-col :xs="4" :sm="6" :md="8" :lg="9" :xl="11">
            <div class="grid-content bg-purple-light"></div>
        </el-col>
        <el-col :xs="4" :sm="6" :md="8" :lg="9" :xl="11">
            <div class="grid-content bg-purple"></div>
        </el-col>
        <el-col :xs="8" :sm="6" :md="4" :lg="3" :xl="1">
            <div class="grid-content bg-purple-light"></div>
        </el-col>
    </el-row>
</div>


<script type=text/javascript src="js/jquery.js"></script>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>

<script type=text/javascript src="js/jquery.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    // new Vue({
    //     el: "#app"
    // })

    // new Vue({
    //     el: "#app2"
    // })

    var vm = new Vue({
        el: "#app2",
        data: {
            tableData: []
        },
        method: {

        },
        mounted: function () {
            var _this = this   //很重要！！
            axios.get('findalll')
                .then(function (res) {
                    console.log(res);
                    _this.tableData = res.data
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
    })

    new Vue({
        el: "#app4"
    })
    new Vue({
        el: "#app5"
    })
    new Vue({
        el: "#app6"
    })
</script>
</body>
</html>

<%--Vue可以总共分为8个阶段：--%>

<%--beforeCreate（创建前）,--%>

<%--created（创建后）,--%>

<%--beforeMount(载入前),--%>

<%--mounted（载入后）,--%>

<%--beforeUpdate（更新前）,--%>

<%--updated（更新后）,--%>

<%--beforeDestroy（销毁前）,--%>

<%--destroyed（销毁后）--%>
