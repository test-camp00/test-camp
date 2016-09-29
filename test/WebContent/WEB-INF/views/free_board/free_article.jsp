<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
function deleteBoard(num) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
	
	    var page = "${page}";
	    var params = "num="+num+"&page="+page;
	    var url = "<%=cp%>/free_board/delete.do?" + params;

	    if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	    	location.href=url;
	</c:if>    
	
	<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
	    alert("게시물을 삭제할 수  없습니다.");
	</c:if>
	
	}
	
function sendReply(){
	var f=document.replyForm;
	var content=f.content.value;

	if(!content ) {
		alert(" 내용을 입력하세요 !!! ");
		f.content.focus();
		return;
	}
		
	var url = "<%=cp%>/free_board/createReply.do";
	f.action=url;
	f.submit();
}	

function deleteReply(rNum) {
	
	var url = "<%=cp%>/free_board/deleteReply.do?replyNum="+rNum+"&num=${dto.num}&${params}";
	if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
    	location.href=url;
}
</script>
</head>
<body>


<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container" role="main">
	 <div class="bodyFrame col-sm-10"  style="float:none;margin:0px; padding:0px;width:1140px">

	    <div class="body-title">
	          <h3><span class="glyphicon glyphicon-book"></span> 자유게시판 </h3>
	    </div>
	    
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 유저분들께서 마음껏 소통하세요 ^^
	    </div>
	    
	    <div class="table-responsive" style="clear: both;">
	        <div class="bbs-article">
	            <table class="table">
	                 <thead>
	                     <tr>
	                         <th colspan="2" style="text-align: center;">
	                                 ${dto.subject}
	                         </th>
	                     </tr>
	                <thead>
	                 <tbody>
	                     <tr>
	                         <td style="text-align: left;">
	                                이름 : ${dto.userName}
	                         </td>
	                         <td style="text-align: right;">
	                          ${dto.created} <i></i>조회 : ${dto.hitCount}
	                         </td>
	                     </tr>
	                     <tr>
	                         <td colspan="2" style="height: 230px;">
	                              ${dto.content}
	                         </td>
	                     </tr>
	                     <tr>
	                      <td colspan="2">
		                        <span style="display: inline-block; min-width: 45px;">첨부</span> :
		                        <c:if test="${not empty dto.saveFilename}">
		                            <a href="<%=cp%>/free_board/download.do?num=${dto.num}">${dto.originalFilename}</a>
		                            (<fmt:formatNumber value="${dto.filesize/1024}" pattern="0.00"/> KByte)
		                        </c:if>
		                  </td>
		               </tr>
	                     <tr>
	                         <td colspan="2">
	                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
							      <c:if test="${not empty preReadDto }">
								      <a href="<%=cp%>/free_board/article.do?${params}&num=${preReadDto.num}">${preReadDto.subject}</a>
							       </c:if>
	                         </td>
	                     </tr>
	                     <tr>
	                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
	                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
							      <c:if test="${not empty nextReadDto }">
								      <a href="<%=cp%>/free_board/article.do?${params}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
							       </c:if>
	                         </td>
	                     </tr>                                          
	                </tbody>
	                <tfoot>
	                	<tr>
	                		<td>
		                        <c:if test="${sessionScope.member.userId==dto.userId}">		                		
	                		        <button type="button" class="btn btn-default btn-sm wbtn"
	                		                    onclick="javascript:location.href='<%=cp%>/free_board/update.do?num=${dto.num}&page=${page}';">수정</button>
	                		    </c:if>
		                        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">    
	                		        <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteBoard('${dto.num}');">삭제</button>
	                		    </c:if>
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-default btn-sm wbtn"
	                		                 onclick="javascript:location.href='<%=cp%>/free_board/board_free.do?${params}';"> 목록으로 </button>
	                		</td>
	                	</tr>
	                </tfoot>
	            </table>
	       </div>
	       
	         <div class="bbs-reply">
	           <div class="bbs-reply-write">
	               <div style="clear: both;">
	           	       <div style="float: left;"><span style="font-weight: bold;">댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
	           	       <div style="float: right; text-align: right;"></div>
	               </div>
	               <div style="clear: both; padding-top: 10px;">
	               <form method="post" name="replyForm">
	                   <textarea name="content" class="form-control" rows="3" required="required"></textarea>
	                   <input type="hidden" name="num" value="${dto.num}">
	                   <input type="hidden" name="page" value="${page}">
	                   <input type="hidden" name="searchKey" value="${searchKey }">
	                   <input type="hidden" name="searchValue" value="${searchValue }">
	               </form>
	               </div>
	               <div style="text-align: right; padding-top: 10px;">
	                   <button type="button" class="btn btn-primary btn-sm" onclick="sendReply();"> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
	               </div>
	           </div>
	           
	            <div style="clear: both; padding-top: 5px;">
					    <c:forEach var="rdto" items="${listReply}">    
					         <div  style="clear:both; margin-top:5px; padding: 10px; border: #d5d5d5 solid 1px; min-height: 100px;">
					              <div style="clear: both;">
					                  <div style="float: left;">${rdto.userId} | ${rdto.created}</div>
					                  <div style="float: right;  text-align: rigth;">
					                        <c:if test="${sessionScope.member.userId==rdto.userId || sessionScope.member.userId=='admin'}">				                    
					                        	  <button type="button" class="btn btn-primary btn-sm" onclick='deleteReply("${rdto.replyNum}");'>댓글삭제</button>
					                        </c:if>
					                  </div>
					              </div>
					              <div  style="clear: both; padding: 5px 0 5px 0px;  min-height: 40px; white-space: pre;">${rdto.content}</div>
					         </div>
				    </c:forEach>
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