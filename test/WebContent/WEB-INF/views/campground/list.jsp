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
			<div>	
				<img src="/test/res/images/map2.jpg">
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div style="clear: both">
			<div>
			
<table class="map_list">
			<caption class="hidden">리스트</caption>
			<colgroup>
				<col style="width:6%;">
								<col>
								<col>
				<col style="width:33%">
				<col style="width:14%">
				<col style="width:20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" style="">지역</th>
										<th scope="col">구분</th>
										<th scope="col">지점명</th>
					<th scope="col">주소</th>
					<th scope="col">전화번호</th>
					<th scope="col">비고</th>
				</tr>
			</thead>
			<tbody>
							<tr>
					<td style=""><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북">전북</a></td>
										<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;category=국립자연휴양림">국립자연휴양림</a></td>
										<td>
						<a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=39" title="회문산 자연휴양림">회문산 자연휴양림</a>
												<a href="tel:063-653-4779" class="mobile_tel">063-653-4779</a></td>
											<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=39">
					<span class="address">전북 순창군 구림면 안심길 214</span>&nbsp;<span class="address">회문산 자연휴양림</span></a>					</td>
					<td>063-653-4779</td>
					<td></td>
				</tr>
							<tr>
					<td style=""><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북">전북</a></td>
										<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;category=국립자연휴양림">국립자연휴양림</a></td>
										<td>
						<a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=29" title="운장산 자연휴양림">운장산 자연휴양림</a>
												<a href="tel:063-432-1193" class="mobile_tel">063-432-1193</a></td>
											<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=29">
					<span class="address">전북 진안군 정천면 휴양림길 77</span>&nbsp;<span class="address">매표소</span></a>					</td>
					<td>063-432-1193</td>
					<td></td>
				</tr>
							<tr>
					<td style=""><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북">전북</a></td>
										<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;category=국립자연휴양림">국립자연휴양림</a></td>
										<td>
						<a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=15" title="변산 자연휴양림">변산 자연휴양림</a>
												<a href="tel:063-581-9977" class="mobile_tel">063-581-9977</a></td>
											<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=15">
					<span class="address">전북 부안군 변산면 변산로 3768</span>&nbsp;<span class="address">변산 자연휴양림</span></a>					</td>
					<td>063-581-9977</td>
					<td></td>
				</tr>
							<tr>
					<td style=""><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북">전북</a></td>
										<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;category=국립자연휴양림">국립자연휴양림</a></td>
										<td>
						<a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=9" title="덕유산 자연휴양림">덕유산 자연휴양림</a>
												<a href="tel:063-322-1097" class="mobile_tel">063-322-1097</a></td>
											<td><a href="http://www.artcamping.co.kr/%ec%ba%a0%ed%95%91%ec%a7%80%eb%8f%84/?&amp;sido=전북&amp;uid=9">
					<span class="address">전북 무주군 무풍면 구천동로 530-62</span>&nbsp;<span class="address">덕유산 자연휴양림</span></a>					</td>
					<td>063-322-1097</td>
					<td></td>
				</tr>
						</tbody>
		</table>

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