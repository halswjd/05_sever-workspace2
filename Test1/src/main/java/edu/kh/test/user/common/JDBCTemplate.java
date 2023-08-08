package edu.kh.test.user.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	
	
	// 1. 커넥션
	public static Connection getConnection() {
		
		Connection conn = null;
		
		Properties prop = new Properties();
		
		String filePath = JDBCTemplate.class.getResource("/db/driver/driver.properties").getPath();

		try {
			prop.load(new FileInputStream(filePath));
			
			// 1. 클래스 파일로 등록
			Class.forName(prop.getProperty("driver"));
			//Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2. 커넥션 객체 생성 (url, 계정명, 비번) => DriverManager
			conn = DriverManager.getConnection(prop.getProperty("url"), prop.getProperty("username"), prop.getProperty("password"));
//			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "test", "test");
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	// 2. 반납
	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Statement stmt) {
		try {
			if(stmt != null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
