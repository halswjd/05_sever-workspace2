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
	
	public Member updateMember(Member m) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().updateMember(conn, m);
		
		Member updateMember = null;
		
		if(result > 0) { // 성공
			commit(conn);
			
			// 갱신된 회원 객체 다시 조회 해오기
			updateMember = new MemberDao().selectMember(conn, m.getUserId());
			
			
		}else { // 실패
			rollback(conn);
		}
		
		close(conn);
		
		return updateMember;
		// 반환은 여러개는 안됨 => 객체를 반환하자
	}
	
	public Member updatePwd(String userId, String userPwd, String updatePwd) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().updatePwd(conn, userId, userPwd, updatePwd);
		
		Member updateMember = null;
		
		if(result > 0) {
			commit(conn);
			
			// 갱신된 회원 객체 다시 조회해오기
			updateMember = new MemberDao().selectMember(conn, userId);
		} else {
			rollback(conn);
		}
		
		return updateMember;
	}
	
	
	public int deleteMember(String userId, String userPwd) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().deleteMember(conn, userId, userPwd);
		
		if(result > 0) { // 성공
			commit(conn);
			
		}else { // 실패
			rollback(conn);
		}
		
		return result;
	}
	

}
