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
			// �˻�
						String searchKey = req.getParameter("searchKey");
						String searchValue = req.getParameter("searchValue");
						if (searchKey == null) {
							searchKey = "subject";
							searchValue = "";
						}
						// GET ����� ��� ���ڵ�
						if (req.getMethod().equalsIgnoreCase("GET")) {
							searchValue = URLDecoder.decode(searchValue, "utf-8");
						}

						// ��ü ������ ����
						int dataCount;
						if (searchValue.length() == 0)
							dataCount = dao.dataCount();
						else
							dataCount = dao.dataCount(searchKey, searchValue);

						// ��ü ������ ��
						int numPerPage = 10;
						int total_page = util.pageCount(numPerPage, dataCount);

						if (current_page > total_page)
							current_page = total_page;

						// �Խù� ������ ���۰� ��
						int start = (current_page - 1) * numPerPage + 1;
						int end = current_page * numPerPage;
						
						// �Խù� ��������
						List<FAQDTO> list = null;
						if (searchValue.length() == 0)
							list = dao.listFAQ(start, end);
						else
							list = dao.listFAQ(start, end, searchKey, searchValue);

						// ����Ʈ �۹�ȣ �����
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
							// �˻��� ��� �˻��� ���ڵ�
							searchValue = URLEncoder.encode(searchValue, "utf-8");
							params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
						}

						// ����¡ ó��
						String listUrl = cp + "/FAQ/list.do";
						String articleUrl = cp + "/FAQ/article.do?page=" + current_page;
						if (params.length() != 0) {
							listUrl += "?" + params;
							articleUrl += "&" + params;
						}

						String paging = util.paging(current_page, total_page, listUrl);

						// �������� JSP�� �ѱ� �Ӽ�
						req.setAttribute("list", list);
						req.setAttribute("page", current_page);
						req.setAttribute("total_page", total_page);
						req.setAttribute("dataCount", dataCount);
						req.setAttribute("paging", paging);
						req.setAttribute("articleUrl", articleUrl);
						
			forward(req, resp, "/WEB-INF/views/FAQ/list.jsp");
			
		} else if (uri.indexOf("created.do") != -1) {
			// �۾��� ��
			if (info == null) { // �α��ε��� ���� ���
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			req.setAttribute("mode", "created");			
			forward(req, resp, "/WEB-INF/views/FAQ/created.jsp");

		} else if (uri.indexOf("created_ok.do") != -1) {
			// �� ����
			if (info == null) { // �α��ε��� ���� ���
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			FAQDTO dto = new FAQDTO();
		
			// �Ķ����						
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			dao.insertFAQ(dto);

			resp.sendRedirect(cp + "/FAQ/list.do");
		
	} else if (uri.indexOf("article.do") != -1) {
		// �ۺ���
		if (info == null) { // �α��ε��� ���� ���
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		// �Ķ���� : num, page, [searchKey, searchValue]
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		
		// �Խù� ��������
		FAQDTO dto = dao.readFAQ(num);
		if (dto == null) { // �Խù��� ������ �ٽ� ����Ʈ��
			resp.sendRedirect(cp + "/FAQ/list.do?page=" + page);
			return;
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// ������ ������
		FAQDTO preReadDto = dao.preReadFAQ(dto.getNum(), searchKey, searchValue);
		FAQDTO nextReadDto = dao.nextReadFAQ(dto.getNum(), searchKey, searchValue);

		// ����Ʈ�� ������/�����ۿ��� ����� �Ķ����
		String params = "page=" + page;
		if (searchValue.length() != 0) {
			params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		// JSP�� ������ �Ӽ�
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("params", params);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);

		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);

		// ������		
		forward(req, resp, "/WEB-INF/views/FAQ/article.jsp");

		}else if (uri.indexOf("update.do") != -1) {
			// ���� ��
			if (info == null) { // �α��ε��� ���� ���
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
			// ���� �Ϸ�
			if (info == null) { // �α��ε��� ���� ���
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
			// ����
			if (info == null) { // �α��ε��� ���� ���
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
