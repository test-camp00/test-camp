<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<br>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<div class="container" >
	
 		<div style="float: left; margin-top: 0px">
 	<span class = "glyphicon glyphicon-earphone" style="color:white; font-size: 11pt; font-weight: bold" >02-761-0003</span>
 	</div>
 	<div class="login header-login" style="float: right;">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >로그인&nbsp;&nbsp;</font></a> <i></i>
                <a href="<%=cp%>/member/member.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >회원가입&nbsp;&nbsp;</font></a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:white;">${sessionScope.member.userName}</span>님 <i></i>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do"><font style="color: orange; font-weight:bold; font-size: 12pt; " >관리자</font></a> <i></i>
                </c:if>
                <a href="<%=cp%>/member/logout.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >로그아웃&nbsp;&nbsp;</font></a>
            </c:if>
              <a href="<%=cp%>/customer/list.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >고객센터&nbsp;&nbsp;</font></a>
    </div>
 
  
</div>
        <br>
      <div class="container">
      <a href="<%=cp%>/" style="text-decoration: none;">
      <span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: arial black; font-size: 36px; font-weight: bold;">ARTCAMPING</span>
</a>
 <form class="navbar-form navbar-right" role="search">
		<div class="form-group">
<br>
		  <input type="text" class="form-control" placeholder="Search" >
	
		<button type="submit" class="btn btn-default" >검색</button>
		</div>
	      </form>  
	      </div>
<div style=" height: 10px;  border-bottom: 4px solid #3cb371;">


  

    </div>


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

	 
	    <div class="navbar-collapse collapse" id="navbar-collapse-1">
	      <ul class="nav navbar-nav" >
	      <li > <a href="#"><span class="glyphicon glyphicon-home" aria-hidden="true" style="float: right;">Home</span></a></li>
		<li><a href="<%=cp%>/campground/list.do"><span class="glyphicon glyphicon-tent" aria-hidden="true" style="float: right">캠핑장</span></a></li>
		<li><a href="<%=cp%>/cooks/cook.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑요리</span></a></li>
		<li><a href="<%=cp%>/tools/tool.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑용품</span></a></li>
		<li><a href="<%=cp%>/camping/HowtoCamp.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right">캠핑노하우</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-send" aria-hidden="true" style="float: right">자유게시판</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-transfer" aria-hidden="true" style="float: right">거래게시판</span></a></li>
		<li><a href="#"><span class="glyphicon glyphicon-camera" aria-hidden="true" style="float: right">갤러리</span></a></li>
	
		
	      </ul>
	     
	      
	     
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	
</div>

<br>