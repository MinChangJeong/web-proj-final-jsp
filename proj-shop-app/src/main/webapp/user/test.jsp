<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% if(session.getAttribute("email")==null) { %>
 <div class="logout">
 <img src="../images/logout.png" alt="" />
 </div>
<% } else { %>
<div class="login">
<img src="../images/login.png" alt="" />
</div>
<%}%>
</body>
</html>