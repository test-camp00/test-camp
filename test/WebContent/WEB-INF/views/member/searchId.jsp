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
function searchId_ok() {
        var f = document.searchIdOkForm;
    		
        f.action = "<%=cp%>/member/searchId_ok.do";
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
		<h3>아이디 찾기</h3>
	</div>
	<form method="post" name="searchIdOkForm">
	<div class="confrimSelf">
		<h4 style="text-align: center;">분실된 아이디를 찾습니다.</h4>
		<p style="padding: 20px 0; text-align: center;">이름과 휴대폰번호를 입력해주세요. 휴대폰번호는 010-0001-0001형식으로 입력합니다.
											</p>
		<div
			style="padding-top: 20px; border-top: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<span style="margin-right: 10px;">이름</span> <input
				type="text" name="userName"
				style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
		</div>
		<div
			style="padding-top: 20px; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<span>휴대폰</span> <input
				type="text" name="tel"
				style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
		</div>
		<div style="padding-top: 20px; border-bottom: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px; text-align: center">
			<button type="button" class="btn btn-success btn-sm"
				onclick="searchId_ok();" style="width: 200px;">확
				인</button>
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