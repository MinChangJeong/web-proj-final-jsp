package dao;

import java.sql.*;
import java.util.Date;

import model.*;
import util.*;

public class UserDAO {
	public void insertUser(Connection conn, User user) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO user (username, email, password, phoneNumber, address, shoesSize, isAdmin, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?);");
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getPhoneNumber());
			pstmt.setString(5, user.getAddress());
			pstmt.setInt(6, user.getShoesSize());
			pstmt.setBoolean(7, false);
			
			java.util.Date date = new java.util.Date();
			java.sql.Date sDate = new java.sql.Date(date.getTime());
			pstmt.setDate(8, sDate);
			
			pstmt.executeUpdate();		
			
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}

}
