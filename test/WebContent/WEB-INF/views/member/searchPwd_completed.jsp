<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
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
function change_ok() {
        var f = document.serachPwdchangeForm;
        
        str = f.userPwd.value;
    	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
    		f.userPwd.focus();
    		return false;
    	}

    	if(f.userPwdCheck.value != str) {
    		alert("비밀번호가 일치하지않습니다.");
    		return false;
    	}
    		
        f.action = "<%=cp%>/member/serachPwd_change.do";
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
		<h3>비밀번호 찾기</h3>
	</div>
	<form method="post" name="serachPwdchangeForm">
	<div class="confrimSelf">
		<c:if test="${state=='nochange'}">
		<h4 style="text-align: center;">${message}</h4>
		<p style="padding: 20px 0; text-align: center;"></p>
		<div
			style="padding-top: 20px; border: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<button type="button" class="btn btn-primary btn-lg btn-block"
				onclick="javascript:location.href='<%=cp%>/';">메인화면으로 이동
				&raquo;</button>
		</div>
		</c:if>
		
		<c:if test="${state=='change'}">
		<h4 style="text-align: center;">${message}</h4>
		<p style="padding: 20px 0; text-align: center;">비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야
											합니다</p>
		<div
			style="padding-top: 20px; border-top: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<span style="margin-right: 10px;">비밀번호 입력</span> <input
				type="password" name="userPwd"
				style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
		</div>
		<div
			style="padding-top: 20px; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<span>비밀번호 재입력</span> <input
				type="password" name="userPwdCheck"
				style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
		</div>
		<div style="padding-top: 20px; border-bottom: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<button type="button" class="btn btn-success btn-sm"
				onclick="change_ok();" style="width: 100px;">확
				인</button>
				<input type="hidden" name="userId" value="${userId}">
		</div>
		</c:if>
		
	</div>
	</form>
</div>


<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>