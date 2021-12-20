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
	
	UserDAO userDAO = new UserDAO();
	User user = userDAO.selectInfoByEmail(conn, String.valueOf(session.getAttribute("LOGIN")));

	
/* 	
	User user = userDAO.selectInfoByEmail(conn, String.valueOf(session.getAttribute("LOGIN")));
	
	String username = request.getParameter("username");
	if(request.getParameter("username").length()==0) {
		username=user.getUsername();
	}
	String email = request.getParameter("email");
	if(request.getParameter("email").length()==0) {
		email=user.getEmail();
	}
	String password = request.getParameter("password");
	if(request.getParameter("password").length()==0) {
		password=user.getPassword();
	}
	String phoneNumber = request.getParameter("phoneNumber");
	if(request.getParameter("phoneNumber").length()==0) {
		phoneNumber=user.getPhoneNumber();
	}
	int shoesSize = Integer.parseInt(request.getParameter("shoesSize"));
	if(request.getParameter("shoesSize").length()==0) {
		shoesSize=user.getShoesSize();
	}
	String address = request.getParameter("address");
	if(request.getParameter("address").length()==0) {
		address=user.getAddress();
	} */
	
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String phoneNumber = request.getParameter("phoneNumber");
	int shoesSize = Integer.parseInt(request.getParameter("shoesSize"));
	String address = request.getParameter("address");
	
	int user_id = user.getId();
	
	System.out.println(user_id);
	System.out.println(username);
	System.out.println(email);
	System.out.println(password);
	System.out.println(phoneNumber);
	System.out.println(shoesSize);
	System.out.println(address);
	
	try {
		user = new User();
		user.setUsername(username);
		user.setEmail(email);
		user.setPassword(password);
		user.setPhoneNumber(phoneNumber);
		user.setAddress(address);
		user.setShoesSize(shoesSize);
		
		userDAO.updateUser(conn, user, user_id);
		%>
			<script type="text/javascript">
				alert("회원정보가 수정되었습니다.");
				window.location.href = 'http://localhost:8080/proj-shop-app/user/userPurchaseInfo.jsp';
			</script>
		<%
	}catch (SQLException e){} 

%>
</body>
</html>