<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">
<link rel="stylesheet" href="<%=cp%>/css/layout/login.css"
	type="text/css">
<script type="text/javascript">
function sendLogin() {
        var f = document.loginForm;

    	var str = f.userId.value;
        if(!str) {
            f.userId.focus();
            return false;
        }

        str = f.userPwd.value;
        if(!str) {
            f.userPwd.focus();
            return false;
        }

        f.action = "<%=cp%>/member/login_ok.do";
        f.submit();
}
</script>

<div>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
<div style="height: 500px;">
	<section id="login">
		<div class="container">
			<div class="row">
				<div class="col-xs-14">
					<div class="form-wrap">
						<h1>회원 로그인</h1>
						<form role="form" method="post" name="loginForm"
							id="login-form" autocomplete="off">
							<div class="form-group">
								<label for="email" class="sr-only">Email</label> <input
									type="text" name="userId" id="userId" class="form-control"
									placeholder="아이디">
							</div>
							<div class="form-group">
								<label for="key" class="sr-only">Password</label> <input
									type="password" name="userPwd" id="userPwd" class="form-control"
									placeholder="비밀번호">
							</div>
							<button type="submit"id="btn-login"
								class="btn btn-custom btn-lg btn-block"
								style="background: #82D580; font-size: 12px; font-weight: bold;" 
								type="button" onclick="sendLogin();"> 로그인 </button>
							
						</form>
						<a href="javascript:;" class="forget" data-toggle="modal"
							data-target=".forget-modal">비밀번호를 잊어버리셨나요?</a>
						<hr>
						<div style="margin-top:10px; text-align: center;">${message}</div>
					</div>
				</div>
				<!-- /.col-xs-12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</section>
</div>
<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
