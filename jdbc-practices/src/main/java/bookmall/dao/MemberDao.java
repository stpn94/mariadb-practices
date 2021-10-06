package bookmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.MemberVo;
import driver.JdbcConn;

public class MemberDao {

	public List<MemberVo> findAll() {
		String sql = "select no, name, phone, email, password from member;";
		try (Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				List<MemberVo> list = new ArrayList<>();
				do {
					list.add(getMembers(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private MemberVo getMembers(ResultSet rs) throws SQLException {
		int no = rs.getInt("no");
		String name = rs.getString("name");
		String phone = rs.getString("phone");
		String email = rs.getString("email");
		String password = rs.getString("password");
		return new MemberVo(no, name, phone, email, password);
	}

	public int insert(MemberVo vo) {
		String sql = "insert into member values(null, ?,?,?,password(?))";
		try (Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
//			pstmt.setInt(1, vo.getNo());
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPhone());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getPassword());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

//	public int delete(int no) {
//		String sql = "delete from member where no = ?";
//		try(Connection con = JdbcConn.getConnection();
//				PreparedStatement pstmt = con.prepareStatement(sql)){
//			pstmt.setInt(1, no);
//			return pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return 0;
//	}
//
//	public int update(MemberVo vo) {
//		String sql = "update member set name = ?, phone = ?,email = ? where no = ?";
//		try(Connection con = JdbcConn.getConnection();
//				PreparedStatement pstmt = con.prepareStatement(sql)){
//			pstmt.setString(1, vo.getName());
//			pstmt.setString(2, vo.getPhone());
//			pstmt.setString(3, vo.getEmail());
//			pstmt.setInt(3, vo.getNo());
//			return pstmt.executeUpdate();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return 0;
//	}
}