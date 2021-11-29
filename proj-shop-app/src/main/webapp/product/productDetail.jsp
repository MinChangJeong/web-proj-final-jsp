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
			<!-- ���Ŵ� size������ �����ϸ� �� ����� �ش�Ǵ� ��ǰ�� �����ϴ� ������ ����ϸ� �ɵ�-->
			<!-- �ϳ��� ������ǰ�� ���� ������ ������ ���������� �� ����� �ش� �Ǵ� ��ǰ�� �ϳ� �� ����  -->
			<!-- �ΰ��� entitiy�� �ʿ��� : 1. product, 2. productDetil -->
			<!-- productName -->
			<h1>${product.productName}</h1>
			<!-- productExplain -->
			<!-- <h2>(GS) Jordan 1 Retro High OG Patent Bred</h2> -->
			<div class="sub-div">
				<span>������</span>
				<!-- productSize-->
				<select>
					<c:forEach var="productDetail" items="${product.getProductDetail()}">
						<option value="${productDetail.size }">${productDetail.size }</option>
			        </c:forEach>
		        </select>
			</div>
			<div class="sub-div">
				<span>�ֱ� �ŷ���</span>
				<!-- productDetail ���� -->
				<select>
					<c:forEach var="productDetail" items="${product.getProductDetail()}">
						<option value="${productDetail.price }">${productDetail.price }��</option>
			        </c:forEach>
		        </select>
			</div>
			<div class="sub-div">
				<!-- onclick���� �����ϸ� �ɵ� -->
				<button class="buyBtn" type="submit">����</button>
				<button class="interBtn" type="submit">���ɻ�ǰ</button>
			</div>
			<div class="product-sub-info">
				<h3>��ǰ ����</h3>
				<div>
					<!-- ����� ���� -->
					<span>�ֱ� �ŷ���</span>
					<span>21/11/19</span>
				</div>
				<div>
					<!-- productColor -->
					<span>�÷�</span>
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