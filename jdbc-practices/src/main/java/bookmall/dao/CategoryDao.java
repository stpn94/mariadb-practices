package bookmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;
import driver.JdbcConn;

public class CategoryDao {
	
	public int insert(CategoryVo vo) {
		String sql = "insert into category values(null, ?)";
		try(Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
//			pstmt.setInt(1, vo.getNo());
			pstmt.setString(1, vo.getName());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<CategoryVo> findAll() {
		String sql = "select no, name from category";
		try(Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()){
			if (rs.next()) {
				List<CategoryVo> list = new ArrayList<>();
				do {
					list.add(getCategorys(rs));
				}while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private CategoryVo getCategorys(ResultSet rs) throws SQLException {
		int no = rs.getInt("no");
		String name = rs.getString("name");
		return new CategoryVo(no, name);
	}
}
