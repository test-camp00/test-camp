package com.customer;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/customer/*")
public class CustomerServlet extends MyServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();

		// 로그인 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		// 파일을 저장할 경로(pathname)
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "customer";
		File f = new File(pathname);
		if (!f.exists())
			f.mkdirs();

		CustomerDAO dao = new CustomerDAO();
		MyUtil util = new MyUtil();

		if (uri.indexOf("list.do") != -1) {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null)
				current_page = Integer.parseInt(page);
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			if (searchKey == null) {
				searchKey = "subject";
				searchValue = "";
			}
			if (req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue, "utf-8");
			}
			
			int numPerPage=10;
			int dataCount, total_page;
			
			if(searchValue.length()!=0)
				dataCount= dao.dataCount(searchKey, searchValue);
			else
				dataCount= dao.dataCount();
			total_page=util.pageCount(numPerPage, dataCount);
			
			if(current_page>total_page)
				current_page=total_page;
			
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
			
			List<CustomerDTO> list;
			if(searchValue.length()!=0)
				list= dao.listCustomer(start, end, searchKey, searchValue);
			else
				list= dao.listCustomer(start, end);
			
			//공지글
			List<CustomerDTO> listNotice=null;
			listNotice = dao.listCustomer();
			Iterator<CustomerDTO> itNotice=listNotice.iterator();
			while (itNotice.hasNext()) {
				CustomerDTO dto=itNotice.next();
				dto.setCreated(dto.getCreated().substring(0, 10));
			}
			Date endDate = new Date();
	        long gap;
			//리스트 글번호 만들기
			int listNum, n=0;
			Iterator<CustomerDTO> it=list.iterator();
			while(it.hasNext()){
				CustomerDTO dto=it.next();
				listNum=dataCount-(start+n-1);
				dto.setListNum(listNum);
				try {
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date beginDate = formatter.parse(dto.getCreated());
	/*            
	            	// 날짜차이(일)
	            	gap=(endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60* 1000);
	            	dto.setGap(gap);
	*/
					// 날짜차이(시간)
					gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
					dto.setGap(gap);
				}catch(Exception e) {
				}
				dto.setCreated(dto.getCreated().substring(0,10));
				n++;
			}
			
			String params="";
			String listUrl;
			String articleUrl;
			
			if(searchValue.length()==0) {
				listUrl=cp+"/customer/list.do";
				articleUrl=cp+"/customer/article.do?page=" +current_page;
			} else {
				params="searchKey="+searchKey;
				params+="&searchValue="+URLEncoder.encode(searchValue,"utf-8");
				
				listUrl=cp+"/customer/list.do?"+params;
				articleUrl=cp+"/customer/article.do?page="+current_page+"&"+params;
			}
			
			String paging=util.paging(current_page, total_page, listUrl);
			req.setAttribute("list", list);
			req.setAttribute("listNotice", listNotice);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("paging", paging);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			
			String path="/WEB-INF/views/customer/list.jsp";
			forward(req, resp, path);
		}else if(uri.indexOf("created.do")!=-1) {
			if(info==null) {
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
			
						
						// 글쓰기 폼
		
						req.setAttribute("mode", "created");
						String path="/WEB-INF/views/customer/created.jsp";
						forward(req, resp, path);
	} else if(uri.indexOf("created_ok.do")!=-1) {
		// 글 저장
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
	
		String encType="utf-8";
		int maxFilesize=10*1024*1024;
		
	    MultipartRequest mreq=new MultipartRequest(
	    		req, pathname, maxFilesize, encType,
	    		new DefaultFileRenamePolicy()
	    		);
		
	    CustomerDTO dto=new CustomerDTO();
	    dto.setUserId(info.getUserId());
	    if(mreq.getParameter("notice")!=null)
	    	dto.setNotice(Integer.parseInt(mreq.getParameter("notice")));
	    dto.setSubject(mreq.getParameter("subject"));
	    dto.setContent(mreq.getParameter("content"));
	    
	    if(mreq.getFile("upload")!=null) {
	    	dto.setSaveFilename(mreq.getFilesystemName("upload"));
	    	dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
		    dto.setFileSize(mreq.getFile("upload").length());
		}
	    dao.insertCustomer(dto);
		
		resp.sendRedirect(cp+"/customer/list.do");
		
	} else if(uri.indexOf("article.do")!=-1){
		if(info==null) {
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		
		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchValue="";
		}
		searchValue=URLDecoder.decode(searchValue, "utf-8");
		
		// 조회수
		dao.updateHitCount(num);
		
		//게시물 가져오기 
		CustomerDTO dto=dao.readCustomer(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/customer/list.do?page="+page);
			return;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	/*	CustomerDTO preReadDto = dao.preReadCustomer(dto.getNum(), searchKey, searchValue);
		CustomerDTO nextReadDto = dao.nextReadCustomer(dto.getNum(), searchKey, searchValue);
		
*/
		String params="page="+page;
		if(searchValue.length()!=0) {
			params+="&searchKey="+searchKey;
			params+="&searchValue="+URLEncoder.encode(searchValue, "utf-8");
		}
		
		req.setAttribute("dto", dto);
	/*	req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);*/
		req.setAttribute("params", params);
		req.setAttribute("page", page);
		
		String path="/WEB-INF/views/customer/article.jsp";
		forward(req, resp, path);
	}
		
}
}
