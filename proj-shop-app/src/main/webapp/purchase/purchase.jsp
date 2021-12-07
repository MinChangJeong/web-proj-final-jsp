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
<link href=".//purchase.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
   request.setCharacterEncoding("utf-8");
   Connection conn = null;
   String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
   String id = "root";
   String pwd = "0216"; 
   
   Class.forName("com.mysql.jdbc.Driver");
   conn = DriverManager.getConnection(url, id, pwd);
   
   int pdId = Integer.parseInt(request.getParameter("pdId"));
   
   ProductDetail productDetail = null;
   Product product = null;
   
   ProductDetailDAO productDetailDAO = new ProductDetailDAO();
   productDetail = productDetailDAO.selectById(conn, pdId);
   
   ProductDAO productDAO = new ProductDAO();
   product = productDAO.selectById(conn, productDetail.getProduct_id());
   
   String userEmail = String.valueOf(session.getAttribute("LOGIN"));
   
   User user = new User();
   UserDAO userDAO = new UserDAO();
   user = userDAO.selectInfoByEmail(conn, userEmail);
   
   
%>
<div class="main-container">

  <div class="page-header">
    <img src="../images/logo1.png" alt="" />
    <div class="menu">
       <a href="../user/logout.jsp"><img src="../images/logout.png" alt="" /></a>
    </div>
  </div>
  
  <c:set var="product" value="<%=product%>" />
  <c:set var="productDetail" value="<%=productDetail%>" />
  <div class="page-body">
     <div class="product-info">
        <img class="product-image" alt="" src="data:image/png;base64,${product.base64Image}" width="100" height="100"/>
        <div class="product-info-sub">
           <span>${product.productName}</span>
           <span>${productDetail.size }</span>
        </div>
     </div>
     
     <c:set var="user" value="<%=user%>" />
     <div class="user-info">
        <h3>��� �ּ�</h3>
        <div class="user-info-sub">
           <span>����� ���� ��� �ּ� : </span>
           <span>${user.address}</span>
        </div>
     
     <hr width="670px" align="center" color= #d7d7d7 size="1px">
     <div class="express-info">
        <h3>��� ���</h3>
        <div class="express-info-sub">
           <span>��� ���</span>
           <span>�˼� �� ��� : 5 ~7 �� ���� ��������</span>
        </div>
     </div>
    </div>    
    <div class="purchase-info">
        <h3>���� �ֹ� ����</h3>
        <div class="purchase-main">
           <span>�� ���� �ݾ�</span>
           <span> ${productDetail.price+1000 }��</span>
        </div>
        <hr width="670px" align="center" color= #d7d7d7 size="1px">
        
        <div class="purchase-sub">
           <span>��� ���Ű�</span>
           <span> ${productDetail.price }��</span>
        </div>
        <div class="purchase-sub">
           <span>�˼���</span>
           <span> ����</span>
        </div>
        <div class="purchase-sub2">
           <span>��ۺ� </span>
           <span>1000��</span>
        </div>
    </div>
    
    <div class="payment-info">
        <h3>���� ���</h3>
        <div class="payment-info-sub">
           <span>���� ����</span>
           <form action="purchaseResult.jsp?pdId=${productDetail.id }" method="post">
              <select name="paymentMethod">
                 <option value="�ſ�/üũī��">�ſ�/üũī��</option>
                 <option value="���̹�����">���̹�����</option>
                 <option value="īī������">īī������</option>
                 <option value="�佺">�佺</option>
                 <option value="������">������</option>
              </select>
                <div class = "buttonWrap">
                   <button type="submit">�����ϱ�</button>
                </div>         
           </form>
        </div>
    </div>

</div>
  <div class="page-footer">
      <img src="../images/banner3.png" alt="img" />
  </div>

</body>
</html>