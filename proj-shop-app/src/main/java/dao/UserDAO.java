package dao;

import java.sql.*;
import java.util.Date;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar;

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
	
	public User selectByEmail(Connection conn, String email) 
	         throws SQLException {
	      PreparedStatement pstmt=null; 
	      ResultSet rs = null;
	      User user = null; 
	      
	      try {
	         pstmt = conn.prepareStatement
	         ("select email, password from user where email = ?");
	         pstmt.setString(1, email);
	         rs = pstmt.executeQuery();
	         
	         if (rs.next()){
	            user = new User();
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	         }
	      } catch (SQLException e){
	         e.printStackTrace();
	      }
	      return user;
	   }
	
	public boolean checkEmail(Connection conn, String email) throws SQLException {
		User user = selectByEmail(conn, email);
		
		System.out.println(email);
		System.out.println("user : "+ user);
		
		if(user!=null) {
			return true;
		}
		else {
			return false;
		}
		
	}
	
	public boolean checkPassword(Connection conn, String email, String password) throws SQLException {
	      
		User user = selectByEmail(conn, email);
      
		if (user.getPassword().equals(password)) {
			return true;
		} else {
			return false;
		}
	}
	
	
	
}
