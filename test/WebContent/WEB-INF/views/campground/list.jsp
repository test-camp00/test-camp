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
	 	width: 180px;
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

<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container" role="main">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<c:if test="${sessionScope.member.userId=='admin'}">
			<button type="button" class="btn btn-success" style="float: right;"
			onclick="javascript:location.href='<%=cp%>/campground/created.do';"
			>등록하기</button>
		</c:if>
		<h3>캠핑장 정보</h3>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div>
			<div style="float: left;">
				<h3 style="padding-bottom: 50px;">캠핑장 정보 검색</h3>
				<div class="schcase">
						<div style="margin-bottom: 10px;">
							<label class="schlbl">지역</label>
							<select class="form-control" style="width: 180px;" name="searchArea">
							<option value="지역선택">지역선택</option>
							<option value="서울">서울</option>
							<option value="인천">인천</option>
							<option value="경기도">경기도</option>
							<option value="강원도">강원도</option>
							<option value="충청북도">충청북도</option>
							<option value="세종">세종</option>
							<option value="대전">대전</option>
							<option value="충청남도">충청남도</option>
							<option value="전라북도">전라북도</option>
							<option value="광주">광주</option>
							<option value="전라남도">전라남도</option>
							<option value="경상북도">경상북도</option>
							<option value="대구">대구</option>
							<option value="울산">울산</option>
							<option value="경상남도">경상남도</option>
							<option value="부산">부산</option>
							<option value="제주도">제주도</option>
							</select><br>
						</div>
						<div>
						   <div>
							  <label class="schlbl">캠핑장명/주소검색</label>
							  <input type="text" class="form-control" style="width: 130px; display: inline-block;" name="searchValue">
							  <button type="button" class="btn btn-default" name="schbtn" >검색</button>
						</div>
						</div>
				</div>
			</div>
			<div style="text-align: center; margin: 0; padding: 0;">	
				<img src="/test/res/images/korea_map.png"  width="296.4px" height="487.2px">
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
			<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th class="text-center" style="width: 80px;">지역</th>
	                        <th class="text-center" style="width: 200px;">캠핑장명</th>
	                        <th class="text-center">주소</th>
	                        <th class="text-center" style="width: 200px;">연락처</th>
	                        <th class="text-center" style="width: 150px;">간단정보</th> 
	                    </tr>
	                </thead>
	                <tbody>
						<c:forEach var="dto" items="${list}">
	                    	<tr>
		                        <td class="text-center">${dto.areaName}</td>
		                        <td><a href='${articleUrl}&num=${dto.num}'>${dto.placeName}</a></td>
		                        <td class="text-center"><a href='${articleUrl}&num=${dto.num}'>${dto.addr}</a></td>
		                        <td class="text-center">${dto.tel}</td>
		                        <td class="text-center">${dto.memo1}</td>
	                    	</tr>
                   		</c:forEach> 
	                </tbody>
	                <tfoot>
	                
	                </tfoot>
	            </table>
	        </div>
	
	        <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
			        <c:if test="${dataCount==0 }">
			                   등록된 게시물이 없습니다.
			         </c:if>
			        <c:if test="${dataCount!=0 }">
			               ${paging}
			         </c:if>
	        </div>
		</div>
	</div>
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>