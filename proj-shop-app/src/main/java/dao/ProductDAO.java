package dao;

import java.sql.*;

import model.*;
import util.*;

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
			
			pId = selectByName(conn, product.getProductName());
			
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
			
			if (rs.next()){
				product = new Product();
				product.setProductName(rs.getString(1));
				product.setProductExplain(rs.getString(2));
				product.setProductColor(rs.getString(3));
			}
			
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return product;
	}
	
	public int selectByName(Connection conn, String productName) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Product product = null; 
		try {
			pstmt = conn.prepareStatement
			("select product_id from product where productName = ?");
			pstmt.setString(1, productName);
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
}
