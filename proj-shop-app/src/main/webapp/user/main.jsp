<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, util.*" %>
<%@page import="dao.*, model.*"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>main</title>
<link href="main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%  request.setCharacterEncoding("utf-8");%>
<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
 	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
%>

<!-- User Insert -->
<jsp:useBean id="user" class="model.User"/>
<jsp:setProperty property="*" name="user"/> 

<%
	try {
		UserDAO userDao= new UserDAO();
		userDao.insertUser(conn, user);
		
	}catch (SQLException e){}
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
    <img src="../images/main-banner.png" alt="" />
  	<div class="products-container">
  		<h2>Just Dropped</h2>
  		<span>발매 상품</span>
  		<div class="products-list">
  			<!-- 판매량이 가장많은 상품4개를 보여준다. -->
  			<div class="product">
  				
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