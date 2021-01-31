package apiIntern;

public class ApiDataBean {
	private String companyNm;
	private String collectJobsNm;
	private String regionNm;
	private String minEdubg;
	private String collectPsncnt;
	private String total;
	private String DetailUrl;
	public String getDetailUrl() {
		return DetailUrl;
	}
	public void setDetailUrl(String detailUrl) {
		DetailUrl = detailUrl;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getCompanyNm() {
		return companyNm;
	}
	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}
	public String getCollectJobsNm() {
		return collectJobsNm;
	}
	public void setCollectJobsNm(String collectJobsNm) {
		this.collectJobsNm = collectJobsNm;
	}
	public String getRegionNm() {
		return regionNm;
	}
	public void setRegionNm(String regionNm) {
		this.regionNm = regionNm;
	}
	public String getMinEdubg() {
		return minEdubg;
	}
	public void setMinEdubg(String minEdubg) {
		this.minEdubg = minEdubg;
	}
	public String getCollectPsncnt() {
		return collectPsncnt;
	}
	public void setCollectPsncnt(String collectPsncnt) {
		this.collectPsncnt = collectPsncnt;
	}
}
