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
			 지도 들어올 공간
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
			<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
	            <table class="table table-hover">
				<colgroup>
					<col style="width:20%">
					<col>
				</colgroup>
	                <thead>
	                    <tr>
	                        <th class="text-center">지점명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">하티게스트하우스</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">주소</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">제주도 한림읍 협재1길 39-5</td> 
	                    </tr>
	                </thead>
	                <tbody>
						<tr>
							<td colspan="2">
							<div>
								<div style="float: left;">
									<img src="/test/res/images/hati.png">
								</div>
								<div style="float: right; border: 1px solid #ccc;
								width: 570px; height: 300px;">
									<h4>
									${dto.memo}
									memo 들어갈 공간
									</h4>
								</div>
							</div>
							</td>
						</tr>
	                </tbody>
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