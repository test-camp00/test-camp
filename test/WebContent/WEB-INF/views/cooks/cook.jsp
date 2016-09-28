<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">

<style type="text/css">

a{
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}
a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
}
.btn {
	 font-size: 12px;
	 color:#333;
 	 font-weight:500;
	 font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	 border:1px solid #ccc;
	 background-color:#FFF;
	 vertical-align:middle;
	 text-align:text-align;
	 cursor:cursor;
	 padding:4px 8px;
	 border-radius:4px;
	 margin-bottom: 3px;
} 
.btn:active, .btn:focus, .btn:hover {
	 background-color:#e6e6e6;
	 border-color: #adadad;
	 color: #333;
}
.boxTF {
	border:1px solid #999;
	padding:4px 6px;
	border-radius:4px;
	background-color:#ffffff;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}
.selectField {
	border:1px solid #999;
	padding:3px 6px;
	border-radius:4px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}
.st>th{font-family: 'Nanum Pen Script'; font-size: 16pt; color: black; text-align: center;}

</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/cooks/cook.do";
		f.submit();
	}
	
	function cookList() {
		var f=document.btnForm;
		f.action="<%=cp%>/cooks/cook.do";
		f.submit();
		
	}
	
	function wanted() {
		var uid="${sessionScope.member.userId}";
		if(! uid) {
			login();
			return false;
		}
		f.action="<%=cp%>/cooks/cook.do";
		f.submit();
		
	}
	
	
</script>

</head>
<body>

<div style="height: 215px">
<div style=" height: 10px;  border-bottom: 60px solid #3cb371; margin-top: 0px">
  <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
</div>

<div class="container" >

     <div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
    
		<h3 style="font-family:'Nanum Pen Script'; font-size: 25pt "><font color="#FF007F">캠핑장</font>에서 즐길 수 있는 맛있는 <font color="#FF007F" size="30pt" >요리</font></h3>
	</div>

	<div>
	<form name="btnForm" method="post" class="form-inline">
		<div class="row">
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food1.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="구이이미지" name="cookbtn" value="구이" onclick="cookList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food2.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="볶음이미지" name="cookbtn" value="볶음" onclick="cookList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food3.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="찜이미지" name="cookbtn" value="찜" onclick="cookList();">
			</div></div>
		</div>
		<div class="row" style="margin-top: 15px;">
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food4.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="스튜이미지" name="cookbtn" value="스튜" onclick="cookList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food5.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="꼬치이미지" name="cookbtn" value="꼬치" onclick="cookList();">
			</div></div>
			<div class="col-md-12 col-md-4"><div style="background-image:url('<%=cp %>/images/pattern3.JPG')" >
				<input type="image" src="<%=cp%>/images/food6.jpg"
					onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'"
					onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"
					style="width: 100%; height: 200px;border-radius:10px 20px 5px;border:4px solid #4C4C4C;border-color: transparent ;" alt="기타이미지" name="cookbtn" value="기타" onclick="cookList();">
			</div></div>
		</div>
	</form>

	</div>
	<br>
	<div style=" margin-bottom: 20px;">
		<h3 ><font style="font-family: 'Nanum Pen Script';margin-top: 30px" size="10pt"><font color="#FF007F">${btnKey }</font> 리스트</font>
				<c:if test="${sessionScope.member.userId=='admin'}">
			<a href="<%=cp%>/cooks/cook_created.do?"><button type="button"
					class="btn btn-success" style="float: right; margin-top: 30px">등록하기</button></a>
		</c:if>
		</h3>
		
	</div>

	<table class="table table-striped table-bordered table-hover" >
		
		<thead >
			<tr class="st" style="background-color: #D5D5D5;">				
				<th class="text-center">요리번호</th>
				<th class="text-center">조리방법</th>
				<th class="text-center">요리재료</th>
				<th class="text-center">요리명</th>
				<th class="text-center">추천수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list}">
				<tr >
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.listNum}</font></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.cookCode}</font></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script'; "size="5">${dto.ways}</font></td>
					<td class="text-center" ><a href='${articleUrl}&num=${dto.num}'><font style="font-family: 'Nanum Pen Script';"size="5";>${dto.name}</font></a></td>
					<td class="text-center"><font style="font-family: 'Nanum Pen Script';" size="5">${dto.wantedCount}</font></td>
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

	
		
		<div style="float: center;  text-align: center;">
			<form name="searchForm" method="post" class="form-inline">
				<select class="form-control input-sm" name="searchKey">
					<option value="cookCode">조리방법</option>
					<option value="ways">요리재료</option>
					<option value="name">요리명</option>
					
				</select> <input type="text" class="form-control input-sm input-search"
					name="searchValue">
				<button type="button" class="btn btn-info btn-sm btn-search"
					onclick="searchList();">
					<span class="glyphicon glyphicon-search"></span>검색
				</button>
				<button type="button" class="btn btn-default btn-sm wbtn"
				onclick="javascript:location.href='<%=cp%>/cooks/cook.do';">새로고침</button>
				<input type="hidden" name="cookbtn" value="${btnKey}">
			
				 
			</form>
			
		</div>
	


</div>







<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>





