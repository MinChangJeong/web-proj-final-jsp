package model;

import java.util.List;

public class Product {
	private int id;
	
	private String productName;
	
	private String productExplain;

	private String productColor;
	
	private byte[] productImage;
	
	private String base64Image;
	
	private List<ProductDetail> productDetail;
	
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

	public List<ProductDetail> getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(List<ProductDetail> productDetail) {
		this.productDetail = productDetail;
	}

	public String getBase64Image() {
		return base64Image;
	}

	public void setBase64Image(String base64Image) {
		this.base64Image = base64Image;
	}

	
}
