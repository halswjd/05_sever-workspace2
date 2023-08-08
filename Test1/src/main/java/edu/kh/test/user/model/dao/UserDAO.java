package edu.kh.test.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import edu.kh.test.user.common.JDBCTemplate;
import edu.kh.test.user.model.vo.User;

public class UserDAO {
	
		
	public User selectUser(Connection conn, int userNo) {
		
		// select문 => ResultSet 객체 필요 => 한행조회 => User 객체에 담자!
		
		// 1) jdbc 객체 생성 + 필요한 객체(User) 생성
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		User user = null;
		
		// 2) sql 쿼리 작성
		String sql = "SELECT * FROM TB_USER WHERE USER_NO = ?";
		
		try {
			// 3) pstmt, rset 채워넣기
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery(); // 뭐라도 있거나 || null
			
			if(rset.next()) {
				user = new User(rset.getInt("user_no")
							  , rset.getString("user_id")
							  , rset.getString("user_name")
							  , rset.getInt("user_age"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return user;
		
	}
	
	public User loginTest(Connection conn, String userId, int userAge) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		User user = null;
		
		String sql = "SELECT * FROM TB_USER WHERE USER_ID = ? AND USER_AGE = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setInt(2, userAge);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				user = new User(rset.getInt("user_no")
							  , rset.getString("user_id")
							  , rset.getString("user_name")
							  , rset.getInt("user_age"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return user;
		
	}
	

}
