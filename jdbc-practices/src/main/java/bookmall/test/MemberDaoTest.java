package bookmall.test;

import java.util.List;

import bookmall.dao.MemberDao;
import bookmall.vo.MemberVo;

public class MemberDaoTest {

	public static void main(String[] args) {

//		updateTest("성공",1L);
//		insertTest("테스트","email","number","password");
//		deletTest(4L);

		insertTest();
		findAllTest();

	}

	public static void findAllTest() {
		List<MemberVo> list = new MemberDao().findAll();
		for (MemberVo vo : list) {
			System.out.println(vo);
		}
	}

	public static void insertTest() {
		MemberVo vo = null;
		vo = new MemberVo();
		vo.setName("아이유");
		vo.setPhone("010-1100-1100");
		vo.setEmail("iuiu@iuiu.iuiu");
		vo.setPassword("1234");
		new MemberDao().insert(vo);
		
		vo = new MemberVo();
		vo.setName("수지요");
		vo.setPhone("010-0011-0011");
		vo.setEmail("sugee@sugee.sugee");
		vo.setPassword("1234");
		new MemberDao().insert(vo);
	}

}