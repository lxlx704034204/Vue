package com.example.dao;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.example.bean.Student;
import com.example.utils.LocalRowMapper;
import com.example.utils.propertiesUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

public class JdbcTemplateDemo {
	
	private static final Logger log = Logger.getLogger(JdbcTemplateDemo.class);
	
	public static void main(String[] args) {

		//获取数据源
		 JdbcTemplate jdbcTemplate = propertiesUtils.getJdbcTemplate();
		
		//queryForList(jdbcTemplate);      //查询所有
		queryForObject(jdbcTemplate);    //查询单个
		//insertData(jdbcTemplate);        //添加
		//deleteData(jdbcTemplate);        //删除
		//updateData(jdbcTemplate);        //修改    
		//queryForMap(jdbcTemplate);       //查询一条，显示为map格式(key为列名，value为值)
		
		log.debug("打印日志");
	}
	
	/**
     * 功能：查询返回对象集合
     * 步骤：新建LocalRowMapper类实现RowMapper接口，重写mapRow方法，指定返回User对象
     */
    public static void queryForList(JdbcTemplate jdbcTemplate) {
        String sql = "select * from student";
        //第三个参数可以省略
        List<Student> students = jdbcTemplate.query(sql, new LocalRowMapper(Student.class));
        log.info(students);
    }
    
    /**
     * 功能：查询返回单个对象
     * 步骤：新建LocalRowMapper类实现RowMapper接口，重写mapRow方法，指定返回Student对象
     */
    public static void queryForObject(JdbcTemplate jdbcTemplate) {
    	String sql = "select * from student where sid=?";
    	Student stu = jdbcTemplate.queryForObject(sql, new LocalRowMapper<Student>(Student.class), "1");
    	System.out.println(stu);
    }
    
    /**
     * 插入数据
     */
    public static void insertData(JdbcTemplate jdbcTemplate) {
    	String sql = "insert into student values(?,?,?)";
    	int rows = jdbcTemplate.update(sql, 5,"李七",25);
    	System.out.println("插入行数："+rows);
    }
    
    /**
     * 删除数据
     */
    public static void deleteData(JdbcTemplate jdbcTemplate) {
    	String sql = "delete from student where sid<?";
    	int rows = jdbcTemplate.update(sql,3);
    	System.out.println("删除行数："+rows);
    }
    
    /**
     * 修改数据
     */
    public static void updateData(JdbcTemplate jdbcTemplate) {
    	String sql = "update student set sname = ? where sid=3 ";
    	int rows = jdbcTemplate.update(sql,"王五五");
    	System.out.println("修改行数："+rows);
    }
    
    /**
     * 查询一条记录
     * 
     * queryForMap方法返回的结果集大小必须是1 ！！！
     * 返回的map中，以列的名字作为key，获取的值作为value
     *  
     */
    public static void queryForMap(JdbcTemplate jdbcTemplate) {
    	String sql = "select * from student where sid=?";
    	Map<String, Object> map = jdbcTemplate.queryForMap(sql,3);
    	
    	for(Entry<String, Object> entity:map.entrySet()) {
    		System.out.println("key:"+entity.getKey()+",value:"+entity.getValue());
    	}
    }
}
