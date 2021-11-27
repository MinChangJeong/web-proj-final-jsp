package model;

import java.util.*;

public class User {
	private int id;
	
	private String username;
	
	private String email;

	private String password;
	
	private String phoneNumber;
	
	private String address;

	private int shoesSize;
	
	private Date createdAt;
	
	private boolean isAdmin;

	public User() {}

	public User(int id, String username, String email, String password, String phoneNumber, String address, int shoesSize, Date createdAt) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.shoesSize = shoesSize;
		this.createdAt = createdAt;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getShoesSize() {
		return shoesSize;
	}

	public void setShoesSize(int shoesSize) {
		this.shoesSize = shoesSize;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
		
	
	
	
}
