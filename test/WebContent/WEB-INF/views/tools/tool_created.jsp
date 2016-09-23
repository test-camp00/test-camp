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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">


	<script type="text/javascript"
		src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
  function check() {
        var f = document.toolForm;

       var str = f.itemCode.value;
        if(!str) {
            f.itemCode.focus();
            return false;
        }

       str = f.name.value;
        if(!str) {
            f.name.focus();
            return false;
        }

       var mode="${mode}";
       if(mode=="created")
          f.action="<%=cp%>/tools/tool_created_ok.do";
       else if(mode=="update")
          f.action="<%=cp%>/tools/tool_update_ok.do";

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
	<form name="toolForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
		<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
			<h3>캠핑용품 등록</h3>
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
						name="itemName">
							<option value="텐트" style="size: 100; font-size: 12pt;">텐트</option>
							<option value="의자" style="size: 100; font-size: 12pt;">의자</option>
							<option value="식기" style="size: 100; font-size: 12pt;">식기</option>
							<option value="랜턴" style="size: 100; font-size: 12pt;">랜턴</option>
							<option value="침낭" style="size: 100; font-size: 12pt;">침낭</option>
							<option value="버너" style="size: 100; font-size: 12pt;">버너</option>
					</select></td>
				</tr>
				<tr>
					<th class="text-center">제품번호</th>
					<td class="text-center"
						style="border-bottom: 2px solid #ddd; width: 700px;"><input
						type="text" name="itemCode" style="width: 100%;"></td>
				</tr>
				<tr>
					<th class="text-center">제품명</th>
					<td class="text-center"
						style="border-bottom: 2px solid #ddd; width: 700px;"><input
						type="text" name="name" style="width: 100%;"></td>
				</tr>
				<tr>
					<th class="text-center">제조사</th>
					<td class="text-center"
						style="border-bottom: 2px solid #ddd; width: 700px;"><input
						type="text" name="makesa" style="width: 100%;"></td>
				</tr>

			</thead>
			<tbody>
				<tr>
					<th class="text-center">상세 정보</th>
					<td colspan="2">
						<div>
							<div>
								<textarea name="content" style="width: 100%; height: 300px;"></textarea>
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
					<td colspan="2" align="center"><input type="submit"
						class="btn btn-default" value="작성 완료"> &nbsp;&nbsp;&nbsp;
						<button type="reset" class="btn btn-default">다시 입력</button>
						&nbsp;&nbsp;&nbsp; <a class="btn btn-default"
						href="javascript:location.href='<%=cp%>/tools/tool.do';">취소</a></td>
				</tr>
			</tfoot>
		</table>
		</form>
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>




</body>
</html>
