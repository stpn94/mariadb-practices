package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectTest01 {

	public static void main(String[] args) {

		Connection conn = null;
		java.sql.Statement stmt =null;
		ResultSet rs = null;
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			// 2. 연결하기
			String url = "jdbc:mysql://127.0.0.1:3306/employees";
			conn = DriverManager.getConnection(url, "hr", "hr");
			
			// 3. Statement
			stmt = conn.createStatement();
			
			// 4 .sql문을 실행
			String sql ="SELECT emp_no , date_format(birth_date, '%Y-%m-%d') , first_name FROM employees WHERE first_name like 'pat%'";
			rs = stmt.executeQuery(sql);
						
			// 5. 결과 가져오기
			while(rs.next()) {
				Long empNo = rs.getLong(1);
				String birthDate = rs.getString(2);
				String fristName = rs.getString(3);
				System.out.println("" + empNo + " : " + birthDate + " : " + fristName + "");
			}
							
			System.out.println("ok:" +conn);
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		} catch (SQLException e) {
			System.out.println("error::" + e);
		} finally {
			try {
				// 자원정리(clean-up)
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// 2.
	}

}