<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");
%>

 <div style="clear: both; padding-top: 20px;">
 	       <div style="float: left; margin: 10px;"><span style="color: #008100; font-weight: bold;">댓글 ${dataCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
 	       <div style="float: right; text-align: right;"></div>
    </div>
    
    <div style="clear: both; padding-top: 5px; border-top: #82D580 solid 2px;">
    <c:forEach var="dto" items="${list}">    
         <div  style="clear:both; margin: 10px; padding: 10px; border-bottom: #d5d5d5 solid 1px; min-height: 100px;">
              <div style="clear: both;">
                  <div style="float: left; font-weight: bold;">${dto.userId} | ${dto.created}</div>
                  <div style="float: right;  text-align: rigth;">
                        <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
                           <a onclick='deleteReply("${dto.replyNum}", "${pageNo}", "${dto.userId}");'>삭제</a>
                        </c:if>
                  </div>
              </div>
              <div  style="clear: both; padding: 5px 0 5px 0px;  min-height: 40px;">
                       ${dto.content}
              </div>
         </div>
    </c:forEach>
    </div>
    
    <div style="clear: both; padding-top: 10px; text-align: center;">
        ${paging}
    </div>