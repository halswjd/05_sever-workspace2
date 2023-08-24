package com.kh.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.kh.model.vo.Member;

/**
 * Servlet implementation class JqAjaxController4
 */
@WebServlet("/jqAjax4.do")
public class JqAjaxController4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController4() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ArrayList<Member> list = new MemberService().selectMemberList();
		ArrayList<Member> list = new ArrayList<Member>(); // []
		list.add(new Member(1, "하조비", 10, "남")); // [{}]
		// Member 객체 하나는 JSONObject
		list.add(new Member(2, "하호두", 5, "여"));
		list.add(new Member(3, "하꽃님", 13, "남"));
		// 객체 여러개가 담긴 [{}, {}, ..] => JSONArray
		// JSONArray [{}, {}, {}]
		
		/* 순수 JSON 방식
		JSONArray jArr = new JSONArray();
		for(Member m : list) {
			JSONObject jObj = new JSONObject();
			jObj.put("userNo", m.getUserNo());
			jObj.put("userName", m.getUserName());
			jObj.put("age", m.getAge());
			jObj.put("gender", m.getGender());
			// {} 객체 하나씩 만들어짐
			
			jArr.add(jObj); // []에 객체 담기 [{}]
		}
		 */
		
		// Gson 방식
		response.setContentType("application/json; charset=UTF-8");
		new Gson().toJson(list, response.getWriter()); // 이 코드 한줄로 위의 순수 JSON방식 과정을 알아서해줌
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
