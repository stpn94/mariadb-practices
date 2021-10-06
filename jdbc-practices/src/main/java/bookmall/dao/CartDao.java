package bookmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import driver.JdbcConn;

public class CartDao {
	public int insert(CartVo vo) {
		String sql = "insert into cart values(? ,? ,?)";
		try(Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, vo.getBookNo());
			pstmt.setInt(2, vo.getMemberNo());
			pstmt.setInt(3, vo.getQuantity());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}


	public List<CartVo> findAll(){
		String sql = "select m.name as name, b.title as title, quantity, b.price*quantity as price "
				+ " from cart c , book b, member m where b.no=c.book_no and m.no = c.member_no";
		try (Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				List<CartVo> list = new ArrayList<>();
				do {
					list.add(getCarts(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}


	private CartVo getCarts(ResultSet rs) throws SQLException {
		String name = rs.getString("name");
		String title = rs.getString("title");
		int quantity = rs.getInt("quantity");
		int price = rs.getInt("price");
		return new CartVo(quantity, name, title, price);
	};
}
