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
				<img src="images/capming3.JPG" style="width: 100%; height: 500px;"
					alt="...">

				<div class="carousel-caption">
					<h2>신촌 캠핑장</h2>
				</div>
			</div>
			<div class="item">
				<img src="images/capming2.JPG"
					style="width: 100%; height: 500px; vertical-align: middle"
					alt="...">
				<div class="carousel-caption">
					<h2>부천 역곡 캠핑장</h2>
				</div>
			</div>
			<div class="item">
				<img src="images/capming1.JPG"
					style="width: 100%; height: 500px; vertical-align: middle"
					alt="...">
				<div class="carousel-caption">
					<h2>서울 강남 캠핑장</h2>
				</div>
			</div>
			<div class="item">
				<img src="images/capming4.JPG"
					style="width: 100%; height: 500px; vertical-align: middle"
					alt="...">
				<div class="carousel-caption">
					<h2>여의도 한강 캠핑장</h2>
				</div>
			</div>
			<div class="item">
				<img src="images/capming5.JPG"
					style="width: 100%; height: 500px; vertical-align: middle"
					alt="...">
				<div class="carousel-caption">

					<div class="tp-caption NotGeneric-SubTitle   tp-resizeme"
						id="slide-29-layer-4"
						style="border-width: 0px; margin: 0px; padding: 0px; transform-origin: 50% 50% 0px; transition: none; line-height: 20px; letter-spacing: 4px; font-size: 15px; font-weight: 500; white-space: nowrap; visibility: inherit; z-index: 7; min-height: 0px; max-height: none; min-width: 0px; max-width: none; opacity: 1; transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1);"
						data-responsive_offset="on" data-start="1000"
						data-mask_in="x:0px;y:[100%];s:inherit;e:inherit;"
						data-transform_out="x:{-250,250};y:{-150,150};rX:{-90,90};rY:{-90,90};rZ:{-360,360};sX:0;sY:0;opacity:0;s:1000;e:Power2.easeInOut;"
						data-transform_in="y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;s:1500;e:Power4.easeInOut;"
						data-transform_idle="o:1;"
						data-height="['auto','auto','auto','auto']"
						data-width="['auto','auto','auto','auto']" data-voffset="-20"
						data-y="center" data-hoffset="" data-x="center"
						data-splitout="none" data-splitin="none">
						<h2>제주 폐교 캠핑장</h2>
						<br>해변의 뜨거운 모래에서 바닷바람의 시원함을 즐기는 캠핑매트
					</div>
				</div>
			</div>
		</div>

		<!-- Controls -->
		<a class="left carousel-control" href="#carousel-example-generic"
			role="button" data-slide="prev">
			<div
				class="tp-caption NotGeneric-Button rev-btn  noSwipe rs-hover-ready"
				id="slide-30-layer-7"
				style="margin-top: 250px; padding: 10px 30px; transform-origin: 50% 50% 0px; border-radius: 0px; border: 1px solid rgba(255, 255, 255, 0.5); transition: none; color: rgba(255, 255, 255, 1); line-height: 14px; letter-spacing: 3px; font-size: 14px; font-style: normal; font-weight: 500; text-decoration: none; white-space: nowrap; visibility: inherit; z-index: 8; cursor: pointer; min-height: 0px; max-height: none; min-width: 0px; max-width: none; box-sizing: border-box; opacity: 1; box-shadow: none; transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1); background-color: rgba(0, 0, 0, 0); -webkit-box-sizing: border-box; -moz-box-sizing: border-box;"
				data-responsive="off" data-responsive_offset="on" data-start="1600"
				data-transform_out="x:{-250,250};y:{-150,150};rX:{-90,90};rY:{-90,90};rZ:{-360,360};sX:0;sY:0;opacity:0;s:1000;e:Power2.easeInOut;
    	  "
				data-transform_in="y:50px;opacity:0;s:1250;e:Power4.easeInOut;"
				data-transform_idle="o:1;"
				data-height="['auto','auto','auto','auto']"
				data-width="['auto','auto','auto','auto']" data-voffset="200"
				data-y="center" data-hoffset="" data-x="center" data-splitout="none"
				data-splitin="none"
				data-actions='[{"event":"click","action":"jumptoslide","slide":"rs-29","delay":""}]'
				data-style_hover="c:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);"
				data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;">PREVIOUS
			</div> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#carousel-example-generic"
			role="button" data-slide="next">

			<div
				class="tp-caption NotGeneric-Button rev-btn  noSwipe rs-hover-ready"
				id="slide-30-layer-7"
				style="margin-top: 250px; padding: 10px 30px; transform-origin: 50% 50% 0px; border-radius: 0px; border: 1px solid rgba(255, 255, 255, 0.5); transition: none; color: rgba(255, 255, 255, 1); line-height: 14px; letter-spacing: 3px; font-size: 14px; font-style: normal; font-weight: 500; text-decoration: none; white-space: nowrap; visibility: inherit; z-index: 8; cursor: pointer; min-height: 0px; max-height: none; min-width: 0px; max-width: none; box-sizing: border-box; opacity: 1; box-shadow: none; transform: matrix3d(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1); background-color: rgba(0, 0, 0, 0); -webkit-box-sizing: border-box; -moz-box-sizing: border-box;"
				data-responsive="off" data-responsive_offset="on" data-start="1600"
				data-transform_out="x:{-250,250};y:{-150,150};rX:{-90,90};rY:{-90,90};rZ:{-360,360};sX:0;sY:0;opacity:0;s:1000;e:Power2.easeInOut;
    	  "
				data-transform_in="y:50px;opacity:0;s:1250;e:Power4.easeInOut;"
				data-transform_idle="o:1;"
				data-height="['auto','auto','auto','auto']"
				data-width="['auto','auto','auto','auto']" data-voffset="200"
				data-y="center" data-hoffset="" data-x="center" data-splitout="none"
				data-splitin="none"
				data-actions='[{"event":"click","action":"jumptoslide","slide":"rs-29","delay":""}]'
				data-style_hover="c:rgba(255, 255, 255, 1.00);bc:rgba(255, 255, 255, 1.00);"
				data-transform_hover="o:1;rX:0;rY:0;rZ:0;z:0;s:300;e:Power1.easeInOut;">N
				E X T</div> <span class="sr-only">Next</span>
		</a>
	</div>
	<script type="text/javascript">
		$('.carousel').carousel({
			interval : 2000
		})
	</script>
</body>
</html>