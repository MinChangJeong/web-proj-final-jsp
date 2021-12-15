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

public class ProductDetailDAO {
	public void insertProductDetail(Connection conn, ProductDetail productDetail, int pid) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO productDetail (size, price, stock, createdAt, pId) VALUES (?, ?, ?, ?, ?);");
			
			pstmt.setInt(1, productDetail.getSize());
			pstmt.setInt(2, productDetail.getPrice());
			pstmt.setInt(3, productDetail.getStock());

			java.util.Date date = new java.util.Date();
			java.sql.Date sDate = new java.sql.Date(date.getTime());
			pstmt.setDate(4, sDate);
			
			pstmt.setInt(5, pid);
			pstmt.executeUpdate(); 
			
		} catch (SQLException e){
			e.printStackTrace();
		}
	}
	
	public int getProductId(Connection conn, int pdId) {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		
		int product_id = -1;
		
		try {			
			pstmt = conn.prepareStatement
			("select pId from productDetail where productDetail_id = ?");
			pstmt.setInt(1, pdId);
			rs = pstmt.executeQuery();
			
			if(rs.next() ) {
				product_id = rs.getInt("pId");
			}
			
		} catch (SQLException e){
			e.printStackTrace();
		}
		return product_id;
	}
	
	public ProductDetail selectById(Connection conn, int pdId) {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		
		ProductDetail productDetail = new ProductDetail();
		
		try {			
			pstmt = conn.prepareStatement
			("select * from productDetail where productDetail_id = ?");
			pstmt.setInt(1, pdId);
			rs = pstmt.executeQuery();
			
			if(rs.next() ) {
				productDetail.setId(rs.getInt("productDetail_id"));
				productDetail.setSize(rs.getInt("size"));
				productDetail.setPrice(rs.getInt("price"));
				productDetail.setStock(rs.getInt("stock"));
				productDetail.setProduct_id(rs.getInt("pId"));
				productDetail.setCreatedAt(rs.getTimestamp("createdAt"));
			}
			
		} catch (SQLException e){
			e.printStackTrace();
		}
		return productDetail;
	}
	
	public List<ProductDetail> selectAllById(Connection conn, int pId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		
		ProductDetail productDetail = null; 
		
		List<ProductDetail> productDetails = new ArrayList<ProductDetail>();
		try {
			pstmt = conn.prepareStatement
					("select * from productDetail where pId = ?");
			pstmt.setInt(1, pId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {				
				productDetail = new ProductDetail();
				productDetail.setId(rs.getInt("productDetail_id"));
				productDetail.setSize(rs.getInt("size"));
				productDetail.setPrice(rs.getInt("price"));
				productDetail.setStock(rs.getInt("stock"));
				productDetail.setProduct_id(rs.getInt("pId"));
				productDetail.setCreatedAt(rs.getTimestamp("createdAt")); 
				
				productDetails.add(productDetail);
			}
			
		} catch (SQLException e){
			e.printStackTrace();
		}
		return productDetails;
	}
}
