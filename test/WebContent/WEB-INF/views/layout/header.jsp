<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

  
 <style media="screen">
 
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



.sub>li {
    width: 120px;
    
}
.sub>li{
text-align:center;

    border: 1px solid white;
   width: 100%;
    display: block;
   
    line-height: 40px;
    background: #515151;
    
    font-weight: bold;

}
.navbar-default {
    background-image: -webkit-linear-gradient(top,#fff 0,#515151 100%);
    background-image: -o-linear-gradient(top,#fff 0,#515151 100%);
    background-image: -webkit-gradient(linear,left top,left bottom,from(#515151),to(#515151));
    background-image: linear-gradient(to bottom,#515151 0,#515151 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#515151', endColorstr='#515151', GradientType=0);
    filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    background-repeat: repeat-x;
    border-radius: 8px;
    -webkit-box-shadow: inset 0 8px 0 #515151,0 8px 8px #515151;
    box-shadow: inset 0 8px 0 #515151,0 8px 8px #515151;
}
.navbar-default {
    background-color: #515151;
    border-color: #515151;
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
	
	<div style="float: left; margin: 0 0">
	<span style="color:white; font-size: 11pt; font-weight: bold">&nbsp;&nbsp;아트캠핑으로 캠핑하자!&nbsp;&nbsp;</span>
 	<span class = "glyphicon glyphicon-earphone" style="color:white; font-size: 11pt; font-weight: bold" >02-761-0003</span>
 	</div>
 	
<div class="container" >


 	<div class="login header-login" style="float: right;">
 	<div id="gnbwrap" >
    <div class="gnb" id="gnb"> 
    
 	
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >로그인&nbsp;&nbsp;</font></a> <i></i>
                <a href="<%=cp%>/member/member.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >회원가입&nbsp;&nbsp;</font></a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
            <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do"><font style="color: #515151; font-weight:bold; font-size: 12pt; " >관리자</font></a> <i></i>
                </c:if>
                <span style="color:white;">${sessionScope.member.userName}</span>님&nbsp;&nbsp;&nbsp;&nbsp; 
                
                <a href="<%=cp%>/member/logout.do"><font style="color: white; font-weight:bold; font-size: 11pt; " >로그아웃&nbsp;&nbsp;</font></a>
            </c:if>
        
        <ul class="menu"style="float:right" >
           <li>
              <a href="<%=cp%>/onetoone/onetoone.do"><font style="color:white; font-weight:bold; font-size: 11pt; " >고객센터&nbsp;&nbsp;</font></a>
 
                <ul class="sub">
                    <li><a href="<%=cp%>/onetoone/onetoone.do"><font style="color: white">질문과 답변</font></a></li>
                    <li><a href=""><font style="color: white">FAQ</font></a></li>
                    <li><a href=""><font style="color: white">개인정보이용방침</font></a></li>
                    <li><a href=""><font style="color: white">이용약관</font></a></li>
                </ul>
            </li>
        </ul>
    </div>
    </div>
  
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

<div style="background-color:#515151; height: 50px ">
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
	      <li  > <a href="#"><span class="glyphicon glyphicon-home" aria-hidden="true" style="float: right; font-size: 12pt; font-style: sans-serif;" >Home</span></a></li>
		<li ><a href="<%=cp%>/"><span class="glyphicon glyphicon-tree-conifer" aria-hidden="true" style="float: right;  font-size: 12pt; font-style: sans-serif;">Camp-Site</span></a></li>
		<li ><a href="<%=cp%>/cooks/cook.do"><span class="glyphicon glyphicon-cutlery" aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif;">Camp-Food</span></a></li>
		<li ><a href="<%=cp%>/tools/tool.do"><span class="glyphicon glyphicon-tent"  aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif">Camp-Equipment</span></a></li>
		<li ><a href="<%=cp%>/camping/HowtoCamp.do"><span class="glyphicon glyphicon-list-alt"  aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif;">Camp know-how</span></a></li>
		<li ><a href="#"><span class="glyphicon glyphicon-bullhorn"  aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif;">FreeBoard</span></a></li>
		<li ><a href="#"><span class="glyphicon glyphicon-transfer"  aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif;">TradBoard</span></a></li>
		<li ><a href="#"><span class="glyphicon glyphicon-camera"  aria-hidden="true" style="float: right; color: white; font-size: 12pt; font-style: sans-serif;">Gallery</span></a></li>
	
		
	      </ul>
	     
	      
	     
	    </div><!-- /.navbar-collapse -->
	 
	  </div><!-- /.container-fluid -->
	</nav>
	</div>
	</div>


<br>