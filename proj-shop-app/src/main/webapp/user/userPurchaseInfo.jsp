<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.nio.file.*, java.io.*, java.util.*, java.sql.*, util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="dao.*, model.*"%> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href=".//userPurchaseInfo.css" rel="stylesheet" type="text/css" />
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
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
<% 
   Connection conn = null;
   String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
   String id = "root";
   String pwd = "0216"; 
   
   Class.forName("com.mysql.jdbc.Driver");
   conn = DriverManager.getConnection(url, id, pwd);
%>
<div class="userInfo-container">
	<div class="page-header">
	   <a href="../main.jsp"><img src="../images/logo1.png" alt="" /></a>
	   <div class="menu">
		   <c:set var ="servlet" value="<%=session.getAttribute(\"LOGIN\")%>"/>
		   <c:choose>
			   <c:when test="${empty servlet}">
		         <a href="../product/productList.jsp"><img src="../images/shop.png" alt="" /></a>
		         <a href="../signin.html"><img src="../images/login.png" alt="img" /></a>
		         <a href="../signup.html"><img src="../images/join.png" alt="img" /></a>
		      	 <div id="toc-content">
	        		<form action="product/productList.jsp?servlet=search" method="post">
	                	<input class="target" name="target" placeholder="Search your product..."/>
	                    <button name="btn" type="submit" style="display: none">검색</button>
	        		</form>
	      		 </div>
				 <img src="images/search.png" alt="img" onclick="openCloseToc()"/>
			   </c:when>
			   
			   <c:when test="${!empty servlet}">
			      <a href="../product/productList.jsp"><img src="../images/shop.png" alt="" /></a>
			      <a href="logout.jsp"><img src="../images/logout.png" alt="" /></a>
			      <a href="userPurchaseInfo.jsp"><img class="mypage" src="../images/mypage.png" alt="" /></a>
			  
			      <div id="toc-content">
	        		<form action="../product/productList.jsp?servlet=search" method="post">
	                	<input class="target" name="target" placeholder="Search your product..."/>
	                    <button name="btn" type="submit" style="display: none">검색</button>
	        		</form>
	      		  </div>
			      <img src="../images/search.png" alt="img" onclick="openCloseToc()"/>  
			   </c:when>
		   </c:choose>
	    </div>
	</div>
	</div>
	<div class="page">
	<div class="leftmenu-container">
		<div class="leftmenu">
	   		<h3>MY PAGE NEMU</h3>
	        <ul>
				<li><a href="../user/userPurchaseInfo.jsp">구매내역</a></li>
				<li><a href="../user/userInterestInfo.jsp">관심상품</a></li>
	       </ul>
	    </div>
	    <div class="line"></div>
	</div>
	<div class="page-body">
	
		<div class="user-content">
		<div class="user-info">
		<%
		    String email = String.valueOf(session.getAttribute("LOGIN"));
		    UserDAO userDAO = new UserDAO();
		   
		    User user = userDAO.selectInfoByEmail(conn, email);		
		%>
		<c:set var="user" value="<%= user %>"/>
			<img class="user-img" alt="" src="../images/userImage.png">
			<div class="user-main-info">
      		 	<h3>${user.username }</h3>
      		 	<span>이메일 : ${user.email }</span>
      		 	<span>전화번호 : ${user.phoneNumber }</span>
      		 	<span>배송지 주소 설정값 : ${user.address }</span>
      		</div>
		</div>
			<!-- purchase -->
			<div class="purchase-wrap">
				<div class="user-purchase-list">
				<%
					PurchaseDAO purchaseDAO = new PurchaseDAO();
					List<Purchase> purchases = purchaseDAO.selectAllPurchaseByIds(conn, user.getId());
					%>
					<h3>구매내역</h3>
					<div class="purchase-header">
						<span>전체 &nbsp &nbsp &nbsp<%= purchases.size() %></span>
						<div class="line1"></div>
						<span>배송준비중 &nbsp &nbsp &nbsp &nbsp<%= purchases.size() %> </span>
						<div class="line1"></div>
						<span>배송완료 &nbsp &nbsp &nbsp 0 &nbsp &nbsp</span>
					</div>
					<% 
					ProductDetailDAO productDetailDAO = new ProductDetailDAO();
					ProductDAO productDAO = new ProductDAO();
					
					Product product = null;
					ProductDetail productDetail = null;
					for(Purchase purchase : purchases) {
						productDetail = new ProductDetail();
						productDetail = purchase.getProductDetail();
						
						product = new Product();
						product = productDetail.getProduct();
					
						%>
						<c:set var="purchase" value="<%= purchase %>"/>
						<c:set var="product" value="<%= product %>"/>
						<c:set var="productDetail" value="<%= productDetail %>"/>
						
						<div class="purchase-body">
							<img class="productImage" alt="img" src="data:image/png;base64,${product.base64Image}" />
							<div class="purchase-detail">
								<span>상품명 : ${product.productName}</span>
								<span>상품 상세 정보 : ${product.productExplain }</span>
								<span>총 주문 가격 : ${purchase.totalPurchasePrice }</span>
								<span>결제 수단 : ${purchase.paymentMethod} </span>
								<span>결제 일시 : ${purchase.createdAt }</span>
							</div>
						</div>
							
						<% 
					}
				%>
				</div>
			</div>
			
		
				<%
					InterestDAO interestDAO = new InterestDAO();
					List<Interest> interests = interestDAO.selectAllInterestByIds(conn, user.getId());
					%>
					
					<% 
				
					for(Interest interest : interests) {
						productDetail = new ProductDetail();
						productDetail = interest.getProductDetail();
					
						product = new Product();
						product = productDetail.getProduct();
				
						%>
						<c:set var="interest" value="<%= interest %>"/>
						<c:set var="product" value="<%= product %>"/>
						<c:set var="productDetail" value="<%= productDetail %>"/>
					
						
						<% 
					}
				%>


		
	</div>
	</div>
	</div>
	<div class="page-footer">
	    <div class="bottom-banner">
	    	<img src="../images/banner1.jpg" alt="" />
	    	<img src="../images/banner2.jpg" alt="" />
	    </div>
	    <img class="bottom-info-img" src="../images/banner3.png" alt="img" />
	</div>

</body>
</html>