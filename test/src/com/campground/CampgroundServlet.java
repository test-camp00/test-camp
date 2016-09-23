package com.campground;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

@WebServlet("/campground/*")
public class CampgroundServlet extends MyServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // ���ڵ� ��� ����
		
		CampgroundDAO dao=new CampgroundDAO();
		MyUtil util=new MyUtil();
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"
				+File.separator+"campground";
		File f=new File(pathname);
		if(!f.exists())
			f.mkdirs();
		
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		if(uri.indexOf("list.do")!=-1){
			// searchArea�� searchValue�� ���� null�� "" ���� ���� �߿�
			// �� ����Ʈ
			String page=req.getParameter("page");
			int current_page=1;
			if(page!=null)
				current_page=Integer.parseInt(page);
			
			// �˻�
			String searchArea=req.getParameter("searchArea");
			String searchValue=req.getParameter("searchValue");
			
			if(searchArea==null){
				searchArea="";
			}
			if(searchValue==null){
				searchValue="";
			}
			
			// ��ü ������ ����
			int dataCount;
			if(searchArea.equals("") && searchValue.length()==0)
				dataCount=dao.dataCount();
			else
				dataCount=dao.dataCount(searchArea, searchValue);
			
			// ��ü ������ ��
			int numPerPage=3;
			int total_page=util.pageCount(numPerPage, dataCount);
			
			if(current_page>total_page)
				current_page=total_page;
			
			// �Խù� ������ ���۰� ��
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
			
			List<CampgroundDTO> list=null;
			if(searchArea.equals("") && searchValue.length()==0){
				list=dao.listBoard(start, end);
			} else{
				list=dao.listBoard(start, end, searchArea, searchValue);
			}
				
			String params="";
			if(searchValue.length()!=0){
				params+="searchArea="+searchArea+
						"&searchValue"+URLEncoder.encode(searchValue, "UTF-8");
			}
			
			String listUrl=cp+"/campground/list.do";
			String articleUrl=cp+"/campground/article.do?page="+current_page;
			
			if(params.length()!=0){
				listUrl+="?"+params;
				articleUrl+="&"+params;
			}
			
			String paging=util.paging(current_page, total_page, listUrl);
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			
			forward(req, resp, "/WEB-INF/views/campground/list.jsp");
			
		} else if(uri.indexOf("created.do")!=-1){
			// �� ����
			if(info==null||!info.getUserId().equals("admin")){
				resp.sendRedirect(cp+"/campground/list.do");
				return;
			}
			
			forward(req, resp, "/WEB-INF/views/campground/created.jsp");
			
		} else if(uri.indexOf("created_ok.do")!=-1){
			// �� ���� �Ϸ�
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

			File file=mreq.getFile("upload");
			if (file != null) {
	            String saveFilename = mreq.getFilesystemName("upload");
	            saveFilename = FileManager.doFilerename(pathname, saveFilename);
	            dto.setFilename(saveFilename);
	         }
			
			dao.insertCampground(dto);
			
			resp.sendRedirect(cp+"/campground/list.do");
		} else if(uri.indexOf("article.do")!=-1){
			// �� ����
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}
			searchValue=URLDecoder.decode(searchValue, 
					"UTF-8");
			
			// �Խù� ��������
			// �Խù� ���� ��� �������� ���ư���
			CampgroundDTO dto=dao.readBoard(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/bbs/list.do?page="+page);
				return;
			}
			
			dto.setMemo2(
					dto.getMemo2().replaceAll("\n", "<br>"));
			// �� ����Ʈ���� ����� �Ķ����
			String params="page="+page;
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey+
						"&searchValue="+URLEncoder.encode(
								searchValue, "utf-8");
			}
			
			// ������ jsp�� �ѱ� ������
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			// param�� el ������ ����ϸ� �ȵ�
			req.setAttribute("params", params);
			
			forward(req,resp,"/WEB-INF/views/campground/article.jsp");
		
		} else if(uri.indexOf("update.do")!=-1){
			// �����ϱ�
			if(info==null||!info.getUserId().equals("admin")){
				resp.sendRedirect(cp+"/campground/list.do");
				return;
			}
			
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			CampgroundDTO dto=dao.readBoard(num);
			if(dto==null){
				resp.sendRedirect(cp+"/campground/list.do?page="+page);
				return;
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req,resp,"/WEB-INF/views/campground/update.jsp");
		} else if(uri.indexOf("update_ok.do")!=-1){
			// �� �����Ϸ�
			String encType="UTF-8";
			int maxFilesize=5*1024*1024;
			
			MultipartRequest mreq=null;
			mreq=new MultipartRequest(
					req, pathname, maxFilesize, encType, 
					new DefaultFileRenamePolicy());
	        String fileName=mreq.getParameter("fileName");
	        File file=mreq.getFile("upload");
			
	        CampgroundDTO dto=new CampgroundDTO();
			int num=Integer.parseInt(mreq.getParameter("num"));
			dto.setNum(num);
			dto.setAreaName(mreq.getParameter("areaname"));
			dto.setPlaceName(mreq.getParameter("placename"));
			dto.setAddr(mreq.getParameter("addr"));
			dto.setTel(mreq.getParameter("tel"));
			dto.setMemo1(mreq.getParameter("memo1"));
			dto.setMemo2(mreq.getParameter("memo2"));
			
			if (file != null) {
				FileManager.doFiledelete(pathname, fileName); // ���� ������ �����ؾ���
	            String saveFilename = mreq.getFilesystemName("upload");
	            saveFilename = FileManager.doFilerename(pathname, saveFilename);
	            dto.setFilename(saveFilename);
	         } else {
	             dto.setFilename(fileName);
	         }
						
			dao.updateCampground(dto, num);
			String page=req.getParameter("page");
			
			resp.sendRedirect(cp+"/campground/article.do?num="+num+"&page="+page);
		} else if(uri.indexOf("delete.do")!=-1){
			if(info==null||!info.getUserId().equals("admin")){
				resp.sendRedirect(cp+"/campground/list.do");
				return;
			}
			
			int num=Integer.parseInt(req.getParameter("num"));
			dao.deleteCampground(num);
			String page=req.getParameter("page");
			
			resp.sendRedirect(cp+"/campground/list.do?page="+page);
		}
	}
}

