<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<br>
<div style="border-top:2px solid black; height: 100px; background-color: black; border-bottom: 4px solid #82D580;">
<a href="<%=cp%>/" style="text-decoration: none;">
      <span style="width: 200px; height: 70; position: relative; left: 400px; top:20px; color: #82D580; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">ARTCAMPING</span>
    </a>
    </div>
<div class="container" >
	
 	<br>
 	<div class="login header-login" style="float: right;">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/member/member.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님 <i></i>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do">관리자</a> <i></i>
                </c:if>
                <a href="<%=cp%>/member/logout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
              <a href="<%=cp%>/"><span class="glyphicon glyphicon-question-sign"></span> 고객센터</a>
    </div>
 
  
</div>
    <br>


<div class="container">
	<nav class="navbar navbar-default" role="navigation">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	      </button>
	     
	    </div>

	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="navbar-collapse collapse" id="navbar-collapse-1">
	      <ul class="nav navbar-nav">
	      <li> <a href="#"><span class="glyphicon glyphicon-home" aria-hidden="true" style="float: right">Home</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-tent" aria-hidden="true" style="float: right">캠핑장</span></a></li>
		<li><a href="<%=cp%>/cooks/cook.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑요리</span></a></li>
		<li><a href="<%=cp%>/tools/tool.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑용품</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑방법</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-send" aria-hidden="true" style="float: right">자유게시판</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-transfer" aria-hidden="true" style="float: right">거래게시판</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-camera" aria-hidden="true" style="float: right">갤러리</span></a></li>
	
		
	      </ul>
	      <form class="navbar-form navbar-right" role="search">
		<div class="form-group">
		  <input type="text" class="form-control" placeholder="Search" >
	
		<button type="submit" class="btn btn-default" >검색</button>
		</div>
	      </form>
	      
	     
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	
</div>

<br>