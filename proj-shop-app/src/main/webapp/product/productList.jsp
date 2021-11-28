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
<link href="productList.css" rel="stylesheet" type="text/css" />
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
	
 	for(Product product : products) {
		for(ProductDetail productDetail : product.getProductDetail()){
			System.out.println(productDetail.getPrice());
			System.out.println(productDetail.getSize());
			System.out.println(productDetail.getStock());
		}
		break;
	} 
	
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
<!--     <img src="../images/main-banner.png" alt="" /> -->
  	<div class="product-list">
  		<c:set var="products" value="<%=products%>" />
		<c:forEach var="product" items="${products}">           
			<table border="1">
				<tr>
	                <td>${product.productName}</td>
	            </tr>
	            <tr>
	                <td>
	                	<img alt="img" src="data:image/png;base64,${product.base64Image}" width="240" height="300"/>
	                </td>
	            </tr>
	            <tr>
	                <td>${product.productColor}</td>
	            </tr>

			</table> 
			<c:set var="flag" value="false" />
 			<c:forEach var="productDetail" items="${product.getProductDetail()}">
	        	<c:if test="${not flag}">
		        	<table border="1">
						<tr>
			                <td>${productDetail.price}</td>
			            </tr>
			            <tr>
			                <td>${productDetail.size}</td>
			            </tr>
			            <tr>
			                <td>${productDetail.stock}</td>
			            </tr>
					</table> 
				<c:set var="flag" value="true" />
				</c:if>
	        </c:forEach> 
	            
    	</c:forEach>  
  	</div>
  </div>

  
<!--   <div class="page-footer">
    <img src="../images/banner1.jpg" alt="" />
    <img src="../images/banner2.jpg" alt="" />
  </div> -->
</div>

</body>
</html>