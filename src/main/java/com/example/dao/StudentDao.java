package com.example.dao;

import com.alibaba.druid.support.json.JSONUtils;
import com.example.bean.Location;
import com.example.bean.Student;
import com.example.utils.LocalRowMapper;
import com.example.utils.propertiesUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentDao {

    private static final Logger log = Logger.getLogger(StudentDao.class);
    private static JdbcTemplate jdbcTemplate = propertiesUtils.getJdbcTemplate();//数据源

    //findall
    public List<Student> queryForList() {
        String sql = "select * from student order by createTime ";
        //第三个参数可以省略
        List<Student> list = jdbcTemplate.query(sql, new LocalRowMapper(Student.class));
        return list;
    }

    //findall + page
    public List<Student> queryForList2(int page,int pageSize) {
        String sql = "select * from student order by createTime ";
        List <Object> params=new ArrayList<Object>();
        if (page!=0 && pageSize!=0) {
            sql += "limit ?,? ";
            params.add((page-1)*pageSize);
            params.add(pageSize);
        }

        List<Student> list = jdbcTemplate.query(sql,params.toArray(),new LocalRowMapper(Student.class));
        return list;
    }

    //findall总数
    public int queryForList3() {
        String sql = "select count(*) from student";
        //第三个参数可以省略
        int count = jdbcTemplate.queryForObject(sql,Integer.class);
        return count;
    }

    //add
    public static int insertData(Student stu) {
        String sql = "insert into student values(?,?,?,CURRENT_TIMESTAMP)";
        int rows = 0;
        try {
            rows = jdbcTemplate.update(sql,
                    stu.getSid(),
                    stu.getSname(),
                    stu.getAge());
            System.out.println("插入行数：" + rows);
            return rows;
        } catch (DataAccessException e) {
            e.printStackTrace();
            return -1;
        }
    }
    //delete
    public static int deleteData(String sid) {
        String sql = "delete from student where sid = ?";
        int rows = jdbcTemplate.update(sql,sid);
        System.out.println("删除行数："+rows);
        return rows;
    }
    //update
    public static int updateData(Student stu) {
        String sql = "update student set sname = ? , age = ? where sid = ? ";
        int rows = jdbcTemplate.update(sql,stu.getSname(),stu.getAge(),stu.getSid());
        System.out.println("修改行数："+rows);
        return rows;
    }


    /**
     * 功能：查询返回单个对象
     * 步骤：新建LocalRowMapper类实现RowMapper接口，重写mapRow方法，指定返回Student对象
     */
    public static Student queryForObject(String id) {
        String sql = "select * from student where sid=?";
        Student stu = jdbcTemplate.queryForObject(sql, new LocalRowMapper<Student>(Student.class), id);
        log.info("查询结果："+stu);
        return stu;
    }
}
