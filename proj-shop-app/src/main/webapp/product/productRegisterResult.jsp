<%@page import="org.apache.tomcat.util.http.fileupload.IOUtils"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ page import="java.nio.file.*, java.io.*, java.util.*, java.sql.*, util.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="dao.*, model.*"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%  request.setCharacterEncoding("euc-kr"); %>

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
			new MultipartRequest(request, path, 5*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
	
	String productName = multi.getParameter("productName");
	String productExplain = multi.getParameter("productExplain");
	String productColor = multi.getParameter("productColor"); 
	String photo = multi.getFilesystemName("photo");
	
	System.out.println(productExplain);
	
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
안녕하세요 

</div>
</body>
</html>