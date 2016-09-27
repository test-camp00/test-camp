package com.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.MyServlet;

@WebServlet("/member/*")
public class MemberServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		if (uri.indexOf("login.do") != -1) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
		} else if (uri.indexOf("login_ok.do") != -1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					session.setMaxInactiveInterval(20 * 60);
					SessionInfo info = new SessionInfo();
					info.setUserId(dto.getUserId());
					info.setUserName(dto.getUserName());

					session.setAttribute("member", info);
					resp.sendRedirect(cp);
					return;
				}
			}

			String msg = "아이디 또는 패스워드가 일치하지 않습니다.";
			req.setAttribute("message", msg);

			String path = "/WEB-INF/views/member/login.jsp";
			forward(req, resp, path);

		} else if(uri.indexOf("logout.do")!=-1) {
			session.removeAttribute("member");
			session.invalidate();
			resp.sendRedirect(cp);
		}
		
		else if (uri.indexOf("member.do") != -1) {

			req.setAttribute("mode", "created");
			String path = "/WEB-INF/views/member/member.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("member_ok.do") != -1) {
			// 회원가입 처리
			MemberDTO dto = new MemberDTO();

			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setBirth(req.getParameter("birth"));
			dto.setEmail(req.getParameter("email"));
			dto.setTel(req.getParameter("tel"));
			dto.setAddr(req.getParameter("addr"));

			int result = dao.insertMember(dto);
			if (result != 1) {
				String message = "회원 가입이 실패 했습니다.";

				req.setAttribute("title", "회원 가입");
				req.setAttribute("mode", "created");
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/member/member.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>" + dto.getUserName() + "</b>님 회원가입이 되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

			req.setAttribute("title", "회원 가입");
			req.setAttribute("message", sb.toString());

			forward(req, resp, "/WEB-INF/views/member/complete.jsp");
		} else if (uri.indexOf("memberInfo.do") != -1) {
			forward(req, resp, "/WEB-INF/views/member/memberInfo.jsp");
		} else if (uri.indexOf("infoChange.do") != -1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd1");

			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					
					req.setAttribute("mode", "update");
					req.setAttribute("dto", dto);
					String path = "/WEB-INF/views/member/member.jsp";
					forward(req, resp, path);
					return;
				}
			}
			String msg = "패스워드가 일치하지 않습니다.";
			req.setAttribute("message", msg);

			String path = "/WEB-INF/views/member/memberInfo.jsp";
			forward(req, resp, path);
			
		} else if (uri.indexOf("update_ok.do")!=-1) {
			MemberDTO dto = new MemberDTO();
			dto.setBirth(req.getParameter("birth"));
			dto.setEmail(req.getParameter("email"));
			dto.setAddr(req.getParameter("addr"));
			dto.setTel(req.getParameter("tel"));
			dto.setUserId(req.getParameter("userId"));
			
			dao.updateMember(dto);
			resp.sendRedirect(cp);

		} else if (uri.indexOf("delete.do")!=-1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd3");

			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					forward(req, resp, "/WEB-INF/views/member/delete.jsp");
					return;
				}
			}

			String path = "/WEB-INF/views/member/memberInfo.jsp";
			forward(req, resp, path);
			
		} else if (uri.indexOf("delete_ok.do")!=-1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					dao.deleteMember(dto);
					forward(req, resp, "/WEB-INF/views/member/delete_completed.jsp");
					return;
				}
			}

			String path = "/WEB-INF/views/member/delete.jsp";
			forward(req, resp, path);
			
		}

	}

}
