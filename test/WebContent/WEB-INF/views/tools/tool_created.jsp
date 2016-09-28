<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
	String dftFilePath = request.getServletContext().getRealPath("");
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

<script type="text/javascript" src="<%=cp%>/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function(){
					nhn.husky.EZCreator.createInIFrame({
						oAppRef: oEditors,
						elPlaceHolder: "ir1",
						//SmartEditor2Skin.html 파일이 존재하는 경로
						sSkinURI: "<%=cp%>/editor/SmartEditor2Skin.html",	
						htParams : {
							// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseToolbar : true,				
							// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : true,		
							// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true,			
							fOnBeforeUnload : function(){
								
							}
						}, 
						fOnAppLoad : function(){
							//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
							oEditors.getById["ir1"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]);
						},
						fCreator: "createSEditor2"
					});
					
					$("#save").click(function(){
						oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
						
						if(!check())
							return;
						
						$("#frm").submit();
					})
});
</script>


</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
	<div class="container">
		<form name="toolForm" method="post" id="frm"
			enctype="multipart/form-data">
			<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
				<h3>캠핑용품 등록<%=cp%></h3>
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
								<option value="텐트"
									${dto.itemName=="텐트" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">텐트</option>
								<option value="의자"
									${dto.itemName=="의자" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">의자</option>
								<option value="식기"
									${dto.itemName=="식기" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">식기</option>
								<option value="랜턴"
									${dto.itemName=="랜턴" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">랜턴</option>
								<option value="침낭"
									${dto.itemName=="침낭" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">침낭</option>
								<option value="버너"
									${dto.itemName=="버너" ? "selected='selected'" : ""}
									style="size: 100; font-size: 12pt;">버너</option>
						</select></td>
					</tr>
					<tr>
						<th class="text-center">제품번호</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="itemCode" style="width: 100%;"
							value="${dto.itemCode}"></td>
					</tr>
					<tr>
						<th class="text-center">제품명</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="name" style="width: 100%;" value="${dto.name}"></td>
					</tr>
					<tr>
						<th class="text-center">제조사</th>
						<td class="text-center"
							style="border-bottom: 2px solid #ddd; width: 700px;"><input
							type="text" name="makesa" style="width: 100%;"
							value="${dto.makesa}"></td>
					</tr>

				</thead>
				<tbody>
					<tr>
						<th class="text-center">상세 정보</th>
						<td colspan="2">
							<div>
								<div>
									<textarea id="ir1" name="content"
										style="width: 100%; height: 300px;">${dto.content}</textarea>
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
						<td colspan="2" align="center"><input type="button" id="save"
							class="btn btn-default" value="작성 완료"> &nbsp;&nbsp;&nbsp;
							<button type="reset" class="btn btn-default">다시 입력</button>
							&nbsp;&nbsp;&nbsp; <a class="btn btn-default"
							href="javascript:location.href='<%=cp%>/tools/tool.do';">취소</a> <c:if
								test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="page" value="${page}">
								<input type="hidden" name="fileName" value="${dto.fileName}">
							</c:if></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>


	<script type="text/javascript"
		src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>


</body>
</html>
