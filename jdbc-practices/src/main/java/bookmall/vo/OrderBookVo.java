package bookmall.vo;

public class OrderBookVo {
	private int bookNo;
	private String bookTitle;
	private int bookPrice;

	private int quantity;
	private long orderNo;

	public OrderBookVo() {
	}

	public OrderBookVo(int bookNo, String bookTitle, int bookPrice, int quantity, long orderNo) {
		super();
		this.bookNo = bookNo;
		this.bookTitle = bookTitle;
		this.bookPrice = bookPrice;
		this.quantity = quantity;
		this.orderNo = orderNo;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	public String getBookTitle() {
		return bookTitle;
	}

	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}

	public int getBookPrice() {
		return bookPrice;
	}

	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public long getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	@Override
	public String toString() {
		return String.format("주문 도서 리스트 [책 번호=%s, 책 제목=%s, 가격=%s, 수량 =%s, 주문번호=%s]", bookNo,
				bookTitle, bookPrice, quantity, orderNo);
	}

}
