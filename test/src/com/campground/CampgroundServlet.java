package com.campground;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpSession;

import com.util.MyServlet;

@WebServlet("/campground/*")
public class CampgroundServlet extends MyServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // ���ڵ� ��� ����
		// HttpSession session=req.getSession(); // �α��� ������ �޾ƿ��� ���� ����
		// SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		if(uri.indexOf("list.do")!=-1){
			forward(req, resp, "/WEB-INF/views/campground/list.jsp");
		}
		
	}

}
