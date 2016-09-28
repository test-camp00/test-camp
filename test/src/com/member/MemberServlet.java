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

			String msg = "���̵� �Ǵ� �н����尡 ��ġ���� �ʽ��ϴ�.";
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
			// ȸ������ ó��
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
				String message = "ȸ�� ������ ���� �߽��ϴ�.";

				req.setAttribute("title", "ȸ�� ����");
				req.setAttribute("mode", "created");
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/member/member.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>" + dto.getUserName() + "</b>�� ȸ�������� �Ǿ����ϴ�.<br>");
			sb.append("����ȭ������ �̵��Ͽ� �α��� �Ͻñ� �ٶ��ϴ�.<br>");

			req.setAttribute("title", "ȸ�� ����");
			req.setAttribute("message", sb.toString());

			forward(req, resp, "/WEB-INF/views/member/complete.jsp");
		} else if (uri.indexOf("memberInfo.do") != -1) {
			
			String act="active1";
			req.setAttribute("active", act);
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
			
			String act="active1";
			req.setAttribute("active", act);
			
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
			String path = "/WEB-INF/views/member/update_complete.jsp";
			forward(req, resp, path);

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
			
			String act="active3";
			req.setAttribute("active", act);
			String path = "/WEB-INF/views/member/memberInfo.jsp";
			forward(req, resp, path);
			
		} else if (uri.indexOf("delete_ok.do")!=-1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");
			
			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					session.removeAttribute("member");
					session.invalidate();
					dao.deleteMember(dto);
					forward(req, resp, "/WEB-INF/views/member/delete_completed.jsp");
					return;
				}
			}

			String path = "/WEB-INF/views/member/delete.jsp";
			forward(req, resp, path);
			
		} else if (uri.indexOf("changePwd.do")!=-1) {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd2");

			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				if (userPwd.equals(dto.getUserPwd()) && dto.getEnabled() == 1) {
					forward(req, resp, "/WEB-INF/views/member/changePwd.jsp");
					return;
				}
			}
			
			String act="active2";
			req.setAttribute("active", act);
			
			String path = "/WEB-INF/views/member/memberInfo.jsp";
			forward(req, resp, path);
			
		} else if (uri.indexOf("change_ok.do")!=-1) {
			String userId = req.getParameter("userId");
			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				dto.setUserPwd(req.getParameter("userPwd"));
				if (dto.getEnabled() == 1) {
					dao.changePwd(dto);
					forward(req, resp, "/WEB-INF/views/member/changePwd_completed.jsp");
					return;
				}
			}
			String path = "/WEB-INF/views/member/changePwd.jsp";
			forward(req, resp, path);
		} else if (uri.indexOf("searchId.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/member/searchId.jsp");
		} else if (uri.indexOf("searchId_ok.do")!=-1) {
			String userName = req.getParameter("userName");
			String tel = req.getParameter("tel");
			MemberDTO dto=dao.searchId(userName, tel);
			String message=null;
			if(dto!=null) {
				if(dto.getEnabled()==0) {
					message="�Է��Ͻ� ������ ���� ���̵�� Ż���� �����Դϴ�.";
				} else {
					message="�Է��Ͻ� ������ ���� ���̵�� " + dto.getUserId()+" �Դϴ�.";
				}
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/member/searchId_completed.jsp");
			}
			message="�Է��Ͻ� ������ ���� ���̵� �������� �ʽ��ϴ�.";
			req.setAttribute("message", message);
			forward(req, resp, "/WEB-INF/views/member/searchId_completed.jsp");
		} else if(uri.indexOf("searchPwd.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/member/searchPwd.jsp");
		} else if(uri.indexOf("searchPwd_ok.do")!=-1) {
			String userId = req.getParameter("userId");
			String userName = req.getParameter("userName");
			String tel = req.getParameter("tel");
			
			MemberDTO dto=dao.searchPwd(userId, userName, tel);
			String message=null;
			String state="nochange";
			if(dto!=null) {
				if(dto.getEnabled()==0) {
					message="�Է��Ͻ� ������ ���� ���̵�� Ż���� �����Դϴ�.";
				} else {
					message="��й�ȣ ��ȣ�� ���Ͽ� " + dto.getUserId()+"���� ��й�ȣ�� �缳���մϴ�.";
					state="change";
				}
				req.setAttribute("message", message);
				req.setAttribute("state", state);
				req.setAttribute("userId", userId);
				forward(req, resp, "/WEB-INF/views/member/searchPwd_completed.jsp");
			}
			message="�Է��Ͻ� ������ ���� ���̵� �������� �ʽ��ϴ�.";
			req.setAttribute("message", message);
			req.setAttribute("state", state);
			forward(req, resp, "/WEB-INF/views/member/searchPwd_completed.jsp");
			
		} else if(uri.indexOf("serachPwd_change.do")!=-1) {
			String userId = req.getParameter("userId");
			MemberDTO dto = dao.readMember(userId);
			if (dto != null) {
				dto.setUserPwd(req.getParameter("userPwd"));
				if (dto.getEnabled() == 1) {
					dao.changePwd(dto);
					forward(req, resp, "/WEB-INF/views/member/changePwd_completed.jsp");
					return;
				}
			}
			String path = "/WEB-INF/views/member/searchPwd.jsp";
			forward(req, resp, path);
			
		}
		
			

	}

}
