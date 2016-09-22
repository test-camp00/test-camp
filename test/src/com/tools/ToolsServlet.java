package com.tools;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/tools/*")
public class ToolsServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		ToolsDAO dao = new ToolsDAO();
		MyUtil util = new MyUtil();
		HttpSession session = req.getSession();

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "photo";
		File f = new File(pathname);
		if (!f.exists()) {
			f.mkdirs();
		}

		if (uri.indexOf("tool.do") != -1) {

			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null)
				current_page = Integer.parseInt(page);
			
			String btnKey = req.getParameter("itembtn");
			if (btnKey == null) {
				btnKey= "텐트";
			}

			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			if (searchKey == null) {
				searchKey = "itemcode";
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

			List<ToolsDTO> list = null;
			if (searchValue.length() == 0)
				list = dao.listTools(start, end, btnKey);
			else
				list = dao.listTools(start, end, searchKey, searchValue, btnKey);

			// 리스트 글번호 만들기
			int listNum, n = 0;
			Iterator<ToolsDTO> it = list.iterator();
			while (it.hasNext()) {
				ToolsDTO dto = it.next();
				listNum = dataCount - (start + n - 1);
				dto.setListNum(listNum);
				n++;
			}

			String params = "";
			if (searchValue.length() != 0) {
				searchValue = URLEncoder.encode(searchValue, "utf-8");
				params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
			}

			String listUrl = cp + "/tools/tool.do";
			String articleUrl = cp + "/tools/tool_article.do?page=" + current_page +"&btnKey="+btnKey;
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

			String path = "/WEB-INF/views/tools/tool.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("tool_created.do") != -1) {
			req.setAttribute("mode", "created");
			String path = "/WEB-INF/views/tools/tool_created.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("tool_created_ok.do") != -1) {

			String encType = "utf-8";
			int maxSize = 5 * 1024 * 1024;
			MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType,
					new DefaultFileRenamePolicy());
			File file=mreq.getFile("upload");

			ToolsDTO dto = new ToolsDTO();

			dto.setItemCode(mreq.getParameter("itemCode"));
			dto.setItemName(mreq.getParameter("itemName"));
			dto.setName(mreq.getParameter("name"));
			dto.setMakesa(mreq.getParameter("makesa"));
			dto.setContent(mreq.getParameter("content"));

			if (file != null) {
				String saveFilename = mreq.getFilesystemName("upload");
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				dto.setFileName(saveFilename);
			}
			dao.insertTool(dto);

			resp.sendRedirect(cp + "/tools/tool.do");

		} else if (uri.indexOf("tool_article.do") != -1) {
			int num = Integer.parseInt(req.getParameter("num"));
			String page = req.getParameter("page");
			String searchKey = req.getParameter("searchKey");
			String searchValue = req.getParameter("searchValue");
			String btnKey = req.getParameter("btnKey");
			if(searchKey==null) {
				searchKey="itemcode";
				searchValue="";
			}
			searchValue=URLDecoder.decode(searchValue, "UTF-8");
			btnKey=URLDecoder.decode(btnKey, "UTF-8");
			
			ToolsDTO dto = dao.readTool(num);
			if(dto==null){ 
				resp.sendRedirect(cp+"/tools/tool.do?page="+page);
				return;
			}
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			String params="page="+page+"&btnKey="+btnKey;
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("params", params);
			
			String path = "/WEB-INF/views/tools/tool_article.jsp";
			forward(req, resp, path);
		}

	}

}
