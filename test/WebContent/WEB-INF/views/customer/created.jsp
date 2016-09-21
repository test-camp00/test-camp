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
<title>study</title>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<script type="text/javascript">
    function check() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return false;
        }

    	var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/customer/created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/notice/update_ok.do";

    	// image 버튼, submit은 submit() 메소드 호출하면 두번전송
        return true;
    }
</script>
</head>
<body>

<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>
<div class="layoutMain">
	
	
	<div class="layoutBody">

		<div style="min-height: 450px;">
		<div class="container">
				<div style="width:100%;	height: 40px; line-height:40px;clear: both; border-top: 1px solid #FFD8D8;border-bottom: 1px solid #FFD8D8;">
				    <div style="width:600px; height:30px; line-height:30px; margin:5px auto;">
				      
				        <span style="font-weight: bold;font-size:15pt;font-family: 나눔고딕, 맑은 고딕, 굴림; color: #F15F5F; font-weight: bold;">질문과 답변</span>
				    </div>
				</div>
</div>			
				<div style="margin: 10px auto; margin-top: 20px; width:600px; min-height: 400px;">
		
					<form name="boardForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
					  <table style="width: 600px; margin: 0px auto; border-spacing: 0px;">
					  <tr><td colspan="2" height="3" bgcolor="#FFD8D8"></td></tr>
					
					  <tr align="left" height="40"> 
					      <td width="100" bgcolor="#FFD8D8" style="text-align: center;color: #F15F5F; font-weight: bold;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					      <td width="500" style="padding-left:10px;"> 
					        <input type="text" name="subject" size="75" maxlength="100" class="boxTF" value="${dto.subject}">
					      </td>
					  </tr>
					  <tr><td colspan="2" height="1" bgcolor="#FFD8D8"></td></tr>
					  
					  <tr align="left" height="40"> 
					      <td width="100" bgcolor="#FFD8D8" style="text-align: center;color: #F15F5F; font-weight: bold;">공지</td>
					      <td width="500" style="padding-left:10px;"> 
					      <c:if test="${sessionScope.member.userId=='admin'}">
					      <input type="checkbox" name="notice" value="1" ${dto.notice==1}?"checked='checked'":"">게시글 공지
					  
					      </c:if>
					      <c:if test="${sessionScope.member.userId!='admin'}">
					      <font color="blue">게시물 공지</font>는 <font color="red" size="3pt">관리자</font>만 가능
					      </c:if>
					   
					      </td>
					  </tr>
				      <tr><td colspan="2" height="1" bgcolor="#FFD8D8"></td></tr>
				      
					  <tr align="left"> 
					      <td width="100" bgcolor="#FFD8D8" style="text-align: center; padding-top:5px;color: #F15F5F; font-weight: bold;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					      <td width="500" valign="top" style="padding:5px 0px 5px 10px;"> 
					        <textarea name="content" cols="75" rows="12" class="boxTA">${dto.content}</textarea>
					      </td>
					  </tr>
				      <tr><td colspan="2" height="1" bgcolor="#FFD8D8"></td></tr>
					  <tr align="left" height="50" >
					      <td bgcolor="#FFD8D8" style="text-align: center; color: #F15F5F; font-weight: bold;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
					      <td style="padding-left:10px;"> 
		                      <input type="file" name="upload" class="boxTF" size="61" style="height: 30px;">			           
					       </td>
					  </tr> 

					  <tr><td colspan="2" height="3" bgcolor="#FFD8D8"></td></tr>
					  </table>
					
					  <table style="width: 600px; margin: 0px auto; border-spacing: 0px;">
					     <tr height="45"> 
					      <td align="center" >
					
						    <input type="image" src="<%=cp%>/res/images/btn_submit.gif" >
		        		    <a href="javascript:location.href='<%=cp%>/customer/list.do';"><img src="<%=cp%>/res/images/btn_cancel.gif" border="0"></a>
	
					      </td>
					    </tr>
					  </table>
					</form>
				</div>
		</div>

    </div>

		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

</div>

</body>
</html>