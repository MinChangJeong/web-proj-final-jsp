<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.nio.file.*, java.io.*, java.util.*, java.sql.*, util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="dao.*, model.*"%> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR" name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href=".//productDetail.css?after" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="product-container">
   <div class="page-header">
     <a href="../main.jsp"><img src="../images/logo1.png" alt="" /></a>
     <div class="menu">
        <a href="productList.jsp"><img src="../images/shop.png" alt="" /></a>
        <a href="../user/logout.jsp"><img src="../images/logout.png" alt="" /></a>
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
      <div class="line"></div>
      <div class="product-detail">
         <!-- ���Ŵ� size������ �����ϸ� �� ����� �ش�Ǵ� ��ǰ�� �����ϴ� ������ ����ϸ� �ɵ�-->
         <!-- �ϳ��� ������ǰ�� ���� ������ ������ ���������� �� ����� �ش� �Ǵ� ��ǰ�� �ϳ� �� ����  -->
         <!-- �ΰ��� entitiy�� �ʿ��� : 1. product, 2. productDetil -->
         <!-- productName -->
         <h2><u>${product.productName}</u></h2>
         <!-- productExplain -->
         <h4>${product.productExplain }</h4>
         <div class="product-sub-info">
            <h4>��ǰ ���� ����</h4>
          	
			<div id="productModal" class="productModal">
				<form action="#" method="post">
					<select name="size">
						<option value="230">230</option>
						<option value="240">240</option>
						<option value="250">250</option>
						<option value="260">260</option>
						<option value="270">270</option>
						<option value="280">280</option>
					</select>
					<button type="submit">submit</button>
				</form>	
			</div>
			<%
				if(request.getParameter("size") == null) {
					%>
					<span>����� �����ϼ���</span>
					<%
				}
				else{
					int size = Integer.parseInt(request.getParameter("size"));
					
					ProductDetailDAO productDetailDAO = new ProductDetailDAO();
		            
		        	for(ProductDetail productDetail : product.getProductDetail()){
		           
		           		ProductDetail detail = productDetailDAO.selectById(conn, productDetail.getId());
		         
		            %>
		            <c:set var="productDetail" value="<%= detail %>" />
		            <%
		            	if(size == detail.getSize()){
		            		%>
		    	            
		    	            <div class="sub-div">
		    	               <span>������</span>
		    	               <!-- productSize-->
		    	               <span>${productDetail.size}</span>
		    	            </div>
		    	            <div class="sub-div">
		    	               <span>��ǰ ����</span>
		    	               <!-- productPrice-->
		    	               <span>${productDetail.price}</span>
		    	            </div>
		    	            <div>
		    	               <!-- onclick���� �����ϸ� �ɵ� -->
		    	               <button class="buyBtn" type="submit"><a class="purchaseBtn" href="../purchase/purchase.jsp?pdId=${productDetail.id}" >����</a></button>
		    	               <button class="interBtn" type="submit"><a class="interestBtn" href="../interest/interest.jsp?pdId=${productDetail.id}" >���ɻ�ǰ���</a></button>
		    	            </div>
		    	            <% 

		            		}   
		            	}	
				}
			%>
            
            <hr width="600px" align="right" color= #d7d7d7 size="1px">
            <div class="sub-div">
               <!-- ����� ���� -->
               <span>�����</span>
               <span>21/11/19</span>
            </div>
            <div class="sub-div">
               <!-- productColor -->
               <span>�÷�</span>
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