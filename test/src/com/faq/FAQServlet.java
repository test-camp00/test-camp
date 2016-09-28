package com.faq;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/FAQ/*")
public class FAQServlet  extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		FAQDAO dao=new FAQDAO();
		MyUtil util=new MyUtil();
		
		if(uri.indexOf("list.do")!=-1) {
			
			String page =req.getParameter("page");
			int current_page=1;
			if(page!=null)
				current_page=Integer.parseInt(page);
			// 검색
						String searchKey = req.getParameter("searchKey");
						String searchValue = req.getParameter("searchValue");
						if (searchKey == null) {
							searchKey = "subject";
							searchValue = "";
						}
						// GET 방식인 경우 디코딩
						if (req.getMethod().equalsIgnoreCase("GET")) {
							searchValue = URLDecoder.decode(searchValue, "utf-8");
						}

						// 전체 데이터 개수
						int dataCount;
						if (searchValue.length() == 0)
							dataCount = dao.dataCount();
						else
							dataCount = dao.dataCount(searchKey, searchValue);

						// 전체 페이지 수
						int numPerPage = 10;
						int total_page = util.pageCount(numPerPage, dataCount);

						if (current_page > total_page)
							current_page = total_page;

						// 게시물 가져올 시작과 끝
						int start = (current_page - 1) * numPerPage + 1;
						int end = current_page * numPerPage;
						
						// 게시물 가져오기
						List<FAQDTO> list = null;
						if (searchValue.length() == 0)
							list = dao.listFAQ(start, end);
						else
							list = dao.listFAQ(start, end, searchKey, searchValue);

						// 리스트 글번호 만들기
						int listNum, n = 0;
						Iterator<FAQDTO> it = list.iterator();
						while (it.hasNext()) {
							FAQDTO dto = it.next();
							listNum = dataCount - (start + n - 1);
							dto.setListNum(listNum);
							n++;
						}

						String params = "";
						if (searchValue.length() != 0) {
							// 검색인 경우 검색값 인코딩
							searchValue = URLEncoder.encode(searchValue, "utf-8");
							params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
						}

						// 페이징 처리
						String listUrl = cp + "/FAQ/list.do";
						String articleUrl = cp + "/FAQ/article.do?page=" + current_page;
						if (params.length() != 0) {
							listUrl += "?" + params;
							articleUrl += "&" + params;
						}

						String paging = util.paging(current_page, total_page, listUrl);

						// 포워딩할 JSP로 넘길 속성
						req.setAttribute("list", list);
						req.setAttribute("page", current_page);
						req.setAttribute("total_page", total_page);
						req.setAttribute("dataCount", dataCount);
						req.setAttribute("paging", paging);
						req.setAttribute("articleUrl", articleUrl);
						
			forward(req, resp, "/WEB-INF/views/FAQ/list.jsp");
			
		} else if (uri.indexOf("created.do") != -1) {
			// 글쓰기 폼
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			req.setAttribute("mode", "created");			
			forward(req, resp, "/WEB-INF/views/FAQ/created.jsp");

		} else if (uri.indexOf("created_ok.do") != -1) {
			// 글 저장
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			FAQDTO dto = new FAQDTO();
		
			// 파라미터						
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dao.insertFAQ(dto);

			resp.sendRedirect(cp + "/FAQ/list.do");
		
	} else if (uri.indexOf("article.do") != -1) {
		// 글보기
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		// 파라미터 : num, page, [searchKey, searchValue]
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		
		// 게시물 가져오기
		FAQDTO dto = dao.readFAQ(num);
		if (dto == null) { // 게시물이 없으면 다시 리스트로
			resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
			return;
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전글 다음글
		FAQDTO preReadDto = dao.preReadFAQ(dto.getNum(), searchKey, searchValue);
		FAQDTO nextReadDto = dao.nextReadFAQ(dto.getNum(), searchKey, searchValue);

		// 리스트나 이전글/다음글에서 사용할 파라미터
		String params = "page=" + page;
		if (searchValue.length() != 0) {
			params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		// JSP로 전달할 속성
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("params", params);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);

		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);

		// 포워딩		
		forward(req, resp, "/WEB-INF/views/FAQ/article.jsp");

		}else if (uri.indexOf("update.do") != -1) {
			// 수정 폼
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			FAQDTO dto = dao.readFAQ(num);

			if (dto == null) {
				resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
				return;
			}			

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");
			
			forward(req, resp, "/WEB-INF/views/FAQ/created.jsp");
			
		} else if (uri.indexOf("update_ok.do") != -1) {
			// 수정 완료
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			String page = req.getParameter("page");

			if (req.getMethod().equalsIgnoreCase("GET")) {
				resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
				return;
			}

			FAQDTO dto = new FAQDTO();
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dao.updateFAQ(dto);

			resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);

		} else if (uri.indexOf("delete.do") != -1) {
			// 삭제
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			FAQDTO dto = dao.readFAQ(num);

			if (dto == null) {
				resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
				return;
			}
			
			dao.deleteFAQ(num);
			resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
		}
	}
}
