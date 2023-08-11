package com.kh.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.vo.Member;
import com.kh.notice.model.service.NoticeService;
import com.kh.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeInsertController
 */
@WebServlet("/insert.no")
public class NoticeInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 인코딩처리
		request.setCharacterEncoding("UTF-8");
		
		// 변수담기
		String noticeTitle = request.getParameter("title");
		String noticeContent = request.getParameter("content");
		
		// db에 insert 하려면 로그인한 회원 정보를 얻어내는 방법
		// 1. input type = "hidden" 으로 애초에 요청시 숨겨서 전달하기
		// 2. session에 담겨있는 loginMember를 활용하는 방법
		HttpSession session = request.getSession();
		int userNo = ((Member)session.getAttribute("loginMember")).getUserNo();
		// 관리자가 로그인 했을때만 작성하기가 되는 loginMember는 무조건 있음(로그인 안한 상태면 null임)
		
		Notice n = new Notice();
		n.setNoticeTitle(noticeTitle);
		n.setNoticeContent(noticeContent);
//		n.setNoticeWriter(userNo + "");
		n.setNoticeWriter(String.valueOf(userNo));
		
		int result = new NoticeService().insertNotice(n);
		
		if(result > 0) { // 성공 => alert 띄우면서 목록조회 화면으로 url 재요청(글목록은 봤던 페이지)
			session.setAttribute("alertMsg", "성공적으로 공지사항 등록되었습니다.");
			response.sendRedirect(request.getContextPath() + "/list.no");
		}else { // 실패 => 에러문구 담아서 에러페이지 포워딩
			request.setAttribute("errorMsg", "공지사항 작성에 실패했습니다.");
			RequestDispatcher view = request.getRequestDispatcher("views/common/errorPage.jsp");
			view.forward(request, response);
					
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
