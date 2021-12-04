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
<link href=".//purchase.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	int pdId = Integer.parseInt(request.getParameter("pdId"));
	
	ProductDetail productDetail = null;
	Product product = null;
	
	ProductDetailDAO productDetailDAO = new ProductDetailDAO();
	productDetail = productDetailDAO.selectById(conn, pdId);
	
	ProductDAO productDAO = new ProductDAO();
	product = productDAO.selectById(conn, productDetail.getProduct_id());
	
	System.out.println(product.getId());
	
	String userEmail = String.valueOf(session.getAttribute("LOGIN"));
	
	User user = new User();

	UserDAO userDAO = new UserDAO();
	user = userDAO.selectInfoByEmail(conn, userEmail);
	
	System.out.println(user.getAddress());
	
%>
<div class="main-container">
  
  <div class="page-header">
    <img src="../images/logo1.png" alt="" />
    <div class="menu">
	    <a href="../user/logout.jsp"><img src="../images/logout.png" alt="" /></a>
    </div>
  </div>
  
  <c:set var="product" value="<%=product%>" />
  <c:set var="productDetail" value="<%=productDetail%>" />
  <div class="page-body">
  	<div class="product-info">
  		<img class="product-image" alt="" src="data:image/png;base64,${product.base64Image}" width="100" height="100"/>
  		<div class="product-info-sub">
  			<span>${product.productName}</span>
  			<span>${productDetail.size }</span>
  			<span></span>
  		</div>
  	</div>
  </div>
  
  <div class="page-footer">
      <img src="../images/banner1.jpg" alt="img" />
      <img src="../images/banner2.jpg" alt="img" />
  </div>
</div>
</body>
</html>