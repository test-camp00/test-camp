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
		<h3>캠핑장 정보</h3>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div>
			<div style="float: left;">
				<h3 style="padding-bottom: 50px;">캠핑장 정보 검색</h3>
				<div class="schcase">
						<div style="margin-bottom: 10px;">
							<label class="schlbl">지역</label>
							<select class="form-control" style="width: 180px;" name="citySel">
							<option>지역선택</option>
							<option value="">서울</option>
							<option value="">인천</option>
							<option value="">경기도</option>
							<option value="">강원도</option>
							<option value="">충청북도</option>
							<option value="">세종</option>
							<option value="">대전</option>
							<option value="">충청남도</option>
							<option value="">전라북도</option>
							<option value="">광주</option>
							<option value="">전라남도</option>
							<option value="">경상북도</option>
							<option value="">대구</option>
							<option value="">울산</option>
							<option value="">경상남도</option>
							<option value="">부산</option>
							<option value="">제주도</option>
							</select><br>
						</div>
						<div>
						   <div>
							  <label class="schlbl">지점명/주소검색</label>
							  <input type="text" class="form-control" style="width: 130px; display: inline-block;" name="citySch">
							  <button type="button" class="btn btn-default" name="schbtn" >검색</button>
						</div>
						</div>
				</div>
			</div>
			<!-- 여기 -->
			<div style="text-align: center; position: relative; margin: 0; padding: 0;">	
				<img src="/test/res/images/korea_map.png"  width="296.4px" height="487.2px">
				<div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
				<span style="top: 160px; left: 50px;"><a href="#">인천</a></span>
				<span style="top: 61px; left: 185px;"><a href="#">강원</a></span>
				</div>
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
			<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
	                <thead>
	                    <tr>
	                        <th class="text-center" style="width: 70px;">번호</th>
	                        <th class="text-center" style="width: 200px;">지점명</th>
	                        <th class="text-center">주소</th>
	                        <th class="text-center" style="width: 200px;">연락처</th>
	                        <th class="text-center" style="width: 150px;">비고</th> 
	                    </tr>
	                </thead>
	                <tbody>
					  <tr>
	                        <td class="text-center">1</td>
	                        <!-- <td class="text-center"><a href='${articleUrl}&num=${dto.num}'>하티게스트하우스</a></td>-->
	                        <td class="text-center"><a href='<%=cp%>/campground/article.do'>하티게스트하우스</a></td>
	                        <td class="text-center">제주도 한림읍 협재1길 39-5</td>
	                        <td class="text-center">010-6364-6006</td>
	                        <td class="text-center">전망/분위기 좋음</td> 
						</tr>
					  <tr>
	                        <td class="text-center">2</td>
	                        <td class="text-center"><a href='${articleUrl}&num=${dto.num}'>한라산게스트하우스</a></td>
	                        <td class="text-center">제주조천읍교래리464-1</td>
	                        <td class="text-center">064-784-8488</td>
	                        <td class="text-center">등산 픽업 서비스</td> 
						</tr>
					  <c:forEach var="dto" items="${list}">
	                    <tr>
	                        <td class="text-center">${dto.listNum}</td>
	                        <td><a href='${articleUrl}&num=${dto.num}'>${dto.areaName}</a></td>
	                        <td class="text-center">${dto.addr}</td>
	                        <td class="text-center">${dto.tel}</td>
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
	        <div align="right">
		      	<button class="btn btn-default" onclick="javascript:location.href='<%=cp%>/campground/created.do';">글쓰기</button>
	      	</div>
		</div>
	</div>
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>