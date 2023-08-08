package edu.kh.test.user.model.service;

import java.sql.Connection;

import edu.kh.test.user.common.JDBCTemplate;
import edu.kh.test.user.model.dao.UserDAO;
import edu.kh.test.user.model.vo.User;

import static edu.kh.test.user.common.JDBCTemplate.*;

public class UserService {
	
	
	public User selectUser(int userNo) {
		
		// 1. 커넥션 객체 생성
		Connection conn = getConnection();
		
		// 2. dao 호출 및 결과받기 => conn도 보내야함!!
		User user = new UserDAO().selectUser(conn, userNo);
		
		// 3. 커넥션 객체 반납
		close(conn);
		
		return user;
		
	}
	
	public User loginTest(String userId, int userAge) {
		
		Connection conn = getConnection();
		
		User user = new UserDAO().loginTest(conn, userId, userAge);
		
		close(conn);
		
		return user;
	}
	
	
	
	
	
	


}
