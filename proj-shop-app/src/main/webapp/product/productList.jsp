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
.pageTable{
	display: flex;
	flex-direction: row;
}
</style>

</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript">
	function openCloseToc() {
      if(document.getElementById('toc-content').style.display === 'block') {
        document.getElementById('toc-content').style.display = 'none';
        
      } else {
        document.getElementById('toc-content').style.display = 'block'; 
      }
    }
</script>
<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	ProductDAO productDAO = new ProductDAO();

	Page pages = new Page();
	
	List<Product> products = pages.getProducts();
	
	if(request.getParameter("pageNumber")==null) {
		if(request.getParameter("servlet") == null) {
			pages = productDAO.selectAllProductsIntoPage(conn, 1);  
			
			products = pages.getProducts();
			
		}
	 	else if(request.getParameter("servlet").equals("search")){
	  		String target = request.getParameter("target");
			
	  		products = productDAO.searchAllProducts(conn, target);
	 	}	
	}
	else {
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		if(request.getParameter("servlet") == null) {
			pages = productDAO.selectAllProductsIntoPage(conn, pageNumber);  
			
			products = pages.getProducts();
			
		}
	 	else if(request.getParameter("servlet").equals("search")){
	  		String target = request.getParameter("target");
			
	  		products = productDAO.searchAllProducts(conn, target);
	 	}
	}
	
	
%>      
<div class="main-container">
  <div class="page-header">

   <a href="../main.jsp"><img src="../images/logo1.png" alt="" /></a>
   <div class="menu">
	   <c:set var ="servlet" value="<%=session.getAttribute(\"LOGIN\")%>"/>
	   <c:choose>
		   <c:when test="${empty servlet}">
	         <a href="../product/productList.jsp"><img src="../images/shop.png" alt="" /></a>
	         <a href="../user/signin.html"><img src="../images/login.png" alt="img" /></a>
	         <a href="../user/signup.html"><img src="../images/join.png" alt="img" /></a>
	      	 <div id="toc-content">
        		<form action="productList.jsp?servlet=search" method="post">
                	<input class="target" name="target" placeholder="Search your product..."/>
                    <button name="btn" type="submit" style="display: none">검색</button>
        		</form>
      		 </div>
			 <img src="../images/search.png" alt="img" onclick="openCloseToc()"/>
       		 
		   </c:when>
		   
		   <c:when test="${!empty servlet}">
		      <a href="../product/productList.jsp"><img src="../images/shop.png" alt="" /></a>
		      <a href="../user/logout.jsp"><img src="../images/logout.png" alt="" /></a>
		      <a href="../user/userPurchaseInfo.jsp"><img class="mypage" src="../images/mypage.png" alt="" /></a>
		      
		      <div id="toc-content">
        		<form action="productList.jsp?servlet=search" method="post">
                	<input class="target" name="target" placeholder="Search your product..."/>
                    <button name="btn" type="submit" style="display: none">검색</button>
        		</form>
      		  </div>
		      <img src="../images/search.png" alt="img" onclick="openCloseToc()"/>  
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
          <%
	      	if(session.getAttribute("LOGIN")!=null && session.getAttribute("LOGIN").equals("ADMIN")){
	    			
	    	}
	      	else if(session.getAttribute("LOGIN") ==null ){
	      		%>
	      	      <tr>
		              <td>
		                  <a href="../user/signin.html" >구매하러가기</a>
		              </td>
		          </tr> 
	      		<% 
	      	}
	      	else {
	      		%>
	      	      <tr>
		              <td>
		                  <a href="productDetail.jsp?pId=${product.id}" >구매하러가기</a>
		              </td>
		          </tr> 
	      		<% 
	      	}
          %>
         </table>                
      </c:forEach>
    </div>

	<div class="pageBtn">
		<form action="" method="post">
			<table class="pageTable">
				<tr>
				<%
					for(int i=1; i<=pages.getPageTotalCount(); i++) {
						%>
						<td>
			            	<button type="submit" name="pageNumber" value="<%=i%>"><%=i%></button>
			            </td>
						<%
					}
				%>
				</tr>
			</table>
		</form>
		
	</div>
  </div>
  
  <div class="page-footer">
    <div class="bottom-banner">
    	<img src="../images/banner1.jpg" alt="" />
    	<img src="../images/banner2.jpg" alt="" />
    </div>
    <img class="bottom-info-img" src="../images/banner3.png" alt="img" />
</div>
</div>

</body>
</html>