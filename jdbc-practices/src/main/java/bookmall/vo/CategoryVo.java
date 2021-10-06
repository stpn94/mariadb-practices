package bookmall.vo;

public class CategoryVo {
	private int no;
	private String name;

	public CategoryVo(int no, String name) {
		super();
		this.no = no;
		this.name = name;
	}

	public CategoryVo() {
		// TODO Auto-generated constructor stub
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "카테고리 리스트 [카테고리번호=" + no + ", 카테고리이름=" + name + "]";
	}

}
