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
			String dbURL = "jdbc:mysql://localhost:3306/MyBoard?characterEncoding=UTF-8&serverTimezone=UT";
			String dbUser = "admin";
			String dbPassword = "admin!234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // print Exception
		}
	}
	
	public int login(String id, String password) {
		// return 값이 0보다 클 때에만 success
		//  1: 정상 로그인 성공
		//  0: 비밀번호 오류
		// -1: 해당 아이디 없음
		// -2: 데이터베이스 오류
		
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
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
