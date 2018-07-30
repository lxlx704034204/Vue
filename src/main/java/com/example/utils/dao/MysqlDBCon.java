package com.example.utils.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class MysqlDBCon {
    private static Connection conn = null;

    public static Connection getCon() {
        try {
            //Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://192.168.175.1:3306/test?useUnicode=true&characterEncoding=UTF8";
            String user = "root";
            String pwd = "1234";

//            String url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=UTF8";
//            String user = "root";
//            String pwd = "1234";

            //先注释，使用时打开
//            String url = "jdbc:mysql://120.77.207.46:3306/zl?useUnicode=true&characterEncoding=UTF8";
//            String user = "root";
//            String pwd = "HaFerd.2133@8455";

//            String url = "jdbc:mysql://localhost:3306/zl?useUnicode=true&characterEncoding=UTF8";
//            String user = "root";
//            String pwd = "HaFerd.2133@8455";

            conn = DriverManager.getConnection(url, user, pwd);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
