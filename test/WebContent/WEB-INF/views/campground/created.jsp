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
	<!-- <form > -->
		<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
			<h3>캠핑장 정보 입력</h3>
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
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" style="width: 100%;">
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">주&nbsp;&nbsp;&nbsp;&nbsp;소</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" style="width: 100%;">
							</td> 
	                    </tr>
	                </thead>
	                <tbody>
						<tr>
							<th class="text-center">상세 정보</th>
							<td colspan="2">
								<div>
									<div>
										<textarea style="width: 100%; height: 300px;"></textarea>
									</div>
									<div style="float: left;">
										<input type="file" name="upload" class="boxTF">
									</div>
								</div>
							</td>
						</tr>
	                </tbody>
	                <tfoot>
						<tr height="45"> 
						<td colspan="2" align="center">
							<input type="submit" class="btn btn-default" value="작성 완료">
		        		    &nbsp;&nbsp;&nbsp;
		        		    <button type="reset" class="btn btn-default">다시 입력</button>
		        		    &nbsp;&nbsp;&nbsp;
		        		    <button class="btn btn-default" onclick="javascript:location.href='<%=cp%>/campground/list.do';">취소</button>
						</td>
						</tr>
				  </tfoot>
	            </table>
	        </div>
		</div>
	<!-- </form> -->
</div>
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>