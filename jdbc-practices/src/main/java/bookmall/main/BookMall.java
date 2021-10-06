package bookmall.main;

import bookmall.test.BookDaoTest;
import bookmall.test.CartDaoTest;
import bookmall.test.CategoryDaoTest;
import bookmall.test.MemberDaoTest;
import bookmall.test.OrderBookDaoTest;
import bookmall.test.OrderDaoTest;

public class BookMall {
	public static void main(String[] args) {
		CategoryDaoTest.insertTest();
		CategoryDaoTest.findAllTest();
		System.out.println("===========================================================");
		BookDaoTest.insertTest();
		BookDaoTest.findAllTest();

		System.out.println("===========================================================");
		MemberDaoTest.insertTest();
		MemberDaoTest.findAllTest();

		System.out.println("===========================================================");
		CartDaoTest.insertTest();
		CartDaoTest.findAllTest();

		System.out.println("===========================================================");
		OrderDaoTest.insertTest();
		OrderDaoTest.findAllTest();

		System.out.println("===========================================================");
		OrderBookDaoTest.insertTest();
		OrderBookDaoTest.findAllTest();
	}
}
