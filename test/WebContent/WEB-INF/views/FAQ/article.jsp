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

.bbs-reply {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bbs-reply-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin'}">
function deleteFAQ(num) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
    var num = "${dto.num}";
    var page = "${page}";
    var params = "num="+num+"&page="+page;
    var url = "<%=cp%>/FAQ/delete.do?" + params;

    if(confirm("위 자료를 삭제하시겠습니까 ? "))
    	location.href=url;
</c:if>    
	}
</c:if>
	function updateFAQ() {
		<c:if test="${sessionScope.member.userId=='admin'}">
	    var num = "${dto.num}";
	    var page = "${page}";
	    var params = "num="+num+"&page="+page;
	    var url = "<%=cp%>/FAQ/update.do?" + params;

	    if(confirm("위 자료를 수정하시겠습니까? "))
	    	location.href=url;
	</c:if>
	
	    
	}
	    
	

</script>

</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container">	
	<div class="table-responsive" style="clear: both;">
        <div class="bbs-article">
            <table class="table">
                 <thead>
                     <tr>
                         <th colspan="2" style="text-align: left;">
                             내용: ${dto.subject}
                         </th>
                     </tr>
                <thead>
                 <tbody>
                     <tr>
                         <td style="text-align: left;">
                                            이름 : 관리자
                         </td>	                         
                     </tr>
                     <tr>
                         <td colspan="2" style="height: 230px;">
                              ${dto.content}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
						      <c:if test="${not empty preReadDto }">
							      <a href="<%=cp%>/FAQ/article.do?${params}&num=${preReadDto.num}">${preReadDto.subject}</a>
						       </c:if>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
						      <c:if test="${not empty nextReadDto }">
							      <a href="<%=cp%>/FAQ/article.do?${params}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
						       </c:if>
                         </td>
                     </tr>
                </tbody>
                <tfoot>
                	<tr>
                		<td>
	                        <c:if test="${sessionScope.member.userId=='admin'}">		                		
                		        <button type="button" class="btn btn-default btn-sm wbtn" onclick="updateFAQ();">수정</button>
                		    </c:if>
	                        <c:if test="${sessionScope.member.userId=='admin'}">    
                		        <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteFAQ();">삭제</button>
                		    </c:if>
                		</td>
                		<td align="right">
                		    <button type="button" class="btn btn-default btn-sm wbtn"
                		                onclick="javascript:location.href='<%=cp%>/FAQ/list.do?${params}';"> 목록으로 </button>
                		</td>
                	</tr>
                </tfoot>
            </table>
       </div>
	</div>
</div>	
	 <div>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
 </div> 
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>       
        
</body>
</html>