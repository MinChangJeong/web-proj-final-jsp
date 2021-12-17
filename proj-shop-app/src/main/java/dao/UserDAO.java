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
		}
	}
	
	public void insertAdmin(Connection conn, User user) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("INSERT INTO user (username, email, password, phoneNumber, address, shoesSize, isAdmin, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?);");
			pstmt.setString(1, "ADMIN");
			pstmt.setString(2, "ADMIN");
			pstmt.setString(3, "ADMIN");
			pstmt.setString(4, "관리자 전화번호 없음");
			pstmt.setString(5, "관리자 주소 없음");
			pstmt.setInt(6, -1);
			pstmt.setBoolean(7, true);
			
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
	
	public User selectInfoByEmail(Connection conn, String email) 
			throws SQLException{
		PreparedStatement pstmt=null; 
	    ResultSet rs = null;
	    User user = null; 
	    
	    try {
	         pstmt = conn.prepareStatement
	         ("select * from user where email = ?");
	         pstmt.setString(1, email);
	         rs = pstmt.executeQuery();
	         
	         if (rs.next()){
	            user = new User();
	            user.setId(rs.getInt("user_id"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setAddress(rs.getString("address"));
	            user.setPhoneNumber(rs.getString("phoneNumber"));
	            user.setShoesSize(rs.getInt("shoesSize"));    
	         }
	      } catch (SQLException e){
	         e.printStackTrace();
	      }
	      return user;
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
