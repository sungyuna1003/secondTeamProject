package freelancer;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.FreelancerBean;
import bean.Freelancer_userBean;
import bean.UserBean;
import resume.DBConnectionMgr;

public class FreelancerMgr {

	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/job/WebContent/img/freelancer/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10 * 1024 * 1024;// 10MB

	public FreelancerMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// Board Insert
	public Vector<FreelancerBean> getFreelancerlist(String keyWord, String region, String includetype, String edutype,
			String educnt, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FreelancerBean> vlist = new Vector<FreelancerBean>();
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") && region.trim().equals("0") && includetype.trim().equals("0")
					&& edutype.trim().equals("0") && educnt.trim().equals("0")) {
				// �˻��� �ƴѰ��
				sql = "select * from freelancer order by f_time desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else {
				if (region.trim().equals("0")) {
					region = "";
				}
				if (includetype.trim().equals("0")) {
					includetype = "";
				}
				if (edutype.trim().equals("0")) {
					edutype = "";
				}
				if (educnt.trim().equals("0")) {
					educnt = "";
				}
				// �˻��� ���
				sql = "SELECT * FROM freelancer " + "WHERE f_includetype LIKE ?" + "and f_edutype LIKE ?"
						+ "AND f_educount LIKE ?" + "and f_region LIKE ?"
						+ "AND f_title LIKE ? order by f_time desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + includetype + "%");
				pstmt.setString(2, "%" + edutype + "%");
				pstmt.setString(3, "%" + educnt + "%");
				pstmt.setString(4, "%" + region + "%");
				pstmt.setString(5, "%" + keyWord + "%");
				pstmt.setInt(6, start);
				pstmt.setInt(7, cnt);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				FreelancerBean bean = new FreelancerBean();

				bean.setFid(rs.getInt("fid"));
				bean.setUid_free(rs.getString("Uid_free"));
				bean.setF_title(rs.getString("f_title"));
				bean.setF_self(rs.getString("F_self"));
				bean.setF_product(rs.getString("F_product"));
				bean.setF_includetype(rs.getString("f_includetype"));
				bean.setF_educount(rs.getString("F_educount"));
				bean.setF_time(rs.getString("F_time"));
				bean.setF_region(rs.getString("F_region"));
				bean.setF_edutype(rs.getString("F_edutype"));
				bean.setf_viewcnt(rs.getInt("F_viewcnt"));
				bean.setAvailable(rs.getString("Available"));
				bean.setFiles(rs.getString("files"));
				bean.setPrice(rs.getInt("price"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// Board Insert
	public FreelancerBean getFreelancer(String fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		FreelancerBean bean = new FreelancerBean();
		try {
			con = pool.getConnection();
			sql = "select * from freelancer where fid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setFid(rs.getInt("fid"));
				bean.setUid_free(rs.getString("Uid_free"));
				bean.setF_title(rs.getString("f_title"));
				bean.setF_self(rs.getString("F_self"));
				bean.setF_product(rs.getString("F_product"));
				bean.setF_includetype(rs.getString("f_includetype"));
				bean.setF_educount(rs.getString("F_educount"));
				bean.setF_time(rs.getString("F_time"));
				bean.setF_region(rs.getString("F_region"));
				bean.setF_edutype(rs.getString("F_edutype"));
				bean.setf_viewcnt(rs.getInt("F_viewcnt"));
				bean.setAvailable(rs.getString("Available"));
				bean.setFiles(rs.getString("files"));
				bean.setPrice(rs.getInt("price"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// Board Total Count : �� �Խù���
	public int getTotalCount(String keyWord, String region, String includetype, String edutype, String educnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") && region.trim().equals("0") && includetype.trim().equals("0")
					&& edutype.trim().equals("0") && educnt.trim().equals("0")) {
				// �˻��� �ƴѰ��
				sql = "select count(*) from freelancer";
				pstmt = con.prepareStatement(sql);
			} else {
				if (region.trim().equals("0")) {
					region = "";
				}
				if (includetype.trim().equals("0")) {
					includetype = "";
				}
				if (edutype.trim().equals("0")) {
					edutype = "";
				}
				if (educnt.trim().equals("0")) {
					educnt = "";
				}
				// �˻��� ���
				sql = "SELECT COUNT(*) FROM freelancer " + "WHERE f_includetype LIKE ?" + "and f_edutype LIKE ?"
						+ "AND f_educount LIKE ?" + "and f_region LIKE ?" + "AND f_title LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + includetype + "%");
				pstmt.setString(2, "%" + edutype + "%");
				pstmt.setString(3, "%" + educnt + "%");
				pstmt.setString(4, "%" + region + "%");
				pstmt.setString(5, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	public int getvote(int fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int vote = 0;

		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM freelancer_user where fid = ? and vote = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vote = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vote;
	}

	public boolean free_usercheck(String uid, String fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM freelancer_user where fid = ? and uid_seeker = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fid);
			pstmt.setString(2, uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	public Freelancer_userBean getfree_user(String uid, String fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Freelancer_userBean bean = new Freelancer_userBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM freelancer_user where fid = ? and uid_seeker = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fid);
			pstmt.setString(2, uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setUid_seeker(rs.getString("Uid_seeker"));
				bean.setFid(rs.getInt("fid"));
				bean.setVote(rs.getString("vote"));
				bean.setContract(rs.getString("contract"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	public void insertfree_user(String uid, String fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {

			con = pool.getConnection();
			sql = "insert freelancer_user(fid,uid_seeker,vote,contract)" + "values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fid);
			pstmt.setString(2, uid);
			pstmt.setString(3, "1");
			pstmt.setString(4, "");
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void updatefree_user(String uid, String fid, String votecnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {

			con = pool.getConnection();
			sql = "update freelancer_user set vote=?, contract=?" + " where uid_seeker=? and fid = ?";
			pstmt = con.prepareStatement(sql);
			if (votecnt.equals("0")) {
				pstmt.setString(1, "1");
			} else if (votecnt.equals("1")) {
				pstmt.setString(1, "0");
			}
			pstmt.setString(2, "");
			pstmt.setString(3, uid);
			pstmt.setString(4, fid);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void viewcntplus(String fid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE freelancer set f_viewcnt = f_viewcnt + 1 " + " where fid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fid);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void insertFreelancer(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MultipartRequest multi = null;
		String img = null;

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

}
	}
}
