package model;

import java.util.List;

public class Page {
	private int currentPageNumber;
	private List<Product> products;
	private int pageTotalCount;
	
	public Page() {}

	public Page(int currentPageNumber, List<Product> products, int pageTotalCount) {
		super();
		this.currentPageNumber = currentPageNumber;
		this.products = products;
		this.pageTotalCount = pageTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public void setCurrentPageNumber(int currentPageNumber) {
		this.currentPageNumber = currentPageNumber;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public void setPageTotalCount(int pageTotalCount) {
		this.pageTotalCount = pageTotalCount;
	}
	
	
}	
