package com.example.dao;

import com.example.bean.Location;
import com.example.bean.Student;
import com.example.utils.LocalRowMapper;
import com.example.utils.propertiesUtils;
import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class LocationDao {
    private static final Logger log = Logger.getLogger(LocationDao.class);
    private static JdbcTemplate jdbcTemplate = propertiesUtils.getJdbcTemplate();//数据源

    //findall
    public List<Location> queryForList() {
        String sql = "select * from location";
        List<Location> list = jdbcTemplate.query(sql, new LocalRowMapper(Location.class));
        return list;
    }

    //add
    public static int insertData(Location location) {
        String sql = "insert into location values(?,?,?,?,?,?,?,?,?)";
        int rows = 0;
        try {
            rows = jdbcTemplate.update(sql,
                    location.getPlacename(),
                    location.getAddress(),
                    location.getProvince(),
                    location.getProvincecode(),
                    location.getCity(),
                    location.getCitycode(),
                    location.getDistrict(),
                    location.getDistrictcode(),
                    location.getLngandlat());
            System.out.println("插入行数："+rows);
            return rows;
        } catch (DataAccessException e) {
            e.printStackTrace();
            return -1;
        }

    }
}
