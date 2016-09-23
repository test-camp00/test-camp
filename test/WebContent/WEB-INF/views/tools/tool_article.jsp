<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

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
	width: 400px;
	float: left;
	margin-right: 30px;
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

.midleView {
	width: 1170px;
	min-height: 400px;
	border-bottom: 2px solid #f0f0f0;
}

.contentBox {
	margin: 30px;
}

.bottomView {
	clear: both;
	width: 1170px;
	margin-top: 10px;
}

.replyView {
	border-top: 2px solid #82D580;
	margin: 20px;
	
}

.replyShow {
	border: 2px solid #82D580;
	margin: 10px;
}

.coment {
	border-bottom: 1px solid #eaeaea;
	margin: 10px;
}

.replyWrite {
	border: 2px solid #82D580;
	margin: 10px;
}

.replymemo {
	float: left;
	height: 130px;

}

.replymemo>textarea {
	margin: 10px;
}

.replymemo>button {
	margin:10px;
	width: 80px;
	height: 80px;
}



</style>

<script type="text/javascript">
function updateTool(num) {
	<c:if test="${sessionScope.member.userId=='admin'}">
	     var url="<%=cp%>/tools/tool_update.do?num=${dto.num}&page=${page}";
	     location.href=url;
	</c:if>
}

function deleteTool(num) {
	<c:if test="${sessionScope.member.userId=='admin'}">
         if(confirm("게시물을 삭제 하시겠습니까 ?")) {
        	 var url="<%=cp%>/tools/tool_delete.do?num=${dto.num}&page=${page}";
        	 location.href=url;
         }	
	</c:if>
}
</script>

</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
	<div class="container">
		<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
			<c:if test="${sessionScope.member.userId=='admin'}">
				<button type="button" onclick="deleteTool(${dto.num})" class="btn btn-success" style="float: right;">삭제하기</button>
				<button type="button" onclick="updateTool(${dto.num})" class="btn btn-success" style="float: right; margin-right: 10px;">수정하기</button>
			</c:if>

			<h3>${dto.name}</h3>
		</div>
		<div class="topView">
			<div class="imgView">
				<div class="Largeimg">
					<img src="<%=cp%>/uploads/photo/${dto.fileName}" alt="">
				</div>
			</div>
			<div class="infoView">
				<ul>
					<li><strong>제품명</strong> <span
						style="color: #00968d; font-size: 16px; font-weight: bold;">${dto.name}</span>
					</li>
					<li><strong>제품번호</strong> <span>${dto.itemCode}</span></li>
					<li><strong>제조사</strong> <span>${dto.makesa}</span></li>
					<li><strong>가격대</strong> <span>30,000</span></li>
					<li><strong>추천수</strong> <span>10</span></li>
				</ul>
			</div>

		</div>
		<div class="midleView">
			<div class="contentBox">${dto.content}</div>
		</div>
		<div class="replyView">
			<div class="replyShow">
				<div class="coment">
					<p>김춘추<p>
					<p>2011-05-08<p>
			
				</div>
				<div class="coment">
					<p>가가가<p>
					<p>2011-06-08<p>
			
				</div>
			
			
			</div>
			<div class="replyWrite">
				<div class="replymemo">
				<textarea rows="5" cols="130"></textarea>
				<button>등록</button>
				</div>
				
				
			
			</div>
		
		</div>
		<div class="bottomView">
			<div style="float: left;">
				<button type="button" class="btn btn-default">추천하기</button>
			</div>
			<div style="float: right;">
				<button type="button"
					onclick="javascript:location.href='<%=cp%>/tools/tool.do?${params}'"
					class="btn btn-default">목록으로</button>
			</div>
		</div>
		
	</div>

	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>


	<script type="text/javascript"
		src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</body>
</html>