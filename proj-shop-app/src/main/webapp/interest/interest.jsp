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
	
	user = userDAO.selectInfoByEmail(conn, email);
	int uId = user.getId();
			
	InterestDAO interestDAO = new InterestDAO();
	interestDAO.insertInterest(conn, uId, pdId);
	%>
		<script type="text/javascript">	
			var check = confirm("관심상품 등록을 확인하시겠습니까?");
		   	  if(check) {
		   		window.location.href = 'http://localhost:8080/proj-shop-app/user/userInterestInfo.jsp';
		   	  }
		   	  else {
		   		history.go(-1);
		   	  }
		</script>
	<%	
%>


</body>
</html>