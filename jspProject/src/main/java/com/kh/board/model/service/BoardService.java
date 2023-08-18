package com.kh.board.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.model.vo.PageInfo;

public class BoardService {
	
	public int selectListCount() {
		
		Connection conn = getConnection();
		
		int listCount = new BoardDao().selectListCount(conn);
		
		close(conn);
		
		return listCount;
	}

	public ArrayList<Board> selectList(PageInfo pi){
		Connection conn = getConnection();
		ArrayList<Board> list = new BoardDao().selectList(conn, pi);
		
		close(conn);
		
		return list;
	}
	
	public ArrayList<Category> selectCategoryList(){
		
		Connection conn = getConnection();
		
		ArrayList<Category> list = new BoardDao().selectCategoryList(conn);
		
		close(conn);
		
		return list;
	}
	
	public int insertBoard(Board b, Attachment at) {
		
		Connection conn = getConnection();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		
		int result2 = 1; // result1,2가 전부 1이여야 커밋되어야함
		// 근데 reulst2를 0으로 하면 if문 안타서 0임 => 커밋안됨
		
		if(at != null) {
			result2 = new BoardDao().insertAttachment(conn, at);
			
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
		// result1이 실패해서 0되면 0이 리턴됨
	}
	
	public int increaseCount(int boardNo) {
		
		Connection conn = getConnection();
		
		int result = new BoardDao().increaseCount(conn, boardNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}
	
	public Board selectBoard(int boardNo) {
		
		Connection conn = getConnection();
		
		Board b = new BoardDao().selectBoard(conn, boardNo);
		
		close(conn);
		
		return b;
	}
	
	public Attachment selectAttachment(int boardNo) {
		
		Connection conn = getConnection();
		
		Attachment at = new BoardDao().selectAttachment(conn, boardNo);
		
		close(conn);
		
		return at;
	}
}
