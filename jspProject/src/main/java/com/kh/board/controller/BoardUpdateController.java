package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.bo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		// form 태그의  enctype의 속성값을 정확히 적었을 때 if문 탐
		if(ServletFileUpload.isMultipartContent(request)) {
			
			// 1_1. 전달되는 파일 용량 제한 (int maxSize)
			int maxSize = 10 * 1024 * 1024;  // 10mbyte
			
			// 1_2. 전달되는 파일을 저장시킬 서버의 폴더 물리적인 경로 (String savePath)
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/"); // board_upfiles 안에 저장 -> 마지막에 /
			
			// 2. 전달된 파일명 수정작업 후 서버에 업로드
			// HttpServletRequest request => MultipartRequest
//			MultipartRequest multiRequest = new MultipartRequest(request, 저장경로, 파일용량, 인코딩방식, 파일명변경객체);
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			// 위 코드 실행되는 순간 파일이 있으면 board_upfiles 폴더에 꽂힘
			
			
			// 3. 본격적으로 sql문 실행할 때 필요한 값 (요청시 전달값) 뽑아서 vo에 기록
			
			// >> 공통적으로 수행 : update board
			// 쿼리문을 보고 필요하 정보 뽑기
			int boardNo = Integer.parseInt(multiRequest.getParameter("bno"));
			String category = multiRequest.getParameter("category");
			String boardTitle = multiRequest.getParameter("title");
			String boardContent = multiRequest.getParameter("content");
			
			Board b = new Board();
			b.setBoardNo(boardNo);
			b.setCategory(category);
			b.setBoardTitle(boardTitle);
			b.setBoardContent(boardContent);
			
			Attachment at = null; // 처음에는 null로 초기화, 만약 넘어오는 새 첨부파일이 있으면 그때 생성
			if(multiRequest.getOriginalFileName("upfile") != null ) { // 새로 넘어온 첨부파일이 있을경우 => Attachment객체 생성
							// "upfile"에 해당되는 키값이 있다면 원본명을 반환하는 메소드
				at = new Attachment();
				at.setOriginName(multiRequest.getOriginalFileName("upfile"));
				at.setChangeName(multiRequest.getFilesystemName("upfile")); // upfile키 값을 가진 파일이 이 시스템에서 어떤 이름으로 저장돼있는 이름 반환
				at.setFilePath("resources/board_upfiles");
				
				// 애초에 글 쓸때 첨파가 없었으면 
				if(multiRequest.getParameter("originFileNo") != null) {
					// 기존에 이미 첨부파일이 있던 경우 => updateAttachment 쿼리문 (기존의 첨부파일 번호 필요)
					at.setFileNo(Integer.parseInt(multiRequest.getParameter("originFileNo")));
					
				}else {
					// 기존에 첨부파일이 없었을 경우 => insertNewAttachment 쿼리문 (현재 게시글 번호 필요)
					at.setRefBoardNo(boardNo);
					
				}
				
				// 새로 넘어온 첨부파일 없었다면 at는 null일꺼임
				
				int result = new BoardService().updateBoard(b, at);
				// 새로운 첨부파일이 x						 => b, null	 => Board Update만 하면됨
				// 새로운 첨부파일 o, 기존의 첨부파일 o			 => b, fileNo이 담긴 at  => Board Update, Attachment Update
				// 새로운 첨부파일 o, 기존의 첨부파일 x			 => b, refBoardBo가 담긴 at  => Board Update, Attachment Insert
				
				if(result > 0) { 
					// 성공 =?> /jsp/detail.bo?bno=해당게시글번호 url 재요청 => 기존에 봤었던 게시글상세조회 페이지
					request.getSession().setAttribute("alertMsg", "성공적으로 수정되었습니다.");
					response.sendRedirect(request.getContextPath() + "/detail.bo?bno=" + boardNo);
					
				}else { 
					// 실패
					request.setAttribute("errorMsg", "일반게시판 작성에 실패했습니다.");
					RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
					view.forward(request, response);
				}
				
			}
			
			
			
			
		}
	}
		

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
