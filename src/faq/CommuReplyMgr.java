package faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

public class CommuReplyMgr {
	
	private DBConnectionMgr pool;
	
	public CommuReplyMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//작성일자 메소드
	public String getDate() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select now()";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ""; //데이터 베이스 오류
	}
	//게시글 번호 부여 메소드
	public int getNext() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select comment_id from community_comment order by comment_id desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1; //데이터 베이스 오류
	}
	public HashMap<String, Object> write(String cid,String comment_con,String uid_seeker) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		HashMap<String, Object> hm = new HashMap<>();
		try {
			con = pool.getConnection();
			sql = "insert community (comment_id,cid,uid_seeker,comment_con,date)"
					+"values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,getNext());
			pstmt.setInt(2, Integer.parseInt(cid));
			pstmt.setString(3, uid_seeker);
			pstmt.setString(4, comment_con);
			pstmt.setString(5, getDate());
			int result = pstmt.executeUpdate();
			 Vector<CommuReplyBean> comments = getList(1);
			 hm.put("result", result);
			 hm.put("comments", comments);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return hm;
	}
	public Vector<CommuReplyBean> getList(int pageNumber){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommuReplyBean> vlist = new Vector<CommuReplyBean>();
		try {
			con = pool.getConnection();
			sql = "select * from community_comment where comment_id < ? and available = 1 "
					+ "order by comment_id desc limit 10";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommuReplyBean Cbean = new CommuReplyBean();
				Cbean.setComment_id(rs.getInt(1));
				Cbean.setCid(rs.getInt(2));
				Cbean.setUid_seeker(rs.getString(3));
				Cbean.setComment_con(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				
				vlist.add(Cbean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from community where cid < ? and available = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return false;
		}
	//게시글 한개
	public CommunityBean getRow(int cid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from community where cid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				return Cbean;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	public int update(int cid,String c_title,String c_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update community set c_title = ?, c_content = ? where cid = ?";
			//게시글 번호는 1번부터 2번, 3, 4, ... 올라가서 마지막의 번호를 가져와서 +1 해준다
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, c_title);
			pstmt.setString(2, c_content);
			pstmt.setInt(3, cid);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	//삭제하지만 서버에는 보관!
	public int delete(int cid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update community set available = 0 where cid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cid);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
}
