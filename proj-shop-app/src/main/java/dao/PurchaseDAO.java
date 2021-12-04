package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import model.ProductDetail;
import model.Purchase;

public class PurchaseDAO {
	public void insertPurchase(Connection conn, int uId, int pdId, Purchase purchase) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement("INSERT INTO purchase (totalPurchasePrice, paymentMethod, createdAt, pId, uId) VALUES (?, ?, ?,? ,?);");
			
			pstmt.setInt(1, purchase.getTotalPurchasePrice());
			pstmt.setString(2, purchase.getPaymentMethod());
			
			java.util.Date date = new java.util.Date(); java.sql.Date sDate = new
			java.sql.Date(date.getTime()); 
			pstmt.setDate(3, sDate);
			
			pstmt.setInt(4, pdId);
			pstmt.setInt(5, uId);
		
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public List<Purchase> selectAllPurchaseByIds(Connection conn, int uId) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<Purchase> purchases = new ArrayList<>();
		Purchase purchase = null;
		try {
			pstmt = conn.prepareStatement("select * from purchase wher uId = ?");
			pstmt.setInt(1, uId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				purchase.setId(rs.getInt("purchase_id"));
				purchase.setTotalPurchasePrice(rs.getInt("totalPurchasePrice"));
				purchase.setPaymentMethod(rs.getString("paymentMethod"));
				
				int pdId = rs.getInt("pId");
				
				ProductDetailDAO productDetailDAO = new ProductDetailDAO();
				
				ProductDetail productDetail = new ProductDetail();
				
				productDetail = productDetailDAO.selectById(conn, pdId);
				
				ProductDAO productDAO = new ProductDAO();
				
				Product product = new Product();
				
				product = productDAO.selectById(conn, productDetail.getProduct_id());
				
				productDetail.setProduct(product);
				
				purchase.setProductDetail(productDetail);
				
				purchases.add(purchase);
			}
		}
		catch(SQLException ex) {
			ex.printStackTrace();
	    }
		return purchases;
	}
	
}
