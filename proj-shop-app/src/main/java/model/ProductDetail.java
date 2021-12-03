package model;

import java.util.*;

public class ProductDetail {
	private int id;
	
	private int size;
	
	private int price;
	
	private int stock;
	
	private Date createdAt;
	
	private Product product;
	
	private int product_id;
	
	public ProductDetail() {}

	public ProductDetail( int size, int price, int stock, Date createdAt) {
		super();
		this.size = size;
		this.price = price;
		this.stock = stock;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
}
