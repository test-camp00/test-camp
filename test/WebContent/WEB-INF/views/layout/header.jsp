<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="container">	    
	<a href="<%=cp%>/" style="text-decoration: none;">
        <span style="width: 200px; height: 70; position: relative; left: 0; top:20px; color: #82D580; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">ARTCAMPING</span>
    </a>
 	<br><br>
 	<div class="login header-login" style="float: right;">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/"><span class="glyphicon glyphicon-user"></span> 회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님 <i></i>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do">관리자</a> <i></i>
                </c:if>
                <a href="<%=cp%>/"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
    </div>
    <br><br>

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
	      <a class="navbar-brand" href="#">Home</a>
	    </div>

	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="navbar-collapse collapse" id="navbar-collapse-1">
	      <ul class="nav navbar-nav">
		<li class="active"><a href="#">추천 <span class="sr-only"></span></a></li>
		
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">캠핑정보 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="#">캠핑장소</a></li>
		    <li><a href="#">캠핑용품</a></li>
		    <li><a href="#">요리</a></li>
		    <li class="divider"></li>
		    <li><a href="#">캠핑노하우</a></li>
		    <li class="divider"></li>
		  </ul>
		</li>
		
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">게시판 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="<%=cp%>/board/board_free.do">자유게시판</a></li>
		    <li><a href="<%=cp%>/board/board_trade.do">거래</a></li>
		  </ul>
		</li>
		
		<li><a href="<%=cp%>/gallery/gallery_list.do">갤러리</a></li>
		
		<li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">고객센터 <span class="caret"></span></a>
		  <ul class="dropdown-menu" role="menu">
		    <li><a href="#">FAQ</a></li>
		    <li><a href="#">Q&A</a></li>
		    <li><a href="#">NOTICE</a></li>
		  </ul>
		</li>
		
	      </ul>
	      <form class="navbar-form navbar-right" role="search">
		<div class="form-group">
		  <input type="text" class="form-control" placeholder="Search">
		</div>
		<button type="submit" class="btn btn-default">검색</button>
	      </form>
	      
	     
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	
</div>
