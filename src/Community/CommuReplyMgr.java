package Community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import chat.ChatDTO;

public class CommuReplyMgr {
			DataSource dataSource;
		public CommuReplyMgr() {
			try {
				InitialContext initContext = new InitialContext();
				Context envContext = (Context) initContext.lookup("java:/comp/env");
				dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
			}catch (Exception e) {
			}
		}
	public ArrayList<CommuReplyBean> getComment(String cid,String checkID){
		ArrayList<CommuReplyBean> CommentList= null;
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "SELECT * FROM community_comment WHERE cid = ? and comment_id >  ?;";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cid);
			pstmt.setString(2, checkID);
			CommentList = new ArrayList<CommuReplyBean>();
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommuReplyBean commuReplyBean = new CommuReplyBean();
				commuReplyBean.setComment_id(rs.getInt("comment_id"));
				commuReplyBean.setCid(rs.getInt("cid"));
				commuReplyBean.setUid_seeker(rs.getString("uid_seeker").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				commuReplyBean.setComment_con(rs.getString("comment_con").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				int date = Integer.parseInt(rs.getString("date").substring(11,13));
				String timeType = "오전";
				if(date > 12) {
					timeType = "오후";
					date -= 12;
				}
				commuReplyBean.setDate(rs.getString("date").substring(0,11)+ " " + timeType + date + ":" + rs.getString("date").substring(14,16)+ "");
				CommentList.add(commuReplyBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return CommentList;
	}
	
	public int submit(int cid,String uid_seeker,String comment_con){
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "insert into community_comment values(null,?,?,?,null)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cid);
			pstmt.setString(2, uid_seeker);
			pstmt.setString(3, comment_con);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
