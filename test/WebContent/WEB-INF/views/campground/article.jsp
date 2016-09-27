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
		<h3>캠핑장 상세 정보</h3>
	</div>
	<div style="width:1000px; height: 500px; margin:0px auto;">
		<div>
			<div style="width: 1000px; height: 487px; border: 1px solid #ccc; ">
				지도 자리
			</div>
		</div>
	</div>
	<div style="width:1000px; height: 350px; margin:0px auto;">
			<div>
	            <table class="table table-hover">
				<colgroup>
					<col style="width:15%">
					<col style="width:30%">
					<col style="width:15%">
					<col style="width:20%">
				</colgroup>
	                <thead>
	                	<tr>
                        	<th class="text-center">캠핑장명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.placeName}
							</td> 
							<th class="text-center">지 역 명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.areaName}
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.addr}
							</td>
							<th class="text-center">연 락 처</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								${dto.tel}
							</td>  
	                    </tr>
	                </thead>
	                <tbody>
						<tr>
							<th class="text-center">상세 정보</th>
							<th>
	                			<img src="<%=cp%>/uploads/campground/${dto.filename}" width="375px" height="207px">
	                		</th>
							<td colspan="2">
								<div style="height: 190px;">
									${dto.memo2}
								</div>
							</td>
						</tr>
	                </tbody>
	            </table>
	        </div>
        <div style="margin-left: 450px">
        <strong>추천수</strong> <span>${wanted}</span>
		<button type="button" class="btn btn-danger btn lg" onclick="wanted();">좋아요</button>
		</div>	        
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