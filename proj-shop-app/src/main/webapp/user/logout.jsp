<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, util.*" %>
<%@page import="dao.*, model.*"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
session.invalidate();
%>
<script>
	alert("로그아웃 되었습니다.");
</script>
<%
response.sendRedirect("..//main.jsp");
%>


</body>
</html>