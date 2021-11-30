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
<link href="productDetail.css?after" rel="stylesheet" type="text/css" />
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
		
		int pId = Integer.parseInt(request.getParameter("pId"));
		
		product = productDAO.selectById(conn, pId);
		
		System.out.println(product);
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
			<div class="product-sub-info">
				<h3>상품 세부 정보</h3>
				
				<%
				ProductDetailDAO productDetailDAO = new ProductDetailDAO();
			
				for(ProductDetail productDetail : product.getProductDetail()){
					
					ProductDetail target = new ProductDetail();
					
 					target = productDetailDAO.selectById(conn, productDetail.getId());
 					
					%>
					<c:set var="productDetail" value="<%= target %>" />
					<div class="sub-div">
						<span>사이즈</span>
						<!-- productSize-->
						<span>${productDetail.size}</span>
					</div>
					<div class="sub-div">
						<span>상품 가격</span>
						<!-- productPrice-->
						<span>${productDetail.price}</span>
					</div>
					<div class="sub-div">
						<!-- onclick으로 진행하면 될듯 -->
						<button class="buyBtn" type="submit"><a class="interestBtn" href="../purchase/purchase.jsp?pId=${productDetail.id}" >구매</a></button>
						<button class="interBtn" type="submit"><a class="interestBtn" href="../interest/interest.jsp?pId=${productDetail.id}" >관심상품등록</a></button>
					</div>
					<% 
					break;
				}	
			%>
				
				<div>
					<!-- 출시일 정보 -->
					<span>상품 등록 날짜</span>
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
	  <img src="../images/banner1.jpg" alt="" />
	  <img src="../images/banner2.jpg" alt="" />
	</div>
</div>
</body>
</html>