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
    <style>
        /*el-table-column .th .cell{*/
            /*font-size:13px;*/
        /*max-height: 10px !important;overflow: auto !important;*/
        /*}*/
        el-table-column lable{
            font-size: 15px;
        }

        .el-table__header-wrapper table .has-gutter{
            font-size: 15px;
        }

        .el-form-item__content{
            margin-right: 100px;
        }

    </style>
</head>
<body>
<div id="app">
    <el-table
            :data="tableData"
    <%--highlight-current-row   &lt;%&ndash;实现单选&ndash;%&gt;--%>
    <%--@current-change="handleCurrentChange" &lt;%&ndash;管理选中时触发的事件，它会传入currentRow，oldCurrentRow&ndash;%&gt;--%>

            <%--:default-sort="{prop: 'sid', order: 'descending'}"  &lt;%&ndash;按sid倒序排列&ndash;%&gt;--%>
            stripe   <%--斑马条纹--%>
            border   <%--table边框--%>
            height="95%" <%--固定表头--%>
            style="width: 100%"
            <%--max-height="200px"  &lt;%&ndash;指定最大高度，超过，显示滚动条&ndash;%&gt;--%>

            <%--@select="selectone" &lt;%&ndash;勾选框&ndash;%&gt;--%>
            <%--@selet-all="selectall"--%>
            size="mini"
            row-style="font-size:13px"
            cell-style="padding:1px"
    >
        <%--<el-table-column type="selection" width="50"> </el-table-column>--%>

        <%--单独增加一列，显示索引--%>
        <el-table-column type="index" width="50px"></el-table-column>

        <el-table-column prop="sid" label="编号" width="80"> <%--sortable--%>
            <%--通过 Scoped slot 可以获取到 row, column, $index 和 store（table 内部的状态管理）的数据--%>
            <template slot-scope="scope">
                <%--<i class="el-icon-time"></i>--%>
                <span style="margin-left: 10px">{{ scope.row.sid }}</span>
            </template>
        </el-table-column>

        <%--多级表头--%>
        <%--<el-table-column label="学生信息" width="360">--%>
        <%--</el-table-column>--%>
        <el-table-column prop="sname" label="姓名" width="100">
            <template slot-scope="scope">
                <el-popover trigger="hover" placement="top">
                    <p>年龄: {{ scope.row.age }}</p>
                    <div slot="reference" class="name-wrapper">
                        <el-tag size="medium">{{ scope.row.sname }}</el-tag>
                    </div>
                </el-popover>
            </template>
        </el-table-column>
        <el-table-column prop="age" label="年龄" width="100"></el-table-column>

        <el-table-column label="操作">
            <template slot-scope="scope">
                <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button size="mini" @click="handleDelete(scope.$index, scope.row)" >删除</el-button>
            </template>
        </el-table-column>
    </el-table>
    <!--分页-->
    <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="pageSizes"
            :page-size="pageSize"
            layout="prev, pager, next, jumper, sizes, total"
            :total="totalPage">
    </el-pagination>
    <el-button size="mini" @click="add()" :plain="true">添加</el-button>

    <el-dialog title="添加学生" :visible.sync="dialogFormVisible">
        <el-form size="mini">
            <el-form-item label="学生ID" :label-width="formLabelWidth">
                <el-input id="sid" v-model="sid"></el-input>
            </el-form-item>
            <el-form-item label="学生名称" :label-width="formLabelWidth">
                <el-input id="sname" v-model="sname"></el-input>
            </el-form-item>
            <el-form-item label="学生年龄" :label-width="formLabelWidth">
                <el-input id="age" v-model="age"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取消</el-button>
            <el-button type="primary" @click="handleAdd()">提交</el-button>
        </div>
    </el-dialog>

    <el-dialog title="修改学生" :visible.sync="dialogFormVisible1">
        <el-form size="mini">
            <el-form-item label="学生ID" :label-width="formLabelWidth">
                <el-input id="sid1" v-model="sid1" disabled ></el-input>
            </el-form-item>
            <el-form-item label="学生名称" :label-width="formLabelWidth">
                <el-input id="sname1" v-model="sname1"></el-input>
            </el-form-item>
            <el-form-item label="学生年龄" :label-width="formLabelWidth">
                <el-input id="age1" v-model="age1"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible1 = false">取消</el-button>
            <el-button type="primary" @click="handleUpdate()">修改</el-button>
        </div>
    </el-dialog>

</div>

<script type=text/javascript src="js/jquery.js"></script>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>

    var v = new Vue({
        el: "#app",
        data: {
            formLabelWidth: '120px',
            //动态数据
            tableData: [],
            dialogFormVisible: false,
            dialogFormVisible1: false,
            sid:'',
            sname:'',
            age:'',
            sid1:'',
            sname1:'',
            age1:'',
            currentPage: 1,
            pageSize:5,
            pageSizes:[5, 10, 15, 20],
            totalPage:0
        },
        methods: {
            // formatter属性，它用于格式化指定列的值，接受一个Function，会传入两个参数：row和column，可以根据自己的需求进行处理。
            formatter(row, column) {
                return row.age;
            },
            add(){
                this.sid = '';
                this.sname = '';
                this.age = '';
                v.dialogFormVisible = true;
            },
            handleAdd() {
                if(this.sid == '' || this.sid == null){
                    v.$message({type:'warning',message:'sid不能为空!'});
                    return;
                }
                    axios.post('addstu', {
                        sid: this.sid,
                        sname: this.sname,
                        age: this.age
                    })
                        .then(function (res) {
                            if (res.data == 1) {
                                v.$message({type:'success',message:'添加成功!'});
                            }
                            v.dialogFormVisible = false;
                            send(v)
                        })
                        .catch(function (error) {
                            console.log(error);
                            v.dialogFormVisible = false;
                        });

            },
            handleDelete(index, row) {
                axios.post('deletestu', {
                    sid:row.sid
                }).then(function (res) {
                    if (res.data == 1) {
                        v.$message({type:'success',message:'删除成功!'});
                        send(v)
                    }
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            handleEdit(index, row) {
                this.sid1 = row.sid
                this.sname1 = row.sname
                this.age1 = row.age
                this.dialogFormVisible1 = true
            },
            handleUpdate(){
                axios.post('updatestu', {
                    sid: this.sid1,
                    sname: this.sname1,
                    age: this.age1,
                })
                    .then(function (res) {
                        if (res.data == 1) {
                            v.$message({type:'success',message:'修改成功!'});
                        }
                        v.dialogFormVisible1 = false;
                        send(v)
                    })
                    .catch(function (error) {
                        console.log(error);
                        v.dialogFormVisible1 = false;
                    });
            },
            selectone(selection, row) {
                var j = new Array();
                if (selection.length > 0) {
                    for (var i = 0; i < selection.length; i++) {
                        j[i] = selection[i].sid
                    }
                }
                console.log(j);  //选择的sid集合
                console.log(row);
            },
            selectall(selection) {
                console.log("111");
                console.log(selection);
            },
            handleSizeChange(val) {
                this.pageSize = val;
                console.log('每页 '+val+' 条');
                send(v)
            },
            handleCurrentChange(val) {
                this.currentPage = val;
                console.log('当前页: '+val);
                send(v)
            },

        },
        mounted: function () {
            var _this = this   //很重要！！
            send(_this)
        },
    })

    function send(_this) {
        //传参为数值时，必须先转为字符串，否则，后台会接受到带.0的数字
        var currentPage =  _this.currentPage+"";
        var pageSize =  _this.pageSize+"";
        console.log(currentPage+","+pageSize);

        // let params = new URLSearchParams();
        // params.append("page", "1");
        // params.append("pageSize", "10");

        axios.post('findalll2',{
            page:currentPage
            ,pageSize:pageSize
        })
            .then(function (res) {
                console.log(res);
                _this.tableData = res.data[0]
                _this.totalPage = res.data[1]
            })
            .catch(function (error) {
                console.log(error);
            });
    }

</script>
</body>
</html>


<%--
Vue生命周期可以总共分为8个阶段：

beforeCreate（创建前）,
created（创建后）,
beforeMount(载入前),
mounted（载入后）,
beforeUpdate（更新前）,
updated（更新后）,
beforeDestroy（销毁前）,
destroyed（销毁后）--%>
