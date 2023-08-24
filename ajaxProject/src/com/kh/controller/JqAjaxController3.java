package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.kh.model.vo.Member;

/**
 * Servlet implementation class JqAjaxController3
 */
@WebServlet("/jqAjax3.do")
public class JqAjaxController3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int userNo = Integer.parseInt(request.getParameter("no"));
		
		// Member m = new MemberService().selectMember(userNo);
		// 위의 Member 객체에 각 필드에 조회된 데이터들이 담겨있을거임
		Member m = new Member(1, "하조비", 10, "남"); // 조회된 데이터가 다음과 같다는 가정하에
		
		// response.getWriter().print(m/*.toString()*/); // vo객체를 곧바로 응답시 .toString()의 문자열이 응답
		
		// 객체 하나니까 JSONObject로 해보자 {key:value, key:value, ...} 에 직접담기
		/*
		JSONObject jObj = new JSONObject(); // {}
		jObj.put("userNo", m.getUserNo()); // {userNo:1}
		jObj.put("userName", m.getUserName()); // {userNo:1, userName:"하조비"}
		jObj.put("age", m.getAge()); // {userNo:1, userName:"하조비", age:10}
		jObj.put("gender", m.getGender()); // {userNo:1, userName:"하조비", age:10, gender:"남"}
		
		response.setContentType("application/json; charset=UTF-8"); // 인코딩처리
		response.getWriter().print(jObj);
		*/
		
		// 더 간단한 방법 : 위의 과정을 알아서 해주는 GSON 라이브러리 사용
		// GSON : Google JSON 
		response.setContentType("application/json; charset=UTf-8");
//		Gson gson = new Gson(); // Gson객체.toJson(응답할 자바객체, 응답할 스트림);
//		gson.toJson(m, response.getWriter());
		new Gson().toJson(m, response.getWriter()); 
		// Gson 은 응답할 자바객체가 JSONArray인지 JSONObject인지 판단해서 응답해줌
		// line(46~49)과정을 자동으로 필드값의 변수명을 키값으로 주고 값을 세팅함
		// => Gson을 이용해서 vo객체 하나만 응답시 JSONObject{key:value, key:value, ..} 형태로 만들어서 응답
		// 이때 key는 해당 vo객체의 필드명으로 알아서 세팅
		
		// 	  자바배열 또는 ArrayList로 응답시 JSONArray [value, vlaue, ..] 형태로 만들어서 응답
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
