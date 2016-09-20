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
<script type="text/javascript">
    function check() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return false;
        }

    	var mode="${mode}";
    	mode="created";
    	if(mode=="created")
    		f.action="<%=cp%>/campground/created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/campground/update_ok.do";

    	// image 버튼, submit은 submit() 메소드 호출하면 두번전송
        return true;
    }
</script>
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

<div class="container">
	<form name="boardForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
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
	                        <th class="text-center">지 역 명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<select class="form-control" style="width: 180px;" name="areaname">
									<option>지역선택</option>
									<option value="서울">서울</option>
									<option value="인천">인천</option>
									<option value="경기도">경기도</option>
									<option value="강원도">강원도</option>
									<option value="충청북도">충청북도</option>
									<option value="세종">세종</option>
									<option value="대전">대전</option>
									<option value="충청남도">충청남도</option>
									<option value="전라북도">전라북도</option>
									<option value="광주">광주</option>
									<option value="전라남도">전라남도</option>
									<option value="경상북도">경상북도</option>
									<option value="대구">대구</option>
									<option value="울산">울산</option>
									<option value="경상남도">경상남도</option>
									<option value="부산">부산</option>
									<option value="제주도">제주도</option>
								</select>
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">캠핑장명</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" name="placename" style="width: 100%;">
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" name="addr" style="width: 100%;">
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">연 락 처</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" name="tel" style="width: 100%;">
							</td> 
	                    </tr>
	                    <tr>
	                        <th class="text-center">간단 정보</th>
	                        <td class="text-center" style="border-bottom: 2px solid #ddd; width: 700px;">
								<input type="text" name="memo1" style="width: 100%;">
							</td> 
	                    </tr>
	                </thead>
	                <tbody>
						<tr>
							<th class="text-center">상세 정보</th>
							<td colspan="2">
								<div>
									<div style="height: 190px;">
										<textarea style="width: 100%; height: 100%;" name="memo2"></textarea>
									</div>
									<div style="float: left;">
										<input type="file" name="upload" class="boxTF" style="line-height: 30px;">
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
		        		    <a class="btn btn-default" href="javascript:location.href='<%=cp%>/campground/list.do';">취소</a>
						</td>
						</tr>
				  </tfoot>
	            </table>
	        </div>
		</div>
	</form>
</div>
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>