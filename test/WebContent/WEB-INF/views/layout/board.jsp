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
</head>
<body>


<div class="boardContainer3" >
				<div class="newCamp3" style="float:left; margin-right: 100px">
					 <h2><img src="" alt="New 최근등록 신규캠핑장" />&nbsp;&nbsp;
	                	
	                	<a href="#"><span class="glyphicon glyphicon-plus" aria-hidden="true" style="float: right"><font size="5">더보기</font></span></a>
	              		
	                 </h2>
		               <ul>
	                    <li><span class="num">1</span>[<a href=""><span class="campName2">오디고캠핑</span></a>]&nbsp;안녕하세요:) 경주 오디...<span class="date">2016-07-02</span></li>
	                    <li><span class="num">2</span>[<a href=""><span class="campName2">몽산포오션캠핑장</span></a>]&nbsp;몽산포해수욕장에 위치한...<span class="date">2016-06-22</span></li>
	                    <li><span class="num">3</span>[<a href=""><span class="campName2">완도수목원오...</span></a>]&nbsp;완도수목원과 3분거리에 ...<span class="date">2016-06-09</span></li>
	                    <li><span class="num">4</span>[<a href=""><span class="campName2">서정온천 캠핑장</span></a>]&nbsp;온천수 수영장 경기...<span class="date">2016-05-23</span></li>
	                    <li><span class="num">5</span>[<a href=""><span class="campName2">원주한울캠핑장</span></a>]&nbsp;강원도 원주시에 위치한 ...<span class="date">2016-05-08</span></li>
	                    <li><span class="num">6</span>[<a href=""><span class="campName2">꿈엔들캠프</span></a>]&nbsp;특징 1.아이들이 마음...<span class="date">2016-03-31</span></li>
	                   </ul>

					<h2><img src="" alt="New 최근등록 후기" />
       <a href="#"><span class="glyphicon glyphicon-plus" aria-hidden="true" style="float: right"><font size="5">더보기</font></span></a>
                	</h2>
						<ul>
	                    <li><span class="num">1</span>[<a href=""><span class="campName2">경주남산 가족...</span></a>]&nbsp;<a href="">재밌었어요!</a><span class="date">2016-04-28</span></li>
	                    <li><span class="num">2</span>[<a href=""><span class="campName2">해담마을 구룡...</span></a>]&nbsp;<a href="">2015년 강원도 해담마...</a><span class="date">2016-01-29</span></li>
	                    <li><span class="num">3</span>[<a href=""><span class="campName2">여수굴전여가...</span></a>]&nbsp;<a href="">여행들가시는데 식재료...</a><span class="date">2015-07-13</span></li>
	                    <li><span class="num">4</span>[<a href=""><span class="campName2">아빠캠핑가</span></a>]&nbsp;<a href="">정말 친절한 캠장님</a><span class="date">2014-09-05</span></li>
	                    <li><span class="num">5</span>[<a href=""><span class="campName2">아빠캠핑가</span></a>]&nbsp;<a href="">8월의마지막주말을 아...</a><span class="date">2014-09-05</span></li>
	                    <li><span class="num">6</span>[<a href=""><span class="campName2">포천해림캠핑장</span></a>]&nbsp;<a href="">해림캠핑랜드</a><span class="date">2014-09-04</span></li>
	                	</ul>
				
			</div>
			
			<div class="boardNew3" style="float:left; ">
				<h2 ><img src="" alt="베스트 Click 캠핑장" />&nbsp;
						<a href="#"><span class="glyphicon glyphicon-plus" aria-hidden="true" style="float: right"><font size="5">더보기</font></span></a>
				</h2>
					<ul>
							<li><span class="num">1</span>[<a href=""><span class="campName2"></span></a>]&nbsp;<span class="click">주간 140 회</span></li>
							<li><span class="num">2</span>[<a href=""><span class="campName2">두밀리낚시터&...</span></a>]&nbsp;경기 가평군<span class="click">주간 126 회</span></li>
							<li><span class="num">3</span>[<a href=""><span class="campName2">임해야영장수련원</span></a>]&nbsp;전남 고흥군<span class="click">주간 95 회</span></li>
							<li><span class="num">4</span>[<a href=""><span class="campName2">분지울작은캠핑장</span></a>]&nbsp;경기 양평군<span class="click">주간 71 회</span></li>
							<li><span class="num">5</span>[<a href=""><span class="campName2">주천강강변자...</span></a>]&nbsp;강원 횡성군<span class="click">주간 70 회</span></li>
							<li><span class="num">6</span>[<a href=""><span class="campName2">아빠캠핑가</span></a>]&nbsp;충북 진천군<span class="click">주간 66 회</span></li>
					</ul>
			
			
			
				<h2><img src="" alt="캠핑장 게시판" />
						<a href="#"><span class="glyphicon glyphicon-plus" aria-hidden="true" style="float: right"><font size="5">더보기</font></span></a>
				</h2>
					<ul class="none">

						<li><span class="num">1</span><a href="">[정보]&nbsp;5월황금 연휴캠핑</a><span class="date">2016-04-27</span></li>
						<li><span class="num">2</span><a href="">[오류정정]&nbsp;해담마을구룡령야영장 ...</a><span class="date">2016-01-29</span></li>
						<li><span class="num">3</span><a href="">[정보]&nbsp;해담마을 구룡령야영장 ...</a><span class="date">2016-01-29</span></li>
						<li><span class="num">4</span><a href="">[정보]&nbsp;해담마을 구룡령야영장 ...</a><span class="date">2016-01-29</span></li>
						<li><span class="num">5</span><a href="">[정보]&nbsp;8월 4일 해담마을 구룡...</a><span class="date">2016-01-29</span></li>
						<li><span class="num">6</span><a href="">[정보]&nbsp;해담마을 구룡령야영장...</a><span class="date">2016-01-29</span></li>
					</ul>
			</div>
		</div>
<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>	
</body>
</html>