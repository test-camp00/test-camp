<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
	<h2>캠핑장 정보</h2>
	<div>
		<h3>캠핑장 정보 검색</h3>
			<div>
				<label style="width: 120px; font-size: 15px;">지역</label>
				<select name="citySel" style="width: 174px; height: 26px; padding-left: 30px;">
				<option>지역선택</option>
				<option value="">서울</option>
				<option value="">경기</option>
				<option value="">인천</option>
				</select><br>
				<label style="width: 120px; font-size: 15px;">지점명/주소검색</label>
				<input type="text" name="citySch">
			</div>
			<img src="/test/res/images/map.jpg" alt="">
	</div>
	
	<div>
		2nd list
	</div>
</div>

<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</body>
</html>