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
 
    	var str=f.areaname.value;
    	if(str==""){
    		alert("지역명을 선택하세요.")
    		return false;
    	}
    	
        str = f.placename.value;
        if(!str) {
            alert("캠핑장명을 입력하세요.");
            f.placename.focus();
            return false;
        }

    	str = f.addr.value;
        if(!str) {
            alert("주소를 입력하세요.");
            f.addr.focus();
            return false;
        }
        
        str = f.tel.value;
        if(!str) {
            alert("연락처를 입력하세요.");
            f.tel.focus();
            return false;
        }
        
        str = f.memo1.value;
        if(!str) {
            alert("간단정보를 입력하세요.");
            f.memo1.focus();
            return false;
        }
        
        str = f.memo2.value;
        if(!str) {
            alert("상세정보를 입력하세요.");
            f.memo2.focus();
            return false;
        }
        
    	var mode="${mode}";
    	mode="created";
    	if(mode=="created")
    		f.action="<%=cp%>/campground/created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/campground/update_ok.do";
    		
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
	                <tfoot>
	                	<tr height="45"> 
						<td colspan="5" align="center">
							<td colspan="2" align="center">
							<input type="submit" class="btn btn-default" value="수정 완료">
		        		    &nbsp;&nbsp;&nbsp;
		        		    <button type="reset" class="btn btn-default">다시 입력</button>
		        		    &nbsp;&nbsp;&nbsp;
		        		    <a class="btn btn-default" href="javascript:location.href='<%=cp%>/campground/list.do';">취소</a>
						</td>
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