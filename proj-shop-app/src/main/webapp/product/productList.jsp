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
<link href="./productList.css" rel="stylesheet" type="text/css">

<style type="text/css">
	.page-body{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.product-list{
		margin-top: 20px;
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	.product-info{
		margin-right: 20px;
	}
	.productImage{
		border: 1px solid black;
	}
</style>
</head>
<body>

<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	ProductDAO productDAO = new ProductDAO();

	List<Product> products = new ArrayList<Product>();
	products = productDAO.selectAllProducts(conn);

%>        

<div class="main-container">
  <div class="page-header">
    <img src="../images/logo.png" alt="" />
    <div class="menu">
      <div class="login-container">
      </div>
    </div>
  </div>

  <div class="page-body">
  	<h1>Shop</h1>
  	<div class="product-list">
  		<c:set var="products" value="<%=products%>" />
		<c:forEach var="product" items="${products}">           
			<table class="product-info" border="1">
				<tr>
	                <td>${product.productName}</td>
	            </tr>
	            <tr>
	                <td>
	                	<img class="productImage" alt="img" src="data:image/png;base64,${product.base64Image}" width="260" height="300"/>
	                </td>
	            </tr>
	            <tr>
	                <td>${product.productColor}</td>
	            </tr>

				<c:set var="flag" value="false" />
	 			<c:forEach var="productDetail" items="${product.getProductDetail()}">
		        	<c:if test="${not flag}">
						<tr>
			                <td>${productDetail.price}</td>
			            </tr>
			            <tr>
			                <td>${productDetail.size}</td>
			            </tr>
			            <tr>
			                <td>${productDetail.stock}</td>
			            </tr>
					<c:set var="flag" value="true" />
					</c:if>
		        </c:forEach>
		        <tr>
	                <td>
	                	<a href="productDetail.jsp?pId=${product.id}" >구매하러가기</a>
	                </td>
	            </tr> 
			</table> 	            
    	</c:forEach>
  	</div>
  </div>
</div>

</body>
</html>