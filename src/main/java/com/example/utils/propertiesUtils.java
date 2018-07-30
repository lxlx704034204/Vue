package com.example.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;


public class propertiesUtils {
	private static final Logger log = Logger.getLogger(propertiesUtils.class);
    private static Properties props;
    
    private synchronized static void loadProps(){
        log.debug("开始加载properties文件内容.......");
        props = new Properties();
        InputStream in = null;

        try {
        	//第一种，通过类加载器进行获取properties文件流
            in = propertiesUtils.class.getClassLoader().getResourceAsStream("jdbc.properties");
            //第二种，通过类进行获取properties文件流 
            //in = PropertyUtil.class.getResourceAsStream("/jdbc.properties");
            props.load(in);
        }catch (IOException e) {
            log.error("出现IOException");
        }catch (Exception e) {
           log.error("dbc.properties文件未找到！");
        }finally {
            try {
                if(null != in) {
                    in.close();
                }
            } catch (IOException e) {
                log.error("jdbc.properties文件流关闭出现异常");
            }
        }
        log.debug("加载properties文件内容完成...........");
        log.debug("properties文件内容：" + props);
    }

    //key
    public static String getProperty(String key){
        if(null == props) { // props.load(in),没有load()到信息
            loadProps();
        }
        return props.getProperty(key);
    }
    
    //key+默认值查询
    public static String getProperty(String key, String defaultValue) {
        if(null == props) {
            loadProps();
        }
        return props.getProperty(key, defaultValue);
    }

    //获取jdbcTemplate
    public static JdbcTemplate getJdbcTemplate() {
        //设置数据库信息
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setUrl(propertiesUtils.getProperty("url"));
        dataSource.setDriverClassName(propertiesUtils.getProperty("driverClassName"));
        dataSource.setUsername(propertiesUtils.getProperty("username"));
        dataSource.setPassword(propertiesUtils.getProperty("password"));

        //设置数据源
        JdbcTemplate jdbcTemplate= new JdbcTemplate(dataSource);
        return jdbcTemplate;
    }
}
