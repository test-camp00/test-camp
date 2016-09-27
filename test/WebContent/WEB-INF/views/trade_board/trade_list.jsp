<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("UTF-8");
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/trade_board/board_trade.do";
		f.submit();
	}
</script>
</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
	 <div class="bodyFrame col-sm-10"  style="float:none;margin:0px; padding:0px;width:1140px">
        
	    <div class="body-title">
	    	  
	    
	    <h3><span class="glyphicon glyphicon-question-sign"></span> 거래게시판 </h3>
	        
	    </div>
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 유저분들이 가지고 있는 물품을 서로 판매하는 공간입니다.
	    </div>
	    
	
	    <div>
	        <div style="clear: both; height: 30px; line-height: 30px;">
	            <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	            <div style="float: right;">&nbsp;</div>
	        </div>
	        
	        <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th class="text-center" style="width: 70px;">번호</th>
	                        <th >제목</th>
	                        <th class="text-center" style="width: 100px;">글쓴이</th>
	                        <th class="text-center" style="width: 100px;">날짜</th>
	                        <th class="text-center" style="width: 70px;">조회수</th> 
	                   		<td class="text-center" style="width: 70px;">첨부</td>
	                    </tr>
	                </thead>
	                
	                <tbody>
					 <c:forEach var="dto" items="${list}">
	                    <tr>
	                    	<th class="text-center" style="width: 70px;">${dto.listNum}</th>
	                        <th ><a href='${articleUrl}&num=${dto.num}'>${dto.subject}</a></th>
	                        <th class="text-center" style="width: 100px;">${dto.userName}</th>
	                        <th class="text-center" style="width: 100px;">${dto.created}</th>
	                        <th class="text-center" style="width: 70px;">${dto.hitCount}</th> 
	                   		<td class="text-center" style="width: 70px;">
	                   			<c:if test="${not empty dto.saveFilename}">
					      			<a href="<%=cp%>/trade_board/download.do?num=${dto.num}"><img  src="<%=cp%>/images/disk.gif"></a>
					      		</c:if>
	                   		</td>
	                    </tr>
	                  </c:forEach>
	                     <tr>
	                  		<th class="text-center" style="width: 70px;"></th>
	                        <th ></th>
	                        <th class="text-center" style="width: 100px;"></th>
	                        <th class="text-center" style="width: 100px;"></th>
	                        <th class="text-center" style="width: 70px;"></th>
	                     </tr>
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
	        		<div style="float: left; width: 20%; min-width: 85px;">
	        		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/trade_board/board_trade.do';">새로고침</button>
	        		</div>
	        		<div style="float: left; width: 60%; text-align: center;">
	        		     <form name="searchForm" method="post" class="form-inline">
							  <select class="form-control input-sm" name="searchKey" >
							      <option value="subject">제목</option>
							      <option value="userName">작성자</option>
							      <option value="content">내용</option>
							      <option value="created">등록일</option>
							  </select>
							  <input type="text" class="form-control input-sm input-search" name="searchValue">
							  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchList()"><span class="glyphicon glyphicon-search"></span> 검색</button>
	        		     </form>
	        		</div>
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/trade_board/board_trade_created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기</button>
	        		</div>
	        </div>
	    </div>

    </div>
</div>



<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</body>
</html>