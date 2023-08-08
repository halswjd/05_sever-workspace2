package edu.kh.test.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.kh.test.user.model.service.UserService;
import edu.kh.test.user.model.vo.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/test.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
		int userAge = Integer.parseInt(request.getParameter("userAge"));
		
		User user = new UserService().loginTest(userId, userAge);
		
		if(user == null) {
//			System.out.println("조회안됨!!!!!");
			request.setAttribute("errorMsg", "로그인실패!!!");
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/searchFail.jsp");
			view.forward(request, response);
		}else {
//			System.out.println(user);
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
