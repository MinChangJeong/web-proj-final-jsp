package util;

import java.sql.*;

public class ConnectionProvider {

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
	}
}
