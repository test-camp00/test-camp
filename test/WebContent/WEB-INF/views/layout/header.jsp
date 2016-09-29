<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">


<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script type="text/javascript">
//엔터 처리

</script>
  
 <style media="screen">

.collapse>ul.nav > li > a:hover {
	
	color: white;
	border-style: none;
}
.collapse>ul.nav >li> a{
color : #BDBDBD;
float: right;
 font-size: 12pt;
 text-decoration: none;

}
 .gnb {
    position:absolute;

}

.gnb>ul>li{
    float: left;
    width: 120px;
    text-align: center;
}


ul{
    list-style:none;
    color: #515151;
    }
  ul,li{margin: 0; padding: 0; }
li{list-style: none;}

.sub>li>a:hover{
	color: white;
	border-style: none;
	text-decoration: none;
	
}
.sub>li>a{
color:#BDBDBD;
}
.sub>li {
    width: 120px;
    
    
}
.sub>li{
text-align:center;

    border: 1px solid white;
   width: 100%;
    display: block;
   
    line-height: 10px;
    background: #4C4C4C;
 
    font-weight: bold;

}
.navbar-default {

    background-image: -webkit-linear-gradient(top,#fff 0,#4C4C4C 100%);
    background-image: -o-linear-gradient(top,#fff 0,#4C4C4C 100%);
    background-image: -webkit-gradient(linear,left top,left bottom,from(#4C4C4C),to(#4C4C4C));
    background-image: linear-gradient(to bottom,#4C4C4C 0,#4C4C4C 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#4C4C4C', endColorstr='#4C4C4C', GradientType=0);
    filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    background-repeat: repeat-x;
    border-radius: 8px;
  
    -webkit-box-shadow: inset 0 8px 8px #4C4C4C,0 8px 8px #4C4C4C;
    box-shadow: inset 20px 20px 10px #4C4C4C;
}
.navbar-default{
    background-color: #515151;
    border:none;
}

    </style>  
<script type="text/javascript">
$(function(){
    $("ul.sub").hide();
    $("ul.menu li").hover(function(){
        $("ul:not(:animated)",this).slideDown("fast");
    },function(){
        $("ul",this).slideUp("fast");
    });
});

</script>
<br>
​﻿

	<div style="float: left; margin: 0 0">
	<span style="color:white; font-size: 18pt; font-weight: bold; font-family:'Nanum Pen Script' "><marquee behavior="alternate" direction="up" height="30" scrollamount="2">
	&nbsp;&nbsp;그린캠핑으로 캠핑하자! 감성캠핑, 힐링캠핑은 이곳에서♡  &nbsp;&nbsp;</marquee></span>
 	
 	</div>
 	
<div class="container" >


 	<div class="login header-login" style="float: right;">
 	<div id="gnbwrap" >
    <div class="gnb" id="gnb"> 
    
 	
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><font style="color: white; font-weight:bold; font-size: 18pt;font-family:'Nanum Pen Script'" >로그인&nbsp;&nbsp;</font></a> 
                <a href="<%=cp%>/member/member.do"><font style="color: white; font-weight:bold; font-size: 18pt;font-family:'Nanum Pen Script' " >회원가입&nbsp;&nbsp;</font></a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">

                <a href="<%=cp%>/member/memberInfo.do"><span style="color:white;">${sessionScope.member.userName}</span>님 <i></i></a>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do"><font style="color: orange; font-weight:bold; font-size: 12pt; " >관리자</font></a> <i></i>

                </c:if>
            
                
                <a href="<%=cp%>/member/logout.do"><font style="color: white; font-weight:bold; font-size: 18pt; font-family:'Nanum Pen Script'" >로그아웃&nbsp;&nbsp;</font></a>
            </c:if>
        
        <ul class="menu"style="float:right" >
           <li>
              <a href="<%=cp%>/onetoone/onetoone.do" style="text-decoration: none"><font style="color:white; font-weight:bold; font-size: 18pt;font-family:'Nanum Pen Script' " >고객센터&nbsp;&nbsp;</font></a>
 
                <ul class="sub">
                    <li><a href="<%=cp%>/onetoone/onetoone.do"><font style="font-family:'Nanum Pen Script'; font-size: 17pt;">질문과 답변</font></a></li>
                    <li><a href="<%=cp%>/FAQ/list.do"><font style="font-family:'Nanum Pen Script'; font-size: 17pt;">FAQ</font></a></li>
                    <li><a href=""><font style="font-family:'Nanum Pen Script'; font-size: 17pt;">개인정보이용방침</font></a></li>
                    <li><a href=""><font style="font-family:'Nanum Pen Script'; font-size: 17pt;">이용약관</font></a></li>
                </ul>
            </li>
        </ul>
    </div>
    </div>
  
</div>
</div>

  
     
     
        <div class="container" >
         <img src="<%=cp%>/images/cam1.JPG" width="90" height="85;" style="position: absolute; top:70px; left:400px ">
        <div style=" position: absolute; top: 100px; left: 500px">
      <a href="<%=cp%>/" style="text-decoration: none; float: left" >
    
    <!--   <span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 36px; font-weight: bold;">GREEN CAMPING</span> -->
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">G</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">R</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">E</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px;  color: #515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">E</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">N</span>
&nbsp;&nbsp;&nbsp;
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">C</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">A</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px;  color:#515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">M</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">P</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px;  color:#515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">I</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px; color: #3cb371; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">N</span>
<span style="vertical-align: middle; height: 70; position: relative; top:20px;  color: #515151; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: 'Hanna'; font-size: 39px; font-weight: bold;">G</span>

</a>
</div>
 <form class="navbar-form navbar-right" role="search">
		<div class="form-group">
<br>
		  <input type="text" class="form-control" placeholder="Search" style="border: 3px solid #3cb371; position: absolute; top:110px;left: 1300px">
	
		<button type="submit" class="btn btn-default" style="background-color:#3cb371; height: 33px; border: none; position: absolute; top: 110px; left: 1500px"><font style="color:white; font-family: 'Hanna'; font-size: 10pt" >검색</font></button>
		</div>
	      </form>  
	      </div>



  <div style="border-bottom:4px solid #3cb371 ;width:100%;position: absolute; top: 156px;"></div>
 <div style="position: absolute;background-color:#515151; height: 55px;   box-shadow: inset 20px 20px 10px #4C4C4C; top: 160px; width: 100%">
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

	
	    <div class="navbar-collapse collapse" id="navbar-collapse-1" ">
	      <ul class="nav navbar-nav" >


	
		  <li >  <a href="<%=cp%>/" style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-home" aria-hidden="true" style="float: left; " ></span>Home</a></li>
		<li><a href="<%=cp%>/campground/list.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-tree-conifer" aria-hidden="true" style="float: left"></span>캠핑장</a></li>
		<li><a href="<%=cp%>/cooks/cook.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: left"></span>캠핑요리</a></li>
		<li><a href="<%=cp%>/tools/tool.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-wrench" aria-hidden="true" style="float: left"></span>캠핑용품</a></li>
		<li><a href="<%=cp%>/camping/HowtoCamp.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-leaf" aria-hidden="true" style="float: left"></span>캠핑노하우</a></li>
		<li><a href="<%=cp%>/free_board/board_free.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-send" aria-hidden="true" style="float: left"></span>자유게시판</a></li>
		<li><a href="<%=cp%>/trade_board/board_trade.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-transfer" aria-hidden="true" style="float: left"></span>거래게시판</a></li>
		<li><a href="<%=cp%>/gallery/gallery_list.do"style="font-family:'Hanna'; width: 130px"><span class="glyphicon glyphicon-camera" aria-hidden="true" style="float: left"></span>갤러리</a></li>
	 
	  
	      </ul>
	     
	      
	     
	    </div><!-- /.navbar-collapse -->
	 
	  </div><!-- /.container-fluid -->
	</nav>
	</div>
</div>


<br>