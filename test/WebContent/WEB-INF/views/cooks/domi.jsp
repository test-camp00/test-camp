<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<Html>
<head>
<meta charset='utf-8'>
<title>도미요리</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>



<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

	<div class="container" role="main">
<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
      <h3>도미구이</h3>
</div>

<div class="row" style="padding-bottom: 50px;">
	<div class="embed-responsive embed-responsive-16by9">
	  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/oMuZ3-vEvBs" frameborder="0" allowfullscreen></iframe>
	</div>	
</div>	

<div style="padding-bottom: 30px;">
	
	  <h2 align="left">☞ 재  료</h2><br><br>
		<p>※  소금 및 후추 약간</p>
		<p>※  도미 1마리</p>
		<p>※  레몬 반개</p>		
</div>

<div style="padding-bottom: 30px;">
	
	  <h2 align="left">☞ 조 리 방 법 </h2><br><br>
		<p>1. 도미의 비늘을 제거한 후에 소금과 후추로 밑간을 하여 잡내를 없애준다.</p>
		<p>2. 겉면을 바삭하게 익혀주면서 레몬즙을 뿌려준다.</p>
		<p>3. 맛있게 먹는다.</p>	
</div>

 <div class="container" role="main" style="padding-bottom: 30px; padding-top: 30px;">         
	     <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
               <table class="table table-hover">
                   <thead>
                       <tr>
                           <th class="text-center" style="width: 70px;">번호</th>
                           <th class="text-center" style="width: 200px;">아이디</th>                           
                           <th class="text-center">댓글</th>         
                           <th class="text-center" style="width: 200px;">입력일</th>          
                       </tr>
                   </thead>
                   <tbody>
                 <tr>
                           <td class="text-center">1</td>                           
                           <td class="text-center">내일은 캠핑왕</td>
                           <td class="text-center">맛있어요</td>
                           <td class="text-center">2016-09-14</td>                 
                  </tr>
                 <tr>
                           <td class="text-center">2</td>
                           <td class="text-center">건강사랑</td>
                           <td class="text-center">최고입니다.ㅋㅋㅋ</td>
                           <td class="text-center">2016-09-14</td>                         
                  </tr>
                 <c:forEach var="dto" items="${list}">
                       <tr>
                           <td class="text-center"></td>
                           <td><a href=''></a></td>
                           <td class="text-center"></td>
                           <td class="text-center"></td>
                       </tr>
                      </c:forEach> 
                   </tbody>
                   <tfoot>
                   
                   </tfoot>
               </table>
           </div>
     <div style="width: 100%;">  
     <c:if test="${sessionScope.member.userId!='admin'}"> 
	<button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-thumbs-up"></span> 좋아요</button>
	</c:if> 
	<c:if test="${sessionScope.member.userId=='admin'}"> 
	<button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon"></span> 수정</button>
	</c:if> 
	<c:if test="${sessionScope.member.userId=='admin'}"> 
	<button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon"></span> 삭제</button>
	</c:if>
	</div> 
	
	</div> 

<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</div>
</body>
</html>
