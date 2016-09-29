<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
function replyOnetoone(num) {
	var userId="${sessionScope.member.userId}";
	if(! userId) {
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
	
	f.action="<%=cp%>/onetoone/reply_ok.do";
	f.submit();

}

</script>


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
    border-bottom:  #d5d5d5 solid 1px;
   
}
.table .guest-header{
    border: #d5d5d5 solid 1px;
    background: #eeeeee; color: #787878;
} 
</style>

</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>
<div class="container" role="main">
    <div class="bodyFrame col-sm-10"  style="float:none; margin-left: auto; margin-right: auto;">
        
	    <div class="body-title">
	          <h3><span class="glyphicon glyphicon-pencil"></span> 1:1답변 <small>Guest Book</small></h3>
	    </div>
	    
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 답변해주세요.
	    </div>
	
	    <div class="guest">
	            <div class="guest-write">
	               <div style="clear: both;">
	           	       <div style="float: left;"><span style="font-weight: bold;">질문하기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
	           	       <div style="float: right; text-align: right;"></div>
	               </div>
	               <br>
	               <div style="clear: both; height: 100px">
	                   <form name="guestForm" method="post" action="">
	                  
	                   
	                       <textarea name="content" id="content" rows="3" value="${dto.content}" required="required"style="height: 70px; width: 900px" >${dto.content}</textarea><br>
	                   
	         <input type="hidden" name="page" value="${page}">
	                  <input type="hidden" name="num" value="${dto.num}">
	                      
	                    </form>
	               </div>
	               <br>
	               <div style="text-align: right; margin-top:10px;padding-top: 10px;">
	              
	                   <button type="button" class="btn btn-primary btn-sm" onclick="replyOnetoone('${dto.num}');"> 답변하기 <span class="glyphicon glyphicon-ok"></span></button>
	                  
	               </div>           
	           </div>
	       
	           
	    </div>

    </div>
</div>

<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>



</body>
</html>