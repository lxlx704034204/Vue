package com.example.utils.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CyclicFindDao {
    public int findClient(String clientIP){
        Connection conn = null;
        int result = 0;
        try {
            conn = MysqlDBCon.getCon(); // 建立数据库连接
            String sql = "select * from client where clientIP = ? "; // insert
            // SQL语句
            PreparedStatement pstmt = conn.prepareStatement(sql); // 创建用户操作执行SQL语句的PreparedStatement对象
            pstmt.setString(1, clientIP);
            ResultSet rs = pstmt.executeQuery(); // 编译执行语句

            if(rs.next()){
                result = 1;
            }else{
                result = 0;
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

//    public int insertClient(Client c){
//        Connection conn = null;
//        int result = 0;
//        try {
//            conn = MysqlDBCon.getCon(); // 建立数据库连接
//            String sql = "insert into client(id,clientIP) values(0,?)"; // insert
//            // SQL语句
//            PreparedStatement pstmt = conn.prepareStatement(sql); // 创建用户操作执行SQL语句的PreparedStatement对象
//            pstmt.setString(1, c.getClientIP());
//            result = pstmt.executeUpdate(); // 编译执行语句
//
//            pstmt.close();
//            conn.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return result;
//    }

    public List findCommand(){
        Connection conn = null;
        List list = new ArrayList();
        try {
            conn = MysqlDBCon.getCon(); // 建立数据库连接
            String sql = "select * from command where status = 'done' order by id desc limit 1 ";
            // SQL语句
            PreparedStatement pstmt = conn.prepareStatement(sql); // 创建用户操作执行SQL语句的PreparedStatement对象
            ResultSet rs = pstmt.executeQuery(); // 编译执行语句

            if(rs.next()){
                int id = rs.getInt("id");
                String commandID = rs.getString("commandID");
                String msg = rs.getString("msg");
                String status = rs.getString("status");
                String clientIp = rs.getString("clientIp");
                //System.out.println(id+","+commandID+","+msg+","+status+","+clientIp);
                list.add(id);
                list.add(commandID);
                list.add(msg);
                list.add(status);
                list.add(clientIp);
            }else{
                list = null;
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int updateCommand(int id){
        Connection conn = null;
        int result = 0;
        try {
            conn = MysqlDBCon.getCon(); // 建立数据库连接
            String sql = "update command set status = 'finsh' where id = ?"; // insert
            // SQL语句
            PreparedStatement pstmt = conn.prepareStatement(sql); // 创建用户操作执行SQL语句的PreparedStatement对象
            pstmt.setInt(1, id);
            result = pstmt.executeUpdate(); // 编译执行语句

            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
