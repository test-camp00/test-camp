<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href=”./css/bootstrap.vertical-tabs.css” rel=”stylesheet”>
<link href=”./css/bootstrap.vertical-tabs.min.css” rel=”stylesheet”>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/css/dic/dic_tooltip.css" type="text/css">
<link href="http://googledrive.com/host/0B-QKv6rUoIcGSXVoclk5aDh4RWM" rel="stylesheet"><!-- bootstrap.vertical-tabs.min.css -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.line_bottom {border-bottom:2px solid black; text-align: center; }
.line_bottom2 {border-bottom:1px solid #ccc; text-align: center;}
.div_width {width:830px;}
</style>

</head>
<body>
<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>


  
<div class="container">

	<h2>캠핑 노하우</h2>

	<div class="col-sm-3">
	  <ul id="myTab2" class="nav nav-tabs tabs-left" role="tablist" >
	    <li role="presentation" class="active"><a href="#home2" id="home-tab2" role="tab" data-toggle="tab" style="width: 200px;">
	     
	  필수 용품 </a></li>
	    <li role="presentation" class="">
	    <a href="#profile2" role="tab" id="profile-tab2" data-toggle="tab" style="width: 200px;">
	   
	캠핑시 주의사항
	    </a></li>
	      <li role="presentation" class=""><a href="#profile3" role="tab" id="profile-tab3" data-toggle="tab" style="width: 200px;">

	   계절에 맞는 캠핑
	</a></li>
	  <li role="presentation" class=""><a href="#profile4" role="tab" id="profile-tab4" data-toggle="tab"style="width: 200px;">
	 
	    개인정보 이용방침
	  </a></li>
	  </ul>
	</div>  
	 <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------- -->  
	
	<div class="col-sm-9" align="center">
	  <div id="myTabContent2" class="tab-content">
	    <div role="tabpanel" class="tab-pane fade active in" id="home2" aria-labelledby="home-tab2">
	    
	      <div style="margin:0px auto 35px; padding-bottom: 5px; text-align: center">
	<strong id="categoryNameForTitle">[월간 <span class="word_dic en">Camping</span>]</strong>
	<p>ArtCampting의 캠핑 코디 </p>
	<div class="line_bottom div_width"><h3>캠핑 용품</h3></div>




	</div>
	<!-- ------------------------------------------------------------------------------------------ -->
	<div class="t_lv_tit">
	<h4>
	<div class="line_bottom2 div_width">Kitchen</div>
	</h4>
	</div>
	     <div class="t_ptype" style="width: 600px;">
	
	<img alt="캠핑용품 이미지 1" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/194/01.jpg?type=w646">
	
	<p class="cap">	</p>
	</div>
	<p class="t_txt">
	키친 테이블에 취사도구를 정리해 놓으면 찾기도 편하고 요리하기도 쉽다. 
캐비닛이 딸려 있으면 그릇과 냄비 등을 깔끔하게 수납할 수 있다. 가스스토브 옆 선반에 도마를 두고 재료를 다듬으면 동선도 줄일 수 있다. 
설거지통도 개수대로 오갈 때 식기류를 한 번에 담아 오갈 수 있는 요긴하다. 높아가는 기온에 식재료의 신선도를 위해 쿨박스도 필수다.
</p>
<div class="t_ptype" style="width: 600px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/59/001.jpg?type=w646">
		<p class="cap">
		<strong>＜이지캠프＞ 사린</strong><br>
		2단 정리함과 2단 사이드 테이블이 있는 키친 테이블. 메쉬 캐비닛이 있어 수납과 정리가 손쉽다. 17만원.
	</p>
</div>

<div class="t_ptype" style="width: 552px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/210/002.jpg?type=w646">
		<p class="cap">
		<strong>＜라푸마＞ 커트럴리 세트</strong><br>
		고기를 구울 때 유용한 가위와 집게가 포함된 4인용 가족 수저세트. 9만9천원.
	</p>
</div>

<div class="t_ptype" style="width: 600px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/285/04.jpg?type=w646">
		<p class="cap">
		<strong>＜라푸마＞ 스테인리스 식기세트</strong><br>
		밥그릇, 국그릇, 접시 등으로 다용도 사용할 수 있는 스테인리스 식기세트. 6만9천원.
	</p>
</div>
<div class="t_ptype" style="width: 557px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/40/05.jpg?type=w646">
		<p class="cap">
		<strong>＜라푸마＞ 프라임 메이블 쿠커세트</strong><br>
		하드 아노다이징 공법으로 알루미늄을 2.5<span class="word_dic en">mm</span> 두껍게 가공한 고급 코펠. 22만9천원.
	</p>
</div>
<div class="t_ptype" style="width: 568px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/138/06.jpg?type=w646">
		<p class="cap">
		<strong>＜파세코＞ 캠핑용 2구 가스스토브</strong><br>
		발열량이 3,100 <span class="word_dic en">kcal</span>/h로 화력이 우수하고 원터치 점화방식 시스템으로 설계돼 편리하다. 33만원.
	</p>
</div>
<div class="t_ptype" style="width: 512px;">
		<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/92/07.jpg?type=w646">
		<p class="cap">
		<strong>＜이지캠프＞ 제리 캔</strong><br>
		온오프 조절 마개와 운반손잡이가 있어 사용하기 편한 23ℓ 물통. 4만2천원.
	</p>
</div>
<!-- ------------------------------------------------------------------------------------------ -->
<div class="t_lv_tit">
<div class="line_bottom div_width"></div>
	<h4>
	<br><br>
	<div class="line_bottom2 div_width">Bedroom</div>
	</h4>
	</div>
	<div class="t_ptype" style="width: 600px;">
	
	<img alt="캠핑용품 이미지 2" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/89/02.jpg?type=w646">
	
	<p class="cap">
	</p>
</div>
<p class="t_txt">가족 구성원이 나란히 누워 살 부비며 뒹굴 수 있는 공간이자 하루 종일 야외에서 활동으로 인한 피로를 푸는 곳. 
거실형 텐트 안에 이너텐트를 설치하면 침실이 생긴다. 포근한 매트를 깔고 침낭을 펼치면 야외에서의 하룻밤이 달디 달다. 티테이블 정도 하나 놓아두면 주전자와 컵,
 휴대폰, 미니 스피커 등을 올려놓고 사용하기 편하다. 
<span class="word_dic en">LED</span>랜턴 하나면 이너텐트 안을 안전하게 밝힐 수 있다.</p>
<div class="t_ptype" style="width: 600px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/2/011.jpg?type=w646">
	
	<p class="cap">
		<strong>＜로고스＞ 안티 슬립 텐트 이너매트 270</strong><br>
		세탁이 가능한 솜 누빔 매트. 7만9천원.
	</p>
</div>
<div class="t_ptype" style="width: 600px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/257/012.jpg?type=w646">
	
	<p class="cap">
		<strong>＜로고스＞ 제미니 침낭 6</strong><br>
		6℃까지 쾌적한 춘추계용 침낭. 5만4천원.
	</p>
</div>

<div class="t_ptype" style="width: 600px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/82/013.jpg?type=w646">
	
	<p class="cap">
		<strong>＜로고스＞ 제미니 침낭 15</strong><br>
		15℃까지 쾌적한 하계용 침낭. 4만9500원.
	</p>
</div>
<div class="t_ptype" style="width: 492px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/230/014.jpg?type=w646">
	
	<p class="cap">
		<strong>＜로고스＞ 베이비 침낭</strong><br>
		아기를 따뜻하게 감싸는 포대기형 침낭. 7만9천원.
	</p>
</div>
<!-- ------------------------------------------------------------------------------------------ -->
<div class="t_lv_tit">
<div class="line_bottom div_width"></div>
	<h4>
	<br><br>
	<div class="line_bottom2 div_width">Hammock</div>
	</h4>
	</div>
<div class="t_ptype" style="width: 600px;">
	
	<img alt="캠핑용품 이미지 3" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/293/03.jpg?type=w646">
	
	<p class="cap">
	</p>
</div>
<p class="t_txt">캠핑장에서 할 일은 그다지 많지 않다. 편안히 휴식을 취하면 그뿐. 릴렉스 체어도 좋지만 해먹에 
몸을 걸치고 책을 읽거나 가벼운 낮잠을 자는 것은 캠핑에서만 즐길 수 있는 유희이기도 하다. 탁 트인 공간이라 해먹을 걸 곳이
 없다면 해먹 스탠드를 이용하면 된다.</p>
 
 <div class="t_ptype" style="width: 490px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/45/0001.jpg?type=w646">
	
	<p class="cap">
		<strong>＜라 씨에스타＞ 손리사 더블 해먹</strong><br>
		해먹텍스라는 특수 기능 원단 사용해 변색되지 않는 2인용 해먹. 13만8천원.
	</p>
</div>
<div class="t_ptype" style="width: 500px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/251/0002.jpg?type=w646">
	
	<p class="cap">
		<strong>＜라 씨에스타＞ 메디테라네오 해먹 스탠드</strong><br>
		높이와 길이를 조절할 수 있는 해먹 스탠드. 한쪽에 바퀴가 있어 이동이 쉽다. 37만3천원.
	</p>
</div>

<!-- ------------------------------------------------------------------------------------------ -->
<div class="t_lv_tit">
<div class="line_bottom div_width"></div>
	<h4>
	<br><br>
	<div class="line_bottom2 div_width">있으면 편한 용품들...</div>
	</h4>
	</div>
	<div class="t_ptype" style="width: 513px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/220/016.jpg?type=w646">
	
	<p class="cap">
		<strong>＜이지캠프＞ 휘파람 주전자</strong><br>
		물이 끓으면 휘파람 소리로 알려준다. 2만4천원.
	</p>
</div>
<div class="t_ptype" style="width: 502px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc01/2012/6/12/49/015.jpg?type=w646">
	
	<p class="cap">
		<strong>＜콜맨＞ <span class="word_dic en">CPX</span>™6 하이브리드 <span class="word_dic en">LED</span> 랜턴</strong><br>
		충전식 다목적 <span class="word_dic en">LED</span> 랜턴. 9만5천원.
	</p>
</div>
<div class="t_ptype" style="width: 460px;">
	
	<img alt="" src="http://ncc.phinf.naver.net/ncc02/2012/6/12/178/017.jpg?type=w646">
	
	<p class="cap">
		<strong>＜이지캠프＞ 미니 롤업 테이블</strong><br>
		롤업 상판 구조의 접이식 미니 테이블. 3만1천원.
	</p>
</div>

<!-- ------------------------------------------------------------------------------------------ -->
	</div>
	 
	    <div role="tabpanel" class="tab-pane fade " id="profile2" aria-labelledby="profile-tab2">
	      <p>
	      <img src="<%=cp %>/res/images/alert1.JPG" style="height: 700px; width: 500px;">
	      <br>
	      <img src="<%=cp %>/res/images/alert2.JPG" style="height: 700px; width: 500px;">
	      <br>
	      <img src="<%=cp %>/res/images/alert3.JPG" style="height: 700px; width: 500px;">
	      <br>
	      <img src="<%=cp %>/res/images/alert4.JPG" style="height: 700px; width: 500px;">
	      <br>
	      
	      </p>
	    </div>
	 <div role="tabpanel" class="tab-pane fade " id="profile3" aria-labelledby="profile-tab3">
	      <p>Profile content</p>
	    </div>
	    <div role="tabpanel" class="tab-pane fade " id="profile4" aria-labelledby="profile-tab4">
	      <div class="contents"><div>얼마 전, TV에서 아이들과 함께 떠난 첫 캠핑에서 우왕좌왕 주변 캠퍼들의 도움을 받아 우역곡절끝에 캠핑준
	      <span style="line-height: 1.5;">비를 하는 송일국의 모습이 방영되었다. 다가오는 봄에는 가족과 함께 캠핑을 떠나고자 생각했다면, 캠핑을&nbsp;</span>
	      <span style="line-height: 1.5;">떠나기 전 철저히 준비를 해 두어야 우왕좌왕하지 않는 캠핑을 즐길 수 있다.</span></div>
	      <div>
	      <br>
	      </div><div>1. 짐싣기</div><div>캠핑을 떠나기 전날 미리 캠핑을 떠날 짐을 차곡차곡 정리해 두는 것이 좋다. 음식 재료 등을 작은 위생봉지
	      <span style="line-height: 1.5;">나 크기가 같은 수납용기에 옮겨 담고 수납통이나 가방에 차곡차곡 넣어 부피를 줄이고 야외에서 금방 필요한&nbsp;</span>
	      <span style="line-height: 1.5;">것을 찾아낼 수 있도록 나누어 담는 것이 좋다. 차에 짐을 실을 때에는 무겁고 덩치가 큰 것은 아래로, 가볍</span>
	      <span style="line-height: 1.5;">고 작은 것은 위로 가도록 차곡차곡 실어주어야 한다. 오토캠핑이라도 차에 아무렇게나 실어 나르기만 하면&nbsp;</span>
	      <span style="line-height: 1.5;">된다고 생각하면 오산이다. 트렁크 문을 닫기 전에 뾰족하게 튀어나온 곳은 없는지 살펴보고, 장비 수납 시&nbsp;</span>
	      <span style="line-height: 1.5;">후방시야를 확보하는 것이 캠핑장까지 안전한 주행을 위해 좋다.</span></div><div><br></div><div>2. 자리잡기</div>
	      <div>미리 조사해 둔 캠핑장에 도착하면 하루를 보낼 좋은 자리를 찾는 것이 중요하다. 화장실, 취사장 및 편의시설과의 거리, 
	      울퉁불퉁하지 않은 바닥 상태, 그늘 여부, 소음정도 등을 따져 최선의 자리를 잡는 것이 즐거운 캠핑을 즐길 수 있는 기본 조건이다. 
	      땅이 기울어져 있다면 텐트 쪽으로 물이 흘러들어 올 수 있으니 피해야 하며 어쩔 수 없을 땐, 물길을 만들어 두어 만약의 상황을 대비하는 것이 좋다. 
	      텐트 사이트를 충분히 덮어줄 수 있는 나무 근처에 자리를 잡는 다면 더우 좋다. 타프로는 다 가려지지 않는 햇빛을 차단하고 해먹을 걸거나 빨래줄을 걸 때에도 요긴하게 이용할 수 있다.</div>
	      <div><br></div><div>3. 타프&amp;텐트 치기</div>
	      <div>좋은 자리를 선정했다면, 이제 그 공간을 우리 가족을 위한 아늑한 캠핑공간으로 꾸미는 단계가 시작된다. 주된 생활 공간이 되는 타프의 위치를 먼저 잘 잡아 설치하고 난 다음, 
	      타프의 위치, 방향, 차량의 위치, 사람들의 동선 등을 고려해 텐트까지 튼튼하게 설치를 하고 자리를 잡으면 된다.&nbsp;</div>
	      <div><br></div>
	      <div>4. 캠핑공간 배치</div><div>주방이 될 공간과 테이블의 위치, 화로와 그릴의 위치 등을 타프와 텐트의 위치에 맞게 동선이 편한 곳에 배치하면 된다. 
	      텐트 안은 바닥의 찬 공기가 올라오지 않도록 매트리스 등으로 잘 깔아주고 침낭 등을 펼쳐준 후 밤에 필요한 물품들을 안쪽으로 가지런히 정리해 둔다. 
	      주방이 될 공간에는 음식을 조리할 도구들을 배치하고 각각의 작업에 필요한 물품들을 가까이 위치해 정리해 두면 된다.</div>
	      <div><br></div>
	      <div>5. 불피우기&amp;요리하기</div><div>음식을 하기 위해 화로에 불을 피워두고 캠핑의 꽃이라 할 수 있는 음식을 준비하면 된다. 
	      완전히 어두워지기 전에 랜턴을 달아주는 데, 생활공간이 되는 타프의 상단에 캠핑장 전체를 잘 비출 수 있는 곳에 위치를 잡아 매달아 주고, 텐트 안 쪽에도 하나 준비해 둔다.</div>
	      <div><br></div><div>6. 취침</div><div>취침 시에는 화로의 불을 완전히 끄고, 주변을 깨끗하게 정리한 후 잠자리에 들도록 한다. 
	      또한 캠핑장은 밤 10시 이후에는 에티켓 타임으로 잠을 자지 않더라도 주변 캠퍼들을 위해 조용히 캠핑을 즐기도록 한다.</div><div><br></div>
	      <div>7. 정리</div>
	      <div>캠핑을 마친 후 집에 돌아가기 전에는 캠핑의 흔적이 남지 않도록 깨끗히 청소하고 올 때와 마찬가지로 차곡차곡 캠핑장비를 챙겨 차에 실을 수 있도록 한다.
	      <br></div>
	      </div>
	    </div>
	  </div>

	</div> 
 </div>


    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>


          <script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>