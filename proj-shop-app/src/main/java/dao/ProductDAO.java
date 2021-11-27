package dao;

import java.sql.*;

import model.*;
import util.*;

public class ProductDAO {
	public Product insertProduct(Connection conn, Product product) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO product (productName, productExplain, productColor, productImage) VALUES (?, ?, ?, ?);");
			
			pstmt.setString(1, product.getProductName());
			pstmt.setString(2, product.getProductExplain());
			pstmt.setString(3, product.getProductColor());
			pstmt.setBytes(4, product.getProductImage());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		return product;
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
}
