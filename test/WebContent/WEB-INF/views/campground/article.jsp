<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");

	String pageNum=request.getParameter("page");
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
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=NOmF6r8jcAzGunBfUNAa"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	.topView {
		width: 1170px;
		height: 400px;
		border-bottom: 2px solid #f0f0f0;
	}
	
	.imgView {
		width: 500px;
		float: left;
		margin-right: 30px;
	}
	
	.infoView {
		width: 500px;
		float: left;
	}
	
	.imgView img {
		width: 500px;
		height: 370px;
	}
	
	.Largeimg {
		width: 500px;
		height: 370px;
	}
	
	.infoView>ul {
		list-style: none;
	}
	
	.infoView>ul>li {
		margin-top: 30px;
		width: 100%;
		border-bottom: 1px solid #f0f0f0;
		padding-bottom: 16px;
	}
	
	.infoView>ul>li>strong {
		margin-right: 50px;
		width: 100px;
		display: block;
		float: left;
		padding: 3px 0;
		line-height: 25px;
	}
	
	.infobtnView {
		margin-top : 230px;
		width: 200px;
		float: left;
	}
	
	.infobtnView>ul {
		list-style: none;
	}
	
	.infobtnView>ul>li {
		margin: 10px;
		width: 100%;
		padding-bottom: 16px;
	}
	
	.infobtnView>ul>li>button {
		width: 100%;
	}
	
	.midleView {
		width: 1170px;
		min-height: 250px;
		border-bottom: 2px solid #f0f0f0;
	}
	
	.contentBox {
		margin: 30px;
	}
	
	.bottomView {
		clear: both;
		width: 1170px;
		margin-top: 10px;
		border-top: 2px solid #f0f0f0;
	}
	
	.replyView {
		margin: 20px;
	}
	
	.replyShow {
		border: 2px solid #82D580;
		margin: 10px;
	}
	
	.comment {
		border-bottom: 1px solid #eaeaea;
		margin: 10px;
	}
	
	.replyWrite {
		margin: 10px;
	}
	
	.replymemo {
		float: left;
	}
	
	.replyWrite>textarea {
		width: 100%;
	}
</style>
<script type="text/javascript">

//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/campground/listReply.do";
	var num="${dto.num}";
	$.post(url, {num:num, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

function sendReply() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var num="${dto.num}"; // 해당 게시물 번호
	var content=$.trim($("#content").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#content").focus();
		return false;
	}
	
	var params="num="+num;
	params+="&content="+content;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/campground/insertReply.do"
		,data:params
		,dataType:"json"
		,success:function(data) {
			$("#content").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

function deleteReply(replyNum, pageNo, userId) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/campground/deleteReply.do";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data){
		        var state=data.state;
				if(state=="loginFail") {
					login();
				} else {
					listPage(pageNo);
				}
		}, "json");
	}
}

function wanted() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	var url="<%=cp%>/campground/campground_wanted.do?${params}&num=${dto.num}";
	location.href=url;
}




</script>
</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container" role="main">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<c:if test="${sessionScope.member.userId=='admin'}">
			<button class="btn btn-success" style="float: right;"
			onclick="javascript:location.href='<%=cp%>/campground/delete.do?page=${page}&num=${dto.num}';">
			삭제하기</button>	
			<button class="btn btn-success" style="float: right; margin-right:10px"
			onclick="javascript:location.href='<%=cp%>/campground/update.do?num=${dto.num}';">
			수정하기</button>
	    </c:if>
		<h3>${dto.placeName}</h3>
	</div>
			<div class="topView">
			<div class="imgView">
				<div class="Largeimg">
					<c:if test="${dto.filename!=null}">
						<img src="<%=cp%>/uploads/campground/${dto.filename}" alt="">
					</c:if>
				</div>
			</div>
			<div class="infoView">
				<ul>
					<li><strong>캠핑장명</strong> <span
						style="color: #00968d; font-size: 16px; font-weight: bold;">${dto.placeName}</span>
					</li>
					<li><strong>지역명</strong> <span>${dto.areaName}</span></li>
					<li><strong>주  소</strong> <span>${dto.addr}</span></li>
					<li><strong>연락처</strong> <span>${dto.tel}</span></li>
					<li><strong>추천수</strong> <span>${wanted}</span>&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-danger btn lg" onclick="wanted();">좋아요</button></li>
				</ul>
			</div>

		</div>
		<div class="midleView">
			<div class="contentBox">${dto.memo2}</div>
		</div>
	<div style="width:1000px; height: 500px; margin:20px auto;">
		<div id="map" style="width:100%;height:100%;"></div>
		<script>
		// 주소에 따른 좌표 정보 가져오기 
			function getNaverGeocode($addr, $cId, $cSecret) {
			 //$addr = urlencode($addr);
			 $addr=encodeURI($addr);
			 $url = "https://openapi.naver.com/v1/map/geocode?encoding=utf-8&coord=latlng&output=json&query=".$addr;
	
			 $headers = new Array();
			 $headers[0] = "GET https://openapi.naver.com/v1/map/geocode?".$addr;
			 $headers[1] ="Host: openapi.naver.com";
			 $headers[2] ="Accept: */*";
			 $headers[3] ="Content-Type: application/json";
			 $headers[4] ="X-Naver-Client-Id: ".$cId;
			 $headers[5] ="X-Naver-Client-Secret: ".$cSecret;
			 $headers[6] ="Connection: Close";
	
			 $result = getHttp($url, $headers);
	
			 return $result;
			}

			
			// curl 통신 하기
			function getHttp($url, $headers=null){
				 $ch = curl_init();
		
				 curl_setopt($ch, CURLOPT_URL, $url);
				 curl_setopt($ch, CURLOPT_HEADER, false);
				 curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
				 $result = curl_exec($ch);
				 curl_close($ch);
		
				 return $result;
			}
			
			// $addr="${dto.addr}";
			$addr="제주특별자치도 제주시 광양9길 10 제주시청";
			$cId="NOmF6r8jcAzGunBfUNAa";
			$cSecret="Ie8Ng5aUgW";
			
			$geo = getNaverGeocode($addr, $cId, $cSecret);
			$data = json_decode($geo,1);
	
			$map_x_point = $data['result']['items'][0]['point']['x'];
			$map_y_point = $data['result']['items'][0]['point']['y'];
	
			
		
			var map = new naver.maps.Map('map', {
			    center: new naver.maps.LatLng(37.3595704, 127.105399),
			    zoom: 11
			});
			
			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(37.3595704, 127.105399),
			    map: map
			});		
		</script>
	</div>
	<div class="replyView">
		<div class="replyShow">
			<div id="listReply"></div>
		</div>
		<div style="border: 2px solid #82D580; margin: 10px;">
			<div style="margin: 10px;">
				<span style="color: #008100; font-weight: bold;">코멘트 입력</span>			
			</div>
			<div class="replyWrite">
				<textarea id="content" required="required" rows="4"></textarea>
			</div>
			<div style="margin: 5px; text-align: right;">
				<button type="button" class="btn btn-success" onclick="sendReply();">덧글쓰기</button>
			</div>
		</div>
	</div>
	<a class="btn btn-default"
	href="javascript:location.href='<%=cp%>/campground/list.do?page=${page}';"
	style="float: right;">목록으로</a>
</div>
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>