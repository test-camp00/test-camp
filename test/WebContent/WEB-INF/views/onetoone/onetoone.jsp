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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css"/>

<style type="text/css">
.guest {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}
.guest-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}

.table td {
    font-weight: normal;
    border-top: none;
}
.table .guest-header{
    border: #d5d5d5 solid 1px;
    background: #eeeeee; color: #787878;
} 
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
function sendGuest() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		location.href="<%=cp%>/member/login.do";
		return;
	}
	
	var f=document.guestForm;
	var str;
	
	str=f.content.value;
	if(!str) {
		alert("내용을 입력 하세요 !!!");
		f.content.focus();
		return;
	}
	
	f.action="<%=cp%>/guest/guest_ok.do";
	f.submit();
}

function deleteGuest(num, uid) {
	var url="<%=cp%>/guest/delete.do?num="+num+"&page=${page}&uid="+uid;
	
	if(confirm("삭제 하시겠습니까 ?"))
		location.href=url;
}
</script>

</head>
<body>

<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>


<div class="container" role="main">
    <div class="bodyFrame col-sm-10"  style="float:none; margin-left: auto; margin-right: auto;">
        
	    <div class="body-title">
	          <h3><span class="glyphicon glyphicon-pencil"></span> 1:1문의 <small>Guest Book</small></h3>
	    </div>
	    
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 질문을 남겨주세요.
	    </div>
	
	    <div class="guest">
	            <div class="guest-write">
	               <div style="clear: both;">
	           	       <div style="float: left;"><span style="font-weight: bold;">질문하기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
	           	       <div style="float: right; text-align: right;"></div>
	               </div>
	               <div style="clear: both; padding-top: 10px;">
	                   <form name="guestForm" method="post" action="">
	                       <textarea name="content" id="content" class="form-control" rows="3" required="required"></textarea>
	                    </form>
	               </div>
	               <div style="text-align: right; padding-top: 10px;">
	                   <button type="button" class="btn btn-primary btn-sm" onclick="sendGuest();"> 등록하기 <span class="glyphicon glyphicon-ok"></span></button>
	               </div>           
	           </div>
	       
	           <div id="listGuest">
	               <div style='clear: both; padding-top: 20px;'>
	                   <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>방명록 ${dataCount}개</span> <span>[목록, ${page}/${total_page} 페이지]</span></div>
	                   <div style='float: right; text-align: right;'></div>
	               </div>           
	               <div class='table-responsive' style='clear: both; padding-top: 5px;'>
	                   <table class='table'>
	                   <c:forEach var="dto" items="${list}">
	                       <tr class='guest-header'>
	                           <td style='width: 50%;'>
	                               ${dto.userName }
	                           </td>
	                           <td style='width: 50%; text-align: right;'>
	                               ${dto.created}
	                               <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">	
								          | <a href="javascript:deleteGuest('${dto.num}', '${dto.userId}');">삭제</a>
								   </c:if>
	                           </td>
	                       </tr>
	                       <tr style='height: 50px;'>
	                           <td colspan='2'>
	                               ${dto.content}
	                           </td>
	                       </tr>
	                    </c:forEach>
	                       
	                       <tr style='height: 30px;'>
	                           <td colspan='2' style='text-align: center;'>
	                               ${paging}
	                           </td>
	                       </tr>
	                   </table>
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