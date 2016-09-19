package com.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/board/*")
public class boardServlet  extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		if(uri.indexOf("board_free.do")!=-1) {
			req.setAttribute("mode", "free");
			forward(req, resp, "/WEB-INF/views/board/list.jsp");
		}else if(uri.indexOf("board_trade.do")!=-1){
			req.setAttribute("mode", "trade");
			forward(req, resp, "/WEB-INF/views/board/list.jsp");
		}else if(uri.indexOf("board_trade.do")!=-1){
			req.setAttribute("mode", "trade");
			forward(req, resp, "/WEB-INF/views/board/list.jsp");
		}
	}
}
