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


<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>
<div class="container">
	<div class="well well-lg">
		<p class="lead text-center">${message}</p>
		<p style="max-width: 400px; margin: 0 auto;">
			<c:if test="${mode2=='created'}">
			<button type="button" class="btn btn-primary btn-lg btn-block"
				onclick="javascript:location.href='<%=cp%>/free_board/board_free.do';">게시글 리스트로 이동
				&raquo;</button>	
			</c:if>	
			<c:if test="${mode2=='update'}">
			<button type="button" class="btn btn-primary btn-lg btn-block"
				onclick="javascript:location.href='<%=cp%>/free_board/board_free.do?page=${page }';">게시글 리스트로 이동
				&raquo;</button>	
			</c:if>		
		</p>
	</div>
</div>


<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>