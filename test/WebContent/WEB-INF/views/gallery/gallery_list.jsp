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

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
    <div class="bodyFrame col-sm-10"  style="float:none;margin:0px; padding:0px;width:1140px">
        
	  <h3><span class="glyphicon glyphicon-picture"></span> GALLERY </h3>
	    
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 캠핑장소를 회원과 공유할 수 있는 공간입니다.
	    </div>
	
	    <div style="max-width:660px; margin: 0px auto;">
	<c:if test="${dataCount!=0 }">    
	        <div style="clear: both; height: 30px; line-height: 30px;">
	            <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	            <div style="float: right;">&nbsp;</div>
	        </div>
	        
	        <div style="clear: both;">
	    <c:forEach var="dto" items="${list}" varStatus="status">
	                 <c:if test="${status.index==0}">
	                       <c:out value="<div style='clear: both; max-width:660px; margin: 0px auto;'>" escapeXml="false"/>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%3==0}">
	                        <c:out value="</div><div style='clear: both; max-width:660px; margin: 0px auto;'>" escapeXml="false"/>
	                 </c:if>
				      <div class="imgLayout">
		                     <img src="<%=cp%>/uploads/photo/${dto.imageFilename}" style="width: 190px; height: 190px;" border="0">
				             <span class="subject" onclick="javascript:article('${dto.num}');" >
				                   ${dto.subject}
				             </span>
				       </div>
	    </c:forEach>
	
	    <c:set var="n" value="${list.size()}"/>
	    <c:if test="${n>0&&n%3!=0}">
			        <c:forEach var="i" begin="${n%3+1}" end="3" step="1">
				             <div class="imgLayout">&nbsp;</div>
			        </c:forEach>
	    </c:if>
		
	    <c:if test="${n!=0 }">
			       <c:out value="</div>" escapeXml="false"/>
	    </c:if>
	        </div>
	</c:if>
	
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
	        		    &nbsp;
	        		</div>
	        		<div style="float: left; width: 60%; text-align: center;">
	        		    &nbsp;
	        		</div>
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/photo/created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기</button>
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