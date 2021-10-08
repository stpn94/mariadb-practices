package bookmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;
import driver.JdbcConn;

public class OrderBookDao {
	public int insert(OrderBookVo vo) {
		String sql = "insert into order_book values(? ,? ,?)";
		try (Connection con = JdbcConn.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, vo.getBookNo());
			pstmt.setInt(3, vo.getQuantity());
			pstmt.setLong(2, vo.getOrderNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public List<OrderBookVo> findAll() {
		String sql = "select b.no as no, b.title as title, b.price*quantity as price, ob.quantity as quantity, cast(o.order_no as int) as orderNo "
				+ " from book b, `order` o, order_book ob "
				+ " where ob.book_no = b.no and ob.order_no = o.no";
		try (Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				List<OrderBookVo> list = new ArrayList<>();
				do {
					list.add(getOrderBooks(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private OrderBookVo getOrderBooks(ResultSet rs) throws SQLException {
		int no = rs.getInt("no");
		String name = rs.getString("title");
		int price = rs.getInt("price");
		int quantity = rs.getInt("quantity");
		long orderNo = rs.getLong("orderNo");
		return new OrderBookVo(no,name,price,quantity,orderNo);
	}

}
