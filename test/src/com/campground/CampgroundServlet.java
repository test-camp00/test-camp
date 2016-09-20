package com.campground;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;

@WebServlet("/campground/*")
public class CampgroundServlet extends MyServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // 인코딩 방식 설정
		// HttpSession session=req.getSession(); // 로그인 정보를 받아오기 위한 세션
		// SessionInfo info=(SessionInfo)session.getAttribute("member");
		CampgroundDAO dao=new CampgroundDAO();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("?");
		String pathname=root+File.separator+"uploads"
				+File.separator+"campground";
		File f=new File(pathname);
		if(!f.exists())
			f.mkdirs();
		
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		if(uri.indexOf("list.do")!=-1){
			forward(req, resp, "/WEB-INF/views/campground/list.jsp");
		} else if(uri.indexOf("created.do")!=-1){
			forward(req, resp, "/WEB-INF/views/campground/created.jsp");
		} else if(uri.indexOf("created_ok.do")!=-1){
			if(info==null||!info.getUserId().equals("admin")){
				resp.sendRedirect(cp+"/campground/list.do");
				return;
			}
			
			CampgroundDTO dto=new CampgroundDTO();
			String encType="UTF-8";
			int maxFilesize=5*1024*1024;
			
			MultipartRequest mreq=null;
			mreq=new MultipartRequest(
					req, pathname, maxFilesize, encType, 
					new DefaultFileRenamePolicy());
			
			dto.setPlaceName(mreq.getParameter("placename"));
			dto.setAreaName(mreq.getParameter("areaname"));
			dto.setAddr(mreq.getParameter("addr"));
			dto.setTel(mreq.getParameter("tel"));
			dto.setMemo1(mreq.getParameter("memo1"));
			dto.setMemo2(mreq.getParameter("memo2"));
			
			dao.insertCampground(dto);
			
			resp.sendRedirect(cp+"/campground/list.do");
		} else if(uri.indexOf("article.do")!=-1){
			forward(req, resp, "/WEB-INF/views/campground/article.jsp");
		}
		
	}
}

