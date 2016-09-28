<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">



</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div>
  
    <jsp:include page="/WEB-INF/views/layout/imgSlide.jsp"></jsp:include>
</div>
<div class="container" role="main">

<jsp:include page="/WEB-INF/views/layout/board.jsp"></jsp:include> 


</div>


<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>




</body>
</html>