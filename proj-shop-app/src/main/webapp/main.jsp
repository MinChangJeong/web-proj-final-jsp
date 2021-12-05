<%@page import="java.net.http.HttpRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.sql.*, util.*" %>
<%@page import="dao.*, model.*"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="main.css" rel="stylesheet" type="text/css" />
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
		    		response.sendRedirect("../admin/admin.html");
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
%>



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
		         <img src="images/search.png" alt="img" />
		   		 <form action="product/productList.jsp?servlet=search" method="post">
		         	<input name="target" placeholder="Search your product..."/>
		         	<button name="btn" type="submit">검색</button>
		         </form>
		   </c:when>
		   
		   <c:when test="${!empty servlet}">
		      <a href="product/productList.jsp"><img src="images/shop.png" alt="" /></a>
		      <a href="user/logout.jsp"><img src="images/logout.png" alt="" /></a>
		      <form action="product/productList.jsp?servlet=search" method="post">
		      	<input name="target" placeholder="Search your product..."/>
		      	<button name="btn" type="submit">검색</button>
		      </form>
		   </c:when>
	   </c:choose>
    </div>
  </div>

  <div class="page-body">
    <img src="images/main-banner.png" alt="" />
  	<div class="products-container">
  		<h2>Just Dropped</h2>
  		<div class="products-list">
  			<!-- 판매량이 가장많은 상품4개를 보여준다. -->
  			<div class="product">
  				
  			</div>
  		</div>
  	</div>
  </div>
  
 <div class="page-footer">
    <img src="images/banner1.jpg" alt="" />
    <img src="images/banner2.jpg" alt="" />
  </div>
</div>

</body>
</html>