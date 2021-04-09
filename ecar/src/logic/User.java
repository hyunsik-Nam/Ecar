package logic;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class User {
	@NotEmpty(message = "사용자 이름은 필수 입니다.")
	private String name;
	@Size(min=3, max=10, message="아이디는 3자 이상 10자 이하로 입력하세요")
	private String id;
	@Size(min=3, max=10, message="비밀번호는 3자 이상 10자 이하로 입력하세요")
	private String pw;
	@NotEmpty(message="email을 입력하세요")
	@Email(message="email 형식으로 입력하세요")
	private String email;
	private int loc;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getLoc() {
		return loc;
	}

	public void setLoc(int loc) {
		this.loc = loc;
	}

	@Override
	public String toString() {
		return "User [name=" + name + ", id=" + id + ", pw=" + pw + ", email=" + email + ", loc=" + loc + "]";
	}

}