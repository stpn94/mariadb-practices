package bookmall.vo;

public class OrderVo {

	private int no;
	private long orderNo;
	private int price;
	private String address;

	private int memberNo;
	private String memberName;

	public OrderVo() {
	}

	public OrderVo(long orderNo, String memberName, int price, String address) {
		super();
		this.orderNo = orderNo;
		this.price = price;
		this.address = address;
		this.memberName = memberName;
	}

	public OrderVo(int no, long orderNo, int price, String address, int memberNo, String memberName) {
		super();
		this.no = no;
		this.orderNo = orderNo;
		this.price = price;
		this.address = address;
		this.memberNo = memberNo;
		this.memberName = memberName;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public long getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(long orderNo) {
		this.orderNo = orderNo;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	@Override
	public String toString() {
		return String.format("주문 리스트    [주문번호=%s, 주문자=%s, 총 금액=%s, 주소=%s ]", orderNo, memberName, price, address);
	}

}