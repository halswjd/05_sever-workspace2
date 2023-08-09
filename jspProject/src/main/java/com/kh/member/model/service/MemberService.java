package com.kh.member.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;

import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;

public class MemberService {
	
	public Member loginMember(String userId, String userPwd) {
		// Connection 객체 생성
		Connection conn = getConnection();
		Member m = new MemberDao().loginMember(conn, userId, userPwd);
		//			   -> MemberDao의 기본생성자 => 호출될때마다 쿼리문 읽는거임
		
		close(conn);
		
		return m;
	}
	
	public int insertMember(Member m) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().insertMember(conn, m);
		
		// DML문 => 트랜젝션 처리
		if(result > 0) { // insert 성공
			commit(conn);
		} else { // insert 실패
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}

}
