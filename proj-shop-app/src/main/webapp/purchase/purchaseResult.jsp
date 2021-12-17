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
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");

	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	int pdId = Integer.parseInt(request.getParameter("pdId"));
	
	ProductDetail productDetail = null;
	
	ProductDetailDAO productDetailDAO = new ProductDetailDAO();
	productDetail = productDetailDAO.selectById(conn, pdId);

	int totalPurchasePrice = productDetail.getPrice();
	
	String paymentMethod = String.valueOf(request.getParameter("paymentMethod"));
	
	PurchaseDAO purchaseDAO = new PurchaseDAO();
	
	String userEmail = String.valueOf(session.getAttribute("LOGIN"));
	User user = new User();

	UserDAO userDAO = new UserDAO();
	user = userDAO.selectInfoByEmail(conn, userEmail);
	
	Purchase purchase = new Purchase();
	purchase.setPaymentMethod(paymentMethod);
	purchase.setTotalPurchasePrice(totalPurchasePrice);

	purchaseDAO.insertPurchase(conn, user.getId(), pdId, purchase);
	%>
		<script>
			alert("상품 구매가 완료 되었습니다.");
			window.location.href = 'http://localhost:8080/proj-shop-app/user/userPurchaseInfo.jsp';
		</script>
	<% 
%>
</body>
</html>