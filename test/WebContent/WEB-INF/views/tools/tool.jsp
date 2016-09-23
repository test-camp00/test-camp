<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />

<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
<<<<<<< HEAD
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/tools/tool.do";
		f.submit();
	}
	
	function itemList() {
		var f=document.btnForm;
		f.action="<%=cp%>/tools/tool.do";
		f.submit();
		
	}
</script>
	
=======
>>>>>>> branch 'master' of https://github.com/test-camp00/test-camp.git

<div style="height: 205px">
<div style=" height: 10px;  border-bottom: 50px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<c:if test="${sessionScope.member.userId=='admin'}">
			<a href="<%=cp%>/tools/tool_created.do"><button type="button"
					class="btn btn-success" style="float: right;">등록하기</button></a>
		</c:if>

		<h3>캠핑용품</h3>

	</div>
	<div>
	<form name="btnForm" method="post" class="form-inline">
		<div class="row">
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/tent1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="텐트이미지" name="itembtn" value="텐트" onclick="itemList();">
			</div>
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/chair1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="의자이미지" name="itembtn" value="의자" onclick="itemList();">
			</div>
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/dishes1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="식기이미지" name="itembtn" value="식기" onclick="itemList();">
			</div>
		</div>
		<div class="row" style="margin-top: 15px;">
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/renton1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="랜턴이미지" name="itembtn" value="랜턴" onclick="itemList();">
			</div>
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/sleepingbag1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="침낭이미지" name="itembtn" value="침낭" onclick="itemList();">
			</div>
			<div class="col-md-12 col-md-4">
				<input type="image" src="<%=cp%>/images/burner1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;" alt="버너이미지" name="itembtn" value="버너" onclick="itemList();">
			</div>
		</div>
	</form>

	</div>
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>${btnKey }류</h3>
	</div>

	<table class="table table-striped table-bordered table-hover">
		<caption>테이블 설명</caption>
		<thead>
			<tr>
				<th>#</th>
				<th>제품번호</th>
				<th>제품명</th>
				<th>제조사</th>
				<th>이미지</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<td class="text-center">${dto.listNum}</td>
					<td class="text-center">${dto.itemCode}</td>
					<td><a href='${articleUrl}&num=${dto.num}'>${dto.name}</a></td>
					<td class="text-center">${dto.makesa}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="paging"
		style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">
			                   등록된 게시물이 없습니다.
			         </c:if>
		<c:if test="${dataCount!=0 }">
			               ${paging}
			         </c:if>
	</div>

	<div style="clear: both;">
		<div style="float: left; width: 20%; min-width: 85px;">
			<button type="button" class="btn btn-default btn-sm wbtn"
				onclick="javascript:location.href='<%=cp%>/tools/tool.do';">새로고침</button>
		</div>
		<div style="float: left; width: 60%; text-align: center;">
			<form name="searchForm" method="post" class="form-inline">
				<select class="form-control input-sm" name="searchKey">
					<option value="itemCode">제품번호</option>
					<option value="name">제품명</option>
					<option value="makesa">제조사</option>
				</select> <input type="text" class="form-control input-sm input-search"
					name="searchValue">
				<button type="button" class="btn btn-info btn-sm btn-search"
					onclick="searchList();">
					<span class="glyphicon glyphicon-search"></span> 검색
				</button>
			</form>
		</div>
	</div>


</div>







<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>


