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

<style type="text/css">

.st>th{font-family: 'Nanum Pen Script'; font-size: 16pt; color: black; text-align: center;}
</style>
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


<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>


<div class="container">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		
		<h3 style="font-family:'Nanum Pen Script'; font-size: 25pt "><font color="#FF007F">캠핑</font>갈 때 있으면 좋은<font color="#FF007F" size="30pt" > 장비</font></h3>
	</div>

	
	<div>
	<form name="btnForm" method="post" class="form-inline">
		<div class="row">
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/tent1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="텐트이미지" name="itembtn" value="텐트" onclick="itemList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/chair1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="의자이미지" name="itembtn" value="의자" onclick="itemList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/dishes1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="식기이미지" name="itembtn" value="식기" onclick="itemList();">
	</div></div>
		</div>
		<div class="row" style="margin-top: 15px;">
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/renton1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="랜턴이미지" name="itembtn" value="랜턴" onclick="itemList();">
	</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/sleepingbag1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="침낭이미지" name="itembtn" value="침낭" onclick="itemList();">
		</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/burner1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="버너이미지" name="itembtn" value="버너" onclick="itemList();">
		</div></div>
		</div>
	</form>

	</div>
	<br>
	
	
	

	<table class="table table-striped table-bordered table-hover" style="margin-top: 0px">
			<h3 style="font-family:'Nanum Pen Script'; font-size: 30pt; float: left"><font color="#FF007F">${btnKey }</font>류</h3>
		
		<c:if test="${sessionScope.member.userId=='admin'}">
			<a href="<%=cp%>/tools/tool_created.do?"><button type="button"
					class="btn btn-success" style="float: right;margin-top: 40px">등록하기</button></a>
		</c:if>
		<thead>
			<tr class="st" style="background-color: #D5D5D5;">
				<th>구분</th>
				<th>제품번호</th>
				<th>제품명</th>
				<th>제조사</th>
				<th>추천수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}">
				<tr class="st" style="text-align: center">
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.listNum}</font></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.itemCode}</font></td>
					<td><a href='${articleUrl}&num=${dto.num}'><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.name}</font></a></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.makesa}</font></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.wanted}</font></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="paging"
		style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">
			                   <font style="font-family: 'Nanum Pen Script'; " size="5">등록된 게시물이 없습니다.</font>
			         </c:if>
		<c:if test="${dataCount!=0 }">
			               ${paging}
			         </c:if>
	</div>

	
	
		<div style="float:center; text-align: center;">
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

				<button type="button" class="btn btn-default btn-sm wbtn"
				onclick="javascript:location.href='<%=cp%>/tools/tool.do';">새로고침</button>

				<input type="hidden" name="itembtn" value="${btnKey}">

			</form>
		</div>



</div>







<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>


