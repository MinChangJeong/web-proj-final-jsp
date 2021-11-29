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
	
		Interest interest = new Interest();
		
		
	%>

<script type="text/javascript">
	alert("관심상품으로 등록 되었습니다.");
</script>
</body>
</html>