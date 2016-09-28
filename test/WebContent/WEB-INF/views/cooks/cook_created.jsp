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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">	


<script type="text/javascript">
  function check() {
        var f = document.cookForm;

       var str = f.cookCode.value;
        if(!str) {
            f.cookCode.focus();
            return false;
        }

       str = f.name.value;
        if(!str) {
            f.name.focus();
            return false;
        }

       var mode="${mode}";
       if(mode=="created")
          f.action="<%=cp%>/cooks/cook_created_ok.do";
       else if(mode=="update")
          f.action="<%=cp%>/cooks/cook_update_ok.do";

		// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
		return true;
	}
</script>
</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
	<div class="container">
		<form name="cookForm" method="post" onsubmit="return check();"
			enctype="multipart/form-data">
			<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
				<h3>캠핑요리 등록</h3>
			</div>
			
			
			<table class="table table-hover">
				<colgroup>
					<col style="width: 20%">
					<col>
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
						<td><select class="selectpicker remove-example"
							name="cookName">
								<option value="구이" ${dto.cookName=="구이" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">구이</option>
								<option value="볶음" ${dto.cookName=="볶음" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">볶음</option>
								<option value="찜" ${dto.cookName=="찜" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">찜</option>
								<option value="스튜" ${dto.cookName=="스튜" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">스튜</option>
								<option value="꼬치" ${dto.cookName=="꼬치" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">꼬치</option>
								<option value="기타" ${dto.cookName=="기타" ? "selected='selected'" : ""} style="size: 100; font-size: 12pt;">기타</option>
						</select></td>
					</tr>
					<tr>
						<th class="text-center">주재료</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="cookCode" style="width: 100%;"
							value="${dto.cookCode}"></td>
					</tr>
					<tr>
						<th class="text-center">요리명</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="name" style="width: 100%;" value="${dto.name}"></td>
					</tr>
					<tr>
						<th class="text-center">요리재료</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="ways" style="width: 100%;"
							value="${dto.ways}" ></td>
					</tr>
					 <tr>
						<th class="text-center">동영상  
						<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" >
						  동영상 올린다면....
						</button>       	
						</th>
						<td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
						<input type="text" name="cookplay" style="width: 100%;" value="${dto.cookplay}">
						</td>
					</tr> 

				</thead>
				<tbody>
					<tr>
						<th class="text-center">레 시 피</th>
						<td colspan="2">
							<div>
								<div>
									<textarea name="memo" style="width: 100%; height: 300px;">${dto.memo}</textarea>
								</div>
								<div style="float: left;">
									<input type="file" name="upload" class="boxTF">
								</div>
							</div>
						</td>
					</tr>
					<c:if test="${mode=='update'&& dto.fileName!=null}">
					<tr>
						<th class="text-center">첨부된 파일</th>
						<td><img src="<%=cp%>/uploads/photo/${dto.fileName}"
				                     width="100" height="100" border="0"
				                     onclick="imageViewer('<%=cp%>/uploads/photo/${dto.fileName}');"
				                     style="cursor: pointer;"></td>
					</tr>
					</c:if>
				</tbody>
				<tfoot>
					<tr height="45">
						<td colspan="2" align="center"><input type="submit"
							class="btn btn-default" value="작성 완료"> &nbsp;&nbsp;&nbsp;
							<button type="reset" class="btn btn-default">다시 입력</button>
							&nbsp;&nbsp;&nbsp; <a class="btn btn-default"
							href="javascript:location.href='<%=cp%>/cooks/cook.do';">취소</a> <c:if
								test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="page" value="${page}">
								<input type="hidden" name="fileName" value="${dto.fileName}">
							</c:if></td>
					</tr>
				</tfoot>
			</table>
		</form>
		
		<!-- 기본 모달 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
		<h4 class="modal-title" id="myModalLabel">동영상 넣는법</h4>
	      </div>
	      <div class="modal-body">
		동영상 하단의 공유를 선택하고 소스보기를 통해서 전체 복사를 하고 동영상 입력란에 붙여넣기 한다.
	      </div>
	      <div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
		
	      </div>
	    </div>
	  </div>
	</div>
		
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>


	<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="http://googledrive.com/host/0B-QKv6rUoIcGREtrRTljTlQ3OTg"></script><!-- ie10-viewport-bug-workaround.js -->
	<script src="http://googledrive.com/host/0B-QKv6rUoIcGeHd6VV9JczlHUjg"></script><!-- holder.js -->

</body>
</html>
