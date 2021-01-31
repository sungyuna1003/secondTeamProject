package Community;

public class CommunityBean {
	private int cid;
	private String uid_seeker;
	private String c_title;
	private String c_content;
	private String date;
	private int available;
	private int hit;
	private String tab;
	private String files;
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getTab() {
		return tab;
	}
	public void setTab(String tab) {
		this.tab = tab;
	}
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	public String getDate() {
		return date;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getUid_seeker() {
		return uid_seeker;
	}
	public void setUid_seeker(String uid_seeker) {
		this.uid_seeker = uid_seeker;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}

}
