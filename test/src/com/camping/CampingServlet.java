package com.camping;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;
@WebServlet("/camping/*")
public class CampingServlet  extends MyServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();

if(uri.indexOf("HowtoCamp.do")!=-1) 
			
			forward(req, resp, "/WEB-INF/views/camping/HowtoCamp.jsp");
	}

}

