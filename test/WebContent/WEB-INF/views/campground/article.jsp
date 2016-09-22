<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
	 .schlbl {
	 	width: 150px;
	 	line-height : 30px;
	 	font-size: 20px;
	 	float: left;
	}
	.schcase {
		width: 500px;
		height: 220px;
		border:1px solid #666666;
		padding-top: 60px;
		padding-left:60px;
	}
	
	.map_list{
		border : 1px solid #000;
	}
</style>
</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>캠핑장 상세 정보</h3>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div>
			<div style="width: 1000px; height: 487px; border: 1px solid #ccc; ">
				지도 자리
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
			<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
				<colgroup>
					<col style="width:15%">
					<col style="width:30%">
					<col style="width:15%">
					<col style="width:20%">
				</colgroup>
	                <thead>
	                	<tr>
	                        <th class="text-center">캠핑장명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.placeName}
							</td> 
							<th class="text-center">지 역 명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.areaName}
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.addr}
							</td>
							<th class="text-center">연 락 처</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.tel}
							</td>  
	                    </tr>
	                </thead>
	                <tbody>
						<tr>
							<th class="text-center">상세 정보</th>
							<th>
	                			<img src="<%=cp%>/uploads/campground/${dto.filename}" width="375px" height="207px">
	                		</th>
							<td colspan="2">
								<div style="height: 190px;">
									${dto.memo2}
								</div>
							</td>
						</tr>
	                </tbody>
	                <tfoot>
	                	<tr height="45"> 
						<td colspan="5" align="center">
						<a class="btn btn-default"
						href="javascript:location.href='<%=cp%>/campground/list.do';"
						style="float: right;">목록</a>
							<c:if test="${sessionScope.member.userId=='admin'}">
								<button class="btn btn-success"
								onclick="javascript:location.href='<%=cp%>/campground/update.do?num=${dto.num}';">
								수정하기</button>
								&nbsp;
								<button class="btn btn-success"
								onclick="javascript:location.href='<%=cp%>/campground/delete.do';">
								삭제하기</button>	
		        		    </c:if>
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