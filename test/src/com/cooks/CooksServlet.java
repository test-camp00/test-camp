package com.cooks;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/cooks/*")
public class CooksServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		CooksDAO dao = new CooksDAO();
		MyUtil util = new MyUtil();
		HttpSession session = req.getSession();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "photo";
		File f = new File(pathname);
		if (!f.exists()) {
			f.mkdirs();
		}

		if (uri.indexOf("cook.do") != -1) {

			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null)
				current_page = Integer.parseInt(page);

			String btnKey = req.getParameter("cookbtn");			
			if (btnKey == null || btnKey.equals("")) {
				btnKey = "����";
			}
						

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			if (searchKey == null) {
				searchKey = "cookCode";
				searchValue = "";
			}

			if (req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue, "utf-8");
			}

			int dataCount;
			if (searchValue.length() == 0)
				dataCount = dao.dataCount(btnKey);
			else
				dataCount = dao.dataCount(searchKey, searchValue, btnKey);

			int numPerPage = 10;
			int total_page = util.pageCount(numPerPage, dataCount);

			if (current_page > total_page)
				current_page = total_page;

			int start = (current_page - 1) * numPerPage + 1;
			int end = current_page * numPerPage;

			List<CooksDTO> list = null;
			if (searchValue.length() == 0)
				list = dao.listCooks(start, end, btnKey);
			else
				list = dao.listCooks(start, end, searchKey, searchValue, btnKey);

			// ����Ʈ �۹�ȣ �����
			int listNum, n = 0;
			Iterator<CooksDTO> it = list.iterator();
			while (it.hasNext()) {
				CooksDTO dto = it.next();
				listNum = dataCount - (start + n - 1);
				dto.setListNum(listNum);
				dto.setWantedCount(dao.wantedCount(dto.getNum()));
				n++;
			}

			String params = "";
			if (searchValue.length() != 0) {
				searchValue = URLEncoder.encode(searchValue, "utf-8");
				params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
			}

			String listUrl = cp + "/cooks/cook.do";
			String articleUrl = cp + "/cooks/cook_article.do?page=" + current_page + "&btnKey=" + btnKey;
			if (params.length() != 0) {
				listUrl += "?" + params;
				articleUrl += "&" + params;
			}

			String paging = util.paging(current_page, total_page, listUrl);

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("paging", paging);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("btnKey", btnKey);

			String path = "/WEB-INF/views/cooks/cook.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("cook_created.do") != -1) {
			req.setAttribute("mode", "created");
			String path = "/WEB-INF/views/cooks/cook_created.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("cook_created_ok.do") != -1) {

			String encType = "utf-8";
			int maxSize = 5 * 1024 * 1024;
			MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType,
					new DefaultFileRenamePolicy());
			File file = mreq.getFile("upload");

			CooksDTO dto = new CooksDTO();

			dto.setCookCode(mreq.getParameter("cookCode"));
			dto.setCookName(mreq.getParameter("cookName"));
			dto.setName(mreq.getParameter("name"));
			dto.setWays(mreq.getParameter("ways"));
			dto.setMemo(mreq.getParameter("memo"));
			dto.setCookplay(mreq.getParameter("cookplay"));

			if (file != null) {
				String saveFilename = mreq.getFilesystemName("upload");
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				dto.setFileName(saveFilename);
			}
			dao.insertCook(dto);

			resp.sendRedirect(cp + "/cooks/cook.do");

		} else if (uri.indexOf("cook_article.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));
			String page = req.getParameter("page");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			String btnKey = req.getParameter("btnKey");
			if (searchKey == null) {
				searchKey = "cookCode";
				searchValue = "";
			}
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
			btnKey = URLDecoder.decode(btnKey, "UTF-8");

			CooksDTO dto = dao.readCook(num);
			if (dto == null) {
				resp.sendRedirect(cp + "/cooks/cook.do?page=" + page + "&btnKey="+btnKey);
				return;
			}

			dto.setMemo(dto.getMemo().replaceAll("\n", "<br>"));

			int wanted = dao.wantedCount(num);
			
			String params = "page=" + page + "&btnKey=" + URLEncoder.encode(btnKey, "utf-8");
			if (searchValue.length() != 0) {
				params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("params", params);
			req.setAttribute("wanted", wanted);

			String path = "/WEB-INF/views/cooks/cook_article.jsp";
			forward(req, resp, path);
		} else if (uri.indexOf("cook_update.do") != -1) {
			req.setAttribute("mode", "update");

			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));

			CooksDTO dto = dao.readCook(num);
			if (dto == null) {
				resp.sendRedirect(cp + "/cooks/cook.do?page=" + page);
				return;
			}
			
			if (!info.getUserId().equals("admin")) {
				resp.sendRedirect(cp + "/board/list.do?page=" + page);
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");

			String path = "/WEB-INF/views/cooks/cook_created.jsp";
			forward(req, resp, path);
		} else if (uri.indexOf("cook_update_ok.do") != -1) {
			String encType = "utf-8";
			int maxSize = 5 * 1024 * 1024;
			MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType,
					new DefaultFileRenamePolicy());
			File file = mreq.getFile("upload");

			CooksDTO dto = new CooksDTO();
			String fileName=mreq.getParameter("filename");
			int page = Integer.parseInt(mreq.getParameter("page"));
			
			dto.setNum(Integer.parseInt(mreq.getParameter("num")));
			dto.setCookCode(mreq.getParameter("cookCode"));
			dto.setCookName(mreq.getParameter("cookName"));
			dto.setName(mreq.getParameter("name"));
			dto.setWays(mreq.getParameter("ways"));
			dto.setMemo(mreq.getParameter("memo"));
			dto.setCookplay(mreq.getParameter("cookplay"));
			
			
			if (file != null) {
				FileManager.doFiledelete(pathname, fileName);
				String saveFilename = mreq.getFilesystemName("upload");
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				dto.setFileName(saveFilename);
			} else {
				dto.setFileName(fileName);
			}
			
			dao.updateCook(dto);

			resp.sendRedirect(cp + "/cooks/cook.do?page=" + page);

		} else if(uri.indexOf("cook_delete.do")!=-1) {
			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			
			CooksDTO dto= dao.readCook(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/cooks/cook.do?page="+page);	
				return;
			}
			if(!info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/cooks/cook.do?page="+page);	
				return;
			}
			FileManager.doFiledelete(pathname, dto.getFileName());
			dao.deleteCook(num);
			resp.sendRedirect(cp+"/cooks/cook.do?page="+page);		
			
		} else if(uri.indexOf("insertReply.do")!=-1) {
			String state="true";
			if (info == null) { // �α��ε��� ���� ���
				state="loginFail";
			} else {
				int num = Integer.parseInt(req.getParameter("num"));
				ReplyDTO rdto = new ReplyDTO();
				rdto.setNum(num);
				rdto.setUserId(info.getUserId());
				rdto.setContent(req.getParameter("content"));

				int result=dao.insertReply(rdto);
				if(result==0)
					state="false";
			}

			StringBuffer sb=new StringBuffer();
			sb.append("{");
			sb.append("\"state\":"+"\""+state+"\"");
			sb.append("}");
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.println(sb.toString());
		} else if (uri.indexOf("listReply.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if (pageNo != null)
				current_page = Integer.parseInt(pageNo);

			int numPerPage = 5;
			int total_page = 0;
			int dataCount = 0;

			dataCount = dao.dataCountReply(num);
			total_page = util.pageCount(numPerPage, dataCount);
			if (current_page > total_page)
				current_page = total_page;

			int start = (current_page - 1) * numPerPage + 1;
			int end = current_page * numPerPage;

			List<ReplyDTO> list = dao.listReply(num, start, end);

			Iterator<ReplyDTO> it = list.iterator();
			while (it.hasNext()) {
				ReplyDTO dto = it.next();
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			String paging = util.paging(current_page, total_page);

			req.setAttribute("list", list);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);

			String path = "/WEB-INF/views/cooks/listReply.jsp";
			forward(req, resp, path);
		} else if (uri.indexOf("deleteReply.do") != -1) {
			int replyNum = Integer.parseInt(req.getParameter("replyNum"));
			String userId=req.getParameter("userId");
			
			String state="false";
			if (info == null) { // �α��ε��� ���� ���
				state="loginFail";
			} else if(info.getUserId().equals("admin") || info.getUserId().equals(userId)) {
				dao.deleteReply(replyNum);
				state="true";
			}
			StringBuffer sb=new StringBuffer();
			sb.append("{");
			sb.append("\"state\":"+"\""+state+"\"");
			sb.append("}");
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out=resp.getWriter();
			out.println(sb.toString());
		} else if (uri.indexOf("wanted.do")!=-1) {
			int num=Integer.parseInt(req.getParameter("num"));
			String userId=info.getUserId();
			String page = req.getParameter("page");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			String btnKey = req.getParameter("btnKey");
			
			if (searchKey == null) {
				searchKey = "cookCode";
				searchValue = "";
			}
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
			btnKey = URLDecoder.decode(btnKey, "UTF-8");


			String params = "page=" + page + "&btnKey=" + URLEncoder.encode(btnKey, "utf-8");
			if (searchValue.length() != 0) {
				params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
			}
			
			WantedDTO dto=new WantedDTO();
			dto.setNum(num);
			dto.setUserId(userId);
			dao.wanted(dto);
			resp.sendRedirect(cp+"/cooks/cook_article.do?"+params+"&num="+num); 
			
			
		}
	} 
}
