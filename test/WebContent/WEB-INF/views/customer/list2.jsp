<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<style type="text/css">


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
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/";
	f.submit();
}
</script>


<link href="http://googledrive.com/host/0B-QKv6rUoIcGSXVoclk5aDh4RWM" rel="stylesheet"><!-- bootstrap.vertical-tabs.min.css -->
<link href=”./css/bootstrap.vertical-tabs.css” rel=”stylesheet”>
<link href=”./css/bootstrap.vertical-tabs.min.css” rel=”stylesheet”>

</head>
<body>
<div class="container">

	<h2>고객센터</h2>

<div class="col-sm-3">
	  <ul id="myTab2" class="nav nav-tabs tabs-left" role="tablist" >
	    <li role="presentation" class="active"><a href="#home2" id="home-tab2" role="tab" data-toggle="tab" style="width: 200px">
	     
	     질문과 답변</a></li>
	    <li role="presentation" class=""><a href="#profile2" role="tab" id="profile-tab2" data-toggle="tab" style="width: 200px">
	   
	    자주하는 질문
	    </a></li>
	      <li role="presentation" class=""><a href="#profile3" role="tab" id="profile-tab3" data-toggle="tab"style="width: 200px" >

	    이용 약관
	</a></li>
	  <li role="presentation" class=""><a href="#profile4" role="tab" id="profile-tab4" data-toggle="tab"style="width: 200px">
	 
	    개인정보 이용방침
	  </a></li>
	  </ul>
	</div>  
	
 <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------- -->  
	<div class="col-sm-9" >
	  <div id="myTabContent2" class="tab-content">
	    <div role="tabpanel" class="tab-pane fade" id="profile2" aria-labelledby="home-tab2">
				<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingOne">
				      <h4 class="panel-title">
				        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				         회원정보를 수정하고 싶어요
				        </a>
				      </h4>
				    </div>
				    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
				      <div class="panel-body">
				       <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
					회원정보 수정은 로그인 상태에서 상단메뉴의 정보 수정 또는 마이페이지에서 수정 가능합니다.
				      </div>
				    </div>
				  </div>
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingTwo">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
				          회원 가입을 해야만 이용할 수 있나요?
				        </a>
				      </h4>
				    </div>
				    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
				      <div class="panel-body">
				      <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
					회원 가입을 해야만 이용 가능한 서비스와 회원 가입이 없어도 이용 가능한 서비스가 있습니다. <br>
					<br>
					1.회원 가입을 해야만 이용 가능한 서비스 <br>
					&nbsp;&nbsp;&nbsp;1) 거래게시판 <br>
					&nbsp;&nbsp;&nbsp;2) 자유게시판 <br>
					<br>
					2. 회원 가입을 안해도 이용 가능한 서비스<br>
					&nbsp;&nbsp;&nbsp;1) 캠핑장 검색 <br>
					&nbsp;&nbsp;&nbsp;2) 알림마당 <br>
				      </div>
				    </div>
				  </div>
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingThree">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
				         회원 탈퇴는 어떻게 하나요?
				        </a>
				      </h4>
				    </div>
				    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
				      <div class="panel-body">
					회원 탈퇴는 할 수 없습니다.
				      </div>
				    </div>
				  </div>
				   <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingfour">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapsefour" aria-expanded="false" aria-controls="collapsefour">
				         갤러리에 올린 사진은 어떻게 다운받을 수 있나요?
				        </a>
				      </h4>
				    </div>
				    <div id="collapsefour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfour">
				      <div class="panel-body">
					다운받을 수 없습니다.
				      </div>
				    </div>
				  </div>
				   <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading5">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse5" aria-expanded="false" aria-controls="collapse5">
				         회원 가입은 아무나 가능한가요?
				        </a>
				      </h4>
				    </div>
				    <div id="collapse5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading5">
				      <div class="panel-body">
					20세 이상의 대한민국 국민이면 누구나 회원가입 가능합니다. 
				      </div>
				    </div>
				  </div>
				</div>
		
	    </div>
 <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------- -->  
	    
	    
	    <div role="tabpanel" class="tab-pane fade  active in" id="home2" aria-labelledby="profile-tab2" align="left">
											    
									<div class="layoutBody">

		<div style="min-height: 450px;">
				<div style="width:100%;	height: 40px; line-height:40px;clear: both; border-top: 1px solid #DAD9FF;border-bottom: 1px solid #DAD9FF;">
				    <div style="width:700px; height:30px; line-height:30px; margin:5px auto;">
				        <img src="<%=cp%>/res/images/arrow.gif" alt="" style="padding-left: 5px; padding-right: 5px;">
				        <span style="font-weight: bold;font-size:13pt;font-family: 나눔고딕, 맑은 고딕, 굴림;">질문과 답변</span>
				    </div>
				</div>
			
				<div style="margin: 10px auto; margin-top: 20px; width:700px; min-height: 400px;">
		
					<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
					   <tr height="35">
					      <td align="left" width="50%">
					          <form name="searchForm" action="" method="post">
					              <select name="searchKey" class="selectField">
									<option value="subject">제목</option>
									<option value="userName">작성자</option>
									<option value="content">내용</option>
									<option value="created">등록일</option>
					            </select>
					            <input type="text" name="searchValue" class="boxTF">
					            <input type="button" value=" 검 색 " class="btn" onclick="searchList()">
					        </form>
					      </td>
					      <td align="right">
					          <input type="image" src="<%=cp%>/res/images/btn_write.gif" onclick="javascript:location.href='<%=cp%>/customer/created.do';">
					      </td>
					   </tr>
					</table>
					
					<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
					  <tr align="center" bgcolor="#507CD1" height="30"> 
					      <td width="60" style="color: #ffffff;">번호</td>
					      <td width="400" style="color: #ffffff;">제목</td>
					      <td width="100" style="color: #ffffff;">작성자</td>
					      <td width="80" style="color: #ffffff;">작성일</td>
					      <td width="60" style="color: #ffffff;">조회수</td>
					  </tr>
					 
					 <c:forEach var="dto" items="${list}">
					  <tr align="center" bgcolor="#ffffff" height="30"> 
					      <td align="center">${dto.listNum}</td>
					      <td align="left" style="padding-left: 10px;">
					          <c:forEach var="n" begin="1" end="${dto.depth}">
	                                &nbsp;&nbsp;
	                            </c:forEach>
	                            <c:if test="${dto.depth!=0}">
	                                <img src='<%=cp%>/res/images/re.gif'>
	                            </c:if>
	                            <a href='${articleUrl}&boardNum=${dto.boardNum}'>${dto.subject}</a>
	                            <c:if test="${dto.gap < 1}">
								       <img src='<%=cp%>/res/images/new.gif'>
							    </c:if>
					      </td>
					      <td align="center">${dto.userName}</td>
					      <td align="center">${dto.created}</td>
					      <td align="center">${dto.hitCount}</td>
					  </tr>
					  <tr><td height="1" colspan="5" bgcolor="#e4e4e4"></td></tr> 
					 </c:forEach>
					</table>
					 
					<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
					   <tr height="35">
						<td align="center">
					        <c:if test="${dataCount==0 }">
			                       등록된 게시물이 없습니다.
			                </c:if>
			                <c:if test="${dataCount!=0 }">
			                    ${paging}
			                </c:if>
						</td>
					   </tr>
					</table>
				</div>
		</div>

    </div>
	
	
	    </div>
	     <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------- -->  
	     <div role="tabpanel" class="tab-pane fade" id="profile3" aria-labelledby="profile-tab3">
	      <div class="join_txt_01">   <p style="margin: 0px;">
	      
                        <h3 style="margin-top: 30px;">제 1장 총칙</h3>
                        <strong>제 1조 목적 </strong>
                        <p>
                            이 약관은 주식회사 캠핑서치(이하 "회사"라 함)에서 운영하는 캠핑정보 웹사이트(campingsearch.co.kr 이하 "사이트"라 함)가 제공하는 모든 서비스의 이용조건 및 절차, 기타 필요한 사항을 규정함을 목적으로 합니다. 
                        </p>
                        <strong>제 2조 약관의 효력과 변경 </strong>
                        <ul>
                            <li>
                                (1) 이 약관은 그 내용을 회사의 웹사이트에 게시하거나, 기타의 방법으로 이용자에게 공지함으로써 효력을 발생합니다.
                            </li>
                            <li>
                                (2) 회사는 사정 변경의 경우와 영업상 중요 사유, 합리적인 사유 가 있을 때 약관을 변경할 수 있으며, 변경된 약관은 전항과 같은 방법으로 효력을 발생합니다. 
                            </li>
                            <li>
                                (3) 회원은 변경된 약관에 동의하지 않으면 언제든지 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경 사항에 동의한 것으로 간주됩니다. 
                            </li>
                        </ul>
                        <strong>제 3조 약관 외 준칙 </strong>
                        <p>
                            이 약관에 명시되지 않은 사항에 관해서는 당사 내규, 전기통신기 본법, 전기통신사업법, 정보통신망 이용촉진 등에 관한 법률, 전자 거래기본법, 전자서명 법 및 기타 관계 법령의 규정에 따릅니다. 
                        </p>
                        <strong>제4조 용어의 정의</strong>
                        <ul>
                            <li>
                                (1) 캠핑장회원 : 일정 이상의 물리적인 공간을 제공하여 숙박(캠핑, 민박, 펜션, 방갈로, 카라반, 글램핑 등)시설을 일반회원이 사용할 수 있도록 운영하는 회원으로 회사와 서비스 이용에 관한 계약을 체결하고 아이디를 부여 받은 자를 말합니다.
                            </li>
                            <li>
                                (2) 일반회원 : 회사와 서비스 이용에 관한 계약을 체결하고 아이디를 부여 받은 자로서 캠핑장 회원이 아닌자를 말합니다.
                            </li>
                            <li>
                                (3) 회원 : 일반회원과 캠핑장회원을 총칭하여 사용합니다.
                            </li>
                        </ul>
                        <h3>제 2장 회원 가입과 서비스 이용</h3>
                        <strong>제 1조 회원가입 </strong>
                        <ul>
                            <li>
                                (1) 회원은 20세 이상의 성인남녀라면 누구나 가입할 수 있다.
                            </li>
                            <li>
                                (2) 회원이라 함은 회사와 서비스 이용에 관한 계약을 체결하고 아이디를 부여 받은 자로 일반회원과 캠핑장회원을 총칭하여 말합니다.
                            </li>
                        </ul>
                        <strong>제 2조 서비스 이용 계약의 성립</strong>
                        <ul>
                            <li>
                                (1) 이용 계약은 이용자의 회원등록 신청에 대한 회사의 이용 승낙과 이용자의 약관 내용에 대한 동의로 성립됩니다. 
                            </li>
                            <li>
                                (2) 회원으로 가입하여 서비스를 이용하고자 하는 희망자는 회사 에서 요청하는 개인 신상정보를 제공해야 합니다.
                            </li>
                            <li>
                                (3) 온라인 가입 신청 양식에 기재하는 모든 회원 정보는 실제와 일치하는 데이터인 것으로 간주됩니다. 실명이나 실제와 일치 하는 정보를 입력하지 않은 자는 법적인 보호를 받을 수 없으며 서비스 이용을 제한 받을 수 있습니다. 
                            </li>
                            <li>
                                (4) 회사는 다음 각 호에 해당하는 이용계약 신청에 대하여는 이를 승낙하지 아니 합니다. 
                                <ol>
                                    <li>
                                        가. 다른 사람의 명의를 사용하여 신청하였을 때 
                                    </li>
                                    <li>
                                        나. 본인의 실명으로 신청하지 않았을 때 
                                    </li>
                                    <li>
                                        다. 이용 계약 신청서의 내용을 허위로 기재하였을 때 
                                    </li>
                                    <li>
                                        라. 사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때
                                    </li>
                                </ol>
                            </li>
                        </ul>
                        <strong>제 3조 서비스의 구분 </strong>
                        <ul>
                            <li>
                                (1) 서비스의 구체적인 종류와 내용은 회사가 이 약관 또는 공지, 이용안내 등에서 별도로 정하는 바에 따릅니다.
                            </li>
                        </ul>
                        <strong>제 4조 서비스 이용 및 제한 </strong>
                        <ul>
                            <li>
                                (1) 서비스 이용은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.
                            </li>
                            <li>
                                (2) 전항의 서비스 이용시간은 시스템 정기점검 등 회사가 필요한 경우, 회원에게 사전 통지한 후, 제한할 수 있습니다. 
                            </li>
                            <li>
                                (3) 전시, 사변, 천재지변 또는 이에 준하는 국가 비상사태가 발생 하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간 통신사업자가 전기통신 서비스를 중지하는 등 기타 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 중지 할 수 있습니다. 
                            </li>
                        </ul>
                        <strong>제 5조 이용계약 사항의 변경</strong>
                        <ul>
                            <li>
                                (1) 회원은 이용신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정합니다. 
                            </li>
                            <li>
                                (2) 회원은 이용신청 시 기재사항의 미 변경 또는 허위변경으로 인하여 발생되는 문제에 대한 책임은 회원에게 있습니다. 
                            </li>
                        </ul>
                        <strong>제 6조 서비스 이용 책임 </strong>
                        <ul>
                            <li>
                                (1) 회원은 자기 책임하에 서비스를 이용하며, 서비스 이용으로 불이익이 발생하더라도 이에 대한 책임은 이용 고객에게 있습니다. 
                            </li>
                            <li>
                                (2) 회원 ID와 비밀번호의 관리 및 이용상의 부주의로 인하여 발생되는 과실 또는 제3자에 의한 부정이용 등에 대한 책임은 회원에게 있습니다.
                            </li>
                        </ul>
                        <strong>제 7조 서비스 양도 등의 금지 </strong>
                        <p>
                            회원은 서비스 이용권리를 타인에게 대여, 양도 또는 증여 등을 할 수 없으며, 또한 질권의 목적으로도 이용할 수 없습니다.
                        </p>
                        <h3>제 3장 의 무 </h3>
                        <strong>제 1조 회사의 의무</strong>
                        <ul>
                            <li>
                                (1) 회사는 특별한 사정이 없는 한 회원이 신청한 서비스 제공 개시 일에 서비스를 이용할 수 있도록 합니다. 
                            </li>
                            <li>
                                (2) 회사는 이 약관에서 정한 바에 따라 계속적, 안정적으로 서비스를 제공할 의무가 있습니다.
                            </li>
                            <li>
                                (3) 회사는 회원으로부터 소정의 절차에 의해 제기되는 의견에 대해서는 적절한 절차를 거쳐 처리하며, 처리시 일정 기간이 소요될 경우 회원에게 그 사유와 처리 일정을 알려주어야 합니다. 
                            </li>
                            <li>
                                (4) 회사는 회원의 정보를 철저히 보안 유지하며, 양질의 서비스를 운영하거나 개선하는 데에만 사용하고, 이외의 다른 목적으로 타 기관 및 개인에게 양도하지 않습니다. 그러나 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 예외입니다. 
                            </li>
                        </ul>
                        <strong>제 2조 회원의 의무</strong>
                        <ul>
                            <li>
                                (1) ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있습니다. 
                            </li>
                            <li>
                                (2) 회원은 서비스의 일부로 보내지는 회사의 전자우편 및 SMS를 받는 것에 동의합니다. 
                            </li>
                            <li>
                                (3) 자신의 ID가 부정하게 사용된 경우, 회원은 반드시 회사에 그 사실을 통보해야 합니다. 
                            </li>
                            <li>
                                (4) 회원은 입력 정보를 정확하게 입력하여야 하며, 입력된 정보와 다를 경우 이용이 제한될 수도 있습니다. 
                            </li>
                            <li>
                                (5) 회원은 회사의 업무 수행에 지장을 초래하는 행위를 하여서는 아니 됩니다. 
                                <ol>
                                    <li>1. 범죄 행위를 목적으로 하거나 범죄행위를 교사하는 행위 </li>
                                    <li>2. 반국가적 행위의 수행을 목적으로 하는 행위 </li>
                                    <li>3. 선량한 풍속, 기타 사회질서를 해하는 행위 </li>
                                    <li>4. 타인의 명예를 손상시키거나 불이익을 주는 행위 </li>
                                    <li>5. 정보통신설비의 오 동작이나 정보 등의 파괴를 유발시키는 해킹, 컴퓨터 바이러스 프로그램 등의 유포행위 </li>
                                    <li>6. 다른 회원 또는 제 3자의 지적 재산권을 침해하는 행위 </li>
                                    <li>7. 서비스의 안정적 운영에 지장을 초래하는 다량의 게시물 등록, 건전한 서비스 이용에 반하는 행위. </li>
                                    <li>8. 타 회원에게 해를 가하는 행위 </li>
                                    <li>9. ID, 비밀번호, 주민번호 도용 및 타인으로 가장하는 행위 </li>
                                    <li>10. 회사의 타 회원을 비방할 목적으로 사실 또는 허위를 날조하여 명예를 훼손하는 행위 </li>
                                    <li>11. 개인 또는 타 회원에게 사적인 이익을 주거나 타 회원에게 위해를 가할 목적으로 허위의 정보를 유통시키는 행위 </li>
                                    <li>12. 수치심이나 혐오감 또는 공포심을 일으키는 행위를 계속하여 상대방에게 도달하게 해 일상적 생활을 방해하는 행위 </li>
                                    <li>13. 회사의 사전 승낙 없이 서비스를 이용한 영리행위</li>
                                    <li>14. 회사의 사전 승낙 없이 타 회원들에게 정보제공을 빙자한 타 사이트에서의 구매를 조장하는 행위 </li>
                                    <li>15. 본 사이트에서 승인되지 않은 불필요한 광고, 판촉물을 게재하거나, 정크 메일, 스팸메일 등 기타 유해메일을 권유하거나 게시, 게재 또는 전자우편으로 보내는 행위</li>
                                    <li>16. 저속 또는 음란한 데이터, 텍스트, 소프트웨어, 음악, 사진, 그래픽, 비디오 메시지 등(이하 ‘컨텐츠’)을 게시, 게재 또는 전자우편으로 보내는 행위 등</li>
                                    <li>17. 권리(지적재산권을 포함한 모든 권리)가 없는 컨텐츠를 게시, 게재 또는 소프트웨어 바이러스를 게시, 게재 또는 전자우편으로 보내는 행위 등</li>
                                    <li>18. 기타 대한민국 법에서 명시하고 있는 불법적이거나 부당한 행위</li>
                                </ol> 
                            </li>
                            <li>
                                (6) 회원은 이 약관 및 관계 법령에서 규정한 사항을 준수하여야 합니다.
                            </li>
                        </ul>
                        <h3>제 4장 계약 해지 및 서비스 이용 제한</h3>
                        <strong>제 1조 계약 해지 및 이용 제한</strong>
                        <ul>
                            <li>
                                (1) 회원이 이용 계약을 해지하고자 하는 때에는 회원 본인이 로그인 후 회원탈퇴 메뉴를 이용하여 직접 해지 할 수 있습니다. (회사가 인정할수 있는 서류 제출도 가능)
                            </li>
                            <li>
                                (2) 한번 해지된 ID는 기존 사용자라도 원칙적으로사용할 수 없음을 알려드립니다. 다만 회사가 사용할만한 사유가 있다고 판단될 때에는 다시 사용할 수 있습니다.
                            </li>
                            <li>
                                (3) 회사는 회원이 다음 사항에 해당하는 행위를 하였을 경우, 사전 통지 없이 이용 계약을 해지하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.
                                <ol>
                                    <li>
                                        가. 공공 질서 및 미풍 양속에 반하는 경우
                                    </li>
                                    <li>
                                        나. 범죄적 행위에 관련되는 경우 
                                    </li>
                                    <li>
                                        다. 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행 할 경우 
                                    </li>
                                    <li>
                                        라. 타인의 ID, 비밀번호 및 닉네임을 도용한 경우 
                                    </li>
                                    <li>
                                        마. 타인의 명예를 손상시키거나 불이익을 주는 경우 
                                    </li>
                                    <li>
                                        바. 같은 사용자가 다른 ID 및 닉네임으로 이중 등록을 한 경우 
                                    </li>
                                    <li>
                                        사. 비실명 가입 등 회원이 제공한 데이터가 허위임이 판명된 경우
                                    </li>
                                    <li>
                                        아. 서비스에 해를 끼치는 등 건전한 이용을 저해하는 경우 
                                    </li>
                                    <li>
                                        자. 기타 관련 법령이나 회사가 정한 이용약관에 위배되는 경우 
                                    </li>
                                </ol>
                            </li>
                        </ul>
                        <strong>제 2조 이용 제한의 해제 절차 </strong>
                        <ul>
                            <li>
                                (1)회사는 이용 제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 전화 또는 e-mail등의 방법을 이용 하여 해당 회원 또는 대리인에게 통지합니다. 
                            </li>
                            <li>
                                (2)다만, 회사가 긴급하게 이용을 중지해야 할 필요가 있다고 인정하는 경우에는 전항의 과정 없이 서비스 이용을 제한할 수 있습니다. 
                            </li>
                            <li>
                                (3)제4장 제2조 1항의 규정에 의하여 서비스 이용중지를 통지 받은 회원 또는 그 대리인은 이용 중지에 대하여 이의가 있을 경우 이의신청을 할 수 있습니다. 
                            </li>
                            <li>
                                (4)회사는 이용중지 기간 중에 그 이용중지 사유가 해소된 것이 확인된 경우에 한하여 이용 중지 조치를 즉시 해제합니다. 
                            </li>
                        </ul>
                        <strong>제 3조 회원의 게시물 관리 </strong> 
                        <p>
                          회사는 회원이 게시하거나 등록한 내용물이 다음 사항 에 해당된다고 판단되는 경우에 사전 통지 없이 삭제할 수 있습니다.
                        </p>
                         <ul>
                            <li>
                                (1) 타인을 비방하거나 중상모략으로 개인 및 단체의 명예를 손상 시키는 내용인 경우
                            </li>
                            <li>
                                (2) 공공질서 및 미풍양속에 위반되는 내용인 경우
                            </li>
                            <li>
                                (3) 범죄적 행위에 부합된다고 인정되는 내용인 경우
                            </li>
                            <li>
                                (4) 타인의 저작권 등 기타의 권리를 침해하는 내용인 경우
                            </li>
                            <li>
                                (5) 기타 관계 법령이나 회사에서 정한 규정에 위배되는 내용인 경우
                            </li>
                        </ul>
                        <strong>제 4조 게시물의 저작권</strong>
                        <ul>
                            <li>
                                (1) 회사가 작성한 저작물에 대한 저작권, 기타 지적재산권은 회사에 있습니다.
                            </li>
                            <li>
                                (2) 회원 당사자가 사이트 내에 게시한 게시물의 저작권 및 사용권은 해당 저작권자에게 있습니다.
                            </li>
                            <li>
                                (3) 회원은 사이트를 이용함으로써 얻은 정보를 회사의 사전 승낙 없이 복제, 출판, 전송, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 할 수 없으며, 회원당사자의 게시물이 아닌 것에 대한 모든 저작권 침해는 관계 법령의 적용을 받습니다. 
                            </li>
                            <li>
                                (4) 회원은 자신이 창작, 등록한 게시물에 대하여 사이트 또는 사이트가 허락한 제3자가 사이트를 운영, 전시, 홍보하기 위한 목적으로 아래와 같이 사용하는 것에 대해 이의를 제기하지 않습니다.
                                <ol>
                                    <li>
                                        ① 사이트 내에서 회원 게시물의 복제, 수정, 개조, 전송, 전시, 배포 및 2차 저작물과 편집 저작물 작성
                                    </li>
                                    <li>
                                        ② 회사에서 운영하는 관련 사이트 내에서 회원 게시물을 전시, 배포
                                    </li>
                                    <li>
                                        ③ 사이트의 서비스를 홍보하기 위한 목적으로 미디어, 통신사 등에게 회원의 게시물 내용을 제공할 때 회원은 비독점적 사용권을 회사에게 부여한 것으로 인정합니다.
                                    </li>
                                </ol>
                            </li>
                            <li>
                                (5) 사이트는 회원이 탈퇴한 이후에도 탈퇴회원의 게시물에 대하여 본 조 제4항의 사용권을 유지합니다.
                            </li>
                            <li>
                                (6) 사이트는 본질적으로 회원의 동의 없이 본 조 제4항에서 규정하는 이외의 목적으로 회원의 게시물을 사용할 수 없으나 회사가 운영하는 사이트간의 통합 등의 사유로 원래의 게시물 내용을 변경하지 않고 사용될 수는 있습니다.
                            </li>
                        </ul>
                        <h3>제 5장 캠핑장 정보 서비스</h3>
                        <strong>제 1조 캠핑장 검색, 캠핑장 예약, 커뮤니티 정보 이용 </strong>
                        <ul>
                            <li>
                                (1) 회원은 사이트 이용을 위해 등록할 경우 완전한 정보를 제공해야 하며 등록정보에 변경 사항이 생기면 즉시 갱신하셔야 합니다. 갱신 미 실행으로 발생하는 불이익에 관해서 회사는 어떠한 책임도 부담하지 아니합니다.
                            </li>
                            <li>
                                (2) 회원이 사이트에서 제공하는 모든 정보를 이용함에 있어 내용의 진실성 및 질에 대하여 회사는 보장하지 않습니다. 회원은 반드시 실제정보와 같은지 확인하고 이용하여야 하며 사이트에 기재된 내용이 실제 내용과 다른 경우 회사는 어떠한 책임도 지지 않습니다.
                            </li>
                            <li>(3) 회원은 각 캠핑장별로 안내 되어있는 캠핑장 이용안내에 대하여 준수합니다. 
                                
                            </li>
                        </ul>
                        <strong>제 2조 캠핑장 예약 체결과  예약 취소 및 변경 </strong>
                        <ul>
                            <li>
                                (1) 일반회원이 이용하고자 하는 캠핑장 예약이 미리 마감 될 수 있으며, 일반회원이 원하는 일자에 예약 편의를 제공 받지 못할 수도 있습니다. 
                            </li>
                            <li>
                                (2) 카드 결제 및 인터넷뱅킹을 통한 결제가 아닌 무통장 입금의 경우 예약을 하는 일반회원과 캠핑장을 운영하는 캠핑장회원간의 예약에 관련하여 발생하는 모든 책임에 대하여 회사는 책임을 지지 않습니다.
                            </li>
                            <li>
                                (3) 예약 취소 및 변경과 관련해서 캠핑장 예약을 하는 일반회원과 캠핑장 예약을 받는 캠핑장회원간에 상호 확인을 하여야 하며 이로 인해 발생하는 손해에 대하여 회사는 어떠한 책임도 지지 않습니다.
                            </li>
                        </ul>
                        <h3>제 6장 기타</h3>
                        <strong>제 1 조 손해배상</strong>
                        <p>
                            회사는 서비스 요금이 무료로 사용하는 회원에게 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다.
                        </p>
                        <strong>제 2 조 면책조항</strong>
                        <ul>
                            <li>
                                (1) 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
                            </li>
                            <li>
                                (2) 사이트는 기간통신사업자가 전기통신 서비스를 중지하여 정상적으로 이용할 수 없어 회원의 손해가 발생한 경우 책임이 면제됩니다.
                            </li>
                            <li>
                                (3) 회사는 회원의 귀책사유로 인하여 서비스 이용의 장애가 발생한 경우에는 책임이 면제됩니다.
                            </li>
                            <li>
                                (4) 회사는 회원이 회사의 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사 선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.
                            </li>
                            <li>
                                (5) 사이트는 회원이 서비스를 이용하면서 얻은 자료로 인한 손해에 대하여 책임을 지지 않습니다. 또한 회사는 회원이 서비스를 이용하면서 타 회원으로부터 입게 되는 정신적 피해나 행사장 내에서 또 다른 회원으로부터 입는 신체적인 피해에 대하여 보상할 책임이 면제됩니다.
                            </li>
                            <li>
                                (6) 회사는 회원이 서비스에 임의로 게재한 각종 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 대하여 책임을 면제됩니다.
                            </li>
                            <li>
                                (7) 회사가 인정하지 않은 이용자 상호간 및 이용자와 제3자 상호간에 상관관계로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해를 배상할 책임도 면제됩니다.
                            </li>
                            <li>
                                (8) 사이트에서 회원에게 무료로 제공하는 서비스나 행사에 대해서는 어떠한 손해도 책임을 지지 않습니다.
                            </li>
                        </ul>
                        <strong>제 3조 관할법원</strong>
                        <p>
                            본 약관 상의 분쟁에 대해 소송이 제기될 경우 회사의 본사 소재지를 관할하는 법원을 관할 법원으로 합니다.
                        </p>
                        <h3>(부칙)</h3>
                        <p>
                            (1)이 약관은 2011년 03월 25일부터 적용됩니다. 
                        </p>
                        </p>
                    </div>
                    
	    </div>
	    
 <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------- -->  	    
	     <div role="tabpanel" class="tab-pane fade" id="profile4" aria-labelledby="profile-tab4">
	      <div class="join_txt_02">
                        <p style="margin: 0px;">
                            (주)캠핑서치(이하 "회사"라 함)에서 운영하는 캠핑서치(www.campingsearch.co.kr 이하 "사이트"라 함)를 이용하는 이용자들의 개인정보보호를 매우 중요시하며, 
                            이용자가 회사의 웹서비스(이하 "서비스"라 함)를 이용함과 동시에 온라인상에서 회사에 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다. 
                            이에 회사는 통신비밀보호법, 전기통신사업법, 정보통신망이용촉진등에관한법률 등 정보통신서비스제공자가 준수하여야 할 관련 법규상의 개인정보보호 규정 및 정보통신부가 제정한 
                            개인정보보호지침을 준수하고 있습니다. 회사는 개인정보 보호정책을 통하여 이용자들이 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 
                            취해지고 있는지 알려드립니다.
                            회사는 개인정보 보호정책을 사이트 첫 화면에 공개함으로써 이용자들이 언제나 용이하게 보실 수 있도록 조치하고 있습니다.
                        </p>
                        <p>
                            회사의 개인정보 보호정책은 정부의 법률 및 지침 변경이나 회사의 내부 방침 변경 등으로 인하여 수시로 변경될 수 있고, 이에 따른 개인정보 보호정책의 지속적인 개선을 위하여 필요한 절차를 정하고 있습니다. 
                            그리고 개인정보 보호정책을 개정하는 경우 회사는 그 변경사항에 대하여 즉시 사이트를 통하여 게시하고 버전번호 및 개정일자 등을 부여하여 개정된 사항을 이용자들이 쉽게 알아볼 수 있도록 하고 있습니다. 
                            이용자들께서는 사이트 방문시 수시로 확인하시기 바랍니다.
                        </p>
                        <p>
                            회사의 개인정보 보호정책은 다음과 같은 내용을 담고 있습니다.
                        </p>
                        <ul>
                            <li><strong>가. 개인정보의 수집목적 및 이용목적</strong></li>
                            <li><strong>나. 개인정보 항목 및 수집방법</strong></li>
                            <li><strong>다. 개인정보의 보유 및 이용기간</strong></li>
                        </ul>
                        
                        <ul>
                            <li>
                                가. 개인정보의 수집목적 및 이용목적 
                                "개인정보"라 함은 생존하는 개인에 관한 정보로서 당해 정보에 포함되어 있는 성명, ID, 비밀번호 사항에 의하여 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 
                                다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다.
                                
                                대부분의 회사 서비스는 별도의 사용자 등록이 없이 언제든지 사용할 수 있습니다. 그러나 회사는 회원서비스를 통하여 이용자들에게 맞춤식 서비스를 비롯한 보다 더 향상된 양질의 서비스를 제공하기 
                                위하여 이용자 개인의 정보를 수집하고 있습니다.
                            </li>
                            <li>
                                나. 개인정보 항목 및 수집방법 
                                회사는 이용자들이 회원서비스를 이용하기 위해 회원으로 가입하실 때 서비스 제공을 위한 필수적인 정보들을 온라인상에서 입력 받고 있습니다. 
                                회원 가입시에 받는 필수적인 정보는 (1) 일반회원 : ID, 비밀번호, 성명, 생년월일, 성별, 이메일주소, 닉네임, 핸드폰번호 등입니다. 
                                또한 양질의 서비스 제공을 위하여 이용자들이 선택적으로 입력할 수 있는 사항으로서 캠핑장 예약 취소시 환불 받기 위한 은행계좌정보 항목을 입력 받고 있습니다.
                                (2) 캠핑장회원 :  ID, 비밀번호, 성명, 생년월일, 성별, 이메일주소, 닉네임, 캠핑장명, 캠핑장주소, 캠핑장전화번호, 핸드폰번호 등입니다. 
                                또한 양질의 서비스 제공을 위하여 이용자들이 선택적으로 입력할 수 있는 사항으로서 캠핑장FAX번호, 사업자등록번호, 대표자성명, 업태, 업종, 사업장주소 이외의 여러 항목을 입력 받고 있습니다.
                            </li>
                            <li>
                                다. 개인정보의 보유 및 이용기간 
                                이용자가 회사의 회원으로서 회사에 제공하는 서비스를 이용하는 동안 회사는 이용자들의 개인정보를 계속적으로 보유하며 서비스 제공 등을 위해 이용합니다. 
                                다만, 아래의 "마. 이용자 자신의 개인정보 관리(열람,정정,삭제 등)에 관한 사항" 에서 설명한 절차와 방법에 따라 회원 본인이 직접 삭제하거나 수정한 정보, 
                                가입해지를 요청한 경우에는 재생할 수 없는 방법에 의하여 디스크에서 완전히 삭제하며 추후 열람이나 이용이 불가능한 상태로 처리됩니다.
                            </li>
                        </ul>
                        
                        <p>
                            이용자들의 개인정보는 비밀번호에 의해 철저히 보호되고 있습니다. 회원 아이디(ID)의 비밀번호는 본인만이 알고 있으며, 개인정보의 확인 및 변경도 비밀번호를 알고 있는 본인에 의해서만 가능합니다. 
                            따라서 이용자 여러분께서는 비밀번호를 누구에게도 알려주시면 안됩니다. 이를 위해 회사에서는 기본적으로 PC에서의 사용을 마치신 후 온라인상에서 로그아웃(LOG-OUT)하시고 웹브라우저를 종료하도록 권장합니다. 
                            특히 다른 사람과 PC를 공유하여 사용하거나 공공장소(학교, 도서관, 인터넷 게임방 등)에서 이용한 경우에는 개인정보가 다른 사람에게 알려지는 것을 막기 위해 위와 같은 절차가 더욱 필요할 것입니다.
                        </p>
                        <p>
                            회사는 해킹이나 컴퓨터 바이러스 등에 의해 회원의 개인정보가 유출되거나 훼손되는 것을 막기 위해 최선을 다하고 있습니다. 
                            개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고, 최신 백신프로그램을 이용하여 이용자들의 개인정보나 자료가 누출되거나 손상되지 않도록 방지하고 있으며, 암호알고리즘 등을 통하여 
                            네트워크상에서 개인정보를 안전하게 전송할 수 있도록 하고 있습니다. 
                            그리고 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있으며, 기타 시스템적으로 안정성을 확보하기 위한 가능한 모든 기술적 장치를 갖추려 노력하고 있습니다.
                        </p>
                        <p>
                            회사는 정보통신부 지정 개인정보지침에 의거 관리책임자를 아래와 같이 지정합니다. 
                            
                        </p>
                        <ul>
                            <li><strong>ㆍ개인정보보호책임자 성명 : 안효상</strong></li>
                            <li><strong>ㆍ전화번호 : 070-4848-0048</strong></li>
                            <li><strong>ㆍ이메일 : <a style="color: rgb(0, 171, 255); letter-spacing: 1px; text-decoration: underline;" href="mailto:info@campingsearch.co.kr">info@campingsearch.co.kr</a></strong></li>
                        </ul>
                    </div>
	    </div>
	  </div>
	</div> 


</div>

  
        
        
</body>
</html>