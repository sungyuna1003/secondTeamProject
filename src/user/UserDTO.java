package user;

public class UserDTO {
	private String uid;
	private String pwd;
	private String name;
	private String email;
	private String nickname;
	private String gender;
	private String birth;
	private String img;
	private int grade;
	private int rid;
	private String edit_resume;
	private String edit_interview;
	private String company;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getEdit_resume() {
		return edit_resume;
	}
	public void setEdit_resume(String edit_resume) {
		this.edit_resume = edit_resume;
	}
	public String getEdit_interview() {
		return edit_interview;
	}
	public void setEdit_interview(String edit_interview) {
		this.edit_interview = edit_interview;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	
}