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

<div class="product-container">
	<div class="page-header">
	  <img src="../images/logo.png" alt="" />
	  <div class="menu">
	  </div>
	</div>
	<!-- get product info -->
	<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
		String id = "root";
		String pwd = "0216"; 
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);
	
		ProductDAO productDAO = new ProductDAO();
		
		Product product = new Product();
		
		System.out.println(request.getParameter("pId"));
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		
		System.out.println(pId);
		
		product = productDAO.selectById(conn, pId);
		
	%>
	<div class="page-body">
	<c:set var="product" value="<%=product%>" />
		<img class="product-image" alt="" src="data:image/png;base64,${product.base64Image}" />
		<div class="product-detail">
			<!-- 구매는 size정보를 선택하면 그 사이즈에 해당되는 상품을 구매하는 것으로 취급하면 될듯-->
			<!-- 하나의 고유상품에 대한 사이즈 정보는 여러개지만 그 사이즈에 해당 되는 상품은 하나 만 존재  -->
			<!-- 두가지 entitiy가 필요함 : 1. product, 2. productDetil -->
			<!-- productName -->
			<h1>${product.productName}</h1>
			<!-- productExplain -->
			<!-- <h2>(GS) Jordan 1 Retro High OG Patent Bred</h2> -->
			<div class="sub-div">
				<span>사이즈</span>
				<!-- productSize-->
				<select>
					<c:forEach var="productDetail" items="${product.getProductDetail()}">
						<option value="${productDetail.size }">${productDetail.size }</option>
			        </c:forEach>
		        </select>
			</div>
			<div class="sub-div">
				<span>최근 거래가</span>
				<!-- productDetail 가격 -->
				<select>
					<c:forEach var="productDetail" items="${product.getProductDetail()}">
						<option value="${productDetail.price }">${productDetail.price }원</option>
			        </c:forEach>
		        </select>
			</div>
			<div class="sub-div">
				<!-- onclick으로 진행하면 될듯 -->
				<button class="buyBtn" type="submit">구매</button>
				<button class="interBtn" type="submit">관심상품</button>
			</div>
			<div class="product-sub-info">
				<h3>상품 정보</h3>
				<div>
					<!-- 출시일 정보 -->
					<span>최근 거래가</span>
					<span>21/11/19</span>
				</div>
				<div>
					<!-- productColor -->
					<span>컬러</span>
					<span>${product.productColor }</span>
				</div>
			</div>
		</div>
	</div>
	  
	<div class="page-footer">
	  <img src="../images/footer-banner1.png" alt="" />
	  <img src="../images/footer-banner2.png" alt="" />
	</div>
</div>
</body>
</html>