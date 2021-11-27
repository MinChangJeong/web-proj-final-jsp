package model;

public class Product {
	private int id;
	
	private String productName;
	
	private String productExplain;

	private String productColor;
	
	private byte[] productImage;
	
	public Product() {}

	public Product(String productName, String productExplain, String productColor) {
		super();
		this.productName = productName;
		this.productExplain = productExplain;
		this.productColor = productColor;
	}

	public Product(String productName, String productExplain, String productColor, byte[] productImage) {
		super();
		this.productName = productName;
		this.productExplain = productExplain;
		this.productColor = productColor;
		this.productImage = productImage;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductExplain() {
		return productExplain;
	}

	public void setProductExplain(String productExplain) {
		this.productExplain = productExplain;
	}

	public String getProductColor() {
		return productColor;
	}

	public void setProductColor(String productColor) {
		this.productColor = productColor;
	}

	public byte[] getProductImage() {
		return productImage;
	}

	public void setProductImage(byte[] productImage) {
		this.productImage = productImage;
	}
	

}
