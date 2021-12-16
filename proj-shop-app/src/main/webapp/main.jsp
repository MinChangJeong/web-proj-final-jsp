<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, util.*" %>
<%@page import="dao.*, model.*"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href=".//main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>main</title>
</head>

<body>
<%  request.setCharacterEncoding("euc-kr");%>
<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	List<Product> products = new ArrayList<>();
	
	if(request.getParameter("servlet") == null) {
		
	}
	else if(request.getParameter("servlet").equals("signup")) {
		User user = null;
		
	 	String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String phoneNumber = request.getParameter("phoneNumber");
		int shoesSize = Integer.parseInt(request.getParameter("shoesSize"));
		String address = request.getParameter("address");
	
		user = new User(username, email, password, phoneNumber, address, shoesSize);
		
	 	try {
			UserDAO userDao= new UserDAO();
			userDao.insertUser(conn, user);
			
			session.setAttribute("LOGIN", email);
		}catch (SQLException e){} 
	}
	else if(request.getParameter("servlet").equals("login")){
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
	    boolean emailCheck = false;
	    
	    try {
	       UserDAO dao = new UserDAO();
	       
	       emailCheck = dao.checkEmail(conn, email);
	    }
	    catch (SQLException e){}
	    
	    if (!emailCheck) {
			%>
				<script>
				   alert("아이디가 틀립니다.");
				   history.go(-1);
				</script>
			<% 
	    	
	    }else {
	    	boolean passwordCheck = false;
		    try {
		       UserDAO dao = new UserDAO();
		       
		       passwordCheck = dao.checkPassword(conn, email, password);
		    }
		    catch (SQLException e){}
		    
		    if (passwordCheck) {
		    	session.setAttribute("LOGIN", email);
		    	
		    	if(session.getAttribute("LOGIN").equals("ADMIN")){
		    		response.sendRedirect("admin/admin.html");
		    	}
		    	
		    } else {
			%>
				<script>
				   alert("패스워드가 틀립니다.");
				   history.go(-1);
				</script>
			<% 
			}
	    }
	}
	PurchaseDAO purchaseDAO = new PurchaseDAO();
	List<Integer> productDetailIds = purchaseDAO.selectTopByProductId(conn);
	
	ProductDetailDAO productDetailDAO = new ProductDetailDAO();
	ProductDAO productDAO = new ProductDAO();
	
	Product product = new Product();
	
	for(int productDetailId : productDetailIds){
		int pId = productDetailDAO.getProductId(conn, productDetailId);
		product = productDAO.selectById(conn, pId);
		
		products.add(product);
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

<!-- html -->
<div class="main-container">
   <div class="page-header">

   <a href="main.jsp"><img src="images/logo1.png" alt="" /></a>
   <div class="menu">
	   <c:set var ="servlet" value="<%=session.getAttribute(\"LOGIN\")%>"/>
	   <c:choose>
		   <c:when test="${empty servlet}">
	         <a href="product/productList.jsp"><img src="images/shop.png" alt="" /></a>
	         <a href="user/signin.html"><img src="images/login.png" alt="img" /></a>
	         <a href="user/signup.html"><img src="images/join.png" alt="img" /></a>
	      	 <div id="toc-content">
        		<form action="product/productList.jsp?servlet=search" method="post">
                	<input class="target" name="target" placeholder="Search your product..."/>
                    <button name="btn" type="submit" style="display: none">검색</button>
        		</form>
      		 </div>
			 <img src="images/search.png" alt="img" onclick="openCloseToc()"/>
       		 
		   </c:when>
		   
		   <c:when test="${!empty servlet}">
		      <a href="product/productList.jsp"><img src="images/shop.png" alt="" /></a>
		      <a href="user/logout.jsp"><img src="images/logout.png" alt="" /></a>
		      <a href="user/userInfo.jsp"><img class="mypage" src="images/mypage.png" alt="" /></a>
		  
		      <div id="toc-content">
        		<form action="product/productList.jsp?servlet=search" method="post">
                	<input class="target" name="target" placeholder="Search your product..."/>
                    <button name="btn" type="submit" style="display: none">검색</button>
        		</form>
      		  </div>
		      <img src="images/search.png" alt="img" onclick="openCloseToc()"/>  
		   </c:when>
	   </c:choose>
    </div>
  </div>
  <div class="page-body">
    <img src="images/main-banner.png" alt="" />
  	<div class="products-container">
  		<h2>Just Dropped</h2>
  		<h3>발매 상품</h3>
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
			                  <a href="./user/signin.html" >구매하러가기</a>
			              </td>
			          </tr> 
		      		<% 
		      	}
		      	else {
		      		%>
		      	      <tr>
			              <td>
			                  <a href="./product/productDetail.jsp?pId=${product.id}" >구매하러가기</a>
			              </td>
			          </tr> 
		      		<% 
		      	}
	          %>
	          
	          
	         </table>                
	      </c:forEach>
	    </div>
  	</div>
  </div>
  
<div class="page-footer">
    <div class="bottom-banner">
    	<img src="images/banner1.jpg" alt="" />
    	<img src="images/banner2.jpg" alt="" />
    </div>
    <img class="bottom-info-img" src="images/banner3.png" alt="img" />
</div>
</div>
</body>
</html>