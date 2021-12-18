package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.jdbc.JdbcConnection;

import model.*;
import util.JdbcUtil;

public class InterestDAO {
	public void insertInterest(Connection conn, int uId, int pdId) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement("INSERT INTO interest (createdAt, pId, uId) VALUES (?, ?, ?);");
			
			java.util.Date date = new java.util.Date(); java.sql.Date sDate = new
			java.sql.Date(date.getTime()); 
			pstmt.setDate(1, sDate);
			
			pstmt.setInt(2, pdId);
			pstmt.setInt(3, uId);
			
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Interest> selectAllInterestByIds(Connection conn, int uId) 
	         throws SQLException {
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      
	      List<Interest> interests = new ArrayList<>();
	      Interest interest = null;
	      try {
	         pstmt = conn.prepareStatement("select * from interest where uId = ?");
	         pstmt.setInt(1, uId);
	         
	         rs = pstmt.executeQuery();
	        
	         
	         ProductDetailDAO productDetailDAO = new ProductDetailDAO();
	         ProductDetail productDetail = null;
	         ProductDAO productDAO = new ProductDAO();
	         Product product = null;
	         
	         while(rs.next()) { 
	        	interest = new Interest();
	        	interest.setId(rs.getInt("interest_id"));
	            interest.setCreatedAt(rs.getTimestamp("createdAt"));
	          
	            productDetail = new ProductDetail();
	            int pdId = rs.getInt("pId");
	            
	            productDetail = productDetailDAO.selectById(conn, pdId);
	            interest.setProductDetail(productDetail);
	            
	            product = new Product();
	            product = productDAO.selectById(conn, productDetail.getProduct_id());
	            productDetail.setProduct(product);
	            
	            interests.add(interest);
	         }
	         
	      }
	      catch(SQLException ex) {
	         ex.printStackTrace();
	       }
	      return interests;
	   }
	
	public void deleteInterest(Connection conn, int interest_id)  
			throws SQLException {
	    PreparedStatement pstmt=null; 		
  		try {
  			pstmt = conn.prepareStatement
  			("delete from interest where interest_id = ?");
  			pstmt.setInt(1, interest_id);
  			pstmt.executeUpdate();			
  		} catch (SQLException e){
  			e.printStackTrace();
  		} finally {
  			JdbcUtil.close(conn);
  			JdbcUtil.close(pstmt);
  		}     
	}
	
}
