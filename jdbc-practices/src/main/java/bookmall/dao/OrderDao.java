package bookmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderVo;
import driver.JdbcConn;

public class OrderDao {
	public List<OrderVo> findAll() {
		String sql = "select cast(o.order_no as int) as orderNo ,m.name as name, price, address from `order` o,member m where o.member_no=m.no;";
		try(Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()){
			if (rs.next()) {
				List<OrderVo> list = new ArrayList<>();
				do {
					list.add(getOrders(rs));
				}while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	private OrderVo getOrders(ResultSet rs) throws SQLException {
		long orderNo = rs.getLong("orderNo");
		String name = rs.getString("name");
		int price = rs.getInt("price");
		String address = rs.getString("address");
		return new OrderVo(orderNo,name,price,address);
	}

	public int insert(OrderVo vo) {
		String sql = "insert into `order`(no,price,address,member_no) values (null,?,?,?)";
		try(Connection con = JdbcConn.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, vo.getPrice());
			pstmt.setString(2, vo.getAddress());
			pstmt.setInt(3, vo.getMemberNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

}
