package dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import model.Product;
import model.ProductDetail;
import util.JdbcUtil;

public class ProductDAO {
	public int insertProduct(Connection conn, Product product) 
			throws SQLException {
		
		PreparedStatement pstmt=null; 
		int pId = -1;
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO product (productName, productExplain, productColor, productImage) VALUES (?, ?, ?, ?);");
			
			pstmt.setString(1, product.getProductName());
			pstmt.setString(2, product.getProductExplain());
			pstmt.setString(3, product.getProductColor());
			pstmt.setBytes(4, product.getProductImage());
			
			pstmt.executeUpdate();
			
			pId = selectByExplain(conn, product.getProductExplain());
			
		} catch (SQLException e){
			e.printStackTrace();
		}
		
		return pId ;
	}
	
	public Product selectById(Connection conn, int pId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Product product = null; 
		try {
			pstmt = conn.prepareStatement
			("select * from product where product_Id = ?");
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			ProductDetailDAO productDetailDAO = new ProductDetailDAO();
			ProductDetail productDetail = null;
			
			List<ProductDetail> productDetails = new ArrayList<ProductDetail>();
			if (rs.next()){
				product = new Product();
				product.setId(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductExplain(rs.getString(3));
				product.setProductColor(rs.getString(4));
				
				Blob blob = rs.getBlob(5);
				
				InputStream inputStream = blob.getBinaryStream();
	            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				
	            try {
	            	byte[] buffer = new byte[4096];
	                int bytesRead = -1;
	                 
	                while ((bytesRead = inputStream.read(buffer)) != -1) {
	                    outputStream.write(buffer, 0, bytesRead);                  
	                }
	                byte[] imageBytes = outputStream.toByteArray();
	                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
	                
	                product.setBase64Image(base64Image);
	            }
	            catch(IOException ex) {
	            	ex.printStackTrace();
	            }
	            
	            productDetails = productDetailDAO.selectAllById(conn, product.getId());
				product.setProductDetail(productDetails);
			
			}
		} catch (SQLException e){
			e.printStackTrace();
		}
		
		return product;
	}
	
	public int selectByExplain(Connection conn, String productExplain) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Product product = null; 
		
		try {
			pstmt = conn.prepareStatement
			("select product_id from product where productExplain = ?");
			pstmt.setString(1, productExplain);
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				product = new Product();
				product.setId(rs.getInt(1));
			}
			
		} catch (SQLException e){
			e.printStackTrace();
		}
		return product.getId();
	}
	
	public List<Product> selectAllProducts(Connection conn) throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		
		Product product = null;
		
		List<Product> products = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement
					("select * from product");
			rs = pstmt.executeQuery();
			
			ProductDetailDAO productDetailDAO = new ProductDetailDAO();
			ProductDetail productDetail = null;
			
			List<ProductDetail> productDetails = new ArrayList<ProductDetail>();
			while(rs.next()) {
				product = new Product();
				product.setId(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductExplain(rs.getString(3));
				product.setProductColor(rs.getString(4));
				
				/* product.setProductImage(rs.getBytes(5)); */
				Blob blob = rs.getBlob(5);
				
				InputStream inputStream = blob.getBinaryStream();
	            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				
	            try {
	            	byte[] buffer = new byte[4096];
	                int bytesRead = -1;
	                 
	                while ((bytesRead = inputStream.read(buffer)) != -1) {
	                    outputStream.write(buffer, 0, bytesRead);                  
	                }
	                byte[] imageBytes = outputStream.toByteArray();
	                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
	                
	                product.setBase64Image(base64Image);
	            }
	            catch(IOException ex) {
	            	ex.printStackTrace();
	            }
	            
				productDetails = productDetailDAO.selectAllById(conn, product.getId());
				product.setProductDetail(productDetails);
				
				products.add(product);
			}
		}catch (SQLException e){
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return products;
	}
	
	public List<Product> searchAllProducts(Connection conn, String target) throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		
		Product product = null;
		
		List<Product> products = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement
					("select * from product where productName like ? ");
			pstmt.setString(1, "%"+target+"%");
			
			rs = pstmt.executeQuery();
			
			ProductDetailDAO productDetailDAO = new ProductDetailDAO();
			ProductDetail productDetail = null;
			
			List<ProductDetail> productDetails = new ArrayList<ProductDetail>();
			
			while(rs.next()) {
				product = new Product();
				product.setId(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductExplain(rs.getString(3));
				product.setProductColor(rs.getString(4));

				Blob blob = rs.getBlob(5);
				
				InputStream inputStream = blob.getBinaryStream();
	            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				
	            try {
	            	byte[] buffer = new byte[4096];
	                int bytesRead = -1;
	                 
	                while ((bytesRead = inputStream.read(buffer)) != -1) {
	                    outputStream.write(buffer, 0, bytesRead);                  
	                }
	                byte[] imageBytes = outputStream.toByteArray();
	                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
	                
	                product.setBase64Image(base64Image);
	            }
	            catch(IOException ex) {
	            	ex.printStackTrace();
	            }
	            
				productDetails = productDetailDAO.selectAllById(conn, product.getId());
				product.setProductDetail(productDetails);
				
				products.add(product);
			}
		}catch (SQLException e){
			e.printStackTrace();
		}finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return products;
	}
}
