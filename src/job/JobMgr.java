package job;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.UserBean;


public class JobMgr {
	
	private DBConnectionMgr pool;

	public JobMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// id 중복 체크 : 중복 -> true
	// select id from tblMember where id=?
	public boolean checkId(String uid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from user where uid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			flag = rs.next();// 결과값이 있다면 true <- 중복
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 회원가입
		public boolean insertMember(UserBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert user(uid,pwd,name,gender,nickname,birth,email,img,grade,company)"
						+ "values(?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getUid());
				pstmt.setString(2, bean.getPwd());
				pstmt.setString(3, bean.getName());
				pstmt.setString(4, bean.getGender());
				pstmt.setString(5, bean.getNickname());
				pstmt.setString(6, bean.getBirth());
				pstmt.setString(7, bean.getEmail());
				pstmt.setString(8, bean.getImg());
				pstmt.setInt(9, bean.getGrade());
				pstmt.setString(10, bean.getCompany());
				if (pstmt.executeUpdate() == 1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		// 로그인 : 성공 -> true
		// select id from tblMember where id=? and pwd=?
		public boolean loginMember(String id, String pwd) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "select uid from user where uid=? and pwd=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				rs = pstmt.executeQuery();
				flag = rs.next();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}
		
		// 아이디 가져오기
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

	
}
