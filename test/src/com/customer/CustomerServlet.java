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
	
		HttpSession session = req.getSession();
		SessionInfo info= (SessionInfo)session.getAttribute("member");
		if(info==null){
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
			}

		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		CustomerDAO dao = new CustomerDAO();
		MyUtil util= new MyUtil();
		
		if(uri.indexOf("list.do")!=-1){
			String page= req.getParameter("page");
			int current_page=1;
			if(page!=null)
					current_page=Integer.parseInt(page);
			
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			if(searchKey==null){
				searchKey="subject";
				searchValue="";
			}
			
			if(req.getMethod().equalsIgnoreCase("GET")){
				searchValue=URLDecoder.decode(searchValue, "utf-8");
			}
			
			int dataCount;
			if(searchValue.length()==0){
				dataCount=dao.dataCount();
			}else
					dataCount=dao.dataCount(searchKey, searchValue);
				
			int numPerPage=10;
			int total_page=util.pageCount(numPerPage, dataCount);
			
			if(current_page>total_page)
				current_page=total_page;
			
			// 게시물 가져올 시작과 끝
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
			
			List<CustomerDTO> list=null;
			if(searchValue.length()==0)
				list=dao.listCustomer(start, end);
			else
				list=dao.listCustomer(start, end, searchKey, searchValue);
	        
			Date endDate = new Date();
	        long gap;
			
			int listNum, n=0;
			Iterator<CustomerDTO>it=list.iterator();
			while(it.hasNext()) {
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
	            
	            dto.setCreated(dto.getCreated().substring(0, 10));
				
				n++;
			}
			
			String params="";
			if(searchValue.length()!=0) {
				// 검색인 경우 검색값 인코딩
				searchValue=URLEncoder.encode(searchValue, "utf-8");
				params="searchKey="+searchKey+
						 "&searchValue="+searchValue;
			}
			
			String listUrl=cp+"/customer/list.do";
			String articleUrl=cp+"/customer/article.do?page="+current_page;
			if(params.length()!=0) {
				listUrl+="?"+params;
				articleUrl+="&"+params;
			}
			
			String paging=util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 JSP로 넘길 속성
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("paging", paging);
			req.setAttribute("articleUrl", articleUrl);
			
			forward(req, resp, "/WEB-INF/views/customer/list.jsp");

			}else if(uri.indexOf("created.do")!=-1) {
				// 글쓰기 폼
				
				req.setAttribute("mode", "created");
				forward(req, resp, "/WEB-INF/views/customer/created.jsp");
			}else if(uri.indexOf("created_ok.do")!=-1) {
				// 글 저장
				CustomerDTO dto=new CustomerDTO();
				
				dto.setUserId(info.getUserId());
				dto.setSubject(req.getParameter("subject"));
				dto.setContent(req.getParameter("content"));
				
				dao.insertCustomer(dto, "created");
				
				resp.sendRedirect(cp+"/customer/list.do");
			} else if(uri.indexOf("article.do")!=-1){
				
				//int groupNum=Integer.parseInt(req.getParameter("groupNum"));
				//int orderNo=Integer.parseInt(req.getParameter("orderNo"));
				int boardNum=Integer.parseInt(req.getParameter("boardNum"));
				String page=req.getParameter("page");
				String searchKey=req.getParameter("searchKey");
				String searchValue=req.getParameter("searchValue");
				
				if(searchKey==null) {
					searchKey="subject";
					searchValue="";
				}
				searchValue=URLDecoder.decode(searchValue, "UTF-8");
				
				dao.updateHitCount(boardNum);
			
				CustomerDTO dto=dao.readCustomer(boardNum);
				if(dto==null) {
					resp.sendRedirect(cp+"/customer/list.do?page="+page);
					return;
				}
				int linesu=dto.getContent().split("\n").length;
				dto.setContent(
						dto.getContent().replaceAll("\n", "<br>"));
				
				CustomerDTO preReadDTO=dao.preReadCustomer(
						dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
				CustomerDTO nextReadDTO=dao.nextReadCustomer(
						dto.getGroupNum(), dto.getOrderNo(), searchKey, searchValue);
				
				String params="page="+page;
				if(searchValue.length()!=0) {
					params+="&searchKey="+searchKey+
							"&searchValue="+URLEncoder.encode(
									searchValue, "utf-8");
				}
				
				req.setAttribute("dto", dto);
				req.setAttribute("page", page);
				req.setAttribute("preReadDTO", preReadDTO);
				req.setAttribute("nextReadDTO", nextReadDTO);
				req.setAttribute("linesu", linesu);
				req.setAttribute("params", params);
				forward(req, resp, "/WEB-INF/views/customer/article.jsp");
			}else if(uri.indexOf("reply.do")!=-1){
			
				int boardNum=Integer.parseInt(req.getParameter("boardNum"));
				String page=req.getParameter("page");
				
				CustomerDTO dto=dao.readCustomer(boardNum);
				if(dto==null){
					resp.sendRedirect(cp+"/customer/list.do?page="+page);
					return;
				}
				dto.setContent("["+dto.getSubject()+"]에 대한 답변입니다.");
				
				req.setAttribute("dto", dto);
				req.setAttribute("page", page);
				req.setAttribute("mode", "reply");
				forward(req, resp, "/WEB-INF/views/customer/created.jsp");
				
			}else if(uri.indexOf("reply_ok.do")!=-1){
				CustomerDTO dto=new CustomerDTO();
				dto.setUserId(info.getUserId());
				dto.setSubject(req.getParameter("subject"));
				dto.setContent(req.getParameter("content"));
				dto.setGroupNum(Integer.parseInt(req.getParameter("groupNum")));
				dto.setOrderNo(Integer.parseInt(req.getParameter("orderNo")));
				dto.setDepth(Integer.parseInt(req.getParameter("depth")));
				dto.setParent(Integer.parseInt(req.getParameter("parent")));
				String page=req.getParameter("page");
				
				dao.insertCustomer(dto, "reply");
				
				resp.sendRedirect(cp+"/customer/list.do?page="+page);
				
			}else if(uri.indexOf("update.do")!=-1){
				
				String page=req.getParameter("page");
				int boardNum=Integer.parseInt(req.getParameter("boardNum"));
				
				CustomerDTO dto=dao.readCustomer(boardNum);
				if(dto==null){
					resp.sendRedirect(cp+"/customer/list.do?page="+page);
					return;
				}
				
				if(!info.getUserId().equals(dto.getUserId())){
					resp.sendRedirect(cp+"/customer/list.do?page="+page);
					return;
				}
				
				req.setAttribute("dto", dto);
				req.setAttribute("page", page);	
				
				req.setAttribute("mode", "update");
				forward(req, resp, "/WEB-INF/views/customer/created.jsp");
				
			
			
			
		}else if(uri.indexOf("update_ok.do")!=-1){
			String page=req.getParameter("page");
			
			if(req.getMethod().equalsIgnoreCase("GET")){
				resp.sendRedirect(cp+"/customer/list.do?page="+page);
			}
			
			CustomerDTO dto= new CustomerDTO();
			dto.setBoardNum(Integer.parseInt(req.getParameter("boardNum")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			dao.updateCustomer(dto);
			resp.sendRedirect(cp+"/customer/list.do?page="+page);
			
			
		}else if(uri.indexOf("delete.do")!=-1){
			
			String page=req.getParameter("page");
			int boardNum = Integer.parseInt(req.getParameter("boardNum"));
			CustomerDTO dto=dao.readCustomer(boardNum);
			
			if(dto==null){
				resp.sendRedirect(cp+"/customer/list.do?page="+page);
				return;
			}
			
			if(!dto.getUserId().equals(info.getUserId())&&info.getUserId().equals("admin")){
		
				req.setAttribute("mode", "delete");
				forward(req, resp, "/WEB-INF/views/customer/list.jsp");
			}
			
			dao.deleteCustomer(boardNum);
			resp.sendRedirect(cp+"/customer/list.do?page="+page);
			
		}

		}
		}
