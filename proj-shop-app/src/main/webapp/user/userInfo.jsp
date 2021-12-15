<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	String email = String.valueOf(session.getAttribute("LOGIN"));
    UserDAO userDAO = new UserDAO();
    User user = userDAO.selectInfoByEmail(conn, email);
   
    int uId = user.getId();
%>
</body>
</html>