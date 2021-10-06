package bookmall.test;

import java.util.List;

import bookmall.dao.OrderDao;
import bookmall.vo.OrderVo;

public class OrderDaoTest {

	public static void main(String[] args) {
		insertTest();
		findAllTest();

	}

	public static void findAllTest() {
		List<OrderVo> list = new OrderDao().findAll();
		for (OrderVo vo : list) {
			System.out.println(vo);
		}
	}

	public static void insertTest() {
		OrderVo vo = new OrderVo();
		vo.setPrice(10000);
		vo.setAddress("서울특별시");
		vo.setMemberNo(1);
		new OrderDao().insert(vo);
		vo.setPrice(20000);
		vo.setAddress("광주광역시");
		vo.setMemberNo(2);
		new OrderDao().insert(vo);
	}

}