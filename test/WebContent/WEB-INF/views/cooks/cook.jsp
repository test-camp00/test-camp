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
<title>요리 리스트</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style type="text/css">
*{
	margin: 0px; padding: 0px;
}
body {
	font-size: 9pt; font-family: 돋움;
}
a{
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}
a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
}
.btn {
	 font-size: 12px;
	 color:#333;
 	 font-weight:500;
	 font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	 border:1px solid #ccc;
	 background-color:#FFF;
	 vertical-align:middle;
	 text-align:text-align;
	 cursor:cursor;
	 padding:4px 8px;
	 border-radius:4px;
	 margin-bottom: 3px;
}
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333;
}
.boxTF {
	border:1px solid #999;
	padding:4px 6px;
	border-radius:4px;
	background-color:#ffffff;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}
.selectField {
	border:1px solid #999;
	padding:3px 6px;
	border-radius:4px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/";
	f.submit();
}

</script>

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>



	
<div class="container" >
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;" >
      <h3>캠핑요리</h3>
	</div>	  	 
	    
	 <div>
	<div class="row">
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food2.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"  style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food3.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div></div>
	<div class="row" style="margin-top: 15px;">
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food4.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food5.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/food6.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div></div>			
					
	</div>
<table style="width: 100%; margin: 0px auto; margin-top: 30px; border-spacing: 0px; padding-bottom: 30px;">
   <tr height="35">
	  <td align="left" width="80%">
		  <form name="searchForm" action="" method="post">
			  <select name="searchKey" class="selectField">
				  <option value="cookCode">주재료</option>
				  <option value="name">요리명</option>				  				 
			</select>
			<input type="text" name="searchValue" class="boxTF">
			<input type="button" value=" 검 색 " class="btn" onclick="searchList()">
			
		</form>
	  </td>	  
   </tr>
</table>

<table style="width: 700px; margin: 0px auto; border-spacing: 0px; width: 100%; height: 150px; padding-bottom: 30px;">
  <tr align="center" bgcolor="#6AD76A" height="30"> 
	  <td width="60" style="color: #ffffff;">번호</td>
	  <td width="100" style="color: #ffffff;">주재료</td>
	  <td width="100" style="color: #ffffff;">요리명</td>
	  <td width="400" style="color: #ffffff;">recipe</td>
	  <td width="60" style="color: #ffffff;">좋아요</td>
  </tr>
 
  <tr align="center" bgcolor="#ffffff" height="30"> 
	  <td align="center">1</td>
	  <td align="center">어류</td>
	  <td align="center">도미구이</td>
	  <td align="left" style="padding-left: 10px;">
		 <a href="<%=cp%>/cooks/domi.do">도미를 이용한 소금구이</a>
	  </td>	  
	  <td align="center">14</td>
  </tr>
  <tr><td height="1" colspan="6" bgcolor="#e4e4e4"></td></tr> 
   
</table>
 
<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
	<tr height="35">
		<td align="center">
		   1 2 3
		</td>
	</tr>
	<div align="right">
			<c:if test="${sessionScope.member.userId=='admin'}">
	         <button type="button" class="btn btn-success btn-sm" onclick="javascript:location.href='<%=cp%>/cook/created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기</button>
	         <button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon"></span> 삭제</button>
	        </c:if>
			</div>
</table>
	
	
	
	
	
	
	
	
	<%-- <div class="container" role="main" style="padding-bottom: 30px; padding-top: 30px;">         
	     <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
               <table class="table table-hover">
                   <thead>
                       <tr>
                           <th class="text-center" style="width: 70px;">번호</th>
                           <th class="text-center" style="width: 200px;">주재료</th>
                           <th class="text-center" style="width: 200px;">요리명</th>
                           <th class="text-center">recipe</th>                           
                           <th class="text-center" style="width: 150px;">좋아요</th> 
                       </tr>
                   </thead>
                   <tbody>
                 <tr>
                           <td class="text-center">1</td>                           
                           <td class="text-center"><a href='<%=cp%>/campground/article.do'>어류</a></td>
                           <td class="text-center">도미구이</td>
                           <td class="text-center">도미를 이용한 소금구이</td>
                           <td class="text-center">14</td> 
                  </tr>
                 <tr>
                           <td class="text-center">2</td>
                           <td class="text-center"><a href='${articleUrl}&num=${dto.num}'>채소</a></td>
                           <td class="text-center">모둠채소구이</td>
                           <td class="text-center">여러가지 신선한 채소들의 모둠 구이</td>
                           <td class="text-center">6</td> 
                  </tr>
                 <c:forEach var="dto" items="${list}">
                       <tr>
                           <td class="text-center">${dto.listNum}</td>
                           <td><a href='${articleUrl}&num=${dto.num}'>${dto.areaName}</a></td>
                           <td class="text-center">${dto.addr}</td>
                           <td class="text-center">${dto.tel}</td>
                       </tr>
                      </c:forEach> 
                   </tbody>
                   <tfoot>
                   
                   </tfoot>
               </table>
           </div>
	
	
	</div> --%>
	
</div>
	
	   

<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</div>
</body>
</html>
