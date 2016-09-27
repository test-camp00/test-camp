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

<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />

	<script type="text/javascript"
		src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

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
	border-top: 2px solid #f0f0f0;
}

.replyView {
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

function login() {
	location.href="<%=cp%>/member/login.do";
}

//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/tools/listReply.do";
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
		,url:"<%=cp%>/tools/insertReply.do"
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
		var url="<%=cp%>/tools/deleteReply.do";
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
	
	var url="<%=cp%>/tools/tool_wanted.do?${params}&num=${dto.num}";
	location.href=url;
	
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
				<button type="button" onclick="deleteTool(${dto.num})"
					class="btn btn-success" style="float: right;">삭제하기</button>
				<button type="button" onclick="updateTool(${dto.num})"
					class="btn btn-success" style="float: right; margin-right: 10px;">수정하기</button>
			</c:if>

			<h3>${dto.name}</h3>
		</div>
		<div class="topView">
			<div class="imgView">
				<div class="Largeimg">
					<c:if test="${dto.fileName!=null}">
						<img src="<%=cp%>/uploads/photo/${dto.fileName}" alt="">
					</c:if>
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
					<li><strong>추천수</strong> <span>${wanted}</span></li>
				</ul>
			</div>
			<div class="infobtnView">
				<ul>
					<li><button type="button" class="btn btn-danger btn lg" onclick="wanted();"  >좋아요</button>  </li>
					<li><button type="button" class="btn btn-primary btn lg" onclick="window.open('http://shopping.naver.com/search/all.nhn?query=${dto.name}')">찾아보기</button> </li>
				</ul>
			
			</div>

		</div>
		<div class="midleView">
			<div class="contentBox">${dto.content}</div>
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
		<div class="bottomView">
			<div style="margin: 10px;">
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

	</div>

	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>




</body>
</html>