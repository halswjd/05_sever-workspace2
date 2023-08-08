package edu.kh.test.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.kh.test.user.model.dao.UserDAO;
import edu.kh.test.user.model.service.UserService;
import edu.kh.test.user.model.vo.User;

/**
 * Servlet implementation class SelectUserServlet
 */
@WebServlet("/selectUser.do")
public class SelectUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1) 필요한 데이터 뽑기 (db에 필요한 데이터들!!)
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		// 2) 서비스 호출 및 결과받기
		User user = new UserService().selectUser(userNo);
		
		// 3) 응답화면 결정
		if(user == null) {
			request.setAttribute("errorMsg", "조회된 결과가 없습니다.");
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/searchFail.jsp");
			view.forward(request, response);
		}else {
			request.setAttribute("user", user);
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/searchSuccess.jsp");
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
