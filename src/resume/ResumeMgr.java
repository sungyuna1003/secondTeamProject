package resume;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import apiIntern.UtilMgr;
import bean.ResumeBean;
import bean.Resume_awardBean;
import bean.Resume_careerBean;
import bean.Resume_certificateBean;
import bean.Resume_eduBean;
import bean.UserBean;

public class ResumeMgr {

	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/job/WebContent/imges/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10 * 1024 * 1024;// 10MB

	public ResumeMgr() {

		pool = DBConnectionMgr.getInstance();

	}

	public void insertResumeall(HttpServletRequest req) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql1 = null;
		String sql2 = null;
		String sql3 = null;
		String sql4 = null;
		String sql5 = null;
		String sql6 = null;
		String sql7 = null;

		String uid = null;
		String name = null;
		String gender = null;
		String birth = null;
		String email = null;
		String img = null;
		String addressA = null;
		String addressB = null;
		String addressC = null;
		String e_name = null;
		String telnum = null;
		String selfintroduce = null;
		int rid = 0;
		MultipartRequest multi = null;
		///// ���Ͼ��ε�//////////////////////////
		try{File dir = new File(SAVEFOLDER);
		if (!dir.exists())// ������ ���ٸ�
					dir.mkdirs();
				// mkdir : ���������� ������ �����Ұ�
				// mkdirs : ���������� ��� ��������
				multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
						new DefaultFileRenamePolicy());
				if (multi.getFilesystemName("img") != null) {
					// �Խù��� ���� ���ε�
					img = multi.getFilesystemName("img");
				}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
	
			
		
			
			con = pool.getConnection();

			// �߰����� �Ķ����
			addressA = multi.getParameter("addressA");
			addressB = multi.getParameter("addressB");
			addressC = multi.getParameter("addressC");
			e_name = multi.getParameter("e_name");
			telnum = multi.getParameter("telnum");
			selfintroduce = multi.getParameter("selfintroduce");
			uid = multi.getParameter("uid");
			
			// �̷¼� �߰�
			sql2 = "insert resume(uid,addressA,addressB,addressC,e_name,telnum,selfintroduce)" + "values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, uid);
			pstmt.setString(2, addressA);
			pstmt.setString(3, addressB);
			pstmt.setString(4, addressC);
			pstmt.setString(5, e_name);
			pstmt.setString(6, telnum);
			pstmt.setString(7, selfintroduce);
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}
		
		try {
			// rid ��������
				sql3 = "select rid from resume where telnum=?";
				pstmt = con.prepareStatement(sql3);
				pstmt.setString(1, telnum);
				rs = pstmt.executeQuery();
				if (rs.next()) {
				rid = rs.getInt(1);
						}
			
		}  catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}
		
		
		try {
		
			// �⺻���� �Ķ����
			uid = multi.getParameter("uid");
			name = multi.getParameter("name");
			gender = multi.getParameter("gender");
			birth = multi.getParameter("birth");
			email = multi.getParameter("email");
			
			// �⺻���� ������Ʈ
			sql1 = "update user set name = ?, gender=?, birth=?, email=?, img=?, rid=?" + " where uid=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, name);
			pstmt.setString(2, gender);
			pstmt.setString(3, birth);
			pstmt.setString(4, email);
			pstmt.setString(5, img);
			pstmt.setInt(6, rid);
			pstmt.setString(7, uid);
			pstmt.executeUpdate();
			
		}  catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}
		try {

			// �ڰ��� �Է�
			if (multi.getParameterValues("certi_name") == null) {// �ܼ��� ��
				String certi_name = multi.getParameter("certi_name");
				String agency = multi.getParameter("agency");
				String certi_date = multi.getParameter("certi_date");
				String certi_grade = multi.getParameter("certi_grade");
				sql4 = "insert resume_certificate(rid,certi_name,certi_date,agency,certi_grade)" + "values(?,?,?,?,?)";
				pstmt = con.prepareStatement(sql4);
				pstmt.setInt(1, rid);
				pstmt.setString(2, certi_name);
				pstmt.setString(3, certi_date);
				pstmt.setString(4, agency);
				pstmt.setString(5, certi_grade);
				pstmt.executeUpdate();

			} else {// �����϶�
				String[] certi_name = multi.getParameterValues("certi_name");
				String[] agency = multi.getParameterValues("agency");
				String[] certi_date = multi.getParameterValues("certi_date");
				String[] certi_grade = multi.getParameterValues("certi_grade");
				for (int i = 0; i < certi_name.length; i++) {
					sql4 = "insert resume_certificate(rid,certi_name,certi_date,agency,certi_grade)"
							+ "values(?,?,?,?,?)";
					pstmt = con.prepareStatement(sql4);
					pstmt.setInt(1, rid);
					pstmt.setString(2, certi_name[i]);
					pstmt.setString(3, certi_date[i]);
					pstmt.setString(4, agency[i]);
					pstmt.setString(5, certi_grade[i]);
					pstmt.executeUpdate();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}
		
		try {
			// ������ �Է�
			if (multi.getParameterValues("award_date") == null) {// �ܼ��� ��
				String award_date = multi.getParameter("award_date");
				String award_group = multi.getParameter("award_group");
				String award_contents = multi.getParameter("award_contents");
				sql5 = "insert resume_award(rid,award_date,award_group,award_contents)" + "values(?,?,?,?)";
				pstmt = con.prepareStatement(sql5);
				pstmt.setInt(1, rid);
				pstmt.setString(2, award_date);
				pstmt.setString(3, award_group);
				pstmt.setString(4, award_contents);
				pstmt.executeUpdate();

			} else {// �����϶�
				String[] award_date = multi.getParameterValues("award_date");
				String[] award_group = multi.getParameterValues("award_group");
				String[] award_contents = multi.getParameterValues("award_contents");
				for (int i = 0; i < award_date.length; i++) {
					sql5 = "insert resume_award(rid,award_date,award_group,award_contents)" + "values(?,?,?,?)";
					pstmt = con.prepareStatement(sql5);
					pstmt.setInt(1, rid);
					pstmt.setString(2, award_date[i]);
					pstmt.setString(3, award_group[i]);
					pstmt.setString(4, award_contents[i]);
					pstmt.executeUpdate();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}

		try {
			// ���� ����
			if (multi.getParameterValues("r_company") == null) {// �ܼ��� ��
				String entered_date = multi.getParameter("entered_date");
				String job_title = multi.getParameter("job_title");
				String r_company = multi.getParameter("r_company");
				String resignation_date = multi.getParameter("resignation_date");
				sql6 = "insert resume_Career(rid,r_company,entered_date,resignation_date,job_title)"
						+ "values(?,?,?,?,?)";
				pstmt = con.prepareStatement(sql6);
				pstmt.setInt(1, rid);
				pstmt.setString(2, r_company);
				pstmt.setString(3, entered_date);
				pstmt.setString(4, resignation_date);
				pstmt.setString(5, job_title);
				pstmt.executeUpdate();

			} else {// �����϶�
				String[] r_company = multi.getParameterValues("r_company");
				String[] entered_date = multi.getParameterValues("entered_date");
				String[] resignation_date = multi.getParameterValues("resignation_date");
				String[] job_title = multi.getParameterValues("job_title");
				for (int i = 0; i < r_company.length; i++) {
					sql6 = "insert resume_Career(rid,r_company,entered_date,resignation_date,job_title)"
							+ "values(?,?,?,?,?)";
					pstmt = con.prepareStatement(sql6);
					pstmt.setInt(1, rid);
					pstmt.setString(2, r_company[i]);
					pstmt.setString(3, entered_date[i]);
					pstmt.setString(4, resignation_date[i]);
					pstmt.setString(5, job_title[i]);
					pstmt.executeUpdate();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			} finally {
					pool.freeConnection(con, pstmt);
				}
		try {
			// �з� ����
			if (multi.getParameterValues("schoolname") == null) {// �ܼ��� ��
				String schoolname = multi.getParameter("schoolname");
				String admission = multi.getParameter("admission");
				String graduated = multi.getParameter("graduated");
				String major = multi.getParameter("major");
				sql7 = "insert resume_edu(rid,schoolname,admission,graduated,major)" + "values(?,?,?,?,?)";

				pstmt = con.prepareStatement(sql7);
				pstmt.setInt(1, rid);
				pstmt.setString(2, schoolname);
				pstmt.setString(3, admission);
				pstmt.setString(4, graduated);
				pstmt.setString(5, major);
				pstmt.executeUpdate();

			} else {// �����϶�
				String[] schoolname = multi.getParameterValues("schoolname");
				String[] admission = multi.getParameterValues("admission");
				String[] graduated = multi.getParameterValues("graduated");
				String[] major = multi.getParameterValues("major");
				for (int i = 0; i < schoolname.length; i++) {
					sql7 = "insert resume_edu(rid,schoolname,admission,graduated,major)" + "values(?,?,?,?,?)";

					pstmt = con.prepareStatement(sql7);
					pstmt.setInt(1, rid);
					pstmt.setString(2, schoolname[i]);
					pstmt.setString(3, admission[i]);
					pstmt.setString(4, graduated[i]);
					pstmt.setString(5, major[i]);
					pstmt.executeUpdate();
				}

			}

		}catch(

	Exception e)
	{
		e.printStackTrace();
	}finally
	{
		pool.freeConnection(con, pstmt);
	}

}
	// ���̵� ��������
		public UserBean getUser(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			UserBean bean = new UserBean();
			try {
				con = pool.getConnection();
				sql = "select * from user where uid = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					bean.setUid(rs.getString("uid"));
					bean.setPwd(rs.getString("pwd"));
					bean.setName(rs.getString("name"));
					bean.setEmail(rs.getString("email"));
					bean.setNickname(rs.getString("nickname"));
					bean.setGender(rs.getString("gender"));
					bean.setBirth(rs.getString("birth"));
					bean.setImg(rs.getString("img"));
					bean.setGrade(rs.getInt("grade"));
					bean.setRid(rs.getInt("rid"));
					bean.setCompany(rs.getString("company"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		
		// �̷¼� ��������
				public ResumeBean getResume(int rid) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					ResumeBean bean = new ResumeBean();
					try {
						con = pool.getConnection();
						sql = "select * from resume where rid = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rid);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							bean.setRid(rs.getInt("rid"));
							bean.setUid(rs.getString("uid"));
							bean.setE_name(rs.getString("e_name"));
							bean.setAddressA(rs.getString("addressA"));
							bean.setAddressB(rs.getString("addressB"));
							bean.setAddressC(rs.getString("addressC"));
							bean.setTelnum(rs.getString("telnum"));
							bean.setSelfintroduce(rs.getString("selfintroduce"));
							
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return bean;
				}
				
				// ������ ��������
				public Vector<Resume_awardBean> getResume_award(int rid) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<Resume_awardBean> vlist = new Vector<Resume_awardBean>();
					try {
						con = pool.getConnection();
						sql = "select * from Resume_award where rid = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rid);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							Resume_awardBean bean = new Resume_awardBean();
							bean.setRid(rs.getInt("rid"));
							bean.setRaid(rs.getInt("raid"));
							bean.setAward_date(rs.getString("Award_date"));
							bean.setAward_group(rs.getString("Award_group"));
							bean.setAward_contents(rs.getString("Award_contents"));
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				
				public Vector<Resume_certificateBean> getResume_certi(int rid) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<Resume_certificateBean> vlist = new Vector<Resume_certificateBean>();
					try {
						con = pool.getConnection();
						sql = "select * from resume_certificate where rid = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rid);
						rs = pstmt.executeQuery();
						System.out.println("getResume_certi");
						while (rs.next()) {
							Resume_certificateBean bean = new Resume_certificateBean();
							bean.setRid(rs.getInt("rid"));
							bean.setRceid(rs.getInt("rceid"));
							bean.setCerti_date(rs.getString("certi_date"));
							bean.setCerti_name(rs.getString("certi_name"));
							bean.setAgency(rs.getString("agency"));
							bean.setCerti_grade(rs.getString("Certi_grade"));
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				
				public Vector<Resume_careerBean> getResume_career(int rid) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<Resume_careerBean> vlist = new Vector<Resume_careerBean>();
					try {
						con = pool.getConnection();
						sql = "select * from resume_career where rid = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rid);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							Resume_careerBean bean = new Resume_careerBean();
							bean.setRid(rs.getInt("rid"));
							bean.setRcid(rs.getInt("rcid"));
							bean.setR_company(rs.getString("r_company"));
							bean.setEntered_date(rs.getString("entered_date"));
							bean.setResignation_date(rs.getString("resignation_date"));
							bean.setJob_title(rs.getString("job_title"));
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				
				public Vector<Resume_eduBean> getResume_edulist(int rid) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					System.out.println("edulist");
					Vector<Resume_eduBean> vlist = new Vector<Resume_eduBean>();
					try {
						con = pool.getConnection();
						sql = "select * from resume_edu where rid = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, rid);
						rs = pstmt.executeQuery();
						
						while (rs.next()) {
						
							Resume_eduBean bean = new Resume_eduBean();
							bean.setRid(rs.getInt("rid"));
							bean.setReid(rs.getInt("reid"));
							bean.setAdmissoin(rs.getString("admission"));
							bean.setGraduated(rs.getString("graduated"));
							bean.setSchoolname(rs.getString("schoolname"));
							bean.setMajor(rs.getString("major"));
							vlist.addElement(bean);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				

}
