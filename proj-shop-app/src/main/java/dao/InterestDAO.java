package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.*;

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
}
