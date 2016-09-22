<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="title" content="marquee">
<title>Insert title here</title>
</head>
<body>
	<div id="carousel-example-generic" class="carousel slide"
		data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>
			<li data-target="#carousel-example-generic" data-slide-to="3"></li>
			<li data-target="#carousel-example-generic" data-slide-to="4"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
		
			<div class="item active">				

				<img src="http://i2.wp.com/www.artcamping.co.kr/wp-content/uploads/2016/07/와플베드_메인_1920-1080.jpg?fit=1920%2C1080" style="background-position: center; width: 100%; height: 700px; visibility: inherit;
				 z-index: 20; opacity: 1;"
					alt="...">

				<div class="carousel-caption">
		
<div style="font-size: 36pt; font-weight: bold; float: center;">

R I V E R&nbsp;&nbsp;C A M P I N G

</div>
<h3>감성 캠핑! 아트캠핑! 재미있는 캠핑</h3>
​﻿

				</div>
			</div>
			<div class="item">
				<img src="http://i0.wp.com/www.artcamping.co.kr/wp-content/uploads/2016/07/BEACH_1920-1080-compressor.jpg?fit=1920%2C1080" style="background-position: center; width: 100%; height: 700px; visibility: inherit; 
				z-index: 20; opacity: 1;"
					alt="...">
				<div class="carousel-caption">
					<div style="font-size: 36pt; font-weight: bold; text-align: center;">

W I N T E R&nbsp;&nbsp;C A M P I N G

</div>
<h3>겨울 캠핑! 아트캠핑! 재미있는 캠핑</h3>
				</div>
			</div>
			<div class="item">
			<img src="http://i1.wp.com/www.artcamping.co.kr/wp-content/uploads/2016/07/겨울_tent-1920-눈.jpg?fit=1920%2C1208" style="background-position: center; width: 100%; height: 700px; visibility: inherit; z-index: 20; opacity: 1;"
					alt="...">
				<div class="carousel-caption">
					<div style="font-size: 36pt; font-weight: bold; text-align: center;">

B E A C H&nbsp;&nbsp;C A M P I N G

</div>
<h3>감성 캠핑! 아트캠핑! 재미있는 캠핑</h3>
				</div>
			</div>
			<div class="item">
				<img src="http://i1.wp.com/www.artcamping.co.kr/wp-content/uploads/2016/07/냇가_1920-1280_밝기.jpg?fit=1920%2C1280" style="background-position: center; width: 100%; height: 700px; visibility: inherit; 
				z-index: 20; opacity: 1;"
					alt="...">

				<div class="carousel-caption">
					<div style="font-size: 36pt; font-weight: bold; text-align: center;">

S U M M E R&nbsp;&nbsp;C A M P I N G

</div>
<h3>감성 캠핑! 아트캠핑! 재미있는 캠핑</h3>
				</div>
			</div>
			<div class="item">
			<img src="http://i0.wp.com/www.artcamping.co.kr/wp-content/uploads/2016/07/BEACH_1920-1080-compressor.jpg?fit=1920%2C1080" style="background-position: center; width: 100%; height: 700px; visibility: inherit; 
				z-index: 20; opacity: 1;"
					alt="...">

				<div class="carousel-caption">

					<div style="font-size: 36pt; font-weight: bold; text-align: center;">

F O R E S T&nbsp;&nbsp;C A M P I N G

</div>
<h3>감성 캠핑! 아트캠핑! 재미있는 캠핑</h3>
				</div>
			</div>
		</div>

		<!-- Controls -->
		<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">

			<div 
				style="margin-top: 350px; padding: 10px 30px; transform-origin: 50% 50% 0px; border-radius: 0px; border: 1px solid rgba(255, 255, 255, 0.5); 
				transition: none; color: rgba(255, 255, 255, 1); line-height: 14px; letter-spacing: 3px; font-size: 14px; font-style: normal; font-weight: 500; 
				text-decoration: none; white-space: nowrap; visibility: inherit; z-index: 8; cursor: pointer; 
				min-height: 0px; max-height: none; min-width: 0px; max-width: none; box-sizing: border-box; 
				opacity: 1; box-shadow: none; transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1); 
				background-color: rgba(0, 0, 0, 0); -webkit-box-sizing: border-box; -moz-box-sizing: border-box;"
				>PREVIOUS
			</div> <span class="sr-only">Previous</span>
		</a> 

		<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">

			<div style="margin-top: 350px; padding: 10px 30px; transform-origin: 50% 50% 0px; border-radius: 0px; border: 1px solid rgba(255, 255, 255, 0.5); 
				transition: none; color: rgba(255, 255, 255, 1); line-height: 14px; letter-spacing: 3px; font-size: 14px; font-style: normal; font-weight: 500; 
				text-decoration: none; white-space: nowrap; visibility: inherit; z-index: 8; cursor: pointer; 
				min-height: 0px; max-height: none; min-width: 0px; max-width: none; box-sizing: border-box; 
				opacity: 1; box-shadow: none; transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1); 
				background-color: rgba(0, 0, 0, 0); -webkit-box-sizing: border-box; -moz-box-sizing: border-box;"
				
				>N E X T</div> <span class="sr-only">Next</span>
		</a>
	</div>
	
</body>
</html>