<%@page import="org.apache.tomcat.util.http.fileupload.IOUtils"%>
<%@page import="java.net.http.HttpRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.file.*, java.io.*, java.util.*, java.sql.*, util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="dao.*, model.*"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="main.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>
<!-- product Insert -->
<%
	Connection conn = null;
	String url = "jdbc:mysql://localhost:3306/web?serverTimezone=UTC";
	String id = "root";
	String pwd = "0216"; 
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	String path ="C:\\Users\\jeong\\web-proj-final\\web-shop-app-jsp-master\\proj-shop-app\\src\\main\\webapp\\product\\uploadImages";
	
	MultipartRequest multi = 
			new MultipartRequest(request, path, 5*1024*1024,"euc-kr",new DefaultFileRenamePolicy());
	
	String productName = multi.getParameter("productName");
	String productExplain = multi.getParameter("productExplain");
	String productColor = multi.getParameter("productColor"); 
	String photo = multi.getFilesystemName("photo");
	
	ProductDAO productDAO = new ProductDAO();
	
	Product product = new Product();
	
	product.setProductName(productName);
	product.setProductExplain(productExplain);
	product.setProductColor(productColor);
	
	path += "\\" + photo;
	
	byte[] image = Files.readAllBytes(Paths.get(path));
	product.setProductImage(image);
	
	int pId = productDAO.insertProduct(conn, product);
%>
<!-- productDetail Insert -->
<%
	String []prices = multi.getParameterValues("price");
	String []sizes = multi.getParameterValues("productSizes");
	String []stocks = multi.getParameterValues("stock");
	
	System.out.println(prices.length);
	
	ProductDetailDAO productDetailDAO = new ProductDetailDAO();
	
	System.out.println(pId);
	
	for(int i=0; i<prices.length; i++) {
		ProductDetail productDetail = new ProductDetail();
		
		int price = Integer.parseInt(prices[i]);
		int size = Integer.parseInt(sizes[i]);
		int stock = Integer.parseInt(stocks[i]);
		
		productDetail.setSize(size);
		productDetail.setPrice(price);
		productDetail.setStock(stock);
		
		productDetailDAO.insertProductDetail(conn, productDetail, pId);
	}
	
%>
<div>
<script>
	alert("상품 등록이 완료 되었습니다.");
</script>
<%
response.sendRedirect(".//productList.jsp");
%>

</div>
</body>
</html>