package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.*;
import util.JdbcUtil;

public class InterestDAO {
	public void insertProductDetail(Connection conn, int uId, int pid) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO productDetail (size, price, stock, createdAt, pId) VALUES (?, ?, ?, ?, ?);");
			
			
			/*
			 * java.util.Date date = new java.util.Date(); java.sql.Date sDate = new
			 * java.sql.Date(date.getTime()); pstmt.setDate(4, sDate);
			 */
			
			pstmt.executeUpdate(); 
			
		} catch (SQLException e){
			e.printStackTrace();
		}
	}
}
