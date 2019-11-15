package db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * Create by 杨浩宇
 * Time: 2019/11/13
 *
 * 连接数据库
 */
public class SqlConnection {
//    private static final String URL = "jdbc:mysql://localhost:3306/security?characterEncoding=utf8&useSSL=true";
//    private static final String USER = "root";
//    private static final String PWD = "yhy123";
    private Connection con;
    private Statement stmt;
    private ResultSet rs;

    //方便使用，使用porperties文件配置数据库
    public Connection myConnection() {
        //Properties 是一个类：
        Properties prop = new Properties();
        InputStream in = SqlConnection.class.getClassLoader().getResourceAsStream("db.properties");//读取文件
        try {
            prop.load(in);//加载文件
        } catch (IOException e) {
            e.printStackTrace();
        }
        String userName = prop.getProperty("userName");
        String pwd = prop.getProperty("pwd");
        String url = prop.getProperty("url");
        String driver = prop.getProperty("driver");
        try {
            Class.forName(driver);// 驱动
            con = DriverManager.getConnection(url, userName, pwd);// 获取连接
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }catch (SQLException e) {
            e.printStackTrace();
        }

        return con;
    }

    //连接数据库
//    public Connection myConnection() {
//        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            con = DriverManager.getConnection(URL, USER, PWD);
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return con;
//    }

    public ResultSet select(String sql) throws SQLException {
        con = myConnection();
        if(con!=null){
//            try {
                stmt =con.createStatement();
                rs= stmt.executeQuery(sql);
//                request.setAttribute("error",null);
//            } catch (SQLException e) {
//                request.setAttribute("error",e.getMessage());
//                e.printStackTrace();
//            }
        }
        return rs;
    }

    public void update(String sql) throws SQLException {
        con = myConnection();
        if(con!=null){
            stmt =con.createStatement();
            stmt.executeUpdate(sql);
        }
    }

    public void insert(String sql) throws SQLException {
        con = myConnection();
        if(con!=null){
            stmt =con.createStatement();
            stmt.execute(sql);
        }
    }

    //关闭，释放资源
    public boolean colse() {
        if(rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if(stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if(con != null) {
                    try {
                        con.close();
                        return true;
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return false;
    }
}
