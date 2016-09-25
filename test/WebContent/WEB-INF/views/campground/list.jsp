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
	
	.area_name:HOVER {
		
	}
</style>
<script type="text/javascript">
	var mapset=true;
	var mapset_sudo=false;
	
	console.log(mapset);
	console.log(mapset_sudo);
	
	function map_sudo(){
		if(mapset==true){
			mapset=false;
		}
		mapset_sudo=true;
		

		console.log("ss");
		console.log(mapset);
		console.log(mapset_sudo);
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
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<c:if test="${sessionScope.member.userId=='admin'}">
			<button type="button" class="btn btn-success" style="float: right;"
			onclick="javascript:location.href='<%=cp%>/campground/created.do';"
			>등록하기</button>
		</c:if>
		<h3>캠핑장 정보</h3>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div style="float: left;">
			<h3 style="padding-bottom: 50px;">캠핑장 정보 검색</h3>
			<form action="<%=cp%>/campground/list.do">
			<div class="schcase">
				<div style="margin-bottom: 10px;">
					<label class="schlbl">지역</label>
					<select class="form-control" style="width: 180px;" name="searchArea">
					<option value="">지역선택</option>
					<option value="수도권">수도권</option>
					<option value="강원도">강원도</option>
					<option value="충청도">충청도</option>
					<option value="전라도">전라도</option>
					<option value="경상도">경상도</option>
					<option value="제주도">제주도</option>
					</select><br>
				</div>
				<div>
				   <div>
					  <label class="schlbl">캠핑장명/주소검색</label>
					  <input type="text" class="form-control" style="width: 130px; display: inline-block;" name="searchValue">
					  <input type="submit" class="btn btn-default" value="검색">
				</div>
				</div>
			</div>
			</form>
		</div>
		<div style="text-align: center; margin: 0; padding: 0; float: right;">	
			<div style="width: 280px; height: 420px;">
				<c:if test="${mapset==true}">
				<img src="<%=cp%>/res/images/map_default.png">
				</c:if>
				<c:if test="${mapset_sudo==true}">
				<img src="<%=cp%>/res/images/map_seoul.png">
				</c:if>
			</div>
			<!--  <div style="background: url('<%=cp%>/res/images/map_default.png');"> -->
			<div>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=수도권" onclick="map_sudo();">수도권</a>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=강원도">강원도</a>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=충청도">충청도</a>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=전라도">전라도</a>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=경상도">경상도</a>
			<a class="area_Name" href="<%=cp%>/campground/list.do?searchArea=제주도">제주도</a>
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
			<div class="table-responsive" style="clear: both;"> 
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
		                        <td class="text-center"><a href="<%=cp%>/campground/list.do?searchArea=${dto.areaName}">${dto.areaName}</a></td>
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