package bookmall.vo;

public class CartVo {
	private int bookNo;          //책 번호
	private int memberNo;        //멤버 번호
	private int quantity;        //총 수량
	
	private String memberName;   //멤버 이름
	private String bookTitle;    //책 이름
	private int price;			 //총 가격
	
	public CartVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CartVo(int quantity, String memberName, String bookTitle, int price) {
		super();
		this.quantity = quantity;
		this.memberName = memberName;
		this.bookTitle = bookTitle;
		this.price = price;
	}


	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return String.format("카트 리스트    [주문자=%s, 책 제목=%s, 가격=%s, 수량=%s]", memberName,
				bookTitle, price, quantity);
	}
	
	
	
}
