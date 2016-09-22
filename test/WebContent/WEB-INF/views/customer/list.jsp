<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>


    <jsp:include page="/WEB-INF/views/customer/list2.jsp"></jsp:include>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

          <script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
        
</body>
</html>