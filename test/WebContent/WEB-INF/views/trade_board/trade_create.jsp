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
  function check() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            f.content.focus();
            return false;
        }

    	var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/trade_board/board_trade_created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/trade_board/update_ok.do";

    	// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
        return true;
 }
  
  <c:if test="${mode=='update'}">
  function deleteFile(num) {
	  var url="<%=cp%>/trade_board/deleteFile.do?num="+num+"&page=${page}";
	  location.href=url;
  }
  </c:if>
</script>
</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
<div class="container" role="main">
   	 
   	 <div class="bodyFrame col-sm-10"  style="float:none;margin:0px; padding:0px;width:1140px">
   
    
	    <h3><span class="glyphicon glyphicon-question-sign"></span> 거래게시판 </h3>
	        
	    </div>
	    <div class="alert alert-info">
	        <i class="glyphicon glyphicon-info-sign"></i> 
	        <b>사진 파일은 JPG, PNG 확장자만 화면에 보이게되며  그외의 확장자는 보이지 않고 다운 받을 수 있습니다.</b>	
	    </div>
	    
	    <div>
	        <form name="boardForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
	            <div class="bs-write">
	                <table class="table">
	                    <tbody>
	                        <tr>
	                            <td class="td1">작성자명</td>
	                            <td class="td2 col-md-5 col-sm-5">
	                                <p class="form-control-static">${sessionScope.member.userName}</p>
	                            </td>
	                            <td class="td1" align="center">&nbsp;</td>
	                            <td class="td2 col-md-5 col-sm-5">
	                                &nbsp;
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="td1">제목</td>
	                            <td colspan="3" class="td3">
	                                <input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="td1" colspan="4" style="padding-bottom: 0px;">내용</td>
	                        </tr>
	                        <tr>
	                            <td colspan="4" class="td4">
	                            	<textarea name="content" class="form-control" rows="13" required="required">${dto.content}</textarea>
	                            </td>
	                        </tr>
	                        <tr align="left" height="40" >
							     <td bgcolor="#EEEEEE" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							     <td style="padding-left:10px;"> 
				                      <input type="file" name="upload" class="boxTF" size="61" style="height: 20px;">	
							      </td>  
					 	   	</tr> 
	                    </tbody>
	                    <tfoot>
	                        <tr>
	                            <c:if test="${mode=='update'}">
				                    	<tr> 
					                        <td class="td1">첨부된파일</td>
					                        <td colspan="3" class="td3"> 
					                            <c:if test="${not empty dto.saveFilename}">
					                                ${dto.originalFilename}
					                                | <a href="javascript:deleteFile('${dto.num}');">삭제</a>
					                            </c:if>	        
					                        </td>
				                    	</tr>
		          				</c:if>
	                            <td colspan="4" style="text-align: center; padding-top: 15px;">
	                                  <button type="submit" class="btn btn-primary"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
	                                  <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/free_board/board_free.do';"> 취소 </button>
	                                  
	                                 
	                                  <c:if test="${mode=='update'}">
	                                      <input type="hidden" name="num" value="${dto.num}">
	                                      <input type="hidden" name="fileSize" value="${dto.filesize}">
	                                      <input type="hidden" name="saveFilename" value="${dto.saveFilename}">
	                                      <input type="hidden" name="originalFilename" value="${dto.originalFilename}">
	                                      <input type="hidden" name="page" value="${page}">
	                                  </c:if>
	                                  
	                            </td>
	                        </tr>
	                    </tfoot>
	                </table>
	            </div>
	        </form>
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