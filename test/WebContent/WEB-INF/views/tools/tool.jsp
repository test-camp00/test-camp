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


<div>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container">
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>캠핑용품</h3>
	</div>
	<div>
	<div class="row">
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/tent1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/chair1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'"  style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/dishes1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div></div>
	<div class="row" style="margin-top: 15px;">
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/renton1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/sleepingbag1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div>
		<div class="col-md-12 col-md-4"><input type="image" src="<%=cp%>/images/burner1.jpg" onMouseOver="this.style.opacity='.6'; this.style.filter='alpha(opacity=60)'" onMouseOut="this.style.opacity='1.0'; this.style.filter='alpha(opacity=100)'" style="width: 100%; height: 200px;"
					alt="..."></div></div>			
					
	</div>
	<div style="border-bottom: 1px solid #ccc; margin-bottom: 30px;">
		<h3>텐트류</h3>
	</div>
	
	<table class="table table-striped table-bordered table-hover">
        <caption>테이블 설명</caption>
        <thead>
            <tr>
                <th>#</th>
                <th>제품번호</th>
                <th>제품명</th>
                <th>제조사</th>
                <th>이미지</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>데이터2</td>
                <td>데이터3</td>
                <td>데이터4</td>
                <td>데이터5</td>
            </tr>
            <tr>
                <td>2</td>
                <td>데이터2</td>
                <td>데이터3</td>
                <td>데이터4</td>
                <td>데이터5</td>
            </tr>
            <tr>
                <td>3</td>
                <td>데이터2</td>
                <td>데이터3</td>
                <td>데이터4</td>
                <td>데이터5</td>
            </tr>
            <tr>
                <td>4</td>
                <td>데이터2</td>
                <td>데이터3</td>
                <td>데이터4</td>
                <td>데이터5</td>
            </tr>
            <tr>
                <td>5</td>
                <td>데이터2</td>
                <td>데이터3</td>
                <td>데이터4</td>
                <td>데이터5</td>
            </tr>
        </tbody>
    </table>
	
	
	</div>
	


	



<div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="<%=cp%>/bootstrap/js/bootstrap.min.js"></script>