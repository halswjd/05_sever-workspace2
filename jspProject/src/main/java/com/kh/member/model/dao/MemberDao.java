package com.kh.member.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.common.JDBCTemplate;
import com.kh.member.model.vo.Member;

public class MemberDao {
	
	private Properties prop = new Properties(); // 전역 선언
	
	public MemberDao() {
		// 기본생성자 => new MemberDao. 할때마다 쿼리 읽음
		String filePath = MemberDao.class.getResource("/db/sql/member-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Member loginMember(Connection conn, String userId, String userPwd) {
		// select문 => ResultSet 객체(한행만 조회될것) => Member 객체로 받자!
		Member m = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("loginMember");
		
		try {
			pstmt = conn.prepareStatement(sql); // 쿼리전달하면서 생성, sql == 미완성된 sql문
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery(); // 조회된 결과가 있다면 한행 조회 || 조회된 결과 없다면 하면 아무것도 안담김
			
			if(rset.next()) { // rset.next() == true 라는건 조회된 결과가 있다는건
				m = new Member(rset.getInt("user_no"), 
							   rset.getString("user_id"), 
							   rset.getString("user_pwd"), 
							   rset.getString("user_name"), 
							   rset.getString("phone"), 
							   rset.getString("email"), 
							   rset.getString("address"), 
							   rset.getString("interest"), 
							   rset.getDate("enroll_date"), 
							   rset.getDate("modify_date"), 
							   rset.getString("status"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return m;
		
	}

}
