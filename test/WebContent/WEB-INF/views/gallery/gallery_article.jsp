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

<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css"/>
<style type="text/css">
.bbs-article .table {
    margin-top: 15px;
}
.bbs-article .table thead tr, .bbs-article .table tbody tr {
    height: 30px;
}
.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
    font-weight: normal;
    border-top: none;
    border-bottom: none;
}
.bbs-article .table thead tr {
    border-top: #d5d5d5 solid 1px;
    border-bottom: #dfdfdf solid 1px;
} 
.bbs-article .table tbody tr {
    border-bottom: #dfdfdf solid 1px;
}
.bbs-article .table i {
    background: #424951;
    display: inline-block;
    margin: 0 7px 0 7px;
    position: relative;
    top: 2px;
    width: 1px;
    height: 13px;    
}
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
function updatePhoto(num) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	     var url="<%=cp%>/gallery/update.do?num="+num+"&page=${page}";
	     location.href=url;
	</c:if>
}

function deletePhoto(num) {
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
         if(confirm("게시물을 삭제 하시겠습니까 ?")) {
        	 var url="<%=cp%>/gallery/delete.do?num="+num+"&page=${page}";
        	 location.href=url;
         }	
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
		
	var url = "<%=cp%>/gallery/createReply.do";
	f.action=url;
	f.submit();
}	

function deleteReply(rNum) {
	
	var url = "<%=cp%>/gallery/deleteReply.do?replyNum="+rNum+"&num=${dto.num}&page=${page}";
	if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
    	location.href=url;
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
	  <h3><span class="glyphicon glyphicon-picture"></span> GALLERY </h3>
	    </div>
	    
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 캠핑장소를 회원과 공유할 수 있는 공간입니다.
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
	                          ${dto.created}
	                         </td>
	                     </tr>
                         <tr style="border-bottom:none;">
                             <td colspan="2">
                                 <c:if test="${not empty dto.filename}">		
                                 	<img src="<%=cp%>/uploads/gallery/${dto.filename}" style="max-width:100%; height:auto; resize:both;">
					      	 	 </c:if>
                             </td>
                         </tr>
	                     <tr>
	                         <td colspan="2" style="min-height: 30px;">
	                              ${dto.content}
	                         </td>
	                     </tr>
	                </tbody>
	                <tfoot>
	                	<tr>
	                		<td>
		                        <c:if test="${sessionScope.member.userId==dto.userId}">		                		
	                		        <button type="button" class="btn btn-default btn-sm wbtn" onclick="updatePhoto(${dto.num});">수정</button>
	                		    </c:if>
		                        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">    
	                		        <button type="button" class="btn btn-default btn-sm wbtn" onclick="deletePhoto(${dto.num});">삭제</button>
	                		    </c:if>
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-default btn-sm wbtn"
	                		                onclick="javascript:location.href='<%=cp%>/gallery/gallery_list.do?page=${page}';"> 목록으로 </button>
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

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>