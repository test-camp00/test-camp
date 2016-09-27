<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<link rel="stylesheet" href="<%=cp%>/bootstrap/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/css/layout/layout.css"
	type="text/css">
<link rel="stylesheet" href="<%=cp%>/css/layout/login.css"
	type="text/css">
	
<style type="text/css">

.confrimSelf {
	border: 1px solid #e9e9e9;
    padding: 19px 9px 9px;
}

</style>
<script type="text/javascript">
function infoChange() {
        var f = document.infoForm;

        str = f.userPwd1.value;
        if(!str) {
            f.userPwd1.focus();
            return false;
        }
        
        f.action = "<%=cp%>/member/infoChange.do";
        f.submit();
}

function deleteMember() {
    var f = document.infoForm;

    str = f.userPwd3.value;
    if(!str) {
        f.userPwd3.focus();
        return false;
    }
    
    f.action = "<%=cp%>/member/delete.do";
    f.submit();
}



</script>
	

<div style="height: 205px">
	<div
		style="height: 10px; border-bottom: 50px solid #3cb371; margin-top: 0px">
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
</div>


<div class="container">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>내 정보관리</h3>
	</div>


	<div class="col-sm-3">
		<ul id="myTab6" class="nav nav-pills nav-stacked" role="tablist">
			<li role="presentation" class="active"><a href="#home6" id="home-tab6"
				role="tab" data-toggle="tab" aria-controls="home6"
				aria-expanded="false">개인정보 변경</a></li>
			<li role="presentation" class=""><a href="#profile6"
				role="tab" id="profile-tab6" data-toggle="tab"
				aria-controls="profile6" aria-expanded="true">비밀번호 변경</a></li>
			<li role="presentation" class=""><a href="#home7" id="home-tab7"
				role="tab" data-toggle="tab" aria-controls="home7"
				aria-expanded="false">회원탈퇴</a></li>
				
	
		</ul>
	</div>
	
	<form method="post" name="infoForm">
	<div class="col-md-9">
		<div id="myTabContent6" class="tab-content">
			<div role="tabpanel" class="tab-pane fade active in" id="home6"
				aria-labelledby="home-tab6">
				<div class="confrimSelf">
					<h4 style="text-align: center;">본인 확인</h4>
					<p style="padding: 20px 0; text-align: center;">고객님의 소중한 개인정보보호를 위해서 본인확인을 진행합니다.</p>
					<div style="padding-top: 20px; border: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px;">
						 <span style="margin-left: 150px;">비밀번호 입력</span>
						 <input type="password" name="userPwd1" style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
						 <button type="button" class="btn btn-success btn-sm" onclick="infoChange();" style="margin-left: 60px; width: 100px;">확 인</button>
					</div>
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane fade" id="profile6"
				aria-labelledby="profile-tab6">
				<div class="confrimSelf">
					<h4 style="text-align: center;">본인 확인</h4>
					<p style="padding: 20px 0; text-align: center;">고객님의 소중한 개인정보보호를 위해서 본인확인을 진행합니다.</p>
					<div style="padding-top: 20px; border: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px;">
						 <span style="margin-left: 150px;">비밀번호 입력</span>
						 <input type="password" name="userPwd2" style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
						 <button type="button" class="btn btn-success btn-sm" style="margin-left: 60px; width: 100px;">확 인</button>
					</div>
				</div>
			</div>
			
			<div role="tabpanel" class="tab-pane fade" id="home7"
				aria-labelledby="home-tab7">
				<div class="confrimSelf">
					<h4 style="text-align: center;">본인 확인</h4>
					<p style="padding: 20px 0; text-align: center;">고객님의 소중한 개인정보보호를 위해서 본인확인을 진행합니다.</p>
					<div style="padding-top: 20px; border: 1px solid #e9e9e9; background-color: #fafafa; padding-bottom: 18px;">
						 <span style="margin-left: 150px;">비밀번호 입력</span>
						 <input type="password" name="userPwd3" style="margin-left: 60px; border: 2px solid #ccc; padding: 3px 0 1px; font-weight: bold; font-size: 15px;">
						 <button type="button" class="btn btn-success btn-sm" onclick="deleteMember();" style="margin-left: 60px; width: 100px;">확 인</button>
					</div>
				</div>
			</div>
			<input type="hidden" name="userId" value="${sessionScope.member.userId}">
			
			
		</div>
		
	</div>
	</form>
	

</div>



<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>