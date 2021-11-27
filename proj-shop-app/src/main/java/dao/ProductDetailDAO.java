package dao;

import java.sql.*;
import java.util.Date;

import model.*;
import util.*;

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
}
