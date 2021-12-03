package model;

import java.util.*;

public class Purchase {
	private int id;
	
	private Date createdAt;

	private int totalPurchasePrice;

	private String paymentMethod;
	
	private ProductDetail productDetail;
	
	public Purchase(Date createdAt, int totalPurchasePrice, String paymentMethod) {
		super();
		this.createdAt = createdAt;
		this.totalPurchasePrice = totalPurchasePrice;
		this.paymentMethod = paymentMethod;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public int getTotalPurchasePrice() {
		return totalPurchasePrice;
	}

	public void setTotalPurchasePrice(int totalPurchasePrice) {
		this.totalPurchasePrice = totalPurchasePrice;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public ProductDetail getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(ProductDetail productDetail) {
		this.productDetail = productDetail;
	}

}
