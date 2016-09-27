<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String cp = request.getContextPath();
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


<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<script type="text/javascript">
    function check() {
        var f = document.FAQForm;

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
    		f.action="<%=cp%>/FAQ/created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/FAQ/update_ok.do";    	

    	// image 버튼, submit은 submit() 메소드 호출하면 두번전송
        return true;
    }
</script>
</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="layoutMain" style="padding-left: 20%; padding-right: 20%;">	
	<div class="layoutBody">
		<div style="height: 450px; ">
				
				    <div style="width:600px; height:30px;  ">
				        <img src="<%=cp%>/res/images/arrow.gif" style="padding-left: 5px; padding-right: 5px; ">
				        <span style="font-weight: bold;font-size:13pt;font-family: 나눔고딕, 맑은 고딕, 굴림; text-align: left" >질문과 답변</span>
				    </div>
				
			
				<div>
	        <form name="FAQForm" method="post" onsubmit="return check();">
	            <div class="bs-write">
	                <table class="table" style="text-align: left; border-bottom: 0px; " >
	                    <tbody>                     
	                        
	                            <h5 class="td1" colspan="4" style="padding-bottom: 0px;">☞ 제목</h5>
	                        
	                        <div>
	                            <span colspan="4" class="td2">
	                            	<textarea name="subject" class="form-control" rows="1" required="required">${dto.subject}</textarea>
	                            </span>
	                        </div>
	                        
	                            <h5 class="td1" colspan="4" style="padding-bottom: 0px;">☞ 내용</h5>
	                        
	                        <div>
	                            <span colspan="4" class="td4">
	                            	<textarea name="content" class="form-control" rows="13" required="required">${dto.content}</textarea>
	                            </span>
	                        </div>
	                    </tbody>
	                    <tfoot>
	                        <tr>
	                            <td colspan="4" style="text-align: center; padding-top: 15px;">
	                                  <button type="submit" class="btn btn-success"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
	                                  <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/FAQ/list.do';"> 취소 <span class="glyphicon glyphicon-ok"></span></button>
	                                  
	                                  <c:if test="${mode=='update'}">
	                                      <input type="hidden" name="num" value="${dto.num}">
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
	</div>
</div>

  <div>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
 </div> 
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>       
        
</body>
</html>