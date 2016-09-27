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

<style type="text/css">

.confrimSelf {
	border: 1px solid #e9e9e9;
    padding: 19px 9px 9px;
}

</style>

<script type="text/javascript">
function delete_ok() {
        var f = document.deleteOkForm;

        str = f.userPwd.value;
        if(!str) {
            f.userPwd.focus();
            return false;
        }
        
        f.action = "<%=cp%>/member/delete_ok.do";
        f.submit();
}
</script>

<div style="height: 205px">
	<div
		style="height: 10px; border-bottom: 50px solid #3cb371; margin-top: 0px">
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
</div>

<div class="container">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>회원 탈퇴</h3>
	</div>
	<form method="post" name="deleteOkForm">
	<div class="confrimSelf">
		<h4 style="text-align: center;">회원탈퇴 재확인</h4>
		<p style="padding: 20px 0; text-align: center;">회원탈퇴하기 전에 비밀번호를 다시 한번 확인해주십시오.</p>
		<div
			style="padding-top: 20px; border: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<span>비밀번호 입력</span> <input
				type="password" name="userPwd"
				style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
			<button type="button" class="btn btn-success btn-sm"
				onclick="delete_ok();" style="margin-left: 60px; width: 100px;">확
				인</button>
				<input type="hidden" name="userId" value="${sessionScope.member.userId}">
		</div>
	</div>
	</form>
</div>


<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>