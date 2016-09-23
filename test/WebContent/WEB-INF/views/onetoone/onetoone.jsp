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


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>


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

<script type="text/javascript">
function sendOnetoone() {
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
	
	f.action="<%=cp%>/onetoone/onetoone_ok.do";
	f.submit();

}

function deleteOnetoone(num, userId) {
	var url="<%=cp%>/onetoone/delete.do?num="+num+"&page=${page}&userID="+userId;
	
	
	if(confirm("삭제 하시겠습니까 ?"))
		location.href=url;
}

function updateOnetoone(num, userId, secret, subject, content) {

	$("#exampleModal").modal("show");
	
	
	 var url="<%=cp%>/onetoone/update.do?num="+num+"&page=${page}&userID="+userId;
	/* +"&{secret}="+secret+"&{subject}="+subject+"&{content}="+content */
	//if(confirm("수정 하시겠습니까 ?"))
	//	location.href=url;
} 




function replyOnetoone(num, userId) {
	var url="<%=cp%>/onetoone/reply.do?num="+num+"&page=${page}&userID="+userId;
	
	if(confirm("답변 하시겠습니까 ?"))
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
	               <div style="clear: both; height: 100px">
	                   <form name="guestForm" method="post" action="">
	                   <textarea name="subject" id="subject"  rows="3" required="required" style="height: 30px; width: 900px" >제목:</textarea><br>
	                       <textarea name="content" id="content" rows="3" required="required"style="height: 70px; width: 900px" >내용:</textarea><br>
	                      
					        <input type="checkbox" name="secret" value="1" ${dto.secret==1 ? "checked='checked' ":"" }> 비밀글
					     
	      
	                      
	                    </form>
	               </div>
	               <div style="text-align: right; padding-top: 10px;">
	                   <button type="button" class="btn btn-primary btn-sm" onclick="sendOnetoone();"> 등록하기 <span class="glyphicon glyphicon-ok"></span></button>
	               </div>           
	           </div>
	       
	           <div id="listGuest">
	               <div style='clear: both; padding-top: 20px;'>
	                   <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>질문글 ${dataCount}개</span> <span>[목록, ${page}/${total_page} 페이지]</span></div>
	                   <div style='float: right; text-align: right;'></div>
	               </div>           
	               <div class='table-responsive' style='clear: both; padding-top: 5px;'>
	                   <table class='table'>
	                   <c:forEach var="dto" items="${list}">
	                       <tr class='guest-header'>
	                       <td style='width: 10%;'>
	                               NO${dto.num}.
	                           </td>
	                           <td style='width: 20%;'>
	                               아이디:${dto.userId}
	                           </td>
	                           
	                           <td style='width: 50%; text-align: left;'>
	                            <c:if test="${dto.secret==1}">제목 : 비밀글입니다.
	       
	                         </c:if>
	                         <c:if test="${dto.secret==0}"> ${dto.subject}</c:if>
	                          
	                           </td>
	                           <td style='width: 20%; text-align: right;'>
	                              
	                               <c:if test="${sessionScope.member.userId==dto.userId}">	
	                               <c:if test="${sessionScope.member.userId!='admin'}">
								         
								          <button type="button" class="btn btn-primary" 
								            onclick="updateOnetoone('${dto.num}', '${dto.userId}', '${dto.secret}', '${dto.subject}');"
								          >수정</button>
  											<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">수정할 정보 입력</h4>
      </div>
      <div class="modal-body">
        <form name="updateForm" method="post" onsubmit="return check();">
          <div class="form-group">
            <label for="recipient-name" class="control-label">NO:</label>
            
            <input type="text" class="form-control" name="num" id="num" value="${dto.num}"disabled="disabled">
          </div>
          
          <div class="form-group">
            <label for="recipient-name" class="control-label">작성자:</label>
            <input type="text" class="form-control"id="userId" name="userId" value="${sessionScope.member.userId}" disabled="disabled">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">제목:</label>
            <input type="text" class="form-control" name="subject" id="subject">
          </div>
          <div class="form-group">
            <label for="message-text" class="control-label" >내용:</label>
            <textarea class="form-control" name="content" id="content"></textarea>
          </div>
           <div class="form-group">
            <label for="message-text" class="control-label" >비밀글:</label>
            <input type="checkbox" name= "secret" id="secret">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Send</button>
      </div>
    </div>
  </div>
</div>


  											
  											<button type="button" class="btn btn-primary" data-toggle="modal"
								           data-target="#exampleModal" data-whatever="@mdo" style="width: 10" 
								           onclick="deleteOnetoone('${dto.num}', '${dto.userId}');">삭제</button>

								          
								         </c:if>
								   <c:if test="${sessionScope.member.userId=='admin'}">
								   | <a href="javascript:deleteOnetoone('${dto.num}', '${dto.userId}');">삭제</a>
								          | <a href="javascript:deleteOnetoone('${dto.num}', '${dto.userId}');">답변</a>
								   </c:if>
								   </c:if>
								   
								   
								
								  
	                           </td>
	                       </tr>
	                       <tr style='height: 50px;'>
	                           <td colspan='2'>
	                            <c:if test="${dto.secret==1}">비밀글입니다.</c:if>
	                   <c:if test="${dto.secret==0}"> ${dto.content}</c:if>
	                              
	                           </td>
	                       </tr>
	                    </c:forEach>
	                       
	                       <tr style='height: 30px;'>
	                           <td colspan='4' style='text-align: center; border-top: none;
    border-bottom:  none;
    border-right:  none;
     border-left:  none;' >
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

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</body>
</html>