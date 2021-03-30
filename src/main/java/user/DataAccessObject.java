package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DataAccessObject {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public DataAccessObject() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/MyBoard";
			String dbUser = "admin";
			String dbPassword = "admin!234";
			Class.forName("com.mysql.jdbc.driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // print Exception
		}
	}
	
	public int login(String id, String password) {
		// return ���� 0���� Ŭ ������ success
		//  1: ���� �α��� ����
		//  0: ��й�ȣ ����
		// -1: �ش� ���̵� ����
		// -2: �����ͺ��̽� ����
		
		String SQL = "SELECT password from user WHERE id = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return (rs.getString(1).equals(password)) ? 1 : 0;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
}
