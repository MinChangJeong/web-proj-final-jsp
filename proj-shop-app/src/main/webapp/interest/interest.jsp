<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.nio.file.*, java.io.*, java.util.*, java.sql.*, util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="dao.*, model.*"%> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="productDetail.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

 	int pdId = Integer.parseInt(request.getParameter("pdId")); 
	
	String email = String.valueOf(session.getAttribute("LOGIN"));
	
	UserDAO userDAO = new UserDAO();
	
	User user = null;
	
	user = userDAO.selectByEmail(conn, email);
	int uId = user.getId();
			
	InterestDAO interestDAO = new InterestDAO();
	interestDAO.insertInterest(conn, uId, pdId);
	
%>

<script type="text/javascript">
	alert("관심상품으로 등록 되었습니다.");
	history.go(-1);
</script>
</body>
</html>