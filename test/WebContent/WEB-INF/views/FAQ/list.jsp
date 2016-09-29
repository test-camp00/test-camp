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
<link href="http://googledrive.com/host/0B-QKv6rUoIcGSXVoclk5aDh4RWM" rel="stylesheet"><!-- bootstrap.vertical-tabs.min.css -->
<link href=”./css/bootstrap.vertical-tabs.css” rel=”stylesheet”>
<link href=”./css/bootstrap.vertical-tabs.min.css” rel=”stylesheet”>


<style type="text/css">
.table th, .table td {
    font-weight: normal;
    border-top: none;
}
.table thead tr th{
     border-bottom: none;
} 
.table thead tr{
    border: #d5d5d5 solid 1px;
     background: #eeeeee; color: #787878;
} 
.table td {
    border-bottom: #d5d5d5 solid 1px;
}
.table td a{
    color: #000;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/FAQ/list.do";
	f.submit();
}
</script>
</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>


	<div class="container" role="main" >

     <div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>☞F A Q</h3>
	</div>
	 
	
<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
 <table class="table table-hover">
   <thead>
       <tr>
           <th class="text-center" style="width: 70px;">번호</th>
           <th >자주하는 질문</th>	                        
       
       </tr>
   </thead>
   <tbody>
 <c:forEach var="dto" items="${list}">
    <tr>
           <td class="text-center">${dto.listNum}</td>
           <td><a href='${articleUrl}&num=${dto.num}'>${dto.subject}</a></td>                     
         
       </tr>
      </c:forEach> 
   </tbody>
 </table>
</div>

<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
        <c:if test="${dataCount==0 }">
                   등록된 게시물이 없습니다.
         </c:if>
        <c:if test="${dataCount!=0 }">
               ${paging}
         </c:if>
</div>

<div style="clear: both;">
	        		
	        		<div style="float: left; width: 60%; text-align: center;">
	        		     <form name="searchForm" method="post" class="form-inline">
							  <select class="form-control input-sm" name="searchKey" >
							      <option value="subject">제목</option>							      
							  </select>
							  <input type="text" class="form-control input-sm input-search" name="searchValue">
							  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchList();"><span class="glyphicon glyphicon-search"></span> 검색</button>
	        		     </form>
	        		</div>
	        		
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
					 <c:if test="${sessionScope.member.userId=='admin'}">	        		   
						 <button type="button" class="btn btn-success btn-sm" onclick="javascript:location.href='<%=cp%>/FAQ/created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기</button>
	        		     <button type="button" class="btn btn-success btn-sm" onclick="javascript:location.href='<%=cp%>/FAQ/list.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 새로고침</button>
	        		 </c:if>
	        		</div>
	        </div>
        

	
	
	
</div>
	

 <div>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
 </div> 
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>       
        
</body>
</html>