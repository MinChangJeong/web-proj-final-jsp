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
<link href=".//productList.css" rel="stylesheet" type="text/css">

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
	
	if(request.getParameter("servlet") == null) {
	      products = productDAO.selectAllProducts(conn);   
    }
   	else if(request.getParameter("servlet").equals("search")){
    	String target = request.getParameter("target");

        products = productDAO.searchAllProducts(conn, target);
   }
	
%>        

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript"></script>
<script>
	function openCloseToc() {
      if(document.getElementById('toc-content').style.display === 'block') {
        document.getElementById('toc-content').style.display = 'none';
        
      } else {
        document.getElementById('toc-content').style.display = 'block';
        
      }
    }
</script>
<style>
#toc-content {
	display: none;
}
#toc-toggle {
  cursor: pointer;
  color: #2962ff;
}
#toc-toggle:hover {
  text-decoration: underline;
}
.page-body {
	display: flex;
   flex-direction: column;
   justify-content: center;
   align-items: center;
}
</style>
<div class="main-container">
  
  <div class="page-header">
    <a href="../main.jsp"><img src="../images/logo1.png" alt="" /></a>
    <div class="menu">
	    <c:set var ="servlet" value="<%=session.getAttribute(\"LOGIN\")%>"/>
	    <c:choose>
	         <c:when test="${empty servlet}">
		         <a href="productList.jsp"><img src="../images/shop.png" alt="" /></a>
		         <a href="../user/signin.html"><img src="../images/login.png" alt="" /></a>
		         <a href="../user/signup.html"><img src="../images/join.png" alt="" /></a>
		         <img src="../images/search.png" alt="img" onclick="openCloseToc()"/>
        		 <div id="toc-content">
	        		<form action="product/productList.jsp?servlet=search" method="post">
	                	<input name="target" placeholder="Search your product..."/>
	                    <button name="btn" type="submit">검색</button>
	        		</form>
       			 </div>
	       	</c:when>
	   
		    <c:when test="${!empty servlet}">
		    	<a href="productList.jsp"><img src="../images/shop.png" alt="" /></a>
		      	<a href="../user/logout.jsp"><img src="../images/logout.png" alt="" /></a>
		        <img src="../images/search.png" alt="img" onclick="openCloseToc()"/>
        		<div id="toc-content">
	        		<form action="product/productList.jsp?servlet=search" method="post">
	                	<input name="target" placeholder="Search your product..."/>
	                    <button name="btn" type="submit">검색</button>
	        		</form>
       			</div>
		   </c:when>
	   </c:choose>
    </div>
  </div>

  <div class="page-body">
  	<h1>Shop</h1>
  	<div class="product-list">
      <c:set var="products" value="<%=products%>" />
      <c:forEach var="product" items="${products}">           
         <table class="product-info">
            <tr>
               <td style="border-collapse: collapse; " >
                  <img class="productImage" alt="img" src="data:image/png;base64,${product.base64Image}" />
               </td>
           </tr>
           <tr>
	           <td><b> ${product.productName} </b></td>
	       </tr>
           <tr>
               <td>컬러 : ${product.productColor}</td>
           </tr>

           <c:set var="flag" value="false" />
           <c:forEach var="productDetail" items="${product.getProductDetail()}">
               <c:if test="${not flag}">
                   <tr>
                       <td> 가격 : <b> ${productDetail.price}원 </b></td>
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
  
  <div class="page-footer">
      <img src="../images/banner1.jpg" alt="img" />
      <img src="../images/banner2.jpg" alt="img" />
  </div>
</div>

</body>
</html>